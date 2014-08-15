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
import java.util.HashSet;
import java.util.List;
import java.util.Random;

import javax.net.ssl.SSLHandshakeException;
import javax.net.ssl.SSLProtocolException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.codehaus.jackson.map.ObjectMapper;
import org.jsoup.HttpStatusException;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import com.glassdoor.constant.Constants;
import com.glassdoor.dao.JobSearchDAO;
import com.glassdoor.databean.GMapResponse;
import com.glassdoor.databean.GMapResult;
import com.glassdoor.databean.GlassdoorJobData;
import com.glassdoor.databean.GoogleResponse;
import com.glassdoor.databean.GoogleResult;
import com.glassdoor.databean.JobDetails;
import com.glassdoor.databean.JobListing;
import com.glassdoor.databean.Location;
import com.google.gson.Gson;

/**
 * The class contains all the services that are required to get the job data
 * from Glassdoor. This also contains the services to update the database with
 * geo-location data.
 * 
 * @author nveeturi
 * 
 */
public class JobSearchService {

	private JobSearchDAO jobSearchDao;

	public List<JobDetails> getAllJobsFromDB() {

		return jobSearchDao.getJobetailsFromDB();
	}

	public JobDetails getJobForId(String jobId) {

		System.out.println("ids");
		return jobSearchDao.getJobDetailsForSearch(jobId);
	}

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

			System.out.println(pageNum);

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

	public void saveJobDetails(List<JobDetails> jobdetails) {

		System.out.println("Saving Job Details: " + jobdetails);
		jobSearchDao.insertJobDetails(jobdetails);

	}

	public List<JobDetails> getCBJobData() {
		List<JobDetails> details = null;
		details = jobSearchDao.getCBJobDetails();
		return details;
	}

	public void updateLocation(String jobTitle, String city, JobDetails details)
			throws XPathExpressionException, SAXException, IOException,
			ParserConfigurationException {

		if (details.getJobRefID() != null && !details.getJobRefID().equals("")) {
			callCBJobRefURL(details);
		} else if (details.getLatitude() == null) {
			int pageNum = 1;
			int totalpages = 1;
			HttpURLConnection con = null;

			while (pageNum <= totalpages) {
				StringBuilder urlString = new StringBuilder(
						"http://api.careerbuilder.com/v1/jobsearch?");
				urlString.append("DeveloperKey=" + Constants.CB_API_KEY);
				urlString.append("&Keywords=" + jobTitle);
				urlString.append("&Location=" + city);
				urlString.append("&PageNumber=" + pageNum);
				URL url = new URL(urlString.toString());
				StringBuilder response = null;
				try {
					System.out.println("Processing page number: " + pageNum);
					con = (HttpURLConnection) url.openConnection();
					con.setRequestMethod("GET");
					BufferedReader br = new BufferedReader(
							new InputStreamReader((con.getInputStream())));
					response = new StringBuilder();
					pageNum++;
					String output;
					while ((output = br.readLine()) != null) {
						response.append(output);
					}
				} catch (IOException e) {
					System.out.println(e.getMessage());
					if (e.getMessage().contains("400")) {
						break;
					}

				}
				DocumentBuilderFactory builderFactory = DocumentBuilderFactory
						.newInstance();
				DocumentBuilder builder = builderFactory.newDocumentBuilder();
				Document document = builder.parse(new ByteArrayInputStream(
						response.toString().getBytes()));

				// parse xml with Xpath
				XPath xPath = XPathFactory.newInstance().newXPath();
				String expression = "/ResponseJobSearch/TotalPages";
				String totalPageStr = xPath.compile(expression).evaluate(
						document);
				System.out.println("totalPageStr" + totalPageStr);
				totalpages = Integer.parseInt(totalPageStr);
				if (totalpages == 0) {
					break;
				}
				expression = "/ResponseJobSearch/Results/JobSearchResult/JobServiceURL";

				// read a nodelist using xpath
				String cbServiceUrl = xPath.compile(expression).evaluate(
						document);
				expression = "/ResponseJobSearch/Results/JobSearchResult/DID";

				String jobDID = xPath.compile(expression).evaluate(document);

				if (callCBServiceURL(cbServiceUrl, con, response, builder,
						builderFactory, details, expression, document, xPath,
						jobDID)) {
					break;
				}

			}
		}

	}

	private boolean callCBServiceURL(String cbServiceUrl,
			HttpURLConnection con, StringBuilder response,
			DocumentBuilder builder, DocumentBuilderFactory builderFactory,
			JobDetails details, String expression, Document document,
			XPath xPath, String jobDID) throws IOException,
			ParserConfigurationException, XPathExpressionException,
			SAXException {

		URL serviceurl = new URL(cbServiceUrl);
		con = (HttpURLConnection) serviceurl.openConnection();
		con.setRequestMethod("GET");
		BufferedReader br = new BufferedReader(new InputStreamReader(
				(con.getInputStream())));
		response = new StringBuilder();
		String output;
		while ((output = br.readLine()) != null) {
			response.append(output);
		}

		builder = builderFactory.newDocumentBuilder();
		document = builder.parse(new ByteArrayInputStream(response.toString()
				.getBytes()));

		expression = "/ResponseJob/Job/DisplayJobID";
		String jobId = xPath.compile(expression).evaluate(document);
		System.out.println("Job Ref ID = " + details.getJobRefID()
				+ " parse Job ID = " + jobId + " parse DID  = " + jobDID);
		if (details.getJobId().equals(jobId)
				|| details.getJobId().equals(jobDID)) {
			expression = "/ResponseJobSearch/Results/JobSearchResult/LocationLatitude";
			String latitude = xPath.compile(expression).evaluate(document);
			details.setLatitude(Double.valueOf(latitude));
			expression = "/ResponseJobSearch/Results/JobSearchResult/LocationLongitude";
			String longitude = xPath.compile(expression).evaluate(document);
			details.setLongitude(Double.valueOf(longitude));
			return true;

		}
		return false;

	}

	public void callCBJobRefURL(JobDetails details) throws IOException,
			ParserConfigurationException, SAXException,
			XPathExpressionException {
		System.out.println(details.getJobRefID());
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

	}

	public List<JobDetails> updateLocationFromCB() throws IOException,
			ParserConfigurationException, SAXException,
			XPathExpressionException {
		List<JobDetails> details = getCBJobData();
		for (JobDetails jobDetails : details) {
			System.out.println("Job ID processing: " + jobDetails.getJobId());

			String jobTitle = jobDetails.getJobTitle();
			String city = jobDetails.getCity();
			updateLocation(URLEncoder.encode(jobTitle, "UTF-8"),
					URLEncoder.encode(city, "UTF-8"), jobDetails);
			// Check if the lat-long maps to the correct address

			validateFromGoogleAPI(jobDetails);
			// if it does not match with the company's address or does not have
			// the company name, set it back to null

		}
		saveJobDetails(details);
		return details;

	}

	private void validateFromGoogleAPI(JobDetails jobDetails)
			throws IOException {

		if (jobDetails.getLatitude() == null
				|| jobDetails.getLongitude() == null) {
			return;
		}
		// Call Maps API to get the nearest company location from the lat/long
		// available

		String latlong = jobDetails.getLatitude().toString() + ","
				+ jobDetails.getLongitude().toString();

		setValidAddress(latlong, jobDetails);

	}

	private void setValidAddress(String latlong, JobDetails jobDetails)
			throws IOException {
		String address = "";
		GMapResponse grsp = getNearByLocation(latlong,
				jobDetails.getCompanyName());

		if (grsp != null) {
			System.out.println("getNearByLocation" + grsp.getStatus());
			if (grsp.getStatus().equals("OK")) {
				System.out.println(grsp.getResults().length);
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

				System.out.println("address is :" + address);

				if (!address.equals("") && !latlong.equals("")) {
					if (address.split(",").length < 2) {
						GoogleResponse resp = convertFromLatLong(latlong);
						if (resp.getResults().length > 0) {
							GoogleResult result = resp.getResults()[0];
							setAddressDetails(result.getFormatted_address(),
									jobDetails);
							System.out.println(result.getFormatted_address());
						}
					} else {
						grsp = getTextLocation(address);
						if (grsp.getResults().length > 0) {
							GMapResult result = (GMapResult) grsp.getResults()[0];
							setAddressDetails(result.getFormatted_address(),
									jobDetails);
							System.out.println(result.getFormatted_address());
						}
					}
				}
			} else {
				jobDetails.setLatitude(null);
				jobDetails.setLongitude(null);
			}

		}
	}

	private String removeSpecialChar(String input) {
		input = input.replaceAll("[^a-zA-Z0-9]+", "");

		return input;

	}

	private void setAddressDetails(String formattedAddress,
			JobDetails jobDetails) {
		if (!formattedAddress.equals("")) {
			String[] splitAddress = formattedAddress.split(",");
			jobDetails.setStreetName1(splitAddress[0].trim());

			String[] stateZip = null;
			String streetNm2 = "";
			String city = "";

			if (splitAddress.length == 5) {
				streetNm2 = splitAddress[1].trim();
				city = splitAddress[2].trim();
				stateZip = splitAddress[3].trim().split("\\s");
			} else if (splitAddress.length == 4) {
				city = splitAddress[1].trim();
				stateZip = splitAddress[2].trim().split("\\s");
			}

			jobDetails.setCity(city);
			jobDetails.setStreetName2(streetNm2);
			jobDetails.setState(stateZip[0]);
			if (stateZip.length > 1) {
				jobDetails.setZipCode(stateZip[1]);
			}

		}
	}

	public GMapResponse getNearByLocation(String latlongString,
			String companyName) throws IOException {
		if (companyName == null || companyName.equals("")) {
			return null;
		}

		URL url = new URL(Constants.MAPS_NEARBY_URL + "?location="
				+ URLEncoder.encode(latlongString, "UTF-8")
				+ "&rankby=distance&name="
				+ URLEncoder.encode(companyName, "UTF-8") + "&key="
				+ Constants.MAPS_API_KEY);
		// Open the Connection
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		System.out.println(conn);
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GMapResponse response = (GMapResponse) mapper.readValue(in,
				GMapResponse.class);
		in.close();
		return response;

	}

	public GMapResponse getTextLocation(String textSearch) throws IOException {

		URL url = new URL(Constants.MAPS_TEXT_SEARCH_URL + "?query="
				+ URLEncoder.encode(textSearch, "UTF-8") + "&key="
				+ Constants.MAPS_API_KEY);
		// Open the Connection
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GMapResponse response = (GMapResponse) mapper.readValue(in,
				GMapResponse.class);
		in.close();
		return response;

	}

	public GoogleResponse convertFromLatLong(String latlongString)
			throws IOException {

		URL url = new URL(Constants.GEOCODE_URL + "?latlng="
				+ URLEncoder.encode(latlongString, "UTF-8") + "&sensor=false");
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GoogleResponse response = (GoogleResponse) mapper.readValue(in,
				GoogleResponse.class);
		in.close();
		return response;

	}

	public GoogleResponse getLocationLatLong(String locationName)
			throws IOException {

		URL url = new URL(Constants.GEOCODE_URL + "?address="
				+ URLEncoder.encode(locationName, "UTF-8"));
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		InputStream in = conn.getInputStream();
		ObjectMapper mapper = new ObjectMapper();
		GoogleResponse response = (GoogleResponse) mapper.readValue(in,
				GoogleResponse.class);
		in.close();
		return response;

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

		// Traverse through all the records that do not have lat-long
		List<JobDetails> details = null;
		JobSearchDAO dao = new JobSearchDAO();
		details = dao.getJobDetailsWithNoLocation();

		for (JobDetails jobDetails : details) {
			try {
				String latlong = "";

				// Check if the lat long is available in Career Builder
				if (jobDetails.getSource().equals("CareerBuilder")
						&& !(jobDetails.getJobRefID() == null || jobDetails
								.getJobRefID() == "")) {
					callCBJobRefURL(jobDetails);
				}

				if (jobDetails.getLatitude() != null
						|| jobDetails.getLongitude() != null) {
					latlong = jobDetails.getLatitude().toString() + ","
							+ jobDetails.getLongitude().toString();
				}
				if (latlong.equals("")) {
					// Get the lat-long of the City
					GoogleResponse res = getLocationLatLong(jobDetails
							.getCity());
					if (res.getResults() != null && res.getResults().length > 0) {
						Location loc = res.getResults()[0].getGeometry()
								.getLocation();
						latlong = loc.getLat() + "," + loc.getLng();
					}
				}

				// Call the nearby search Google Places API with the company
				// name and latlong
				if (!latlong.equals("")) {
					setValidAddress(latlong, jobDetails);
				}

				if (latlong.equals("")
						&& !(jobDetails.getJobLink() == null || jobDetails
								.getJobLink().equals(""))) {
					updateLocationFromJobLink(jobDetails);
				}

			} catch (IOException e) {
				System.out.println(e.getLocalizedMessage());
				continue;

			}

		}

		// If it is a single location single company, we will get one
		// record
		// If it is a single company in each location, we will get one
		// result

		// If many outlets in single city, we will get many results
		saveJobDetails(details);

		// For such records, we will call Career builder API if the source
		// is
		// Careerbuilder
		// For remaining records, we will try to scrape the company's
		// website
		// and get the location information
		// Save in the database

	}

	public void updateLocationFromJobLink(JobDetails jobDetails) {
		try {
			// STEP 4: Execute a query
			org.jsoup.nodes.Document doc = null;
			boolean flag = false;
			// STEP 5: Extract data from result set
			String link = "";
			System.out.println(jobDetails.getJobLink());
			link = jobDetails.getJobLink();
			try {
				doc = Jsoup.connect(link).ignoreContentType(true).timeout(0)
						.get();
			} catch (HttpStatusException hp) {
				flag = true;
			} catch (SSLHandshakeException e) {
				flag = true;
			} catch (MalformedURLException e) {
				flag = true;
			} catch (SSLProtocolException e) {
				flag = true;
			} catch (Exception e) {
				flag = true;
			}
			if (flag) {
				System.out.println("Error occured");
				flag = false;
				return;
				// continue;
			}
			Elements elements = doc.body().select("*");

			for (Element x : elements) {
				// System.out.println(x.ownText());
				String text = x.ownText();
				String[] words = text.split("\\s+");
				for (String word : words) {
					if (Arrays.asList(Constants.US_STATES).contains(word)
							|| Arrays.asList(Constants.StateCodes).contains(
									word)) {
						System.out.println("Address found");
						System.out.println(text);
						return;
					} else {
						System.out.println("-------------Address not found");
					}
				}
			}

			// STEP 6: Clean-up environment

		} catch (Exception e) {
			// Handle errors for Class.forName
			e.printStackTrace();
		}

		// saveJobDetails(details);

		System.out.println("Goodbye!");
	}// end main

	public void setJobSearchDao(JobSearchDAO jobSearchDao) {
		this.jobSearchDao = jobSearchDao;
	}

	public List<JobDetails> getJobDataForIds(String jobIds) {

		return jobSearchDao.getJobsForIds(jobIds);
	}

	public void matchLatLongFromJobList(List<JobDetails> details) {
		List<JobDetails> JobListWithLatLong = jobSearchDao.getLatLong(details);
		// match lat long to job details list
		for (JobDetails i : details) {
			boolean found = false;
			for (JobDetails j : JobListWithLatLong) {
				if (i.getJobId().equals(j.getJobId())) {
					found = true;
					if(j.getLatitude() == null) {
						i.setLatitude(0.0);
						i.setLongitude(0.0);
						break;
					}else{
						i.setLatitude(j.getLatitude());
						i.setLongitude(j.getLongitude());
						break;
					}
				}
			}
			if(!found) {
				i.setLatitude(0.0);
				i.setLongitude(0.0);
			}
		}
	}

	public void updateCommuteTimeAndDistance(List<JobDetails> details) {
		// double curLat = 40.4435386;
		// double curLong = -79.94435829999998;
		double curLat = 47.649677;
		double curLong = -122.357569;
		double desLat = 47.646757;
		double desLong = -122.361152;
		// 47.646757,-122.361152
		for (JobDetails i : details) {
			if (i.getLatitude() != null && i.getLongitude() != null) {
				// get distance
				double a = i.getLatitude();
				double b = i.getLongitude();
				double distance = caculateDistance(curLat, curLong,
						i.getLatitude(), i.getLongitude());

				// // commute time by drive
				// // int busTime = caculateCommuteTime("drive", curLat,
				// curLong,
				// // i.getLatitude(), i.getLongitude());
				// int busTime = caculateCommuteTime("drive", curLat, curLong,
				// desLat, desLong);
				//
				// // commute time by walk
				// int walkTime = caculateCommuteTime("walk", curLat, curLong,
				// i.getLatitude(), i.getLongitude());
				//
				// // commute time by bus
				// int transitTime = caculateCommuteTime("transit", curLat,
				// curLong, i.getLatitude(), i.getLongitude());
				//
				// // commute time by bike
				// int bikeTime = caculateCommuteTime("bike", curLat, curLong,
				// i.getLatitude(), i.getLongitude());

				i.setDistance(distance);

				Random r = new Random();
				i.setDriveTime(r.nextInt(10000));
				i.setBikeTime(r.nextInt(10000));
				i.setTransitTime(r.nextInt(10000));
				i.setWalkTime(r.nextInt(10000));

				// i.setDriveTime(busTime);
				// i.setBikeTime(bikeTime);
				// i.setTransitTime(transitTime);
				// i.setWalkTime(walkTime);

			}
		}

	}

	private double caculateDistance(double initialLat, double initialLong,
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
			if (o1.getDistance() == null) {
		        return (o2.getDistance() == null) ? 0 : -1;
		    }
		    if (o2.getDistance() == null) {
		        return -1;
		    }
			return (int) (o2.getDistance() - o1.getDistance());
		}
	};
	private static Comparator<JobDetails> CommuteTimecomparator = new Comparator<JobDetails>() {
		public int compare(JobDetails o1, JobDetails o2) {
			if (o1.getTransitTime()== 0) {
		        return (o2.getTransitTime() == 0) ? 0 : -1;
		    }
		    if (o2.getTransitTime()== 0) {
		        return -1;
		    }
			return o2.getTransitTime() - o1.getTransitTime();
		}
	};

	public ArrayList<JobDetails> refineSearch(List<JobDetails> jobdetails,
			int distance, int commuteTime, String commuteType) {
		ArrayList<JobDetails> newJob = (ArrayList<JobDetails>) jobdetails;
		for (int i = 0; i < newJob.size(); i++) {
			if (newJob.get(i).getDistance() > distance) {
				newJob.remove(i);
			}
			switch (commuteType) {
			case "bus":
				if (newJob.get(i).getTransitTime() > commuteTime) {
					newJob.remove(i);
				}
			case "drive":
				if (newJob.get(i).getDriveTime() > commuteTime) {
					newJob.remove(i);
				}
			case "walk":
				if (newJob.get(i).getWalkTime() > commuteTime) {
					newJob.remove(i);
				}
			case "bike":
				if (newJob.get(i).getBikeTime() > commuteTime) {
					newJob.remove(i);
				}
			}
		}
		return newJob;

	}
}
