package com.dj.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class adminController {
	
	@RequestMapping("admin")
	public String admin() {
		System.out.println("adminController.admin()");
		return "admin/login";
	}

}
