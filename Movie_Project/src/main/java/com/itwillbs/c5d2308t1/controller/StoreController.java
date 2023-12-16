package com.itwillbs.c5d2308t1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class StoreController {
	
	@GetMapping("store")
	public String store() {
		return "store/store_main";
	}
	
	@GetMapping("event")
	public String event() {
		return "event/event_movie";
	}
	
	@GetMapping("storeDetail")
	public String storeDetail() {
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
