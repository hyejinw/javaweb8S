package com.spring.javaweb8S;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@RequestMapping(value = "/practice", method = RequestMethod.GET)
	public String practice() {
		return "admin/practice";
	}

}
