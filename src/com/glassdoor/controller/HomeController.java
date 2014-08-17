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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.SAXException;

import com.glassdoor.databean.JobDetails;
import com.glassdoor.jobsearch.JobSearchService;

@RestController
public class HomeController {
	@Autowired
	private JobSearchService jobService;
	public static Logger logger = Logger.getLogger(HomeController.class);
	List<JobDetails> jobdetails = null;

	/***
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView("/index");
		return mav;
	}

	@RequestMapping(value = "search", method = RequestMethod.POST)
	public ModelAndView search(String keyword, String location, String pageCount) {
		ModelAndView mav = new ModelAndView("/jobs");
		if(pageCount == null){
			pageCount = "10";
		}
		
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "Pittsburgh" : URLEncoder.encode(location,
					"UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");

			/*jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode,false,Integer.parseInt(pageCount),25);*/
			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode,true,1,50);
			System.out.println(jobdetails);
			jobdetails=jobService.matchLatLongFromJobList(jobdetails);
//			jobService.updateCommuteTimeAndDistance(jobdetails);
			jobService.updateCommuteTimeAndDistanceGL(jobdetails);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mav.addObject("keyword", keyword);
		mav.addObject("location", location);
		mav.addObject("joblist", jobdetails);
		return mav;
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public List<JobDetails> getJobs(@RequestParam String keyword, @RequestParam String location) {
		List<JobDetails> jobdetails = null;
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "" : URLEncoder.encode(location, "UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");
			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode, true, 1, 50);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jobdetails;
	}
	
	@RequestMapping(value = "sort", method = RequestMethod.POST) 
	public ModelAndView sort(String criteria) { 
		ModelAndView mav = new ModelAndView("/jobs");
		jobService.sortJobList(jobdetails,criteria);//distance or commute time
		mav.addObject("joblist", jobdetails);
		return mav;
	}
	
	@RequestMapping(value ="filter", method = RequestMethod.POST) 
	public ModelAndView filter(String distance, String commuteTime, String commuteType) { 
		ModelAndView mav = new ModelAndView("/jobs");
		String dis = distance.split(" ")[1];
		String com = commuteTime.substring(2, 4);
		List<JobDetails> newJobs = jobService.refineSearch(jobdetails, Integer.parseInt(dis), Integer.parseInt(com)*60, commuteType);//filter
		mav.addObject("joblist", newJobs);
		return mav;
	}

	@RequestMapping(value = "/updateLocation", method = RequestMethod.GET)
	public void updateLocation() {
		try {
			logger.info("Initiating updateLocation batch");
			jobService.updateLocationInfo();
		} catch (XPathExpressionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/updateJobData/{keyword}/{location}", method = RequestMethod.GET)
	public void updateJobData(@PathVariable String keyword,
			@PathVariable String location) {
		List<JobDetails> jobdetails = null;
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "" : URLEncoder.encode(location, "UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");
			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode, true, 1, 50);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(jobdetails);
		jobService.saveJobDetails(jobdetails);
	}

	@RequestMapping(value = "/getJobsData", method = RequestMethod.GET)
	public List<JobDetails> getAllJobsFromDB() {
		return jobService.getAllJobsFromDB();

	}

	@RequestMapping(value = "/getJobsData/{jobId}", method = RequestMethod.GET)
	public JobDetails getJobForId(@PathVariable String jobId) {
		return jobService.getJobForId(jobId);

	}

	@RequestMapping(value = "/getJobsData/list/{ids}", method = RequestMethod.GET)
	public List<JobDetails> getJobs(@PathVariable("ids") String jobIds) {
		System.out.println("ids" + jobIds);
		return jobService.getJobDataForIds(jobIds);
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

	@RequestMapping("test")
	public ModelAndView test() {
		ModelAndView mav = new ModelAndView("test");
		return mav;
	}

	public void setJobService(JobSearchService jobService) {
		this.jobService = jobService;
	}
}
