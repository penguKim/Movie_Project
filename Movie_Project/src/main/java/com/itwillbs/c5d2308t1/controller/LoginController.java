package com.itwillbs.c5d2308t1.controller;

import java.text.DecimalFormat;
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
import com.itwillbs.c5d2308t1.service.ReserveService;
import com.itwillbs.c5d2308t1.vo.*;
@Controller
public class LoginController {

	@Autowired
	private LoginService service;
	
	@Autowired
	ReserveService reserve;
	
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
		
		List<RefundVO> reserveList = service.getReserveList(refund);
		
		// DecimalFormat을 사용하여 payment_total_price를 30,000 형식으로 변환
	    DecimalFormat decimalFormat = new DecimalFormat("###,###");
	    
		System.out.println("지금 내아이디다 : " + refund.getMember_id());
		
		model.addAttribute("reserveList", reserveList);
		
		System.out.println("지금나는뭘까요 :" +  reserveList);
		
		
		return"login/Mypage_Refund_BoardList";
	}
	
	@GetMapping("Mypage_ReviewList")
	public String mypage_ReviewList(HttpSession session, Model model, ReviewsVO review) { // 리뷰 게시판으로 이동
		String sId = (String)session.getAttribute("sId");//현재 로그인 중인 아이디 sId 저장
		review.setMember_id(sId);
//		System.out.println(sId);
		List<ReviewsVO> myreview = service.getReviewList(review);
		model.addAttribute("myreview", myreview);
		return "login/Mypage_ReviewList";
	}
	
	
	// ============================================================================	
	// =====================마이페이지 나의게시글 1대1문의 내역==================
	// 마이페이지 나의 게시글 1대1문의 내역 조회 게시판으로 이동
	@GetMapping("Mypage_OneOnOneList")
	public String mypage_OneOnOneList(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model, MemberVO member) {
		String sId = (String)session.getAttribute("sId");
		member.setMember_id(sId);
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		
		// LoginService - getMyOneOnOnePostsCount() 메서드 호출해 전체 게시글 개수 조회
		// => 파라미터 : 세션 아이디(sId)	 리턴타입 : int
		int listCount = service.getMyOneOnOnePostsCount(sId);
		
		// PageDTO 객체와 게시글 갯수, 페이지 번호 갯수를 파라미터로 전달
		PageCount pageInfo = new PageCount(page, listCount, 3);
		
		// LoginService - getMyOneOnOnePosts() 메서드 호출해 글 목록 조회
		// => 파라미터 : 세션 아이디(sId), PageDTO 객체(page) 	 리턴 타입 : List<HashMap<String, Object>>(myOneOnOneList)
		List<HashMap<String, Object>> myOneOnOneList = service.getMyOneOnOnePosts(sId, page);
//		List<HashMap<String, Object>> myOneOnOneList = service.getMyOneOnOnePosts(sId);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		for(HashMap<String, Object> map : myOneOnOneList) {
			// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
			LocalDateTime date = (LocalDateTime)map.get("cs_date");
			map.put("cs_date", date.format(dtf));
		}
//		System.out.println("myOneOnOneList : " + myOneOnOneList);
		model.addAttribute("myOneOnOneList", myOneOnOneList);
		model.addAttribute("sId", sId);
		model.addAttribute("pageInfo", pageInfo);

		
		return "login/Mypage_OneOnOneList";
	}

	
	// 마이페이지 나의 게시글 1대1문의 상세 조회
	@GetMapping("Mypage_OneOnOneDetail")
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
	@GetMapping("MyPageOneOnOneDelete")
	public String MyPageOneOnOneDelete(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		cs.setMember_id(sId);
		if(sId == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		// LoginService - removeMyOneOnOne() 메서드 호출해 해당 글 상세 내용 조회
		// 파라미터 : CsVO 객체(cs) 		리턴타입 : int (deleteCount) 
		int deleteCount = service.removeMyOneOnOne(cs);
		if(deleteCount > 0) {
			return "redirect:/Mypage_OneOnOneList";
		} else {
			model.addAttribute("msg", "1대1문의 글 삭제에 실패했습니다!");
			return "fail_back";
		}
		
	}
	
	// ============================================================================	
	
	
	
	// 분실물 문의 게시판으로 이동
	@GetMapping("Mypage_LostBoard_List")
	public String LostBoard(Model model, HttpSession session, CsVO myCs) { 
		
		String sId = (String)session.getAttribute("sId");
		
		myCs.setMember_id(sId);
		
		List<CsVO> myLost = service.getLostBoardList(myCs);
		
//		Map<String, Object> myLost2 = service.getlostnfound(myCs);
		
//		myLost2.put("myLost2", myLost2);
		
		model.addAttribute("myLost", myLost);
		
		System.out.println("ㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴㄴ + " + myLost);
		
		return "login/Mypage_LostBoard_List";
	}
	
	@GetMapping("Mypage_LostBoad")
	public String mypage_LostBoad() { // 분실물 문의 상세게시판으로 이동
		return "login/Mypage_LostBoad";
	}
	
	@GetMapping("Mypage_Product_boardList")
	public String mypage_Product_boardList(HttpSession session, RefundVO refund, Model model) { // 상품내역 게시판
		
		// 세션 아이디 저장
		String sId = (String)session.getAttribute("sId");
		// 세션 아이디 refund.member_id에 저장
		refund.setMember_id(sId);
		
		List<RefundVO> myStoreList = service.getMyStoreSelect(refund);
		// 모델 객체에 select한 결과값 저장
		model.addAttribute("myStoreList", myStoreList);
		
		System.out.println("ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ : " + myStoreList);
		
		
		return "login/Mypage_Product_boardList";
	}
	
	//마이페이지 예매 취소 상세내역 팝업창
	@GetMapping("refundInfoDetailPro")
	public String resInfoDetailPro(@RequestParam String payment_id, Map<String, String> map, Model model) {
		map = reserve.getresInfoDetail(payment_id);
		model.addAttribute("map",map);
		return"login/popup3";
	}
	
	// 마이페이지 분실물 상세 조회
		@GetMapping("Mypage_LostBoardDetail")
		public String LostBoardDetail(HttpSession session,Model model, CsVO cs) {
			
			// cs_id가 저장된 cs 객체 전달하여 게시글 가져오기(극장명이 포함되어 HashMap 객체로 저장)
			Map<String, Object> myLostDetail = service.getlostnfound(cs);
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
			LocalDateTime date = (LocalDateTime)myLostDetail.get("cs_date");
			myLostDetail.put("cs_date", date.format(dtf));
			model.addAttribute("myLostDetail", myLostDetail);
			
		return "login/Mypage_LostBoardDetail";
	}
}
