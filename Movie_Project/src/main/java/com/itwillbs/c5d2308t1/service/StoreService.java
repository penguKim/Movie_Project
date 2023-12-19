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

	public int insertTest( MemberVO member) {
		
		return mapper.insertTest(member);
	}

	public List<CartVO> selectTest1(MemberVO member) {
		
		return mapper.selectTest1(member);
	}

//	public int updateTest(MemberVO member) {
//		
//		return mapper.updateTest(member);
//	}
	
}
