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
	
@GetMapping("theater")
public String theater() {
	
	return "theater/theater";
}
@GetMapping("theater_parking")
public String theater_parking() {
	
	return "theater/theater_parking";
}

}