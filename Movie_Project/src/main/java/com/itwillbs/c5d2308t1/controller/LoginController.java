package com.itwillbs.c5d2308t1.controller;

import java.util.List;

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
	@GetMapping("mypage") //메인화면에서 버튼 클릭시 mypage이동
	public String mypage() {
		return "login/mypage";
	}
	
	@PostMapping("MemberLoginPro") // 로그인 클릭 시 메인페이지로 이동
	public String MemberLoginPro(MemberVO member, HttpSession session, Model model) {
	    MemberVO dbMember = service.getMember(member);
	    
	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();//테스트 주석
//	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder(); 테스트
	    
//	    if(dbMember == null) {//로그인 실패시
	    if(dbMember == null || !passwordEncoder.matches(member.getMember_passwd(), dbMember.getMember_passwd())) {//로그인 실패시
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
	
	@GetMapping("SideMypage") //마이페이지 이동
	public String SideMypage() {
		
		return"login/mypage";
	}
	
	@GetMapping("SideEditmember") //회원수정 페이지 이동
	public String SideEditmember() {
		return"login/editmember";
	}
	
	@GetMapping("SideRefund") //취소내역 페이지 이동
	public String SideRefund() {
		return"login/refund";
	}
	
	@GetMapping("SideMyboard") //나의 게시글 페이지 이동
	public String SideMyboard() {
		return"login/myboard";
	}
	
	@GetMapping("myPageOneOnOneDtl")
	public String myPageOneOnOneDtl() { // 나의 게시글 1대1문의 상세페이지로 이동
		return "login/mypage_OneOnOne";
	}
	
	
	
}
