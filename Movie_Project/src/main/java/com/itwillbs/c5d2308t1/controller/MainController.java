package com.itwillbs.c5d2308t1.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.MainService;
import com.itwillbs.c5d2308t1.vo.EventsVO;
import com.itwillbs.c5d2308t1.vo.MainMovieType;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Controller
public class MainController {
	
	@Autowired
	MainService service;
	
	// 메인페이지 영화목록 출력
	@ResponseBody
	@GetMapping("mainMovieChart")
	public List<MoviesVO> movieChart(String status, String sort) {
		List<MoviesVO> movieList = null;
		if(status.equals(MainMovieType.RELEASE) && sort.equals(MainMovieType.DATE_SORT)) {
			// 현재 상영작 조회
			movieList = service.getMainMovieList(MainMovieType.STATUS_RELEASE, MainMovieType.DATE_SORT);
		} else if(status.equals(MainMovieType.COMMING) && sort.equals(MainMovieType.DATE_SORT)) {
			// 상영 예정작 조회
			movieList = service.getMainMovieList(MainMovieType.STATUS_COMMING, MainMovieType.DATE_SORT);
		} else if(status.equals(MainMovieType.RELEASE) && sort.equals(MainMovieType.AUDIENCE_SORT)) {
			// 관객수순 조회
			movieList = service.getMainMovieList(MainMovieType.STATUS_RELEASE, MainMovieType.AUDIENCE_SORT);
		} 
		return movieList;			
	}
	
	
	
	// 메인페이지 이벤트목록 출력
	@ResponseBody
	@GetMapping("eventList")
	public List<EventsVO> eventList(Map<String, String> map) {
		map = null;
		
		List<EventsVO> eventList = service.getEventList();
		
		System.out.println(eventList);
		return eventList;
	}
	
	
}
