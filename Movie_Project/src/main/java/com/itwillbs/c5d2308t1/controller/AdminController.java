package com.itwillbs.c5d2308t1.controller;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.service.AdminService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.PageInfo;

@Controller
public class AdminController {
	
	@Autowired
	AdminService service;
	
	
	// =============== 2023.12.19 임은령 주석 ============================
	// 1. 자바스크립트 처리가 동일하여 서블릿 매핑을 모듈화 하였으나 사용하는 것이 적합하지않다고 판명되어 
	// 이전처럼 개별 서블릿 주소를 이용하는 방식으로 수정해야할 것 같습니다.
	// 기존에 만들어놓은 서블릿 이름은 아래에 있으므로 각 페이지 작업하실 때 매핑만 해주시면 됩니다.
	
	// 2. 공통되는 자바스크립트는
	// 1) 등록
	//	 	  confirm() 등으로 "XXX를 등록하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	// 2) 수정
	//	 	  confirm() 등으로 "XXX를 수정하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	// 3) 삭제
	//	 	  confirm() 등으로 "XXX를 삭제하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	//	    입니다. 지금 시점에서는 페이지별로 각자 작업하는 것이 효율적이라고 판단해 다시 수정하지 않았습니다.
	//	    번거롭지만 추가 부탁 드립니다. 
	// => XXX은 각 페이지 별 수행할 작업을 뜻합니다.
	//	    예시) 상영스케쥴 페이지의 경우 : "상영 일정을 등록하시겠습니까?"
	
	// 3. 기본적으로 post 방식으로 매핑해두었으나 각 페이지별로 작업하시다가 
	//	    적절한 방식으로 변경, 추가해주시면 됩니다
	
	// 4. 상영일정관리, 1대1문의 답변, 분실물 문의 답변, 영화 예매 팝업, 회원정보 상세
	//	    자주묻는질문 상세, 공지사항 상세 페이지 등은 하나의 폼에서 여러개의 서브밋을 사용하는데
	//	    따로 자료 링크를 보내드릴테니 참고해 작업하실 수 있을 것 같습니다
	
	//		  급하게 서블릿 매핑을 몇 번씩 갈아엎다보니 누락되는 부분이 많을 것으로 예상됩니다.
	//		  필요 시 코드는 편하게 수정하시면 됩니다. 협조 감사 드립니다.

	// =============================================================
	@PostMapping("movieRgst") // 영화 등록 팝업 : admin_movie_update.jsp
	public String movieRgst() {
		return "";
	}
	
	@PostMapping("movieSchedule") // 상영일정 관리 메인 : admin_movie_schedule.jsp
	public String movieSchedule() {
		return "";
	}

	@PostMapping("boardFaqRgst") // 자주묻는 질문 글쓰기 : admin_board_faq_write.jsp
	public String boardFaqRgst() {
		return "";
	}
	
	@PostMapping("boardNoticeRgst") // 공지사항 글쓰기 : admin_board_notice_write.jsp
	public String boardNoticeRgst() {
		return "";
	}
	
	@PostMapping("boardOneOnOneRsp") // 1대1문의 답변 : admin_board_one_on_one_response.jsp
	public String boardOneOnOneRsp() {
		return "";
	}
	
	// 분실물 문의 등록
	@PostMapping("boardLostnfoundRgst") // 분실물문의 답변 등록 : admin_board_lostnfound_response.jsp
	public String boardLostnfoundRgst(CsVO cs, HttpSession session, Model model) {
		System.out.println("넘어온 정보" + cs);
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		int updateCount = service.LostnfoundReply(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}
	
	@PostMapping("movieMod") // 영화 정보 수정 팝업 : admin_movie_modify.jsp
	public String movieMod() {
		return "";
	}
	
	@PostMapping("movieBooking") // 영화 예매 팝업(수정/삭제) : admin_movie_booking_modify.jsp
	public String movieBooking() {
		return "";
	}
	
	@PostMapping("memberModOrDlt") // 회원정보 상세(회원) : admin_member_modify.jsp
	public String memberModOrDlt() {
		return "";
	}
	
	@PostMapping("boardFaqModOrDlt") // 자주 묻는 질문 상세조회/수정 : admin_board_faq_modify.jsp
	public String boardFaqModOrDlt() {
		return "";
	}
	
	@PostMapping("boardNoticeModOrDlt") // 공지사항 상세조회/수정 : admin_board_notice_detail.jsp
	public String boardNoticeModOrDlt() {
		return "";
	}
	
	
	@PostMapping("memberDlt") // 회원 정보 관리 메인(탈퇴, 비회원) : admin_member.jsp
	public String memberDlt() {
		return "";
	}
	
	// 분실물 문의 답변 삭제
	@PostMapping("boardLostnfoundDlt") // 분실문 문의 답변완료 : admin_board_lostnfound.jsp
	public String boardLostnfoundDlt(CsVO cs, HttpSession session, Model model) {
		System.out.println("넘어온 정보" + cs);
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		int updateCount = service.lostnfoundDlt(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound";
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다!");
			return "fail_back";
		}
	}
	
	@PostMapping("reviewDlt") // 리뷰 관리 : admin_review.jsp
	public String reviewDlt() {
		return "";
	}


	// =============================== 단순 이동 서블릿 매핑 =================================
	// 관리자페이지 영화 정보 관리 페이지로 이동
	@GetMapping("adminMovie")
	public String adminMovie() {
		return "admin/admin_movie";
	}

	// 관리자페이지 영화 정보 등록 페이지로 이동
	@GetMapping("adminMovieUdt")
	public String adminMovieUdt() {
		return "admin/admin_movie_update";
	}

	// 관리자페이지 영화 정보 수정 페이지로 이동
	@GetMapping("adminMovieMod")
	public String adminMovieMod() {
		return "admin/admin_movie_modify";
	}
	
	// 관리자페이지 영화 상영 일정 관리 페이지로 이동
	@GetMapping("adminMovieSchedule")
	public String adminMovieSchedule() {
		return "admin/admin_movie_schedule";
	}
	
	// 관리자페이지 영화 예매 관리 페이지로 이동
	@GetMapping("adminMovieBooking")
	public String adminMovieBooking() {
		return "admin/admin_movie_booking";
	}
	
	// 관리자페이지 영화 예매 정보 상세 조회 및 수정/삭제 페이지로 이동
	@GetMapping("adminMovieBookingMod")
	public String adminMovieBookingMod() {
		return "admin/admin_movie_booking_modify";
	}
	
	// 관리자페이지 스토어결제 관리 페이지로 이동
	@GetMapping("adminPayment")
	public String adminPayment() {
		return "admin/admin_payment";
	}
	
	// 관리자페이지 스토어 결제 상세 조회 및 취소 페이지로 이동
	@GetMapping("adminPaymentDtl")
	public String adminPaymentDtl() {
		return "admin/admin_payment_detail";
	}
	
	// 관리자페이지 회원정보 관리 페이지로 이동
	@GetMapping("adminMember")
	public String adminMember() {
		return "admin/admin_member";
	}
	
	// 관리자페이지 회원정보 상세 조회 및 수정/삭제 페이지로 이동
	@GetMapping("adminMemberMod")
	public String adminMemberMod() {
		return "admin/admin_member_modify";
	}
	
	// 관리자페이지 자주묻는질문 관리 페이지로 이동
	@GetMapping("adminFaq")
	public String adminFaq() {
		return "admin/admin_board_faq";
	}

	// 관리자페이지 자주묻는질문 상세 조회 및 수정 페이지로 이동
	@GetMapping("adminFaqMod")
	public String adminFaqMod() {
		return "admin/admin_board_faq_modify";
	}

	// 관리자페이지 자주묻는질문 글 등록 페이지로 이동
	@GetMapping("adminFaqWrt")
	public String adminFaqWrt() {
		return "admin/admin_board_faq_write";
	}

	// 관리자페이지 공지사항 관리 페이지로 이동
	@GetMapping("adminNotice")
	public String adminNotice() {
		return "admin/admin_board_notice";
	}
	
	// 관리자페이지 공지사항 상세 조회 및 수정 페이지로 이동
	@GetMapping("adminNoticeDtl")
	public String adminNoticeDtl() {
		return "admin/admin_board_notice_detail";
	}
	
	// 관리자페이지 공지사항 글등록 페이지로 이동
	@GetMapping("adminNoticeWrt")
	public String adminNoticeWrt() {
		return "admin/admin_board_notice_write";
	}
	
	// 관리자페이지 1대1문의 관리 페이지로 이동
	@GetMapping("adminOneOnOne")
	public String adminOneOnOne() {
		return "admin/admin_board_one_on_one";
	}
	
	// 관리자페이지 1대1문의 답변 등록 및 수정 페이지로 이동
	@GetMapping("adminOneOnOneResp")
	public String adminOneOnOneResp() {
		return "admin/admin_board_one_on_one_response";
	}

	// 관리자페이지 분실물 문의 관리 페이지로 이동
	@GetMapping("adminLostNFound")
	public String adminLostNFound(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
		// =============== 페이징 처리 ===============
		// 한 페이지에서 표시할 글 목록 갯수 지정
		int listLimit = 5;
		// 조회 시작 행(레코드) 번호 계산
		// => 0번부터 시작하여 페이지 당 목록 갯수씩 증가해야함
		int startRow = (pageNum - 1) * listLimit; 
		
		// 한 페이지에서 표시할 페이지 목록(번호) 계산
		int listCount = service.getlostnfoundListCount();
		System.out.println("전체 게시물 수 : " + listCount);
		// 2) 한 페이지에서 표시할 페이지 목록 갯수(페이지 번호 갯수) 설정
		int pageListLimit = 3; // 임시로 목록갯수 지정
		
		// 3) 전체 페이지 목록 갯수 계산
//		// 페이지 목록 갯수 계산 후 나머지가 0보다 크면 페이지 갯수 + 1 처리
		// => 10개씩 나눈 나머지가 0보다 크면 + 1 처리 추가
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//		System.out.println("전체 페이지 목록 갯수 : " + maxPage);
		// 4) 시작 페이지 번호 계산
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
//		System.out.println(startPage);
		// 5) 끝 페이지 번호 계산
		// 시작 페이지 번호와 한 페이지 당 페이지 번호 갯수를 더한 값 - 1
		int endPage = startPage + pageListLimit - 1;
		// 6) 만약, 끝 페이지 번호(endPage)가 전체(최대) 페이지 번호(maxPage) 보다 클 경우
		//    끝 페이지 번호를 최대 페이지 번호로 교체
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 분실물 게시글 목록 조회
		List<CsVO> lostnfoundList = service.getLostnfoundList();
		// 목록을 뷰페이지로 전달하기 위해서 model 객체에 담는다.
		model.addAttribute("lostnfoundList", lostnfoundList);
		model.addAttribute("sId", sId);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_board_lostnfound";
	}

	// 관리자페이지 분실물 문의 상세 조회 및 답변 등록 페이지로 이동
	@GetMapping("adminLostNFoundResp")
	public String adminLostNFoundResp(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// cs_id가 저장된 cs 객체 전달하여 게시글 가져오기
		CsVO lostnfound = service.getlostnfound(cs);
		
		model.addAttribute("lostnfound", lostnfound);
		
		return "admin/admin_board_lostnfound_response";
	}
	
	
	// 관리자페이지 영화 리뷰 관리 페이지로 이동
	@GetMapping("adminReview")
	public String adminReview() {
		return "admin/admin_review";
	}

}
