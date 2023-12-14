package com.itwillbs.c5d2308t1.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.JoinService;
import com.itwillbs.c5d2308t1.vo.MemberVO;

@Controller
public class JoinController {
	
	// 의존성 주입받을 멤버변수 선언 시 @Autowired 어노테이션을 지정
	@Autowired
	private JoinService service;
	
	// 회원가입(인증) 페이지로 이동
	@GetMapping("memberJoin")
	public String memberJoin() {
		return "join/join_certification";
	}
	
	// 회원가입(동의) 페이지로 이동
	@PostMapping("memberJoinAgree")
	public String memberJoinAgree() {
		return "join/join_agree";
	}
	
	// 회원가입(폼) 페이지로 이동
	@PostMapping("memberJoinForm")
	public String memberJoinForm() {
		return "join/join_form";
	}
	
	// 회원가입 폼에 입력된 정보를 DB에 저장하고
	// 회원가입 완료 페이지로 이동
	@PostMapping("memberJoinPro")
	public String memberJoinPro(MemberVO member, Model model) {
		// JoinService - registMember() 메서드 호출하여 회원정보 등록 요청
		// => 파라미터 : StudentVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registMember(member);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount == 0) {
			model.addAttribute("msg", "회원정보 등록 실패!");
			return "fail_back";
		}
		
		return "join/join_completion";
	}
	
	// 아이디 중복검사를 위해 DB에 접근
//	@PostMapping("idCheck")
//	@ResponseBody
//	public String idCheck(@RequestParam("member_id") String member_id) throws Exception {
//		int idCheck = service.idCheck(member_id);   
//		System.out.println(idCheck);
//		
//		return "join_form";
//		
//	}
	
	// 로그인 페이지로 이동
	@GetMapping("memberLogin")
	public String memberLogin() {
		return "login/login";
	}
	
	// 메인 페이지로 이동
	@GetMapping("main")
	public String main() {
		return "main";
	}
	
}