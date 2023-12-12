package com.itwillbs.c5d2308t1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.c5d2308t1.service.CsService;
import com.itwillbs.c5d2308t1.vo.CsVO;

@Controller
public class CsController {
	
	// 의존성 주입받을 멤버변수 선언 시 @Autowired 어노테이션을 지정
	@Autowired
	private CsService service;
	
	// 고객센터 메인 페이지로 이동
	// 메인페이지 하단에 자주묻는질문, 공지사항 미리보기 출력
	@GetMapping("csMain")
	public String csMain(CsVO cs, Model model) {
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(faqList)
		List<CsVO> faqList = service.getFqaList();
		System.out.println(faqList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqList")
		model.addAttribute("faqList", faqList);
		
		
		// CsService - getNoticeList() 메서드 호출하여 공지사항 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(noticeList)
		List<CsVO> noticeList = service.getNoticeList();
		System.out.println(noticeList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
		model.addAttribute("noticeList", noticeList);
		
		
		
		return "cs/cs_main";
	}
	
	
	// 고객센터 1대1문의 페이지로 이동
	@GetMapping("csOneOnOneForm")
	public String csOneOnOneForm() {
		return "cs/cs_OneOnOne";
	}
	
	// 고객센터 분실물문의 페이지로 이동
	@GetMapping("csLostForm")
	public String csLostForm() {
		return "cs/cs_lost";
	}
	
	
	// DB에 있는 자주 묻는 질문, 공지사항 출력하여
	// 테이블에 표시하기
	
	// 고객센터 자주묻는질문 페이지로 이동
	@GetMapping("csFaq")
	public String csFaq(CsVO cs, Model model) {
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(faqList)
		List<CsVO> faqList = service.getFqaList();
		System.out.println(faqList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqList")
		model.addAttribute("faqList", faqList);
		
		return "cs/cs_FAQ";
	}
	
	// 고객센터 공지사항 페이지로 이동
	@GetMapping("csNotice")
	public String csNotice(CsVO cs, Model model) {
		// CsService - getNoticeList() 메서드 호출하여 공지사항 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(noticeList)
		List<CsVO> noticeList = service.getNoticeList();
		System.out.println(noticeList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
		model.addAttribute("noticeList", noticeList);
		
		return "cs/cs_notice";
	}
	
	
	// 고객센터 공지사항 상세 페이지로 이동
	@GetMapping("csNoticeDetail")
	public String csNoticeDetail(CsVO cs, Model model) {
		// CsService - getNoticeList() 메서드 호출하여 공지사항 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(noticeList)
		List<CsVO> noticeList = service.getNoticeList();
		System.out.println(noticeList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
		model.addAttribute("noticeList", noticeList);
		
		return "cs_notice_detail";
	}
	
	
	
	
	// 고객센터 1대1문의, 분실물문의 폼에 입력된 정보를 DB에 입력하고
	// 고객센터 메인 페이지로 이동
	@PostMapping("csBoardPro")
	public String csBoardPro(CsVO cs, Model model) {
		// CsService - registMember() 메서드 호출하여 회원정보 등록 요청
		// => 파라미터 : StudentVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registBoard(cs);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount == 0) {
			model.addAttribute("msg", "문의글 등록 실패!");
			return "fail_back";
		}
		
		return "cs/cs_main";
	}
	
	
}
