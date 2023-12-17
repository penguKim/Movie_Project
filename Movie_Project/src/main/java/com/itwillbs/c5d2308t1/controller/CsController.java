package com.itwillbs.c5d2308t1.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.CsService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.PageInfo;

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
		List<CsVO> faqList = service.getFaqList();
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
	public String csOneOnOneForm(MemberVO member, Model model, HttpSession session) {
//		// 세션 아이디 가져와서 저장하기
//		String id = (String)session.getAttribute("sId");
//		
//		// 세션 아이디가 존재하지 않을 경우(null)
//		// 자바스크립트 사용하여 "잘못된 접근입니다!" 출력 후 메인페이지로 이동
//		if(id == null) {
////			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
////			return "fail_back";
//		}
		
//		return "redirect:/cs/cs_OneOnOne";
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
	public String csFaq(CsVO cs, Model model, HttpServletRequest request) {
		// 페이징 처리를 위한 pageNum 변수 선언
		// 파라미터로 전달받은 pageNum 값을 가져오기
		// 파라미터가 없을 경우 기본값 1
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
//		System.out.println("현재 페이지 : " + pageNum);
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 3;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<CsVO> faqList = service.getFaqList(startRow, listLimit);
//		System.out.println(noticeList);
		
		
		// ======================================================
		// 글 목록 페이징 처리
		// 1) 한 페이지에서 표시할 페이지 목록(번호) 계산
		// CsService - getFaqListCount() 메서드를 호출하여
		//     전체 게시물 수 조회(페이지 목록 계산에 활용)
		// => 파라미터 : 없음   리턴타입 : Integer(listCount)
		Integer listCount = service.getFaqListCount();
//		System.out.println(listCount);
		
		// 2) 한 페이지에 표시할 페이지 목록 갯수 설정(테스트)
		int pageListLimit = 2;
		
		// 3) 전체 페이지 목록 갯수 계산
		// 페이지 목록 갯수 계산 후 나머지가 0보다 크면 페이지 갯수 +1 처리
		int maxPage = listCount / listLimit + ((listCount % listLimit) > 0 ? 1 : 0);
		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		
		// 4) 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 끝 페이지 번호 계산
		// 시작 페이지 번호화 한 페이지 당 페이지 번호 갯수를 더한 값 -1
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다 클 경우
		//    끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, maxPage, pageListLimit, startPage, endPage);
		// ------------------------------------------------------
		// 글목록(List 객체)과 페이징정보(pageInfo 객체) 를 request 객체에 저장
		request.setAttribute("pageInfo", pageInfo);
		
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqList")
		model.addAttribute("faqList", faqList);
			
		return "cs/cs_FAQ";
	}
	
	
	// 자주묻는질문 카테고리별 모아보기 기능
	@ResponseBody
	@GetMapping("faqDetail")
	public List<CsVO> faqDetail(Model model, String buttonName) {
		if(buttonName.equals("전체")) {
			// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
			// => 파라미터 : 없음   리턴타입 : List<CsVO>(faqList)
			List<CsVO> faqList = service.getFaqList();
			System.out.println(faqList);
			
			// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqList")
			model.addAttribute("faqList", faqList);
			
			return faqList;
		} else {
			// CsService - getFaqDetail() 메서드 호출하여 자주 묻는 질문 출력
			// => 파라미터 : 없음   리턴타입 : List<CsVO>(faqDetail)
			List<CsVO> faqDetail = service.getFaqDetail(buttonName);
			System.out.println(faqDetail);
			
			// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqList")
			model.addAttribute("faqDetail", faqDetail);
			
			return faqDetail;			
		}
		
	}
	
	// 자주묻는질문 검색 기능
	@ResponseBody
	@GetMapping("faqSearch")
	public List<CsVO> faqSearch(Model model, String searchValue) {
		// CsService - getFaqDetail() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(faqDetail)
		List<CsVO> faqSearch = service.getFaqSearch(searchValue);
		System.out.println(faqSearch);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqList")
		model.addAttribute("faqSearch", faqSearch);
		
		return faqSearch;			

	}
	
	
	
	
	
	// 고객센터 공지사항 페이지로 이동
	@GetMapping("csNotice")
	public String csNotice(CsVO cs, Model model, HttpServletRequest request) {
		// 페이징 처리를 위한 pageNum 변수 선언
		// 파라미터로 전달받은 pageNum 값을 가져오기
		// 파라미터가 없을 경우 기본값 1
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
//		System.out.println("현재 페이지 : " + pageNum);
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 3;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getNoticeList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<CsVO> noticeList = service.getNoticeList(startRow, listLimit);
//		System.out.println(noticeList);
		
		
		// ======================================================
		// 글 목록 페이징 처리
		// 1) 한 페이지에서 표시할 페이지 목록(번호) 계산
		// CsService - getNoticeListCount() 메서드를 호출하여
		//     전체 게시물 수 조회(페이지 목록 계산에 활용)
		// => 파라미터 : 없음   리턴타입 : Integer(listCount)
		Integer listCount = service.getNoticeListCount();
//		System.out.println(listCount);
		
		// 2) 한 페이지에 표시할 페이지 목록 갯수 설정(테스트)
		int pageListLimit = 2;
		
		// 3) 전체 페이지 목록 갯수 계산
		// 페이지 목록 갯수 계산 후 나머지가 0보다 크면 페이지 갯수 +1 처리
		int maxPage = listCount / listLimit + ((listCount % listLimit) > 0 ? 1 : 0);
		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		
		// 4) 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		
		// 5) 끝 페이지 번호 계산
		// 시작 페이지 번호화 한 페이지 당 페이지 번호 갯수를 더한 값 -1
		int endPage = startPage + pageListLimit - 1;
		
		// 6) 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다 클 경우
		//    끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, maxPage, pageListLimit, startPage, endPage);
		// ------------------------------------------------------
		// 글목록(List 객체)과 페이징정보(pageInfo 객체) 를 request 객체에 저장
		request.setAttribute("pageInfo", pageInfo);
		
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
		model.addAttribute("noticeList", noticeList);
		
		return "cs/cs_notice";
	}
	
	
	// 고객센터 공지사항 상세 페이지로 이동
//	@GetMapping("csNoticeDetail")
//	public String csNoticeDetail(CsVO cs, Model model) {
//		// CsService - getNoticeList() 메서드 호출하여 공지사항 출력
//		// => 파라미터 : 없음   리턴타입 : List<CsVO>(noticeList)
//		List<CsVO> noticeList = service.getNoticeList();
//		System.out.println(noticeList);
//		
//		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
//		model.addAttribute("noticeList", noticeList);
//		
//		return "cs_notice_detail";
//	}
//	
	
	
	
	// 고객센터 1대1문의, 분실물문의 폼에 입력된 정보를 DB에 입력하고
	// 고객센터 메인 페이지로 이동
	@PostMapping("csBoardPro")
	public String csBoardPro(CsVO cs, Model model, HttpServletRequest request, HttpSession session) {
		
		
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
