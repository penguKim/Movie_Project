package com.itwillbs.c5d2308t1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	// 관리자페이지 공통 작업을 수행할 매핑메서드
	// 1. 등록   2. 수정   3. 삭제   4. 조회
	
	// 1. 등록
	/*
	function btnRgst() {
		var result = confirm("영화 정보를 등록하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	 * */
	// 1-3) 자주묻는 질문 글쓰기
	// 1-4) 공지사항 글쓰기
	// 1-5) 1대1문의 답변
	// 1-6) 분실물 문의 등록
//	@GetMapping("boardRgst")
//	public String boardRgst(Model model) {
//		
//		// 파일명 추출해서 문자열 비교해 판별할 것이므로
//		// 파일명을 추출하기위한 변수 지정
//		
//		
//		if(영화등록팝업 판별식) { // 1-1) 영화 등록 팝업 
//			model.addAttribute("msg", "영화 정보");
//			model.addAttribute("servlet", "movieUpdate");
//		} else if(상영일정관리 판별식) { // 1-2) 상영일정 관리 메인
//			model.addAttribute("msg", "상영일정");
//			model.addAttribute("servlet", "movieScheduleUpdate");
//		} else if(상영일정관리 판별식) { // 1-2) 상영일정 관리 메인
//			model.addAttribute("msg", "상영일정");
//			model.addAttribute("servlet", "movieScheduleUpdate");
//		} else if(상영일정관리 판별식) { // 1-2) 상영일정 관리 메인
//			model.addAttribute("msg", "상영일정");
//			model.addAttribute("servlet", "movieScheduleUpdate");
//		} else if(상영일정관리 판별식) { // 1-2) 상영일정 관리 메인
//			model.addAttribute("msg", "상영일정");
//			model.addAttribute("servlet", "movieScheduleUpdate");
//		} else if(상영일정관리 판별식) { // 1-2) 상영일정 관리 메인
//			model.addAttribute("msg", "상영일정");
//			model.addAttribute("servlet", "movieScheduleUpdate");
//		}
//		return "boardRegister";
//		
//	}
	
	
	
	// 2. 수정
	/*
	 *
	function btnMod() {
		var result = confirm("자주 묻는 질문을 수정하시겠습니까?");
		if(result) {
			location.reload();
		}
	}
	 * 
	 */
	// 2-1) 영화 정보 수정 팝업
	// 2-2) 상영일정 관리 메인
	// 2-3) 영화예매관리 수정/삭제 팝업
	// 2-4) 회원정보 상세(회원)
	// 2-5) 자주 묻는 질문 상세조회/수정
	// 2-6) 공지사항 상세조회/수정
	
	
	// 3. 삭제
	/*
	 * 
	function btnDlt() {
		var result = confirm('자주 묻는 질문을 삭제하시겠습니까?');
		if(result) {
			location.href = "adminFaq";
	} 
	 * 
	 */
	// 3-1) 상영일정 관리 메인
	// 3-2) 영화 예매 팝업(수정/삭제) 
	// 3-3) 회원 정보 관리 메인(탈퇴, 비회원) 
	// 3-4) 회원정보상세(회원)
	// 3-5) 자주 묻는 질문 상세조회/수정 
	// 3-6) 공지사항 상세조회/수정 
	// 3-7) 1대1문의 답변완료
	// 3-8) 분실문 문의 답변완료 
	// 3-9) 리뷰 관리
	
	
	// 4. 조회
	/*
	 * 	
	function btnLookup() {
		location.reload();
	}
	 * 
	 * */
	// 4-1) 영화 관리 팝업(등록)
	// 4-2) 영화 관리 팝업(정보수정)
	// 4-3) 상영일정 관리 메인
	// 4-4) 스토어 결제관리 메인
	// 4-5) 회원 정보 관리 메인
	// 4-6) 리뷰관리
	
	
	// 5. 결제취소
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 단순 이동 서블릿 매핑
	
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
	public String adminLostNFound() {
		return "admin/admin_board_lostnfound";
	}

	// 관리자페이지 분실물 문의 상세 조회 및 답변 등록 페이지로 이동
	@GetMapping("adminLostNFoundResp")
	public String adminLostNFoundResp() {
		return "admin/admin_board_lostnfound_response";
	}

	// 관리자페이지 영화 리뷰 관리 페이지로 이동
	@GetMapping("adminReview")
	public String adminReview() {
		return "admin/admin_review";
	}
	
	
	
	
}
