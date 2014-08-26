package com.glassdoor.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.SAXException;

import com.glassdoor.databean.JobDetails;
import com.glassdoor.jobsearch.JobSearchService;
import com.glassdoor.jobsearch.UserService;

/**
 * The single Controller intercepts all the request and redirects
 * to the appropriate view and calls the services accordingly to 
 * display the desired data.
 * @author Glassdoor Practicum Team
 * MSIT eBusiness Technology 2014 -  Carnegie Mellon University
 *
 */
@RestController
@SessionAttributes({"usename"})
public class HomeController {
	@Autowired
	private JobSearchService jobService;
	@Autowired
	private UserService userService;
	public static Logger logger = Logger.getLogger(HomeController.class);
	List<JobDetails> jobs = null;

	/***
	 * The welcome page
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("/index");
		return mav;
	}
	
	/**
	 * This action handles the registration of new users and save their profile in database
	 * and redirects to their profile page.
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "register.do", method = RequestMethod.POST)
	public ModelAndView register(String username, String password) {
		ModelAndView mav = new ModelAndView("/profile");
		userService.addUser(username, password);
		mav.addObject("username", username);
		return mav;
	}
	
	/**
	 * The action handles the login of the existing users and redirects the user 
	 * to their profile page.
	 * @param username
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public ModelAndView login(String username, String password) {
		ModelAndView mav = new ModelAndView("/profile");
		mav.addObject("username", username);
		return mav;
	}
	
	/**
	 * This action calls the glassdoor search API to fetch all the results for the search keyword
	 * and location. It then matches the job data with the data available in local database
	 * for which geo location is available. Then the commute time is calculated and displayed in the
	 * view. 
	 * @param keyword
	 * @param location
	 * @param pageCount
	 * @return
	 */
	@RequestMapping(value = "searchGlassdoor", method = RequestMethod.POST)
	public ModelAndView searchGlassdoor(String keyword, String location, String pageCount) {
		ModelAndView mav = new ModelAndView("/jobs");
		List<JobDetails> jobdetails = null;
		logger.info("Search is made with keyword "+keyword + " and city "+location);
		if(pageCount == null){
			pageCount = "1";
		}
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "Pittsburgh" : URLEncoder.encode(location,
					"UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");

			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode,true,1,50);
			jobdetails=jobService.matchLatLongFromJobList(jobdetails);
			jobService.updateCommuteTimeAndDistanceGL(jobdetails);

		} catch (IOException e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message",e.getMessage());
			return mav;
		}
		mav.addObject("keyword", keyword);
		mav.addObject("location", location);
		mav.addObject("joblist", jobdetails);
		return mav;
	}
	
	/**
	 * The action fetches all the job data form the database along with the 
	 * street address and geo location data and displays in the list and map format
	 * along with the commute time.
	 * 
	 * @param keyword
	 * @param location
	 * @param pageCount
	 * @return
	 */
	@RequestMapping(value = "search", method = RequestMethod.POST)
	public ModelAndView search(String keyword, String location, String pageCount) {
		ModelAndView mav = new ModelAndView("/jobs");
	
		try{
			logger.info("Search is made with keyword "+keyword + " and city "+location);
			if(jobs == null) {
				jobs = jobService.getAllJobsInCity(location);
				jobService.updateCommuteTimeAndDistanceGL(jobs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message",e.getMessage());
			return mav;
		}

		mav.addObject("keyword", keyword);
		mav.addObject("location", location);
		mav.addObject("joblist", jobs);
		return mav;
	}
	
	@RequestMapping(value = "searchJob", method = RequestMethod.GET)
	public ModelAndView searchJob(String keyword, String location) {
		ModelAndView mav = new ModelAndView("/jobs");
		
		try{
			logger.info("Search is made with keyword "+keyword + " and city "+location);
			if(jobs == null) {
				jobs = jobService.getAllJobsInCity(location);
				jobService.updateCommuteTimeAndDistanceGL(jobs);
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("message",e.getMessage());
			return  new ModelAndView("error");
		}
		mav.addObject("keyword", keyword);
		mav.addObject("location", location);
		mav.addObject("joblist", jobs);
		return mav;
	}
	
	/**
	 * Returns the job details for the search keyword and location
	 * @param keyword
	 * @param location
	 * @return
	 */
	@RequestMapping(value = "searchws", method = RequestMethod.GET)
	public List<JobDetails> searchws(String keyword, String location) {
		List<JobDetails> jobdetails = null;
		try {
			String locationEncode = (location == null || 
					location.trim().equals("")) ? "Pittsburgh" : URLEncoder.encode(location,"UTF-8");
			String keywordEncode = (keyword == null || keyword.trim().equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");
			
			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,locationEncode,true,1,50);
			jobdetails=jobService.matchLatLongFromJobList(jobdetails);
			jobService.updateCommuteTimeAndDistanceGL(jobdetails);
		
		} catch (Exception e) {
			e.printStackTrace();
		}
			
			
		return jobdetails;
	}
	
	
	@RequestMapping(value = "searchmap", method = RequestMethod.GET)
	public List<JobDetails> searchmap(String keyword, String location) {
		try {
			if(jobs == null) {
				jobs = jobService.getAllJobsInCity(location);
				jobService.updateCommuteTimeAndDistanceGL(jobs);
			}

		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return jobs;
	}
	
	/**
	 * The action is used to sort the job data that is displayed in the list view
	 * based on the criteria such as, commute time and the distance.
	 * @param criteria
	 * @return
	 */
	@RequestMapping(value = "sort", method = RequestMethod.POST) 
	public ModelAndView sort(String criteria) { 
		ModelAndView mav = new ModelAndView("/jobs");
		try{
			List<JobDetails> tmpJobs = new ArrayList<JobDetails>(jobs);
			jobService.sortJobList(tmpJobs,criteria);//distance or commute time
			mav.addObject("joblist", tmpJobs);
		}
		catch(Exception e){
			e.printStackTrace();
			mav  =  new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		}
		return mav;
	}
	
	@RequestMapping(value = "sortws", method = RequestMethod.POST) 
	public List<JobDetails> sortws(String criteria) { 
		jobService.sortJobList(jobs,criteria);//distance or commute time
		return jobs;
	}
	
	/**
	 * The action filters the job data displayed in the list view based on the 
	 * @param distance
	 * @param commuteTime
	 * @param commuteType
	 * @return
	 */
	@RequestMapping(value ="filter", method = RequestMethod.POST) 
	public ModelAndView filter(String distance, String commuteTime, String commuteType) { 
		ModelAndView mav = new ModelAndView("/jobs");
		try{
		String dis = distance.split(" ")[1];
		String com = commuteTime.substring(2, 4);
		List<JobDetails> newJobs = jobService.refineSearch(jobs, Integer.parseInt(dis), Integer.parseInt(com), commuteType);//filter
		mav.addObject("joblist", newJobs);
		}
		catch(Exception e){
			e.printStackTrace();
			mav  =  new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		}
		return mav;
	}
	
	@RequestMapping(value ="filterws", method = RequestMethod.POST) 
	public List<JobDetails> filterws(String distance, String commuteTime, String commuteType) { 
		List<JobDetails> jobdetails = null;
		String dis = distance.split(" ")[1];
		String com = commuteTime.substring(2, 4);
		return jobService.refineSearch(jobdetails, Integer.parseInt(dis), Integer.parseInt(com)*60, commuteType);//filter
	}
	
	/**
	 * This action exposes the rest web service to update the jobs
	 * available in the database with the geo location data using third party REST
	 * services such as, Career Builder API, Google Maps API and SmartyStreet API
	 * to find the lat/long and street address.
	 * @return
	 */
	@RequestMapping(value = "/updateLocation", method = RequestMethod.GET)
	public ModelAndView updateLocation() {
		ModelAndView mav = new ModelAndView("/batchservice");
		try {
			logger.info("Initiating updateLocation batch");
			jobService.updateLocationInfo();
		} catch (XPathExpressionException e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		} catch (SAXException e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		}
		return mav;
	}
	
	/**
	 * This action exposes the rest webservice that makes search in Glassdoor
	 * database using the search API and then uploads it in the local database.
	 * This can be used as a batch service to dump the data in the local database
	 * with job details and the city / location.
	 * 
	 * @param keyword
	 * @param location
	 * @return
	 */
	@RequestMapping(value = "/updateJobData/{keyword}/{location}", method = RequestMethod.GET)
	public ModelAndView updateJobData(@PathVariable String keyword,
			@PathVariable String location) {
		ModelAndView mav = new ModelAndView("/batchservice");
		List<JobDetails> jobdetails = null;
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "" : URLEncoder.encode(location, "UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");
			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode, true, 1, 50);
		
		jobService.saveJobDetails(jobdetails);
		} catch (IOException e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		}
		catch (Exception e) {
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		}
		return mav;
	}

	/**
	 * This action is exposed as rest web service to get all the jobs available in the database and returns
	 * the job data in JSON format.
	 * @return
	 */
	@RequestMapping(value = "/getJobsData", method = RequestMethod.GET)
	public List<JobDetails> getAllJobsFromDB() {
		List<JobDetails> details = null;
		try{
		details =  jobService.getAllJobsFromDB();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return details;
	}

	/**
	 * This action is exposed as a rest web service to get the job details of a
	 * certain job with glassdoor jobId. This returns the response in JSON format
	 * @param jobId
	 * @return
	 */
	@RequestMapping(value = "/getJobsData/{jobId}", method = RequestMethod.GET)
	public JobDetails getJobForId(@PathVariable String jobId) {
		JobDetails details = null;
		try{
		details = jobService.getJobForId(jobId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return details;

	}

	/**
	 * This action is exposed as a rest web service to get the job details of a list of
	 * glassdoor jobIds. This returns the response in JSON format.
	 * @param jobIds
	 * @return
	 */
	@RequestMapping(value = "/getJobsData/list/{ids}", method = RequestMethod.GET)
	public List<JobDetails> getJobs(@PathVariable("ids") String jobIds) {
		List<JobDetails> details = null;
		try{
			details = jobService.getJobDataForIds(jobIds);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return details;
	}

	@RequestMapping("jobs")
	public ModelAndView jobs() {
		ModelAndView mav = new ModelAndView("/jobs");
		return mav;
	}

	@RequestMapping("map")
	public ModelAndView map() {
		ModelAndView mav = new ModelAndView("map");
		return mav;
	}
	
	@RequestMapping("login")
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView("login");
		return mav;
	}
	
	@RequestMapping("register")
	public ModelAndView register() {
		ModelAndView mav = new ModelAndView("register");
		return mav;
	}
	
	@RequestMapping("profile")
	public ModelAndView profile(@ModelAttribute("username") String username) {
		ModelAndView mav = new ModelAndView("profile");
		username = "Jessica";
		mav.addObject("username", username);
		
		return mav;
	}
	
	@RequestMapping("batch")
	public ModelAndView batchList() {
		ModelAndView mav = new ModelAndView("batchservice");
		return mav;
	}
	@RequestMapping("test")
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView("test");
		return mav;
	}
	
	@RequestMapping("error")
	public ModelAndView error() {
		ModelAndView mav = new ModelAndView("error");
		return mav;
	}

	public void setJobService(JobSearchService jobService) {
		this.jobService = jobService;
	}
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
}
