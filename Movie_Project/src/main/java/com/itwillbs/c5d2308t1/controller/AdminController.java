package com.itwillbs.c5d2308t1.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;
import com.itwillbs.c5d2308t1.service.AdminService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.PageCount;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.PageInfo;
import com.itwillbs.c5d2308t1.vo.PlayVO;
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
	
	//관리자페이지 영화검색 페이지로 이동
	@GetMapping("adminMovieSearch")
	public String adminMovieSearch(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "admin/admin_movie_search";
	}
	
	//영화검색 페이지에서 검색버튼 누를시 데이터 조회
	@PostMapping("adminMovieDetails")
	public String adminMovieDetails(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";		
		}
		return "admin/admin_movie_search";
	}	
	

	// DB에 등록된 영화 중복 판별 작업
	@ResponseBody
	@GetMapping("movieDupl")
	public String movieDupl(MoviesVO movie) {
		System.out.println(movie.getMovie_id());
		
		movie = service.getMovie(movie);
		
		if(movie != null) {
			return "true";
		} else {
			return "false";
		}
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
	public String adminMovieSchedule(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		List<Map<String, Object>> playList = service.getMainScheduleInfo();
		System.out.println(playList);
		model.addAttribute("playList", playList);
		
//		TheaterVO mTheater = service.getMainScheduleInfo(theater);
//		System.out.println(mTheater);
//		
//		if(mTheater != null) {
//			model.addAttribute("mTheater", mTheater);
//			return "admin/admin_movie_schedule";
//		} else {
//			model.addAttribute("msg", "상영 일정 조회에 실패했습니다!");
//			return "fail_back";
//		}
		
//		PlayVO playList = service.getMainScheduleInfo(play);
		
		return "admin/admin_movie_schedule";
	}
	
	// 상영 일정 조회
	@ResponseBody
	@GetMapping("ScheduleSearch")
	public List<Map<String, Object>> ScheduleSearch(
			@RequestParam Map<String, String> map) {
		System.out.println("파라미터로 받아온 theater_id : " + map.get("theater_id"));
		System.out.println("파라미터로 받아온 play_date : " + map.get("play_date"));
		// System.out.println(theater_id);
		// System.out.println(play_date);
		List<Map<String, Object>> playList = service.getScheduleInfo(map);
		System.out.println("playList : " + playList); // 출력값 X
		return playList;
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
	
//	@PostMapping("memberDlt") // 회원 정보 관리 메인(탈퇴, 비회원) : admin_member.jsp
//	public String memberDlt() {
//		return "";
//	}
	
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
	public String adminFaq(CsVO cs, Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1") int pageNum, HttpSession session) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 자주묻는질문 버튼을 눌렀을 때 cs_type을 자주묻는질문으로 설정
		cs.setCs_type("자주묻는질문");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<HashMap<String, Object>> faqList = service.getCsList(cs, startRow, listLimit);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getCsTypeListCount(cs);
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
		model.addAttribute("faqList", faqList);
		model.addAttribute("pageNum", pageNum);
		
		return "admin/admin_board_faq";
	}

	// 관리자페이지 자주묻는질문 글쓰기 페이지로 이동
	@GetMapping("adminFaqWriteForm")
	public String adminFaqWriteForm(HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		return "admin/admin_board_faq_write";
	}

	// 관리자페이지 자주묻는질문 글 등록하기
	@PostMapping("adminFaqWritePro") // 자주묻는 질문 글쓰기 : admin_board_faq_write.jsp
	public String boardFaqWritePro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		int insertCount = service.registBoard(cs);

		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount > 0) {
			
			return "redirect:/adminFaq";
			
		} else {			
			model.addAttribute("msg", "자주묻는질문 등록 실패!");
			return "fail_back";
		}
				
	}

	
	// 관리자페이지 자주묻는질문 상세 조회 페이지로 이동
	@GetMapping("adminFaqView")
	public String adminFaqView(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}

		HashMap<String, Object> faqDetail = service.boardfaqDetailPage(cs);
		System.out.println(faqDetail);
		model.addAttribute("faqDetail", faqDetail);
		
		return "admin/admin_board_faq_view";
	}
	
	@PostMapping("adminFaqModifyForm") // 자주 묻는 질문 수정 : admin_board_faq_write.jsp 재사용
	public String adminFaqModifyForm(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// DB에 등록되어있는 값 가져오기
		HashMap<String, Object> faqDetail = service.boardfaqDetailPage(cs);
		System.out.println(faqDetail);
		model.addAttribute("faqDetail", faqDetail);	
		
		return "admin/admin_board_faq_modify";
	}
	
	// 관리자페이지 자주묻는질문 글 수정하기
	@PostMapping("adminFaqModifyPro") // 자주묻는 질문 글쓰기 : admin_board_faq_write.jsp
	public String boardFaqModifyPro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// AdminService - registBoard() 메서드 호출하여 문의글 수정 요청
		int updateCount = service.updateBoard(cs);
		System.out.println("updateCount :" + updateCount);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(updateCount > 0) {
			
			return "redirect:/adminFaq";
			
		} else {			
			model.addAttribute("msg", "자주묻는질문 수정 실패!");
			return "fail_back";
		}
			
	}
	
	
	@GetMapping("adminFaqDelete")
	public String adminFaqDelete(CsVO cs, @RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		HashMap<String, Object> board = service.boardfaqDetailPage(cs);
		
		int deleteCount = service.removeBoard(board);
		
		if(deleteCount > 0) { // 삭제 성공
			
			return "redirect:/adminNotice?pageNum=" + pageNum;
			
		} else { // 삭제 실패
			// "글 삭제 실패!" 메세지 처리
			model.addAttribute("msg", "글 삭제 실패!");
			return "fail_back";
		}

	}

	// ===========================================================================================
	// ********************** 공지사항 관리 페이지 *************
	// 관리자페이지 공지사항 관리 페이지로 이동
	@GetMapping("adminNotice")
	public String adminNotice(CsVO cs, Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1") int pageNum, HttpSession session) {
		
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 공지사항 버튼을 눌렀을 때 cs_type을 자주묻는질문으로 설정
		cs.setCs_type("공지사항");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 공지사항 출력(재사용)
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<HashMap<String, Object>> NoticeList = service.getCsList(cs, startRow, listLimit);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getCsTypeListCount(cs);
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
		model.addAttribute("NoticeList", NoticeList);
		model.addAttribute("pageNum", pageNum);
		System.out.println(NoticeList);
		
		return "admin/admin_board_notice";
	}

	// 관리자페이지 공지사항 글등록 페이지로 이동
	@GetMapping("adminNoticeWriteForm")
	public String adminNoticeWriteForm(HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		return "admin/admin_board_notice_write";
	}

	@PostMapping("adminNoticeWritePro") // 공지사항 글쓰기 : admin_board_notice_write.jsp
	public String adminNoticeWritePro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// --------------------------------------------------------
		// 파일업로드를 위한 준비
		// resources 디렉토리 내에 upload 파일 생성
		String uploadDir = "/resources/upload"; // 가상 디렉토리
		String saveDir = session.getServletContext().getRealPath(uploadDir); // 실제 디렉토리
		String subDir = "";
//				
		// 날짜별로 서브디렉토리 생성하기
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		subDir = now.format(dtf);
		
		saveDir += File.separator + subDir;
		
		// 해당 디렉토리가 존재하지 않을 때에만 자동생성
		try {
			Path path = Paths.get(saveDir); // 업로드 경로
			Files.createDirectories(path); // Path 객체
		} catch (IOException e) {
			e.printStackTrace();
		}
		
//				// MultipartFile 타입 객체 꺼내기
		MultipartFile mFile = cs.getMFile();
		
		// 파일명 중복을 방지하기 위해 난수 생성하기
		cs.setCs_file("");
		String fileName = UUID.randomUUID().toString() + "_" + mFile.getOriginalFilename();
		
		if(!mFile.getOriginalFilename().equals("")) {
			cs.setCs_file(subDir + "/" + fileName);
		}
		
		System.out.println("업로드 파일명 확인 : " + cs.getCs_file());
		
		
		// CsService - registBoard() 메서드 호출하여 문의글 등록 요청
		// => 파라미터 : CsVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registBoard(cs);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount > 0) {
			// 파일이 있을 경우에만 파일 생성
			try {
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
					
			
			return "redirect:/adminNotice";
			
		} else {			
			model.addAttribute("msg", "공지사항 등록 실패!");
			return "fail_back";
		}
			
		
	}

	// 관리자페이지 공지사항 상세 조회 페이지로 이동
	@GetMapping("adminNoticeView")
	public String adminNoticeView(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}

		HashMap<String, Object> noticeDetail = service.boardNoticeDetailPage(cs);
		System.out.println(noticeDetail);
		model.addAttribute("noticeDetail", noticeDetail);
				

		return "admin/admin_board_notice_view";
	}
	
	// 공지사항 수정
	@PostMapping("adminNoticeModifyForm")
	public String adminNoticeModifyForm(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// DB에 등록되어있는 값 가져오기
		HashMap<String, Object> noticeDetail = service.boardNoticeDetailPage(cs);
		System.out.println(noticeDetail);
		model.addAttribute("noticeDetail", noticeDetail);	
		
		return "admin/admin_board_notice_modify";
	}
	
	
	@PostMapping("adminNoticeModifyPro") // 공지사항 글쓰기 : admin_board_notice_write.jsp
	public String adminNoticeModifyPro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// --------------------------------------------------------
		// 파일업로드를 위한 준비
		// resources 디렉토리 내에 upload 파일 생성
		String uploadDir = "/resources/upload"; // 가상 디렉토리
		String saveDir = session.getServletContext().getRealPath(uploadDir); // 실제 디렉토리
		String subDir = "";
//				
		// 날짜별로 서브디렉토리 생성하기
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		subDir = now.format(dtf);
		
		saveDir += File.separator + subDir;
		
		// 해당 디렉토리가 존재하지 않을 때에만 자동생성
		try {
			Path path = Paths.get(saveDir); // 업로드 경로
			Files.createDirectories(path); // Path 객체
		} catch (IOException e) {
			e.printStackTrace();
		}
		
//		// MultipartFile 타입 객체 꺼내기
		MultipartFile mFile = cs.getMFile();
		
		// 파일명 중복을 방지하기 위해 난수 생성하기
		cs.setCs_file("");
		String fileName = UUID.randomUUID().toString() + "_" + mFile.getOriginalFilename();
		
		if(!mFile.getOriginalFilename().equals("")) {
			cs.setCs_file(subDir + "/" + fileName);
		}
		
		System.out.println("업로드 파일명 확인 : " + cs.getCs_file());
		

		int updateCount = service.updateBoard(cs);
		System.out.println("updateCount :" + updateCount);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(updateCount > 0) {
			// 파일이 있을 경우에만 파일 생성
			try {
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "redirect:/adminNotice";
				
		} else {			
			model.addAttribute("msg", "공지사항 수정 실패!");
			return "fail_back";
		}
		
	}
	
	
	@GetMapping("adminNoticeDelete")
	public String adminNoticeDelete(CsVO cs, @RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		HashMap<String, Object> board = service.boardfaqDetailPage(cs);
		
		int deleteCount = service.removeBoard(board);
		
		if(deleteCount > 0) { // 삭제 성공
			try {
				// ------------------------------------------------------
				// [ 서버에서 파일 삭제 ]
				String uploadDir = "/resources/upload"; // 가상의 경로(이클립스 프로젝트 상에 생성한 경로)
				String saveDir = session.getServletContext().getRealPath(uploadDir);

				if(!board.get("cs_file").equals("")) {
					// Paths.get() 메서드 호출하여 파일 경로 관리 객체인 Path 객체 생성 후
					// => 파라미터로 업로드 디렉토리명과 서브디렉토리를 포함한 파일명 결합하여 전달
					// => Files.deleteIfExists() 메서드 호출하여 파일이 존재할 경우에만 파일 삭제
					Path path = Paths.get(saveDir + "/" + board.get("cs_file"));
					System.out.println(path);
					Files.deleteIfExists(path);
				}
							
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "redirect:/adminNotice?pageNum=" + pageNum;
			
		} else { // 삭제 실패
			// "글 삭제 실패!" 메세지 처리
			model.addAttribute("msg", "글 삭제 실패!");
			return "fail_back";
		}

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

	// 관리자페이지 1대1문의 상세 조회 페이지로 이동
	@GetMapping("OneOnOneDetail")
	public String OneOnOneDetail(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
//		// AdminService - getOneOnOnePostById() 메서드 호출해 해당 글 조회
//		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : Map<String, Object> (oneOnOne)
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
		
		return "admin/admin_board_one_on_one_detail";
	}
	
	// 관리자페이지 1대1문의 등록 페이지로 이동
	@GetMapping("OneOnOneMoveToRegister")
	public String OneOnOneRsp(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
//		// AdminService - getOneOnOnePostById() 메서드 호출해 글 목록 조회
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
		
		return "admin/admin_board_one_on_one_response";
	}
	
	
	
	// 관리자 페이지 1대1문의 답변 등록
	@PostMapping("OneOnOneResponse") 
	public String OneOnOneResponse(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNum, CsVO cs) {
//		System.out.println(cs);
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
			// 답변 등록 완료 후 해당 글이 속해있는 1대1문의 관리페이지로 이동해 버튼으로 답변 상태 확인
			return "redirect:/adminOneOnOne?pageNum=" + pageNum;
			
		} else { // 등록 실패
			model.addAttribute("msg", "1대1 답변 등록 실패!");
			return "fail_back";
		}
		
	}
	
	// 관리자페이지 1대1문의 기존 답변 수정페이지로 이동
	@PostMapping("OneonOneMoveToModify")
	public String OneonOneMoveToModify(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
//		// AdminService - getOneOnOnePostById() 메서드 호출해 해당 글 조회
//		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : Map<String, Object> (oneOnOne)
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
				
		
		return "admin/admin_board_one_on_one_response";
	}
	
	// 관리자 페이지 1대1문의 기존 답변 수정
	@PostMapping("OneOnOneModify")
	public String OneOnOneModify(HttpSession session, Model model, CsVO cs, @RequestParam int cs_id) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// AdminService - modifyOneOnOneReply() 메서드 호출해 등록된 답변 수정
		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : int(updateCount)
		int updateCount = service.modifyOneOnOneReply(cs);
		
		if(updateCount == 0) { // 수정 실패 시
			model.addAttribute("msg", "1대1문의 답변 수정 실패!");
			return "fail_back";
		} else {
			// Model 객체에 저장
			model.addAttribute("cs_id", cs_id);
			return "redirect:/OneOnOneDetail?cs_id=" + cs_id;
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
	

	// 관리자페이지 분실물 문의 등록 페이지로 이동
	@GetMapping("LostNFoundMoveToRegister")
	public String lostNFoundResp(CsVO cs, HttpSession session, Model model) {
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
		
		return "admin/admin_board_lostnfound_response";
	}
	
	// 분실물 문의 답변 등록
	@PostMapping("LostNFoundResponse") // 분실물문의 답변 등록 : admin_board_lostnfound_response.jsp
	public String lostnFoundResponse(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 등록 작업
		int updateCount = service.LostnfoundReply(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 관리자페이지 분실물 문의 상세 조회 페이지로 이동
	@GetMapping("LostNFoundDetail")
	public String lostNFoundDetail(CsVO cs, HttpSession session, Model model) {
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
		
		return "admin/admin_board_lostnfound_detail";
	}
	
	// 관리자페이지 분실물 문의 기존 답변 수정 페이지로 이동
	@PostMapping("LostNFoundMoveToModify")
	public String lostNFoundMoveToModify(CsVO cs, HttpSession session, Model model) {
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
		
		return "admin/admin_board_lostnfound_response";
	}
	
	// 관리자페이지 분실물 문의 기존 답볍 수정 
	@PostMapping("LostNFoundModify")
	public String lostnFoundModify(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 등록 작업
		int updateCount = service.LostnfoundReply(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}

	// 분실물 문의 답변 삭제
	@PostMapping("LostNFoundDelete") // 분실문 문의 답변삭제 : admin_board_lostnfound.jsp
	public String lostNFoundDelete(CsVO cs, HttpSession session, Model model) {
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