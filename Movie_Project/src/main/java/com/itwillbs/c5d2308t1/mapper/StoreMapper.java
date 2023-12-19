package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Mapper
public interface StoreMapper {
	
	// 상세 페이지를 위한 SELECT 조회
	StoreVO selectPro(String product_id);

	CartVO updateTest(CartVO cart);

	int insertTest(MemberVO member);
	
	// 장바구니 조회를 위한 SELECT 결과  
	List<StoreVO> selectCart(MemberVO member);
	
	// 스토어 결재를 위한 SELECT 결과 조회
	List<StoreVO> selectStore(StoreVO store);

	
}
