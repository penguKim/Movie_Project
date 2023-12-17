package com.itwillbs.c5d2308t1.controller;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminController {
	
	
	// =========== 2023.12.17 임은령 주석 ===============
	// ***** 참고 1
	// 각 페이지의 조회 버튼과 스토어 결제 관리 페이지의 결제 취소버튼에 대한 매핑은
	// 각 페이지의 기능 구현 담당자가 별도로 처리하는 것이 효율적이라 판단해 매핑해두지 않았고
	// 자바스크립트를 통한 기본 처리가 되어있습니다(조회는 새로고침, 결제 취소는 모달창 후 새로고침)
	// 각자 필요한 방법으로 편하게 매핑 추가하시면 됩니다
	
	// ***** 참고 2
	// 기본적으로 post 방식으로 매핑해두었으나 각 페이지 별로 작업하시다가
	// 필요할 경우 requestmapping 어노테이션 등의 방식을 사용해 get 방식 매핑 추가하시면 됩니다
	// 서블릿 매핑이 해제되는 일이 없도록만 주의해서 자유롭게 수정해주시기 바랍니다
	
	// ***** 참고 3
	// 상영일정관리, 영화 예매 팝업, 자주 묻는 질문, 공지사항, 회원정보, 1대1문의 등
	// 공통 작업이 복수개가 들어가는 페이지들은 기본적으로 form 태그 내의 action 값을
	// 1) 등록 작업을 포함해 복수개의 작업이 있는 경우(주로 등록, 수정, 삭제) 
	//    => boardRgst (등록작업 공통 서블릿 주소)를 기본값으로 지정했으므로 수정, 삭제 버튼을 클릭해도 등록 모달창이 뜹니다
	// 2) 등록 작업이 없는 경우(주로 수정, 삭제만 존재) 
	//    => boardMod (수정 작업 공통 서블릿 주소)를 기본값으로 지정했으므로 삭제 버튼을 클릭해도 수정 모달창이 뜹니다
	// 참고3의 내용은 각 뷰 페이지의 주석에서도 확인이 가능하니 판별식을 이용해 처리해주시면 됩니다
	
	
	// =====================================================================================
	// 관리자페이지 공통 작업을 수행할 매핑메서드
	// 1. 등록   2. 수정   3. 삭제   4. 조회
	
	// ****************** 1. 등록 ********************
	@PostMapping("boardRgst")
	public String boardRgst(@RequestParam("fileName") String fileName, Model model) {
		if("admin_movie_update".equals(fileName)) { // 1-1) 영화 등록 팝업 
			model.addAttribute("msg", "영화 정보");
			model.addAttribute("servlet", "movieRgst");
		} else if("admin_movie_schedule".equals(fileName)) { // 1-2) 상영일정 관리 메인
			model.addAttribute("msg", "상영일정");
			model.addAttribute("servlet", "movieScheduleRgst");
		} else if("admin_board_faq_write".equals(fileName)) { // 1-3) 자주묻는 질문 글쓰기
			model.addAttribute("msg", "자주묻는질문");
			model.addAttribute("servlet", "boardFaqRgst");
		} else if("admin_board_notice_write".equals(fileName)) { // 1-4) 공지사항 글쓰기
			model.addAttribute("msg", "공지사항");
			model.addAttribute("servlet", "boardNoticeRgst");
		} else if("admin_board_one_on_one_response".equals(fileName)) { // 1-5) 1대1문의 답변
			model.addAttribute("msg", "1대1문의 답변");
			model.addAttribute("servlet", "boardOneOnOneRgst");
		} else if("admin_board_lostnfound_response".equals(fileName)) { // 1-6) 분실물문의 답변 등록
			model.addAttribute("msg", "분실물 문의 답변");
			model.addAttribute("servlet", "boardLostnfoundRgst");
		}
			
		return "boardRegist";
	}
	
	
	
	// ********************** 2. 수정 **********************************
	@PostMapping("boardMod")
	public String boardMod(@RequestParam("fileName") String fileName, Model model) {
		if("admin_movie_modify".equals(fileName)) { // 2-1) 영화 정보 수정 팝업 
			model.addAttribute("msg", "영화 정보");
			model.addAttribute("servlet", "movieMod");
		} else if("admin_movie_schedule".equals(fileName)) { // 2-2) 상영일정 관리 메인
			model.addAttribute("msg", "상영일정");
			model.addAttribute("servlet", "movieScheduleMod");
		} else if("admin_movie_booking_modify".equals(fileName)) { // 2-3) 영화 예매 팝업(수정/삭제)
			model.addAttribute("msg", "영화예매정보");
			model.addAttribute("servlet", "movieBookingMod");
		} else if("admin_member_modify".equals(fileName)) { // 2-4) 회원정보 상세(회원)
			model.addAttribute("msg", "회원정보");
			model.addAttribute("servlet", "memberMod");
		} else if("admin_board_faq_modify".equals(fileName)) { // 2-5) 자주 묻는 질문 상세조회/수정
			model.addAttribute("msg", "자주 묻는 질문");
			model.addAttribute("servlet", "boardFaqMod");
		} else if("admin_board_notice_detail".equals(fileName)) { // 2-6) 공지사항 상세조회/수정
			model.addAttribute("msg", "공지사항");
			model.addAttribute("servlet", "boardNoticeMod");
		}
		return "boardModify";
		
	}
	
	
	// **************************** 3. 삭제 **********************************
	@PostMapping("boardDlt")
	public String boardDlt(@RequestParam("fileName") String fileName, Model model) {
		if("admin_movie_schedule".equals(fileName)) { // 3-1) 상영일정 관리 메인
			model.addAttribute("msg", "상영일정");
			model.addAttribute("servlet", "movieScheduleDlt");
		} else if("admin_movie_booking_modify".equals(fileName)) { // 3-2) 영화 예매 팝업(수정/삭제)
			model.addAttribute("msg", "영화 예매 정보");
			model.addAttribute("servlet", "movieBookingDlt");
		} else if("admin_member".equals(fileName)) { // 3-3) 회원 정보 관리 메인(탈퇴, 비회원)
			model.addAttribute("msg", "활동하지 않는 회원의 정보");
			model.addAttribute("servlet", "memberDlt");
		} else if("admin_member_modify".equals(fileName)) { // 3-4) 회원정보상세(회원)
			model.addAttribute("msg", "회원정보");
			model.addAttribute("servlet", "memberDlt");
		} else if("admin_board_faq_modify".equals(fileName)) { // 3-5) 자주 묻는 질문 상세조회/수정
			model.addAttribute("msg", "자주 묻는 질문");
			model.addAttribute("servlet", "boardFaqDlt");
		} else if("admin_board_notice_detail".equals(fileName)) { // 3-6) 공지사항 상세조회/수정
			model.addAttribute("msg", "공지사항");
			model.addAttribute("servlet", "boardNoticeDlt");
		} else if("admin_board_one_on_one_response".equals(fileName)) { // 3-7) 1대1문의 답변완료
			model.addAttribute("msg", "1대1문의 답변");
			model.addAttribute("servlet", "boardOneOnOneDlt");
		} else if("admin_board_lostnfound_response".equals(fileName)) { // 3-8) 분실문 문의 답변완료
			model.addAttribute("msg", "분실물 문의 답변");
			model.addAttribute("servlet", "boardLostnfoundDlt");
		} else if("admin_review".equals(fileName)) { // 3-9) 리뷰 관리
			model.addAttribute("msg", "해당 리뷰");
			model.addAttribute("servlet", "reviewDlt");
		}
		
		return "boardDelete";
		
	}

	
	
	// ======================================================================================================
	// =============================== 비즈니스 로직 처리를 위한 서블릿 매핑 ================================
	
	// ******************* 등록 처리 개별 매핑 ****************
	// 영화 정보 등록
	@GetMapping("movieRgst")
	public String movieRgst() {
		return "";
	}

	// 상영 일정 등록
	@PostMapping("movieScheduleRgst")
	public String movieScheduleRgst() {
		return "";
	}

	// 자주 묻는 질문 등록
	@PostMapping("boardFaqRgst")
	public String boardFaqRgst() {
		return "";
	}

	// 공지사항 등록
	@PostMapping("boardNoticeRgst")
	public String boardNoticeRgst() {
		return "";
	}

	// 1대1문의 등록
	@PostMapping("boardOneOnOneRgst")
	public String boardOneOnOneRgst() {
		return "";
	}

	// 분실물 문의 등록
	@PostMapping("boardLostnfoundRgst")
	public String boardLostnfoundRgst() {
		return "";
	}

	
	// ******************* 수정 처리 개별 매핑 ****************
	// 영화 정보 수정
	@PostMapping("movieMod")
	public String movieMod() {
		return "";
	}

	// 상영일정 수정
	@PostMapping("movieScheduleMod")
	public String movieScheduleMod() {
		return "";
	}

	// 영화예매정보 수정
	@PostMapping("movieBookingMod")
	public String movieBookingMod() {
		return "";
	}

	// 회원정보 수정
	@PostMapping("memberMod")
	public String memberMod() {
		return "";
	}
	
	// 자주 묻는 질문 수정
	@PostMapping("boardFaqMod")
	public String boardFaqMod() {
		return "";
	}
	
	// 공지사항 수정
	@PostMapping("boardNoticeMod")
	public String boardNoticeMod() {
		return "";
	}
	
	
	// ******************* 삭제 처리 개별 매핑 ****************
	// 상영일정 삭제
	@PostMapping("movieScheduleDlt")
	public String movieScheduleDlt() {
		return "";
	}
	
	// 영화 예매 정보 삭제
	@PostMapping("movieBookingDlt")
	public String movieBookingDlt() {
		return "";
	}
	
	// 회원정보 삭제(탈퇴, 비회원, 회원)
	@PostMapping("memberDlt")
	public String memberDlt() {
		return "";
	}

	// 자주 묻는 질문 삭제
	@PostMapping("boardFaqDlt")
	public String boardFaqDlt() {
		return "";
	}

	// 공지사항 삭제
	@PostMapping("boardNoticeDlt")
	public String boardNoticeDlt() {
		return "";
	}
	
	// 1대1문의 답변 삭제
	@PostMapping("boardOneOnOneDlt")
	public String boardOneOnOneDlt() {
		return "";
	}

	// 분실물 문의 답변 삭제
	@PostMapping("boardLostnfoundDlt")
	public String boardLostnfoundDlt() {
		return "";
	}

	// 리뷰 삭제
	@PostMapping("reviewDlt")
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
