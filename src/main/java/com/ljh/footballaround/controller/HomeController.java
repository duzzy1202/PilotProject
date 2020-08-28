package com.ljh.footballaround.controller;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ljh.footballaround.service.ClubdataService;
import com.ljh.footballaround.service.CrawlingService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class HomeController {
	@Autowired
	private CrawlingService crawlingService;
	@Autowired
	private ClubdataService clubdataService;
	
	@RequestMapping("/home/main")
	public String showMain(Model model) {
		return "home/main";
	}

	@RequestMapping("/")
	public String showMain2() {
		return "redirect:/home/main";
	}
	
	@RequestMapping("/home/updateClubData")
	public String updateClubData(Model model) throws IOException {
		crawlingService.crawlingKL1();
		crawlingService.crawlingKL2();
		
		model.addAttribute("redirectUri", "/home/main");
		model.addAttribute("alertMsg", "업데이트가 완료되었습니다.");
		return "common/redirect";
		
	}
	
	@RequestMapping("/home/dataCenter")
	public String dataCenter() {
		return "home/dataCenter";
	}
	
	@RequestMapping("/home/addData")
	public String AddClubData(Model model, @RequestParam Map<String, Object> param) {
		clubdataService.addClubData(param);
		
		model.addAttribute("redirectUri", "/home/dataCenter");
		model.addAttribute("alertMsg", "데이터 추가가 완료되었습니다.");
		return "common/redirect";
		
	}
}
