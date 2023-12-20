package com.itwillbs.c5d2308t1.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.StoreMapper;
import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Service
public class StoreService {
	
	@Autowired
	StoreMapper mapper;
	
	
	public StoreVO selectStore(String product_id) {
		
		return mapper.selectStorePro(product_id);
	}
	
	//-----------------------------
	// 장바구니 판별후 UPDATE
	public int updateCart(String sId, String product_id) {
		
		return mapper.updateCart(sId, product_id);
	}
	// 장바구니 판별 후 INSERT
	public int insertCart(String sId, String product_id ) {
		
		return mapper.insertCart(sId, product_id);
	}
	// --------------------------------

	// 현재 나의 장바구니 조회 - SELECT
	// 장바구니에 출력할 데이터 조회
	public List<StoreVO> myCartList(String sId) {
		
		return mapper.selectMyCartList(sId);
	}
	
	// 판별된 장바구니에 담긴 값 조회
	// store_cart 페이지 출력할 List 조회
	public List<CartVO> resultCartList(String sId) {
		return mapper.resultCartList(sId);
	}
	
	public List<StoreVO> selectStore(StoreVO store) {
		return mapper.selectStore(store);
	}


	public List<CartVO> selectCart2(MemberVO member) {
		
		return mapper.selectCart2(member);
	}


	public CartVO selectCart1(String product_count) {
		
		return mapper.selectCart1(product_count);
	}


	
}
