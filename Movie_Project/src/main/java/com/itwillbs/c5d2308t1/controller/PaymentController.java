package com.itwillbs.c5d2308t1.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String paymentEndpoint(@RequestBody Map<String, Object> map) {
		System.out.println("맵 넘어온 데이터" + map);
		
		service.registPayment(map);
		System.out.println(map.get("payment_name"));
		
		JSONObject jsonObject = new JSONObject(map);
		
		return jsonObject.toString();
	}
	
	// 결제 성공 시
	@GetMapping("PaymentSuccess")
	public String paymentSuccess(Model model, HttpSession session) {
		
		// 결제 성공 후 success 화면에 보여줄 결제 내역 조회
		
		
		return "store/payment_success";
	}
	
	// 결제 실패 시 
	@GetMapping("PaymentFail")
	public String paymentFail() {
		
		return "store/payment_fail";
	}
	
}
