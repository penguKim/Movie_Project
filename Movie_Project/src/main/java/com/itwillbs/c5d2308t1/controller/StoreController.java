package com.itwillbs.c5d2308t1.controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.c5d2308t1.service.StoreService;
import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Controller
public class StoreController {
	
	@Autowired
	private StoreService service;
	
	@GetMapping("store")
	public String store() {
		
		return "store/store_main";
	}
	
	@GetMapping("event")
	public String event() {
		return "event/event_movie";
	}
	
	@GetMapping("storeDetail")
	public String storeDetail(HttpSession session, String product_id, Model model) {

		String sId = (String)session.getAttribute("sId");
			
		if(sId == null) {
			
			return "login/login";
		}
		
		System.out.println("상품명 : " + product_id);
		
		StoreVO store = service.selectTest(product_id); 
		
//		System.out.println("출력값 : " + store);
		
		model.addAttribute("store", store);
		
		return "store/store_detail";
	}
	
	@GetMapping("storeCart") 
	public String storeCart(HttpSession session, Model model, MemberVO member, CartVO cart) {
			
		String sId = (String)session.getAttribute("sId");
		
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		
		
		member.setMember_id(sId);
		
		int result = service.insertTest(member);

		List<CartVO> result2 = service.selectTest1(member);
		
		System.out.println("내아이디 : " + member);
		
		model.addAttribute("product_id",result2);
		

		if(result > 0 ) {
			return "store/store_cart";
		} else {
			model.addAttribute("msg", "잘못된 접근입니다");
			return "forward2";
		}
	}
	
	
	
	@GetMapping("storeCart2")
	public String storeCart2(MemberVO member, HttpSession session, Model model) {
		
		String sId = (String)session.getAttribute("sId");
		
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		
		System.out.println("내 sId다 : " + sId);
		
		member.setMember_id(sId);
		
		List<CartVO> result3 = service.selectTest1(member);
		
		System.out.println("내정보다 : " + result3);
		
		
		return "store/store_cart";
		
	}
	
	
	@GetMapping("storePay")
	public String storePay(HttpSession session, Model model, StoreVO store) {
		
		String sId = (String)session.getAttribute("sId");
		if(sId == null) {
			
			return "login/login";
		}
		
		
		return "store/store_pay";
	}
	
	
	
	
}
