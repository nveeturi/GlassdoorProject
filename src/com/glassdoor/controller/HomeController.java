package com.glassdoor.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPathExpressionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.xml.sax.SAXException;

import com.glassdoor.databean.JobDetails;
import com.glassdoor.jobsearch.JobSearchService;

@RestController
public class HomeController {
	@Autowired
	private JobSearchService jobService;

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
			pageCount = "1";
		}
		List<JobDetails> jobdetails = null;
		try {
			String locationEncode = (location == null || location.trim()
					.equals("")) ? "Pittsburgh" : URLEncoder.encode(location,
					"UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");

			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode,
					locationEncode,false,Integer.parseInt(pageCount),25);
			System.out.println(jobdetails);
			jobService.matchLatLongFromJobList(jobdetails);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		mav.addObject("keyword", keyword);
		mav.addObject("location", location);
		mav.addObject("joblist", jobdetails);
		return mav;
	}

	@RequestMapping(value = "/updateLocation", method = RequestMethod.GET)
	public void updateLocation() {
		try {
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
					.equals("")) ? "San Francisco" : URLEncoder.encode(
					location, "UTF-8");

			String keywordEncode = (keyword == null || keyword.trim()
					.equals("")) ? "" : URLEncoder.encode(keyword, "UTF-8");
			jobdetails = jobService.getJobDataFromGlassdoor(keywordEncode, locationEncode,
					true, 1, 50);
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
