package com.itwillbs.c5d2308t1.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.PaymentService;

@Controller
public class PaymentController {
	
	@Autowired
	private PaymentService service;
	
	// 장바구니 결제 
	// 단일결제 따로 만들어야하는 상황
	// 결제 데이터 입력을 위한 ajax
	@ResponseBody
	@PostMapping("PaymentEndpoint")
	public Map<String, String> paymentEndpoint(@RequestBody Map<String, String> map) {
		System.out.println("맵 넘어온 고유번호" + map);
		
		int insertCount = service.registPayment(map);
		
		return map;
	}
		
	@GetMapping("PaymentSuccess")
	public String paymentSuccess() {
		
		return "store/payment_success";
	}
	
	
}
