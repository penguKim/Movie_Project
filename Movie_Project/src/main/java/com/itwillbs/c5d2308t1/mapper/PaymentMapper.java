package com.itwillbs.c5d2308t1.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PaymentMapper {
	
	// 결제 성공시 결제 정보 등록 INSERT
	int insertPaymentPro(Map<String, String> map);
	
	// 결제 정보 등록 성공 시 주문 정보 등록 INSERT
	int insertOrderPro(Map<String, String> map);
	
}
