package com.ljh.footballaround.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		return "home/main";
	}

	@RequestMapping("/")
	public String showMain2() {
		return "home/main";
	}
	
}


