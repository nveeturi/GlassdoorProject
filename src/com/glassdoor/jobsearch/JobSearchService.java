package com.glassdoor.jobsearch;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.glassdoor.constant.Constants;
import com.glassdoor.dao.JobSearchDAO;
import com.glassdoor.databean.AddressResponse;
import com.glassdoor.databean.GMapResponse;
import com.glassdoor.databean.GMapResult;
import com.glassdoor.databean.GlassdoorJobData;
import com.glassdoor.databean.GoogleResponse;
import com.glassdoor.databean.GoogleResult;
import com.glassdoor.databean.JobDetails;
import com.glassdoor.databean.JobListing;
import com.glassdoor.databean.Location;
import com.glassdoor.databean.Results;
import com.glassdoor.databean.TravelTimeListing;
import com.glassdoor.databean.TravelTimeListingWS;
import com.glassdoor.databean.TravelTimeWS;
import com.google.gson.Gson;

/**
 * The class contains all the services that are required to get the job data
 * from Glassdoor. This also contains the services to update the database with
 * geo-location data.
 * 
 * @author Glassdoor Practicum Team 
 * MSIT eBusiness Technology 2014 - Carnegie Mellon University
 * 
 */
public class JobSearchService {

	private JobSearchDAO jobSearchDao;
	public static Logger logger = Logger.getLogger(JobSearchService.class);
	private static String wsapikey = "4e5e6d22d4da1c95033c23cb1b606596";

	/**
	 * The service calls the Glassdoor Search API with search keyword or job title
	 * and location and returns the results with number of records per page equal to
	 * resultCount.
	 * 
	 * @param jobTitle
	 * @param city
	 * @param loadAll
	 * @param pageNum
	 * @param resultCount
	 * @return
	 * @throws IOException
	 */
	public List<JobDetails> getJobDataFromGlassdoor(String jobTitle,
			String city, boolean loadAll, int pageNum, int resultCount)
			throws IOException {

		int totalpages = pageNum;
		Long prevJobId = 0L;
		List<JobDetails> jobResult = new ArrayList<JobDetails>();
		while (pageNum <= totalpages) {

			StringBuilder urlString = new StringBuilder(
					"http://api.glassdoor.com/api/api.htm?");
			urlString.append("t.p=" + Constants.passCode);
			urlString.append("&t.k=" + Constants.key);
			urlString.append("&userip=" + Constants.localIP);
			urlString.append("&useragent=");
			urlString.append("&format=json");
			urlString.append("&v=1.1");
			urlString.append("&action=jobs");
			urlString.append("&q=" + jobTitle);
			urlString.append("&l=" + city);
			urlString.append("&pn=" + pageNum);
			urlString.append("&ps=" + resultCount);
			URL url = new URL(urlString.toString());
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			BufferedReader br = new BufferedReader(new InputStreamReader(
					(con.getInputStream())));
			StringBuilder response = new StringBuilder();
			String output;
			while ((output = br.readLine()) != null) {
				response.append(output);
			}

			Gson gson = new Gson();
			JobListing jobListings = gson.fromJson(response.toString(),
					JobListing.class);
			List<GlassdoorJobData> joblist = jobListings.getResponse()
					.getJobListings();

			if (loadAll) {
				totalpages = jobListings.getResponse().getTotalNumberOfPages();
			}

			pageNum++;

			for (GlassdoorJobData job : joblist) {
				JobDetails jobdetail = new JobDetails();
				if (prevJobId.longValue() == job.getJobListingId().longValue()) {
					continue;
				}
				jobdetail.setJobTitle(job.getJobTitle());
				jobdetail.setTotalPages(jobListings.getResponse()
						.getTotalNumberOfPages());
				String[] location = job.getLocation().split(",");
				if (location.length == 2) {
					jobdetail.setCity(location[0]);
					jobdetail.setState(location[1]);
				}

				jobdetail.setCompanyName(job.getEmployer().getName());
				jobdetail.setJobId(job.getJobListingId());
				prevJobId = job.getJobListingId();
				jobdetail.setJobLink(job.getJobViewUrl());
				jobdetail.setSource(job.getSource());
				jobdetail.setCountry("USA");
				jobdetail.setJobDescription(job.getDescriptionFragment());
				jobdetail.setStreetName1(job.getLocation());
				jobResult.add(jobdetail);

			}

		}

		return jobResult;

	}

	/**
	 * This is the main service that will update the geo-location data in the
	 * database. This service fetches all the job data from database and calls
	 * different service methods that makes Career Builder API call and uses
	 * Places API data to update the street location data and the lat/long
	 * information.
	 * 
	 * @throws XPathExpressionException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 */
	public void updateLocationInfo() throws XPathExpressionException,
			ParserConfigurationException, SAXException {

		logger.info("updateLocationInfo batch initiated");
		// Traverse through all the records that do not have lat-long
		List<JobDetails> details = null;
		details = jobSearchDao.getJobDetailsWithNoLocation();
		if (details != null) {
			for (JobDetails jobDetails : details) {
				try {
					String latlong = "";
					logger.info("Processing the job with job Id "
							+ jobDetails.getJobId());
					// Check if the lat long is available in Career Builder
					if (jobDetails.getSource().equals("CareerBuilder")
							&& !(jobDetails.getJobRefID() == null || jobDetails
									.getJobRefID() == "")) {
						logger.info("Job is from source Career Builder");
						callCBJobRefURL(jobDetails);
					}

					if (jobDetails.getLatitude() != null
							&& jobDetails.getLongitude() != null) {
						latlong = jobDetails.getLatitude().toString() + ","
								+ jobDetails.getLongitude().toString();
					}

					if (latlong.equals("")) {
						latlong = jobSearchDao.getLatLongForCity(jobDetails
								.getCity());
					}
					if (latlong.equals("")) {
						// Get the lat-long of the City
						logger.info("Call Google Geocode API to get city lat/long");
						GoogleResponse res = getLocationLatLong(jobDetails
								.getCity());
						if (res.getResults() != null
								&& res.getResults().length > 0) {
							Location loc = res.getResults()[0].getGeometry()
									.getLocation();
							latlong = loc.getLat() + "," + loc.getLng();
							if (!latlong.equals("")) {
								logger.info("Geocode latitude/longitude found for city "
										+ jobDetails.getCity()
										+ " is "
										+ latlong);
								jobSearchDao.insertLatLongForCity(
										jobDetails.getCity(), latlong);
							}
						}
					}
					// Call the nearby search Google Places API with the company name and lat/long
					if (!latlong.equals("")) {
						setValidAddress(latlong, jobDetails);
					}
					if (latlong.equals("")
							&& !(jobDetails.getJobSourceLink() == null || jobDetails
									.getJobSourceLink().equals(""))) {
						logger.info("The job source link will be scrapped to find the address "
								+ jobDetails.getJobSourceLink());
						updateLocationFromJobLink(jobDetails);
					}
				} catch (IOException e) {
					logger.error("Error occurred for Job ID "
							+ jobDetails.getJobId() + " - " + e.getMessage());
					continue;

				} catch (Exception e) {
					logger.error("Error occurred - " + e.getMessage());
					continue;

				}

			}

			saveJobDetails(details);
		}

	}

	/**
	 * The service will call the Career Builder API with Job Ref ID and extracts the
	 * latitude and longitude of the job details.
	 * @param details
	 * @throws IOException
	 * @throws ParserConfigurationException
	 * @throws SAXException
	 * @throws XPathExpressionException
	 */
	public void callCBJobRefURL(JobDetails details) throws IOException,
			ParserConfigurationException, SAXException,
			XPathExpressionException {
		logger.info("callCBJobRefURL method initiated");
		logger.info("Career Builder Job Ref Id :" + details.getJobRefID());

		String jobRefId = details.getJobRefID() != null ? URLEncoder.encode(
				details.getJobRefID(), "UTF-8") : "";
		StringBuilder urlString = new StringBuilder(
				"http://api.careerbuilder.com/v1/job?");
		urlString.append("DeveloperKey=" + Constants.CB_API_KEY);
		urlString.append("&DID=" + jobRefId);
		urlString.append("&HostSite=US");
		URL url = new URL(urlString.toString());
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		BufferedReader br = new BufferedReader(new InputStreamReader(
				(con.getInputStream())));
		StringBuilder response = new StringBuilder();
		String output;
		while ((output = br.readLine()) != null) {
			response.append(output);
		}
		DocumentBuilderFactory builderFactory = DocumentBuilderFactory
				.newInstance();
		DocumentBuilder builder = builderFactory.newDocumentBuilder();
		Document document = builder.parse(new ByteArrayInputStream(response
				.toString().getBytes()));
		XPath xPath = XPathFactory.newInstance().newXPath();
		String expression = "/ResponseJob/Errors";
		String error = xPath.compile(expression).evaluate(document);
		if (error.trim().equals("")) {
			expression = "/ResponseJob/Job/LocationLatitude";
			String latitude = xPath.compile(expression).evaluate(document);
			if (!latitude.equals("")) {
				details.setLatitude(Double.valueOf(latitude));
			}
			expression = "/ResponseJob/Job/LocationLongitude";
			String longitude = xPath.compile(expression).evaluate(document);
			if (!longitude.equals("")) {
				details.setLongitude(Double.valueOf(longitude));
			}

		}
		logger.info("callCBJobRefURL method ended");

	}

	/**
	 * 
	 * @param latlong
	 * @param jobDetails
	 * @throws IOException
	 */
	private void setValidAddress(String latlong, JobDetails jobDetails)
			throws IOException {

		logger.info("setValidAddress method initiated");
		String address = "";
		GMapResponse grsp = getNearByLocation(latlong,
				jobDetails.getCompanyName());

		if (grsp != null) {

			if (grsp.getStatus().equals("OK")) {
				if (grsp.getResults().length == 0) {
					jobDetails.setLatitude(null);
					jobDetails.setLongitude(null);
					return;
				}
				int relevantCount = 0;
				HashSet set = new HashSet();
				for (GMapResult result : grsp.getResults()) {

					String resultCoName = removeSpecialChar(result.getName());
					String jobCompany = removeSpecialChar(jobDetails
							.getCompanyName());
					if ((resultCoName.toLowerCase().contains(
							jobCompany.toLowerCase()) || jobCompany
							.toLowerCase().contains(resultCoName.toLowerCase()))
							&& result.getVicinity().contains(
									jobDetails.getCity())) {
						address = result.getVicinity();
						set.add(address);
						latlong = result.getGeometry().getLocation().getLat()
								.toString()
								+ ","
								+ result.getGeometry().getLocation().getLng()
										.toString();
						relevantCount = set.size();

						jobDetails.setLatitude(Double.valueOf(result
								.getGeometry().getLocation().getLat()));
						jobDetails.setLongitude(Double.valueOf(result
								.getGeometry().getLocation().getLng()));

						if (relevantCount > 1) {
							address = "";
							latlong = "";
							jobDetails.setLatitude(null);
							jobDetails.setLongitude(null);
							break;
						}
					}
				}

				logger.info("The address found from Google Places API is "
						+ address);

				if (!address.equals("") && !latlong.equals("")) {
					if (address.split(",").length < 2) {
						GoogleResponse resp = convertFromLatLong(latlong);
						if (resp.getResults().length > 0) {
							GoogleResult result = resp.getResults()[0];
							setAddressDetails(result.getFormatted_address(),
									jobDetails);
							logger.info("Formatted address is "
									+ result.getFormatted_address());
						}
					} else {
						grsp = getTextLocation(address);
						if (grsp.getResults().length > 0) {
							GMapResult result = (GMapResult) grsp.getResults()[0];
							setAddressDetails(result.getFormatted_address(),
									jobDetails);
							logger.info("Formatted address is "
									+ result.getFormatted_address());
						}
					}
				}
			} else {
				jobDetails.setLatitude(null);
				jobDetails.setLongitude(null);
				logger.info("Address not found from Google Places API");
			}

		}
	}

	/**
	 * 
	 * @param jobdetails
	 */
	public void saveJobDetails(List<JobDetails> jobdetails) {

		jobSearchDao.insertJobDetails(jobdetails);

	}

	private String removeSpecialChar(String input) {
		input = input.replaceAll("[^a-zA-Z0-9]+", "");

		return input;

	}

	public List<JobDetails> getAllJobsFromDB() {
		return jobSearchDao.getJobetailsFromDB();
	}

	public JobDetails getJobForId(String jobId) {
		return jobSearchDao.getJobDetailsForSearch(jobId);
	}

	/**
	 * 
	 * @param formattedAddress
	 * @param jobDetails
	 */
	private void setAddressDetails(String formattedAddress,
			JobDetails jobDetails) {
		if (!formattedAddress.equals("")) {
			String[] splitAddress = formattedAddress.split(",");
			String[] stateZip = null;
			String streetNm2 = "";
			String city = "";
			String streetNm1 = "";

			if (splitAddress.length == 3) {
				city = splitAddress[0].trim();
			}
			if (splitAddress.length == 5) {
				streetNm1 = splitAddress[0].trim();
				streetNm2 = splitAddress[1].trim();
				city = splitAddress[2].trim();
				stateZip = splitAddress[3].trim().split("\\s");
			} else if (splitAddress.length == 4) {
				streetNm1 = splitAddress[0].trim();
				city = splitAddress[1].trim();
				stateZip = splitAddress[2].trim().split("\\s");
			}
			jobDetails.setStreetName1(streetNm1);
			jobDetails.setCity(city);
			jobDetails.setStreetName2(streetNm2);
			if (!(stateZip.equals(""))) {
				jobDetails.setState(stateZip[0]);
				if (stateZip.length > 1) {
					jobDetails.setZipCode(stateZip[1]);
				}
			}

		}
	}

	/**
	 * 
	 * @param latlongString
	 * @param companyName
	 * @return
	 * @throws IOException
	 */
	public GMapResponse getNearByLocation(String latlongString,
			String companyName) throws IOException {
		logger.info("getNearByLocation method initiated");

		if (companyName == null || companyName.equals("")) {
			return null;
		}

		URL url = new URL(Constants.MAPS_NEARBY_URL + "?location="
				+ URLEncoder.encode(latlongString, "UTF-8")
				+ "&rankby=distance&name="
				+ URLEncoder.encode(companyName, "UTF-8") + "&key="
				+ Constants.MAPS_API_KEY);
		// Open the Connection
		logger.info("Calling the URL " + url.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GMapResponse response = (GMapResponse) mapper.readValue(in,
				GMapResponse.class);
		logger.info("Status of the Response :" + response.getStatus());
		in.close();
		return response;

	}

	/**
	 * 
	 * @param textSearch
	 * @return
	 * @throws IOException
	 */
	public GMapResponse getTextLocation(String textSearch) throws IOException {
		logger.info("getTextLocation method initiated");
		URL url = new URL(Constants.MAPS_TEXT_SEARCH_URL + "?query="
				+ URLEncoder.encode(textSearch, "UTF-8") + "&key="
				+ Constants.MAPS_API_KEY);
		// Open the Connection
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GMapResponse response = (GMapResponse) mapper.readValue(in,
				GMapResponse.class);
		logger.info("Status of the Response :" + response.getStatus());
		in.close();
		return response;

	}

	/**
	 * 
	 * @param latlongString
	 * @return
	 * @throws IOException
	 */
	public GoogleResponse convertFromLatLong(String latlongString)
			throws IOException {

		URL url = new URL(Constants.GEOCODE_URL + "?latlng="
				+ URLEncoder.encode(latlongString, "UTF-8") + "&sensor=false");
		logger.info("Calling the URL " + url.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GoogleResponse response = (GoogleResponse) mapper.readValue(in,
				GoogleResponse.class);
		logger.info("Status of the Response :" + response.getStatus());
		in.close();
		return response;

	}

	/**
	 * 
	 * @param locationName
	 * @return
	 * @throws IOException
	 */
	public GoogleResponse getLocationLatLong(String locationName)
			throws IOException {
		logger.info("getLocationLatLong method initiated");
		URL url = new URL(Constants.GEOCODE_URL + "?address="
				+ URLEncoder.encode(locationName, "UTF-8"));
		logger.info("Calling the URL " + url.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GoogleResponse response = (GoogleResponse) mapper.readValue(in,
				GoogleResponse.class);
		logger.info("Status of the Response :" + response.getStatus());
		in.close();
		logger.info("getLocationLatLong method ended");
		return response;

	}

	/**
	 * 
	 * @param jobDetails
	 * @throws IOException
	 */
	public void updateLocationFromJobLink(JobDetails jobDetails)
			throws IOException {
		logger.info("updateLocationFromJobLink batch initiated");
		// STEP 1: Execute a query
		org.jsoup.nodes.Document doc = null;
		String error = "";
		boolean flag = false;
		// STEP 2: Extract data from result set
		String link = "";
		link = jobDetails.getJobSourceLink();
		doc = Jsoup.connect(link).ignoreContentType(true).timeout(0).get();

		Elements elements = doc.body().select("*");

		for (Element x : elements) {
			// System.out.println(x.ownText());
			String text = x.ownText();
			String[] words = text.split("\\s+");
			for (String word : words) {
				if (Arrays.asList(Constants.US_STATES).contains(word)
						|| Arrays.asList(Constants.StateCodes).contains(word)) {

					return;
				} else {
					String addr = "";
					for (int i = 0; i < words.length; i++) {
						addr += words[i] + " ";

					}

					if (!addr.trim().equals("")) {
						URL url = new URL(Constants.SMARTY_STR_URL + "?street="
								+ URLEncoder.encode(addr, "UTF-8")
								+ "&candidates=5&auth-id="
								+ Constants.SS_AUTH_ID + "&auth-token="
								+ Constants.SS_AUTH_TOKEN);
						// Open the Connection
						HttpURLConnection conn = (HttpURLConnection) url
								.openConnection();
						InputStream in = conn.getInputStream();
						ObjectMapper mapper = new ObjectMapper();
						AddressResponse response = (AddressResponse) mapper
								.readValue(in, AddressResponse.class);
						logger.info("Address retrieved");
						if (response.getComponents() != null) {
							logger.info("Address retrieved");
							String street1 = response.getComponents()
									.getPrimary_number()
									+ response.getComponents().getStreet_name()
									+ response.getComponents()
											.getStreet_suffix();
							jobDetails.setStreetName1(street1);
							jobDetails.setCity(response.getMetadata()
									.getCounty_name());
							jobDetails.setLatitude(response.getMetadata()
									.getLatitude());
							jobDetails.setLongitude(response.getMetadata()
									.getLongitude());
						}

						in.close();

					}
				}

			}
		}

	}// end main

	public void setJobSearchDao(JobSearchDAO jobSearchDao) {
		this.jobSearchDao = jobSearchDao;
	}

	public List<JobDetails> getJobDataForIds(String jobIds) {

		return jobSearchDao.getJobsForIds(jobIds);
	}

	/**
	 * 
	 * @param details
	 * @return
	 */
	public List<JobDetails> matchLatLongFromJobList(List<JobDetails> details) {
		List<JobDetails> JobListWithLatLong = jobSearchDao.getLatLong(details);
		List<JobDetails> newJob = new ArrayList<JobDetails>();
		// match lat long to job details list
		for (JobDetails i : details) {
			for (JobDetails j : JobListWithLatLong) {
				if (i.getJobId().equals(j.getJobId())) {
					if (j.getLatitude() != null) {
						i.setLatitude(j.getLatitude());
						i.setLongitude(j.getLongitude());
						newJob.add(i);
						break;
					}
				}
			}

		}
		return newJob;
	}

	// public void updateCommuteTimeAndDistance(List<JobDetails> details) {
	// // double curLat = 40.4435386;
	// // double curLong = -79.94435829999998;
	// double curLat = 40.443504;
	// double curLong = -79.941571;
	// double desLat = 47.646757;
	// double desLong = -122.361152;
	// // 47.646757,-122.361152
	// for (JobDetails i : details) {
	// if (i.getLatitude() != null && i.getLongitude() != null) {
	// // get distance
	// double a = i.getLatitude();
	// double b = i.getLongitude();
	// double distance = caculateDistance(curLat, curLong,
	// i.getLatitude(), i.getLongitude());
	//
	// // commute time by bus
	// int busTime = caculateCommuteTime("transit", curLat, curLong,
	// i.getLatitude(), i.getLongitude());
	// // int busTime = caculateCommuteTime("drive", curLat, curLong,
	// // desLat, desLong);
	//
	// // commute time by walk
	// int walkTime = Integer.parseInt(caculateCommuteTimeGl(
	// "walking", curLat, curLong, i.getLatitude(),
	// i.getLongitude()));
	//
	// // commute time by drive
	// int driveTime = Integer.parseInt(caculateCommuteTimeGl(
	// "driving", curLat, curLong, i.getLatitude(),
	// i.getLongitude()));
	//
	// // commute time by bike
	// int bikeTime = Integer.parseInt(caculateCommuteTimeGl(
	// "bicycling", curLat, curLong, i.getLatitude(),
	// i.getLongitude()));
	//
	// int min = Math.min(Math.min(walkTime, driveTime),
	// Math.min(busTime, bikeTime));
	// i.setDistance(distance);
	// i.setDriveTime(driveTime);
	// i.setBikeTime(bikeTime);
	// i.setTransitTime(busTime);
	// i.setWalkTime(walkTime);
	// i.setMinCommuteTime(min);
	// }
	// }
	//
	// }

	/**
	 * 
	 * @param commuteType
	 * @param curLat
	 * @param curLong
	 * @param desLat
	 * @param desLong
	 * @return
	 */
	private String calculateCommuteTimeGl(String commuteType, double curLat,
			double curLong, double desLat, double desLong) {
		StringBuilder urlString = new StringBuilder(
				"https://maps.googleapis.com/maps/api/distancematrix/json?");
		urlString.append("origins=" + curLat + "," + curLong);
		urlString.append("&destinations=" + desLat + "," + desLong);
		urlString.append("&key=AIzaSyBwt9e578fMqY9A0EfiLEr7pj-s9fjfZj4");
		urlString.append("&mode=" + commuteType);
		urlString.append("&language=en-EN");
		URL url;
		TravelTimeListing ttl = null;
		try {
			url = new URL(urlString.toString());

			HttpURLConnection con;

			con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("GET");

			BufferedReader br = new BufferedReader(new InputStreamReader(
					con.getInputStream()));

			StringBuilder response = new StringBuilder();
			String output;
			while ((output = br.readLine()) != null) {
				response.append(output);
			}

			Gson gson = new Gson();
			ttl = gson.fromJson(response.toString(), TravelTimeListing.class);

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ttl.getRows()[0].getElements()[0].getDuration().getValue();

	}

	/**
	 * 
	 * @param commuteType
	 * @param curLat
	 * @param curLong
	 * @param desLat
	 * @param desLong
	 * @return
	 */
	private int calculateCommuteTime(String commuteType, double curLat,
			double curLong, double desLat, double desLong) {
		StringBuilder urlString = new StringBuilder(
				"http://api2.walkscore.com/api/v1/traveltime/json?");

		urlString.append("wsapikey=" + wsapikey);
		urlString.append("&mode=" + commuteType);
		urlString.append("&origin=" + curLat + "," + curLong);
		urlString.append("&destination=" + desLat + "," + desLong);
		URL url;
		TravelTimeListingWS ttl = null;
		try {
			url = new URL(urlString.toString());

			HttpURLConnection con;

			con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("GET");

			BufferedReader br = new BufferedReader(new InputStreamReader(
					con.getInputStream()));

			StringBuilder response = new StringBuilder();
			String output;
			while ((output = br.readLine()) != null) {
				response.append(output);
			}

			Gson gson = new Gson();
			ttl = gson.fromJson(response.toString(), TravelTimeListingWS.class);

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ttl.getResponse().getResults()[0].getTravel_times()[0]
				.getSeconds();

	}

	/**
	 * 
	 * @param initialLat
	 * @param initialLong
	 * @param finalLat
	 * @param finalLong
	 * @return
	 */
	private double calculateDistance(double initialLat, double initialLong,
			double finalLat, double finalLong) {
		double latDiff = finalLat - initialLat;
		double longDiff = finalLong - initialLong;
		double earthRadius = 6371; // In Km

		double distance = 2
				* earthRadius
				* Math.asin(Math.sqrt(Math.pow(Math.sin(latDiff / 2.0), 2)
						+ Math.cos(initialLat) * Math.cos(finalLat)
						* Math.pow(Math.sin(longDiff / 2), 2)));

		return distance;
	}

	public void sortJobList(List<JobDetails> jobdetails, String criteria) {
		if (criteria.equals("Distance")) {
			Collections.sort(jobdetails, DistanceComparator);
		} else if (criteria.equals("CommuteTime")) {
			Collections.sort(jobdetails, CommuteTimecomparator);
		}

	}

	private static Comparator<JobDetails> DistanceComparator = new Comparator<JobDetails>() {
		public int compare(JobDetails o1, JobDetails o2) {
			if (o1.getDistance() == 0) {
				return (o2.getDistance() == 0) ? 0 : -1;
			}
			if (o2.getDistance() == 0) {
				return -1;
			}
			return (int) (o1.getDistance() - o2.getDistance());
		}
	};
	private static Comparator<JobDetails> CommuteTimecomparator = new Comparator<JobDetails>() {
		public int compare(JobDetails o1, JobDetails o2) {
			return o1.getMinCommuteTime() - o2.getMinCommuteTime();
		}
	};

	/**
	 * 
	 * @param jobdetails
	 * @param distance
	 * @param commuteTime
	 * @param commuteType
	 * @return
	 */
	public ArrayList<JobDetails> refineSearch(List<JobDetails> jobdetails,
			int distance, int commuteTime, String commuteType) {
		ArrayList<JobDetails> newJob = new ArrayList<JobDetails>(jobdetails);
		for (int i = 0; i < newJob.size(); i++) {
			if (newJob.get(i).getDistance() > distance * 1609) {
				newJob.remove(i);
			}
			switch (commuteType) {
			case "Transit":
				if (newJob.get(i).getTransitTime() > commuteTime) {
					newJob.remove(i);
				}
				continue;
			case "Drive":
				if (newJob.get(i).getDriveTime() > commuteTime) {
					newJob.remove(i);
				}
				continue;
			case "Walk":
				if (newJob.get(i).getWalkTime() > commuteTime) {
					newJob.remove(i);
				}
				continue;
			case "Bike":
				if (newJob.get(i).getBikeTime() > commuteTime) {
					newJob.remove(i);
				}
				continue;
			}
		}
		return newJob;

	}

	// public void updateCommuteTimeAndDistanceGL(List<JobDetails> details) {
	// double curLat = 40.443504;
	// double curLong = -79.941571;
	//
	// StringBuilder sbws = new StringBuilder();
	// StringBuilder sbgl = new StringBuilder();
	// // get all the location lat long
	// for (JobDetails i : details) {
	// sbws.append("&destination=" + i.getLatitude() + ","
	// + i.getLongitude());
	// sbgl.append(i.getLatitude() + "," + i.getLongitude() + "|");
	//
	// }
	// sbgl.deleteCharAt(sbgl.length() - 1);
	//
	// TravelTimeWS[] transitTimes = caculateCommuteTime("transit", curLat,
	// curLong, sbws);
	// Results[] walkTimes = caculateCommuteTimeGL("walking", curLat, curLong,
	// sbgl);
	// Results[] driveTimes = caculateCommuteTimeGL("driving", curLat,
	// curLong, sbgl);
	// Results[] bikeTimes = caculateCommuteTimeGL("bicycling", curLat,
	// curLong, sbgl);
	//
	// // 47.646757,-122.361152
	// for (int j = 0; j < details.size(); j++) {
	// JobDetails i = details.get(j);
	// if (i.getLatitude() != null && i.getLongitude() != null) {
	// // get distance
	// double a = i.getLatitude();
	// double b = i.getLongitude();
	// double distance = caculateDistance(curLat, curLong,
	// i.getLatitude(), i.getLongitude());
	//
	// // commute time by bus
	// int busTime = transitTimes[j].getSeconds();
	// // int busTime = caculateCommuteTime("drive", curLat, curLong,
	// // desLat, desLong);
	//
	// // commute time by walk
	// int walkTime = Integer.parseInt(walkTimes[j].getDuration()
	// .getValue());
	//
	// // commute time by drive
	// int driveTime = Integer.parseInt(driveTimes[j].getDuration()
	// .getValue());
	//
	// // commute time by bike
	// int bikeTime = Integer.parseInt(bikeTimes[j].getDuration()
	// .getValue());
	//
	// int min = Math.min(Math.min(walkTime, driveTime),
	// Math.min(busTime, bikeTime));
	// i.setDistance(distance);
	// i.setDriveTime(driveTime);
	// i.setBikeTime(bikeTime);
	// i.setTransitTime(busTime);
	// i.setWalkTime(walkTime);
	// i.setMinCommuteType(min);
	// }
	// }
	// }
	public void updateCommuteTimeAndDistanceGL(List<JobDetails> details) {
		double curLat = 40.443504;
		double curLong = -79.941571;

		ArrayList<StringBuilder> idgl = new ArrayList<StringBuilder>();
		HashMap<Integer, Results[]> mapWalk = new HashMap<Integer, Results[]>();
		HashMap<Integer, Results[]> mapDrive = new HashMap<Integer, Results[]>();
		HashMap<Integer, Results[]> mapBike = new HashMap<Integer, Results[]>();

		StringBuilder sbws = new StringBuilder();
		StringBuilder sbgl = new StringBuilder();
		// get all the location lat long
		for (int i = 0; i < details.size(); i++) {
			sbws.append("&destination=" + details.get(i).getLatitude() + ","
					+ details.get(i).getLongitude());
			sbgl.append(details.get(i).getLatitude() + ","
					+ details.get(i).getLongitude() + "|");
			if ((i + 1) % 100 == 0) {
				sbgl.deleteCharAt(sbgl.length() - 1);
				idgl.add(new StringBuilder(sbgl));
				sbgl.setLength(0);
			}
		}
		if (details.size() < 100) {
			sbgl.deleteCharAt(sbgl.length() - 1);
			idgl.add(sbgl);
		}

		TravelTimeWS[] transitTimes = calculateCommuteTime("transit", curLat,
				curLong, sbws);

		for (int i = 0; i < idgl.size(); i++) {
			StringBuilder idx = idgl.get(i);
			Results[] walkTimes = calculateCommuteTimeGL("walking", curLat,
					curLong, idx);

			Results[] driveTimes = calculateCommuteTimeGL("driving", curLat,
					curLong, idx);

			Results[] bikeTimes = calculateCommuteTimeGL("bicycling", curLat,
					curLong, idx);

			mapWalk.put(i, walkTimes);
			mapDrive.put(i, driveTimes);
			mapBike.put(i, bikeTimes);
		}

		// 47.646757,-122.361152
		for (int j = 0; j < details.size(); j++) {
			JobDetails i = details.get(j);
			if (i.getLatitude() != null && i.getLongitude() != null) {
				// get distance
				double a = i.getLatitude();
				double b = i.getLongitude();
				double distance = calculateDistance(curLat, curLong,
						i.getLatitude(), i.getLongitude());

				// commute time by bus
				int busTime = transitTimes[j].getSeconds();

				int k = j / 99;
				int l = j - k * 100;
				int walkTime = Integer.MAX_VALUE, driveTime = Integer.MAX_VALUE, bikeTime = Integer.MAX_VALUE;
				// commute time by walk
				if (mapWalk.containsKey(k)) {
					walkTime = Integer.parseInt(mapWalk.get(k)[l].getDuration()
							.getValue());
				}

				// commute time by drive
				if ((mapDrive.containsKey(k))) {
					driveTime = Integer.parseInt(mapDrive.get(k)[l]
							.getDuration().getValue());
				}

				// // commute time by bike
				if (mapBike.containsKey(k)) {
					bikeTime = Integer.parseInt(mapBike.get(k)[l].getDuration()
							.getValue());
				}

				int min = Math.min(Math.min(walkTime, driveTime),
						Math.min(busTime, bikeTime));
				i.setDistance((int) distance);
				i.setDriveTime(driveTime);
				i.setBikeTime(bikeTime);
				i.setTransitTime(busTime);
				i.setWalkTime(walkTime);
				i.setMinCommuteTime(min);
			}
		}
	}

	private Results[] calculateCommuteTimeGL(String commuteType, double curLat,
			double curLong, StringBuilder sbgl) {
		StringBuilder urlString = new StringBuilder(
				"https://maps.googleapis.com/maps/api/distancematrix/json?");
		urlString.append("origins=" + curLat + "," + curLong);
		urlString.append("&destinations=" + sbgl);
		urlString.append("&key=AIzaSyBwt9e578fMqY9A0EfiLEr7pj-s9fjfZj4");
		urlString.append("&mode=" + commuteType);
		urlString.append("&language=en-EN");
		URL url;
		TravelTimeListing ttl = null;
		try {
			url = new URL(urlString.toString());

			HttpURLConnection con;

			con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("GET");

			BufferedReader br = new BufferedReader(new InputStreamReader(
					con.getInputStream()));

			StringBuilder response = new StringBuilder();
			String output;
			while ((output = br.readLine()) != null) {
				response.append(output);
			}

			Gson gson = new Gson();
			ttl = gson.fromJson(response.toString(), TravelTimeListing.class);

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (ttl != null) {
			return ttl.getRows()[0].getElements();
		} else {
			return null;
		}

	}

	private TravelTimeWS[] calculateCommuteTime(String commuteType,
			double curLat, double curLong, StringBuilder sbws) {
		StringBuilder urlString = new StringBuilder(
				"http://api2.walkscore.com/api/v1/traveltime/json?");

		urlString.append("wsapikey=" + wsapikey);
		urlString.append("&mode=" + commuteType);
		urlString.append("&origin=" + curLat + "," + curLong);
		urlString.append(sbws);
		URL url;
		TravelTimeListingWS ttl = null;
		try {
			url = new URL(urlString.toString());

			HttpURLConnection con;

			con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("GET");

			BufferedReader br = new BufferedReader(new InputStreamReader(
					con.getInputStream()));

			// private Results[] caculateCommuteTimeGL(String commuteType,
			// double
			// curLat,
			// double curLong, StringBuilder sbgl) {
			// StringBuilder urlString = new StringBuilder(
			// "http://maps.googleapis.com/maps/api/distancematrix/json?");
			// urlString.append("origins=" + curLat + "," + curLong);
			// urlString.append("&destinations=" + sbgl);
			// urlString.append("&mode=" + commuteType);
			// urlString.append("&language=en-EN");
			// URL url;
			// TravelTimeListing ttl = null;
			// try {
			// url = new URL(urlString.toString());
			//
			// HttpURLConnection con;
			//
			// con = (HttpURLConnection) url.openConnection();
			//
			// con.setRequestMethod("GET");
			//
			// BufferedReader br = new BufferedReader(new InputStreamReader(
			// con.getInputStream()));
			//
			// StringBuilder response = new StringBuilder();
			// String output;
			// while ((output = br.readLine()) != null) {
			// response.append(output);
			// }
			//
			// Gson gson = new Gson();
			// ttl = gson.fromJson(response.toString(),
			// TravelTimeListing.class);
			//
			// } catch (MalformedURLException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// } catch (IOException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// }
			// return ttl.getRows()[0].getElements();
			//
			// }
			StringBuilder response = new StringBuilder();
			String output;
			while ((output = br.readLine()) != null) {
				response.append(output);
			}

			// private TravelTimeWS[] caculateCommuteTime(String commuteType,
			// double curLat, double curLong, StringBuilder sbws) {
			// StringBuilder urlString = new StringBuilder(
			// "http://api2.walkscore.com/api/v1/traveltime/json?");
			//
			// urlString.append("wsapikey=" + wsapikey);
			// urlString.append("&mode=" + commuteType);
			// urlString.append("&origin=" + curLat + "," + curLong);
			// urlString.append(sbws);
			// URL url;
			// TravelTimeListingWS ttl = null;
			// try {
			// url = new URL(urlString.toString());
			//
			// HttpURLConnection con;
			//
			// con = (HttpURLConnection) url.openConnection();
			//
			// con.setRequestMethod("GET");
			//
			// BufferedReader br = new BufferedReader(new InputStreamReader(
			// con.getInputStream()));
			//
			// StringBuilder response = new StringBuilder();
			// String output;
			// while ((output = br.readLine()) != null) {
			// response.append(output);
			// }
			//
			// Gson gson = new Gson();
			// ttl = gson.fromJson(response.toString(),
			// TravelTimeListingWS.class);
			//
			// } catch (MalformedURLException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// } catch (IOException e) {
			// // TODO Auto-generated catch block
			// e.printStackTrace();
			// }
			// return ttl.getResponse().getResults()[0].getTravel_times();
			// }
			Gson gson = new Gson();
			ttl = gson.fromJson(response.toString(), TravelTimeListingWS.class);

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (ttl != null) {
			return ttl.getResponse().getResults()[0].getTravel_times();
		} else {
			return null;
		}
	}

	public List<JobDetails> getAllJobsInCity(String location) {

		return jobSearchDao.getJobetailsInCity(location);
	}
}
