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
	
	
	public StoreVO selectTest(String product_id) {
		
		return mapper.selectPro(product_id);
	}
	
	
	public CartVO updateTest(CartVO cart) {
		
		return mapper.updateTest(cart);
	}

	// 장바구니 셀렉트 결과 
	public List<StoreVO> selectCart(MemberVO member) {
		
		return mapper.selectCart(member);
	}
	
	// 장바구니 판별 후 인설트
	public int insertTest( MemberVO member) {
		
		return mapper.insertTest(member);
	}
	
	// 장바구니 판별 후 업데이트
	public int updateCart(MemberVO member) {
		return 0;
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
