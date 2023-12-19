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
	
	// 스토어 상세페이지 매핑
	@GetMapping("storeDetail")
	public String storeDetail(HttpSession session, String product_id, Model model) {
//		System.out.println("상품명 : " + product_id);
		StoreVO store = service.selectTest(product_id); 
//		System.out.println("출력값 : " + store);
		model.addAttribute("store", store);
		
		return "store/store_detail";
	}
	
	// 스토어 장바구니 매핑
	@GetMapping("storeCart") 
	public String storeCart(HttpSession session, Model model, MemberVO member, CartVO cart) {
		String sId = (String)session.getAttribute("sId");
		// 장바구니 담기를 위한 세션 아이디 판별
		// 세션 아이디가 없을 경우
		if(sId == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		
		// 멤버 VO 객체에 세션 아이디 저장
		member.setMember_id(sId);
		
		// 장바구니에 저장된 데이터
		List<StoreVO> cartList = service.selectCart(member);
		
		System.out.println("");
		// 장바구니 비즈니스 로직(insert, update) 성공여부 확인을 위한 insertSuccess 변수 초기화
		int cartDbSuccess = 0;
		
		// 장바구니 판별 어떻게 해야할까???
		if(cartList != null) {
			cartDbSuccess = service.updateCart(member);
		} else {
			// 장바구니 버튼 클릭 시 해당 상품 인설트 
			cartDbSuccess = service.insertTest(member);
		}
		
//		System.out.println("내아이디 : " + member);
		model.addAttribute("cartList", cartList);
		
		if(cartDbSuccess > 0 ) {
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
		
		System.out.println("다시 아이디 : " + member.getMember_id());
		List<StoreVO> cartList = service.selectCart(member);
		
		
		System.out.println("내정보다 : " + cartList);
		
		model.addAttribute("cartList", cartList);
		
		return "store/store_cart";
		
	}
	
	@GetMapping("storePay")
	public String storePay(HttpSession session, Model model, StoreVO store, String quantity) {
		String sId = (String)session.getAttribute("sId");
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
//		System.out.println("스토어아이디: " + store);
		List<StoreVO> storeList = service.selectStore(store);
		// List<CartVO> storeList = service.selectStore(store);
		
		System.out.println("리스트 : " + storeList);
		
		// 1안
		// List 객체에 CartVO 하나더 정의해서 model객체에 저장 후
		// 두 List를 한번에 꺼내 쓰는건 어떨까???
		// List<CartVO> storeList = service.selectStore(store);
		
		model.addAttribute("storeList", storeList);
		
		// 2안
		// quantity 변수를 사용해서 강제적으로 사용
//		model.addAttribute("storeList", quantity);
		
		return "store/store_pay";
	}
	
}
