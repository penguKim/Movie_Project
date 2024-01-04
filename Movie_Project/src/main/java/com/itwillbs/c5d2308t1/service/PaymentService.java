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
		mapper.insertPaymentPro(map);
		
		// product_name 을 가지고 product_id와 product_id의 순번을 가진 quantity를 가져온다?
		for(String product_name : map.get("product_name").split(",")) {
			System.out.println(product_name);
			map.put("product_name", product_name);
			mapper.insertOrderPro(map);
		}
		
		return 0;
				
	}

}
