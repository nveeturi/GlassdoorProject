package com.glassdoor.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.SAXException;

import com.glassdoor.databean.JobDetails;
import com.glassdoor.jobsearch.JobSearchService;
import com.glassdoor.jobsearch.UserService;

@RestController
public class HomeController {
	@Autowired
	private JobSearchService jobService;
	@Autowired
	private UserService userService;
	public static Logger logger = Logger.getLogger(HomeController.class);
	List<JobDetails> jobs = null;

	/***
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("/index");
		return mav;
	}
	
	@RequestMapping(value = "register.do", method = RequestMethod.POST)
	public ModelAndView register(String username, String password) {
		ModelAndView mav = new ModelAndView("/profile");
		userService.addUser(username, password);
		mav.addObject("username", username);
		return mav;
	}
	
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public ModelAndView login(String username, String password) {
		ModelAndView mav = new ModelAndView("/profile");
		mav.addObject("username", username);
		return mav;
	}
	
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
			// TODO Auto-generated catch block
			e.printStackTrace();
			mav =  new ModelAndView("error");
		}
		mav.addObject("keyword", keyword);
		mav.addObject("location", location);
		mav.addObject("joblist", jobdetails);
		return mav;
	}
	
	@RequestMapping(value = "search", method = RequestMethod.POST)
	public ModelAndView search(String keyword, String location, String pageCount) {
		ModelAndView mav = new ModelAndView("/jobs");
	
		try{
		logger.info("Search is made with keyword "+keyword + " and city "+location);
		jobs = jobService.getAllJobsInCity(location);
		jobService.updateCommuteTimeAndDistanceGL(jobs);
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
		List<JobDetails> jobs = null;
		try{
		logger.info("Search is made with keyword "+keyword + " and city "+location);
		jobs = jobService.getAllJobsInCity(location);

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
	
	@RequestMapping(value = "searchws", method = RequestMethod.GET)
	public List<JobDetails> searchws(String keyword, String location) {
		List<JobDetails> jobdetails = null;
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "Pittsburgh" : URLEncoder.encode(location,
					"UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");

			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode,true,1,50);
			jobdetails=jobService.matchLatLongFromJobList(jobdetails);
//			jobService.updateCommuteTimeAndDistanceGL(jobdetails);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		}
		return jobdetails;
	}
	
	@RequestMapping(value = "sort", method = RequestMethod.POST) 
	public ModelAndView sort(String criteria) { 
		ModelAndView mav = new ModelAndView("/jobs");
		try{
		jobService.sortJobList(jobs,criteria);//distance or commute time
		mav.addObject("joblist", jobs);
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
	
	@RequestMapping(value ="filter", method = RequestMethod.POST) 
	public ModelAndView filter(String distance, String commuteTime, String commuteType) { 
		ModelAndView mav = new ModelAndView("/jobs");
		try{
		String dis = distance.split(" ")[1];
		String com = commuteTime.substring(2, 4);
		List<JobDetails> newJobs = jobService.refineSearch(jobs, Integer.parseInt(dis), Integer.parseInt(com)*60, commuteType);//filter
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
	
	
	@RequestMapping(value = "/updateLocation", method = RequestMethod.GET)
	public ModelAndView updateLocation() {
		ModelAndView mav = new ModelAndView("/batch");
		try {
			logger.info("Initiating updateLocation batch");
			jobService.updateLocationInfo();
		} catch (XPathExpressionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			mav = new ModelAndView("error");
			mav.addObject("message", e.getMessage());
		} catch (SAXException e) {
			// TODO Auto-generated catch block
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

	@RequestMapping(value = "/updateJobData/{keyword}/{location}", method = RequestMethod.GET)
	public ModelAndView updateJobData(@PathVariable String keyword,
			@PathVariable String location) {
		ModelAndView mav = new ModelAndView("/batch");
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
			// TODO Auto-generated catch block
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
	public ModelAndView profile() {
		ModelAndView mav = new ModelAndView("profile");
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
