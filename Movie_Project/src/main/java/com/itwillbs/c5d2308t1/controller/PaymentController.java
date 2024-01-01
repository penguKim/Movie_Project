package com.itwillbs.c5d2308t1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class PaymentController {
	
	@GetMapping("ProductPayment")
	public String productPayment() {
		
		return "store/paymentAPI";
	}	
	
	// 결제 데이터 입력을 위한 ajax
	@PostMapping("PaymentEndpoint")
	public String paymentEndpoint() {
		
		
		return "";
	}
		
		
	
	
}
