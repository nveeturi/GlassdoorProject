package com.glassdoor.jobsearch;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/jobService")
public class JobSearchServiceEndPoint {

	@Autowired
	private JobSearchService jobService;

	@RequestMapping("/updateLocation")
	public void updateLocationFromJobLink() throws IOException {
		jobService.updateLocationFromJobLink();
	}

}
