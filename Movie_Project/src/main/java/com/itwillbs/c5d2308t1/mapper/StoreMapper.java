package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Mapper
public interface StoreMapper {
	
	// 상세 페이지를 위한 SELECT 조회
	StoreVO selectStorePro(String product_id);

	// 장바구니 판별 이벤트
	// ------------------------
	int insertCart(@Param("sId") String sId
			, @Param("product_id") String product_id);
	int updateCart(@Param("sId") String sId
			, @Param("product_id") String product_id);
	
	// 장바구니 조회를 위한 SELECT 결과  
	List<StoreVO> selectStoreList(String sId);
	
	// 스토어 결재를 위한 SELECT 결과 조회
	List<StoreVO> selectStore(StoreVO store);

	// 현재 나의 장바구니 조회
	List<StoreVO> selectMyCartList(String sId);
	
	// 장바구니 판별 후 DB 작업 처리 한 cartList
	List<CartVO> resultCartList(String sId);
	
	
	List<CartVO> selectCart2(MemberVO member);

	CartVO selectCart1(String product_count);

	MemberVO selectMemberInfo(MemberVO member);

	// 장바구니에서 수량 변경 시 UPDATE 처리 
	int updateQuan(@Param("sId") String sId
			, @Param("product_count") int product_count
			, @Param("product_id") String product_id);

	int sumPrice(@Param("sId") String sId
			, @Param("product_count") int product_count
			, @Param("product_id") String product_id);
	
	// 업데이트 후 상품 수량및 가격 리턴을 위한 조회
	List<CartVO> updateAfter(@Param("sId") String sId, @Param("product_id") String product_id);



	
	
}
