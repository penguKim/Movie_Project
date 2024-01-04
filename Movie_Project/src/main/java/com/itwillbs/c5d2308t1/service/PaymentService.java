package com.itwillbs.c5d2308t1.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.c5d2308t1.mapper.PaymentMapper;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentMapper mapper;
	
	public int registPayment(Map<String, String> map) {
		return mapper.insertPaymentPro(map);
		
		
//		return mapper.insertOrderPro(map); 
				
	}

}
