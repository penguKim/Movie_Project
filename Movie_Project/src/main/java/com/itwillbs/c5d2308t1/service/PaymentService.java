package com.itwillbs.c5d2308t1.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.c5d2308t1.mapper.PaymentMapper;

@Service
public class PaymentService {
	
	@Autowired
	private PaymentMapper mapper;
	
	@Transactional
	public void registPayment(Map<String, Object> map) {
		System.out.println("이다음부터 왜안돼!");
		
//		String[] productIdArr = (String[]) map.get("product_id");
//		String[] productQuanArr = (String[]) map.get("quantity");
//		// 결제 테이블 insert 성공 시 주문테이블 insert 요청
//		for(int i = 0; i < productIdArr.length; i++) {
//			map.put("product_id", productIdArr[i]);
//			map.put("quantity", productQuanArr[i]);
//			mapper.insertOrderPro(map);
//		}
		
		// 결제 성공 시 결제 테이블 인설트 요청
		mapper.insertPaymentPro(map);
		
		List<String> productIdArr = (List<String>) map.get("product_id");
		List<String> productQuanArr = (List<String>) map.get("quantity");

		// 결제 성공 시 결제 테이블 인설트 요청
		// 결제 테이블 insert 성공 시 주문테이블 insert 요청
		for (int i = 0; i < productIdArr.size(); i++) {
		    map.put("product_id", productIdArr.get(i));
		    map.put("quantity", productQuanArr.get(i));
		    System.out.println(productIdArr.get(i));
		    System.out.println(productQuanArr.get(i));
		    
		    mapper.insertOrderPro(map);
		}
		
		
		// 주문 테이블 insert 후 해당하는 값 삭제
	    // 장바구니에서 온 요청 판별 
	    if(map.get("type").equals("cart")) {
	    	// 장바구니 내역 삭제
	    	for (String product_id : productIdArr) {
	    		map.put("product_id", product_id);
	            mapper.paymentAfterCartDel(map);
		    }
		 }
	}

}
