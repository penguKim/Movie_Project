package com.itwillbs.c5d2308t1.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.c5d2308t1.service.StoreService;
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
//		무조건 자바스크립트 처리해야하는지?
//		String sId = (String)session.getAttribute("sId");
//		
//		if(sId == null) {
//			
//			return "login/login";
//		}
		
		System.out.println("상품명 : " + product_id);
		
		StoreVO store = service.selectTest(product_id); 
		
		System.out.println("출력값 : " + store);
		
		model.addAttribute("store", store);
		
		return "store/store_detail";
	}
	
	@GetMapping("storeCart") 
	public String storeCart() {
		return "store/store_cart";
	}
	
	
	@PostMapping("storePay")
	public String storePay() {
		return "store/store_pay";
	}
	
	
	
	
}
