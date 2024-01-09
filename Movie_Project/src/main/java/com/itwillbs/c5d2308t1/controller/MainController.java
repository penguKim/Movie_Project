package com.itwillbs.c5d2308t1.controller;

import java.util.List;
import java.util.Map;

import org.json.JSONArray;
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
	public String movieChart(String status, String sort) {
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
		
		JSONArray jsonArray = new JSONArray(movieList);
		
		return jsonArray.toString();			
	}
	
	
	
	// 메인페이지 이벤트목록 출력
	@ResponseBody
	@GetMapping("eventList")
	public String eventList() {
		// 이벤트 목록 조회
		List<EventsVO> eventList = service.getEventList();
		
		
		if(eventList.size() > 4) { // 이벤트가 4개를 초과할 경우
			eventList = eventList.subList(0, 4); // 0 ~ 3번 인덱스까지만 저장한다.
		}
		
		JSONArray jsonArray = new JSONArray(eventList);
		
		return jsonArray.toString();
	}
	
	
}
