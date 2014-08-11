/**
 * 
 */
package com.glassdoor.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author jes2ica
 *
 */
@Controller
public class OtherController {
	
	@RequestMapping("other")
	public String other(){
		return "other";
	}

}
