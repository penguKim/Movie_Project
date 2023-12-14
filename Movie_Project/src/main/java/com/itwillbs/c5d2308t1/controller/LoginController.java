package com.itwillbs.c5d2308t1.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@PostMapping("MemberLoginPro") // 로그인 클릭 시 메인페이지로 이동
	public String MemberLoginPro(MemberVO member, HttpSession session, Model model) {
	    MemberVO dbMember = service.getMember(member);
	    
	    System.out.println(member.getMember_id());
	    
	    
	    
	    if(dbMember == null) {
	    	System.out.println("로그인 실패");
	    	return "main";
	    } else {
	    	model.addAttribute("dbMember", dbMember);
	    	System.out.println("로그인 성공: " + dbMember);
	    	return "main";
	    }
	}
	
	
}
