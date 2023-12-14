
package com.itwillbs.c5d2308t1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {
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
