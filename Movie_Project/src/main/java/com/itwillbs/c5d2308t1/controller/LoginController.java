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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.service.LoginService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.RefundVO;
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
	    	//주소값 뒤에 파라미터값을 판별해서 각 페이지로 이동한다.
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
	public String mypage_Refund_BoardList(HttpSession session,Model model, RefundVO refund) {
		// 세션 아이디를 판별
		String sId = (String) session.getAttribute("sId");
		
		refund.setMember_id(sId);
		
		List<RefundVO> reserveList = service.getReserveList2(refund, sId);
		
		System.out.println("지금 내아이디다 : " + refund.getMember_id());
		
		model.addAttribute("reserveList", reserveList);
		
		return"login/Mypage_Refund_BoardList";
	}
	
	@GetMapping("Mypage_ReviewList")
	public String mypage_ReviewList() { // 리뷰 게시판으로 이동
		return "login/Mypage_ReviewList";
	}
	
	
	// 마이페이지 나의 게시글 1대1문의 내역 조회 게시판으로 이동
	@GetMapping("Mypage_OneOnOneList")
	public String mypage_OneOnOneList(HttpSession session, Model model, MemberVO member) {
		String sId = (String)session.getAttribute("sId");
		member.setMember_id(sId);
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		// LoginService - getMyOneOnOnePosts() 메서드 호출해 글 목록 조회
		// => 파라미터 : 세션아이디(sId) 	 리턴 타입 : List<HashMap<String, Object>>(myOneOnOneList)
		List<HashMap<String, Object>> myOneOnOneList = service.getMyOneOnOnePosts(sId);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		for(HashMap<String, Object> map : myOneOnOneList) {
			// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
			LocalDateTime date = (LocalDateTime)map.get("cs_date");
			map.put("cs_date", date.format(dtf));
		}
//		System.out.println("myOneOnOneList : " + myOneOnOneList);
		model.addAttribute("myOneOnOneList", myOneOnOneList);
		model.addAttribute("sId", sId);
		
		return "login/Mypage_OneOnOneList";
	}

	
	// 마이페이지 나의 게시글 1대1문의 상세 조회
	@RequestMapping(value = "Mypage_OneOnOneDetail", method = {RequestMethod.GET, RequestMethod.POST})
	public String Mypage_OneOnOneDetail(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		// LoginService - getMyOneOnOneDetail() 메서드 호출해 해당 글 상세 내용 조회
		// 파라미터 : CsVO 객체(cs) 		리턴타입 : Map<String, Object> (oneOnOne) 
		Map<String, Object> oneOnOne = service.getMyOneOnOneDetail(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		
		model.addAttribute("oneOnOne", oneOnOne);

		return "login/Mypage_OneOnOne";
	}
	
	// 마이페이지 나의 게시글 1대1문의 글 삭제
	@PostMapping("MyPageOneOnOneDelete")
	public String MyPageOneOnOneDelete(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		// LoginService - removeMYOneOnOne() 메서드 호출해 해당 글 상세 내용 조회
		// 파라미터 : CsVO 객체(cs) 		리턴타입 : int (deleteCount) 
		int deleteCount = service.removeMyOneOnOne(cs);
		if(deleteCount > 0) {
			return "redirect:/Mypage_OneOnOneList";
		} else {
			model.addAttribute("msg", "1대1문의 글 삭제에 실패했습니다!");
			return "fail_back";
		}
		
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
