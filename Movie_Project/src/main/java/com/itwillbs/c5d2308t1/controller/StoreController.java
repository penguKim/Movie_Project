package com.itwillbs.c5d2308t1.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@PostMapping("storeDetail")
	@ResponseBody
	public StoreVO storeDetail(HttpSession session, String product_id, Model model) {
		
		
		System.out.println("상품명 : " + product_id);
		
		StoreVO store = service.selectTest(product_id); 
		
		System.out.println("출력값 : " + store);
		
		model.addAttribute("store", store);
		
		return store;
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
