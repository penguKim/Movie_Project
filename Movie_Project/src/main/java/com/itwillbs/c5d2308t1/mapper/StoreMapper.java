package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Mapper
public interface StoreMapper {

	StoreVO selectPro(String product_id);

	CartVO updateTest(CartVO cart);

	int insertTest(MemberVO member);

	List<CartVO> selectTest1(MemberVO member);

//	int updateTest(MemberVO member);
	
}
