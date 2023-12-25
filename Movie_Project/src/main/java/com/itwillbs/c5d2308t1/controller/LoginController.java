package com.itwillbs.c5d2308t1.controller;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.c5d2308t1.service.LoginService;
import com.itwillbs.c5d2308t1.vo.MemberVO;
@Controller
public class LoginController {

	@Autowired
	private LoginService service;
	
	@GetMapping("memberLogin") //메인화면에서 로그인 버튼 클릭시 이동
	public String memberLogin() {
//		System.out.println("memberLogin");
		return "login/login";
	}
	@GetMapping("Mypage") //메인화면에서 버튼 클릭시 mypage이동
	public String mypage() {
		return "login/Mypage";
	}
	
	@PostMapping("MemberLoginPro") // 로그인 클릭 시 메인페이지로 이동
	public String memberLoginPro(MemberVO member, HttpSession session, Model model) {
	    MemberVO dbMember = service.getMember(member);
	    
//	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	    
	    if(dbMember == null || !member.getMember_passwd().equals(dbMember.getMember_passwd())) {//로그인 실패시
//	    if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {//로그인 실패시

	    	model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지않습니다");
	    	return "fail_back";
	    	
	    } else { // 로그인 성공시
	    	model.addAttribute("dbMember", dbMember);
	    	session.setAttribute("sId", member.getMember_id());
	    	System.out.println("로그인 성공: " + dbMember);
	    	return "main";
	    }
	}
	
	@GetMapping("MemberLogout") //로그아웃
	public String logout(HttpSession session) {
		session.invalidate(); //세션값 초기화
		return "redirect:/";
	}
	
	
	@GetMapping("SideEditmember") //회원수정 페이지 이동
	public String sideEditmember() {
		return"login/editmember";
	}
	
	@GetMapping("Mypage_Refund_BoardList") //취소내역 페이지 이동
	public String mypage_Refund_BoardList(
		    Model model, HttpSession session) {
		// 내 세션 아이디 저장

		String sId = (String)session.getAttribute("sId");
		
		// 임시 예매페이지에서 영화제목 , 예약시간 , 예약상태 조회
		Map<String, String> reserveList = service.getReserveList();
		
		model.addAttribute("reserveList", reserveList);
		
		// 로그인한 아이디에 따라서
		// 예매내역 판별 해야됨
		// 취소시 고놈만 취소내역에 남도록
		
		System.out.println("지금내아이디 : " + sId);
		
		System.out.println("여긴 뭐가 들었지? : " + reserveList);
		
		return"login/Mypage_Refund_BoardList";
		
	}
	
	@GetMapping("Mypage_ReviewList")
	public String mypage_ReviewList() { // 1대1문의게시판으로 이동
		return "login/Mypage_ReviewList";
	}
	
	@GetMapping("Mypage_OneOnOne")
	public String mypage_OneOnOne() { //1대1문의 상세게시판으로 이동
		return "login/Mypage_OneOnOne";
	}
	
	@GetMapping("Mypage_OneOnOneList")
	public String mypage_OneOnOneList() { // 1대1문의게시판으로 이동
		return "login/Mypage_OneOnOneList";
	}
	
	@GetMapping("Mypage_LostBoard_List")
	public String mypage_LostBoard_List() { // 분실물 문의 게시판으로 이동
		return "login/Mypage_LostBoard_List";
	}
	
	@GetMapping("Mypage_LostBoad")
	public String mypage_LostBoad() { // 분실물 문의 상세게시판으로 이동
		return "login/Mypage_LostBoad";
	}
	
	@GetMapping("Mypage_Reserv_boardList")
	public String mypage_Reserv_boardList() { // 예매내역 게시판
		return "login/Mypage_Reserv_boardList";
	}
	
	@GetMapping("Mypage_Product_boardList")
	public String mypage_Product_boardList() { // 상품내역 게시판
		return "login/Mypage_Product_boardList";
	}
	
}
