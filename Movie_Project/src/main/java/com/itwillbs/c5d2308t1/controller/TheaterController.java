package com.itwillbs.c5d2308t1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.JoinService;
import com.itwillbs.c5d2308t1.vo.MemberVO;

@Controller
public class TheaterController {
	
	// 위 메뉴바에서 극장 눌렀을때 극장페이지로 이동
	@GetMapping("theater")
	public String theater() {
		return "theater/theater";
	}
	
	// 극장페이지에서 위치/주차 눌렀을때 주차페이지로 이동
	@GetMapping("theater_parking")
	public String theater_parking() {
		return "theater/theater_parking";
	}
	
	
}