package com.itwillbs.c5d2308t1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.CsService;
import com.itwillbs.c5d2308t1.service.JoinService;
import com.itwillbs.c5d2308t1.service.MoviesService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.PageInfo;

@Controller
public class TheaterController {
	
	@Autowired
	CsService service;
	
	@Autowired
	MoviesService movie;
	// 위 메뉴바에서 극장 눌렀을때 극장페이지로 이동
	@GetMapping("theater")
	public String theater(CsVO cs, Model model, HttpServletRequest request,
		@RequestParam(defaultValue = "1") int pageNum,
		@RequestParam(defaultValue = "0") int theater,
		@RequestParam(defaultValue = "") String searchValue) {
		cs.setCs_type("공지사항");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<HashMap<String, Object>>(noticeList)
		List<HashMap<String, Object>> noticeList = service.getNoticeList(cs, startRow, listLimit, theater, searchValue);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getCsNoticeCount(cs, theater, searchValue);
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + ((listCount % listLimit) > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
			
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, maxPage, pageListLimit, startPage, endPage);
		// ------------------------------------------------------
		// 글목록(List 객체)과 페이징정보(pageInfo 객체) 를 request 객체에 저장
		model.addAttribute("pageInfo", pageInfo);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
		model.addAttribute("noticeList", noticeList);
		System.out.println("noticeList : " +noticeList);
		
		List<Map<String, Object>> theaterNames = movie.getTheaterName();
		
		model.addAttribute("theaterNames", theaterNames);
		return "theater/theater";
	}
	
	// 극장페이지에서 위치/주차 눌렀을때 주차페이지로 이동
	@GetMapping("theater_parking")
	public String theater_parking() {
		return "theater/theater_parking";
	}
	
	
}