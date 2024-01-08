package com.itwillbs.c5d2308t1.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.RefundVO;

@Mapper
public interface PaymentMapper {
	
	// 결제 성공시 결제 정보 등록 INSERT
	int insertPaymentPro(Map<String, Object> map);
	
	// 결제 정보 등록 성공 시 주문 정보 등록 INSERT
	int insertOrderPro(Map<String, Object> map);
	
	// 카트에서 결제 성공시 카트 내역 삭제
	void paymentAfterCartDel(Map<String, Object> map);
	
	// 결제 성공 시 조회할 목록
	RefundVO selectPaymentSuccess(Map<String, String> map);
		
}
