package com.itwillbs.c5d2308t1.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.service.AdminService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.PageCount;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.TheaterVO;

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
	//	 	confirm() 등으로 "XXX를 등록하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	// 2) 수정
	//	 	confirm() 등으로 "XXX를 수정하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	// 3) 삭제
	//	 	confirm() 등으로 "XXX를 삭제하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	//	    입니다. 지금 시점에서는 페이지별로 각자 작업하는 것이 효율적이라고 판단해 다시 수정하지 않았습니다.
	//	    번거롭지만 추가 부탁 드립니다. 
	// => XXX은 각 페이지 별 수행할 작업을 뜻합니다.
	//	  예시) 상영스케쥴 페이지의 경우 : "상영 일정을 등록하시겠습니까?"
	
	// 3. 기본적으로 post 방식으로 매핑해두었으나 각 페이지별로 작업하시다가 
	//	  적절한 방식으로 변경, 추가해주시면 됩니다
	
	// 4. 상영일정관리, 1대1문의 답변, 분실물 문의 답변, 영화 예매 팝업, 회원정보 상세
	//	  자주묻는질문 상세, 공지사항 상세 페이지 등은 하나의 폼에서 여러개의 서브밋을 사용하는데
	//	  따로 자료 링크를 보내드릴테니 참고해 작업하실 수 있을 것 같습니다
	
	//	  급하게 서블릿 매핑을 몇 번씩 갈아엎다보니 중복되거나 누락되는 부분이 많을 것으로 예상됩니다.
	//	  필요 시 코드는 편하게 수정하시면 됩니다. 협조 감사 드립니다.

	// ===========================================================================================
	// *********************** 영화관리 페이지 *************
	// 관리자페이지 영화 정보 관리 페이지로 이동
	@GetMapping("adminMovie")
	public String adminMovie(@RequestParam(defaultValue = "") String searchKeyword, 
						     @RequestParam(defaultValue = "1") int pageNum, 
						     MemberVO member, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = service.getMovieListCount(searchKeyword);
		System.out.println(listCount);
		// 페이징 처리
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// 한 페이지에 불러올 영화 목록 조회
		List<MoviesVO> movieList = service.getMovieList(searchKeyword, page);
		
		model.addAttribute("movieList", movieList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/admin_movie";
	}
	
	// 관리자페이지 영화 정보 등록 페이지로 이동
	@GetMapping("adminMovieUdt")
	public String adminMovieUdt(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "admin/admin_movie_update";
	}

	@PostMapping("movieRgst") // 영화 등록 팝업 : admin_movie_update.jsp
	public String movieRgst(@RequestParam Map<String, Object> map, Model model) {
		int insterCount = service.registMovie(map);
		
		if(insterCount > 0) {
			return "redirect:/adminMovie";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 관리자페이지 영화 정보 수정 페이지로 이동
	@GetMapping("adminMovieMod")
	public String adminMovieMod(@RequestParam(defaultValue = "1") int pageNum, 
							MoviesVO movie, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		MoviesVO dbMovie = service.getMovie(movie);
		
		if(dbMovie != null) {
			model.addAttribute("movie", dbMovie);
			model.addAttribute("pageNum", pageNum);
			return "admin/admin_movie_modify";
		} else {
			model.addAttribute("msg", "없는 영화입니다!");
			return "fail_back";
		}
	}
	
	// 관리자페이지 영화 정보 삭제 
	@PostMapping("adminMovieDlt")
	public String adminMovieDlt(@RequestParam(defaultValue = "1") int pageNum, 
							MoviesVO movie, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		int deleteCount = service.deleteMovie(movie);
		
		if(deleteCount > 0) {
			model.addAttribute("pageNum", pageNum);
			return "redirect:/adminMovie";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다!");
			return "fail_back";
		}
	}
	
	@PostMapping("movieMod") // 영화 정보 수정 팝업 : admin_movie_modify.jsp
	public String movieMod(@RequestParam(defaultValue = "1") int pageNum, MoviesVO movie, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 영화 DB 수정
		int updateCount = service.modifyMovie(movie);
		
		if(updateCount > 0) {
			model.addAttribute("pageNum", pageNum);
			return "redirect:/adminMovie";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다!");
			return "fail_back";
		}
	}

	
	
	// ===========================================================================================
	// ************************ 상영일정관리 페이지 *************
	// 관리자페이지 영화 상영 일정 메인 페이지로 이동
	@GetMapping("adminMovieSchedule")
	public String adminMovieSchedule(HttpSession session, Model model, TheaterVO theater) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		TheaterVO mTheater = service.getMainScheduleInfo(theater);
		System.out.println(mTheater);
		
		if(mTheater != null) {
			model.addAttribute("mTheater", mTheater);
			return "admin/admin_movie_schedule";
		} else {
			model.addAttribute("msg", "상영 일정 조회에 실패했습니다!");
			return "fail_back";
		}
	}
	
	

	@GetMapping("movieScheduleMod") // 상영일정 관리 페이지 : admin_movie_schedule_modify.jsp
	public String movieScheduleMod() {
		return "admin/admin_movie_schedule_modify";
	}
	
	
	// ===========================================================================================
	// ******************** 영화 예매 관리 페이지 *************
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
	
	@PostMapping("movieBooking") // 영화 예매 팝업(수정/삭제) : admin_movie_booking_modify.jsp
	public String movieBooking() {
		return "";
	}

	
	// ===========================================================================================
	// ******************** 스토어 결제 관리 페이지 *************
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
	
	// ===========================================================================================
	// ******************** 회원 정보 관리 페이지 *************
	// 관리자페이지 회원정보 관리 페이지로 이동
	@GetMapping("adminMember")
	public String adminMember(@RequestParam(defaultValue = "") String searchType,
							  @RequestParam(defaultValue = "") String searchKeyword, 
							  @RequestParam(defaultValue = "1") int pageNum, 
							  MemberVO member, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = service.getMemberListCount(searchType, searchKeyword);
		// 페이징 처리
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// 한 페이지에 표시할 회원 목록 조회
		List<MemberVO> memberList = service.getMemberList(searchType, searchKeyword, page);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_member";
	}
	
	@PostMapping("memberDlt") // 회원 정보 관리 메인(탈퇴, 비회원) : admin_member.jsp
	public String memberDlt() {
		return "";
	}
	
	// 관리자페이지 회원정보 상세 조회 및 수정/삭제 페이지로 이동
	@GetMapping("adminMemberMod")
	public String adminMemberMod(@RequestParam(defaultValue = "1") int pageNum, MemberVO member, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		if(!sId.equals("admin") || sId.equals("admin") && (member.getMember_id() == null || member.getMember_id().equals(""))) {
			member.setMember_id(sId);
		}
		
		MemberVO dbMember = service.getMember(member); 
		// input[type=date] 입력을 위한 처리
		dbMember.setMember_birth(dbMember.getMember_birth().replace(".", "-"));
		
		model.addAttribute("member", dbMember);
		
		return "admin/admin_member_modify";
	}
	
	@PostMapping("memberModOrDlt") // 회원정보 상세(회원) : admin_member_modify.jsp
	public String memberModOrDlt(@RequestParam(defaultValue = "1") int pageNum, MemberVO member, String newPasswd, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		if(sId.equals("admin") && (member.getMember_id() == null || member.getMember_id().equals(""))) {
			member.setMember_id(sId);
		}
		
		// 새 비밀번호가 있을 경우 암호화 처리
		BCryptPasswordEncoder passwoedEncoder = new BCryptPasswordEncoder();
		if(newPasswd != null && !newPasswd.equals("")) {
			newPasswd = passwoedEncoder.encode(newPasswd);
		}
		// 회원 정보 수정 및 탈퇴 작업
		int updateCount = service.memberModOrDlt(member, newPasswd);
		
		if(updateCount > 0) {
			return "redirect:/adminMember?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "수정에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// ===========================================================================================
	// ****************** 자주 묻는 질문 관리 페이지 *************
	// 관리자페이지 자주묻는질문 관리 페이지로 이동
	@GetMapping("adminFaq")
	public String adminFaq() {
		return "admin/admin_board_faq";
	}

	// 관리자페이지 자주묻는질문 글 등록 페이지로 이동
	@GetMapping("adminFaqWrt")
	public String adminFaqWrt() {
		return "admin/admin_board_faq_write";
	}

	@PostMapping("boardFaqRgst") // 자주묻는 질문 글쓰기 : admin_board_faq_write.jsp
	public String boardFaqRgst() {
		return "";
	}

	// 관리자페이지 자주묻는질문 상세 조회 및 수정 페이지로 이동
	@GetMapping("adminFaqMod")
	public String adminFaqMod() {
		return "admin/admin_board_faq_modify";
	}
	
	@PostMapping("boardFaqModOrDlt") // 자주 묻는 질문 상세조회/수정 : admin_board_faq_modify.jsp
	public String boardFaqModOrDlt() {
		return "";
	}

	
	// ===========================================================================================
	// ********************** 공지사항 관리 페이지 *************
	// 관리자페이지 공지사항 관리 페이지로 이동
	@GetMapping("adminNotice")
	public String adminNotice() {
		return "admin/admin_board_notice";
	}

	// 관리자페이지 공지사항 글등록 페이지로 이동
	@GetMapping("adminNoticeWrt")
	public String adminNoticeWrt() {
		return "admin/admin_board_notice_write";
	}

	@PostMapping("boardNoticeRgst") // 공지사항 글쓰기 : admin_board_notice_write.jsp
	public String boardNoticeRgst() {
		return "";
	}

	// 관리자페이지 공지사항 상세 조회 및 수정 페이지로 이동
	@GetMapping("adminNoticeDtl")
	public String adminNoticeDtl() {
		return "admin/admin_board_notice_detail";
	}
	
	@PostMapping("boardNoticeModOrDlt") // 공지사항 상세조회/수정 : admin_board_notice_detail.jsp
	public String boardNoticeModOrDlt() {
		return "";
	}
	
	// ===========================================================================================
	// *********************** 1대1문의 관리 페이지 *************
	// 관리자페이지 1대1문의 관리 페이지로 이동
	@GetMapping("adminOneOnOne")
	public String adminOneOnOne(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		
		// AdminService - getOneOnOneListCount() 메서드 호출해 전체 게시글 개수 조회
		// => 파라미터 : 없음	 리턴타입 : int
		int listCount = service.getOneOnOneListCount();

		// PageDTO 객체와 게시글 갯수, 페이지 번호 갯수를 파라미터로 전달
		PageCount pageInfo = new PageCount(page, listCount, 3);
		
		// AdminService - getOneOnOnePosts() 메서드 호출해 글 목록 조회
		// => 파라미터 : PageDTO 객체(page)	 리턴타입 : List<CsVO>(oneOnOneList)
		List<CsVO> oneOnOneList = service.getOneOnOnePosts(page);
		
		// Model 객체에 저장
		model.addAttribute("oneOnOneList", oneOnOneList);
		model.addAttribute("sId", sId);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_board_one_on_one";
	}

	// 관리자페이지 1대1문의 상세 조회, 답변 등록 및 수정 페이지로 이동
	@GetMapping("adminOneOnOneResp")
	public String adminOneOnOneResp(@RequestParam(defaultValue = "1") int pageNum, CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
//		// AdminService - getOneOnOnePostById() 메서드 호출해 글 목록 조회
//		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : CsVO 객체(oneOnOne)
//		CsVO oneOnOne = service.getOneOnOnePostById(cs);
		
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));		
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
		model.addAttribute("pageNum", pageNum);
		
		return "admin/admin_board_one_on_one_response";
	}
	
	// 관리자 페이지 1대1문의 답변 등록
	@PostMapping("boardOneOnOneRsp") 
	public String boardOneOnOneRsp(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNum, CsVO cs) {
		System.out.println(cs);
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// AdminService - writeOneOnOneReply() 메서드 호출해 답변 등록
		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : int(updateCount)
		int updateCount = service.writeOneOnOneReply(cs);
		
		if(updateCount > 0) { // 등록 성공
			model.addAttribute("pageNum", pageNum);
			// 1대1문의 관리페이지 메인으로 이동해 답변 상태 확인
			return "redirect:/adminOneOnOne";
			
		} else { // 등록 실패
			model.addAttribute("msg", "1대1 답변 등록 실패!");
			return "fail_back";
		}
		
	}
	
	
	// ===========================================================================================
	// ********************* 분실물 문의 관리 페이지 *************
	// 관리자페이지 분실물 문의 관리 페이지로 이동
	// 파라미터로 pageNum을 넘겨주고 파라미터가 없을 경우 기본값으로 1을 넘겨줍니다.
	@GetMapping("adminLostNFound")
	public String adminLostNFound(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = service.getlostnfoundListCount();
		// PageDTO 객체와 게시글 갯수, 페이지 번호 갯수를 파라미터로 전달
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// page 객체를 파라미터로 글 목록 조회(극장명이 포함되어 HashMap 객체로 저장)
		List<HashMap<String, Object>> lostnfoundList = service.getLostnfoundList(page);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		for(HashMap<String, Object> map : lostnfoundList) {
			// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
			LocalDateTime date = (LocalDateTime)map.get("cs_date");
			map.put("cs_date", date.format(dtf));
		}
		
		// 모델 객체에 담아서 전송
		model.addAttribute("lostnfoundList", lostnfoundList);
		model.addAttribute("sId", sId);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_board_lostnfound";
	}

	// 관리자페이지 분실물 문의 상세 조회 및 답변 등록 페이지로 이동
	@GetMapping("adminLostNFoundResp")
	public String adminLostNFoundResp(@RequestParam(defaultValue = "1") int pageNum, CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// cs_id가 저장된 cs 객체 전달하여 게시글 가져오기(극장명이 포함되어 HashMap 객체로 저장)
		Map<String, Object> lostnfound = service.getlostnfound(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)lostnfound.get("cs_date");
		lostnfound.put("cs_date", date.format(dtf));
		model.addAttribute("lostnfound", lostnfound);
		model.addAttribute("pageNum", pageNum);
		
		return "admin/admin_board_lostnfound_response";
	}

	// 분실물 문의 등록
	@PostMapping("boardLostnfoundRgst") // 분실물문의 답변 등록 : admin_board_lostnfound_response.jsp
	public String boardLostnfoundRgst(@RequestParam(defaultValue = "1") int pageNum, CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 등록 작업
		int updateCount = service.LostnfoundReply(cs);
		
		if(updateCount > 0) {
			model.addAttribute("pageNum", pageNum);
			return "redirect:/adminLostNFound";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}


	// 분실물 문의 답변 삭제
	@PostMapping("boardLostnfoundDlt") // 분실문 문의 답변삭제 : admin_board_lostnfound.jsp
	public String boardLostnfoundDlt(CsVO cs, HttpSession session, Model model) {
		System.out.println("넘어온 정보" + cs);
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 삭제 작업 요청
		int updateCount = service.lostnfoundDlt(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound";
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// ===========================================================================================
	// ********************* 영화리뷰 관리 페이지 *************
	// 관리자페이지 영화 리뷰 관리 페이지로 이동
	@GetMapping("adminReview")
	public String adminReview() {
		return "admin/admin_review";
	}

	@PostMapping("reviewDlt") // 리뷰 관리 : admin_review.jsp
	public String reviewDlt() {
		return "";
	}
	

}