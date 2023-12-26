package com.itwillbs.c5d2308t1.controller;

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
	    
	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	    
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
	
	
	@GetMapping("SideEditmember") //회원수정 페이지 이동
	public String sideEditmember(MemberVO member, HttpSession session, Model model) {
		// 세션 아이디가 없을 경우 "fail_back" 페이지를 통해 "잘못된 접근입니다" 출력 처리
		String sId = (String) session.getAttribute("sId");
		if (sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			return "fail_back";
		}
		//(memberid가 null 또는 널스트링이고 세션Id가 admin이거나),sId가 admin이 아닐때
		//id를 세션아이디로 봐꾸기
		if(!sId.equals("admin") || (sId.equals("admin") && (member.getMember_id() == null || member.getMember_id().equals("")))) {
			member.setMember_id(sId);
		}
		MemberVO dbMember = service.getMember(member);
		
		model.addAttribute("member",dbMember);
		return "login/editmember";
	}
	
	@GetMapping("Mypage_Refund_BoardList") //취소내역 페이지 이동
	public String mypage_Refund_BoardList(HttpSession session,Model model) {
		// 세션 아이디를 판별
		String sId = (String) session.getAttribute("sId");
		
		Map<String, String> reserveList = service.getReserveList(); 
		
		model.addAttribute("reserveList", reserveList);
		
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
	
	// 마이페이지 나의 게시글 1대1문의 게시판으로 이동
	@GetMapping("Mypage_OneOnOneList")
	public String mypage_OneOnOneList(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
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
	
	@GetMapping("Mypage_Product_boardList")
	public String mypage_Product_boardList() { // 상품내역 게시판
		return "login/Mypage_Product_boardList";
	}
	
}
