package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Mapper
public interface StoreMapper {
	
	// 관리자 페이지
	// ===================================================
	// 모든 상품 조회
	List<StoreVO> allSelectStore();

	// 관리자 페이지 상품 등록 - INSERT 
	int productInsert(StoreVO store);
	
	// 관리자페이지 상품 등록 시 상품 id 중복 판별을 위한 셀렉트
	StoreVO adminProductSelect(StoreVO store);
	
	// 상세 페이지를 위한 SELECT 조회
	List<StoreVO> selectStorePro(String product_id);
	
	// 관리자 페이지 상품 삭제를 위한 DELETE
	int adminProductDel(StoreVO store);
	
	// 페이징 처리를 위한 게시글 카운트 조회
	int selectProductListCount(String searchKeyword);
	
	// 관리자 페이지 상품 리스트 조회
	List<StoreVO> selectStoreList(@Param("searchKeyword") String searchKeyword,@Param("searchType") String searchType, @Param("page") PageDTO page);
	
	// 스토어 페이지
	// ===================================================================
	// 장바구니 판별 이벤트
	// ------------------------
	int insertCart(@Param("sId") String sId
			, @Param("product_id") String product_id);
	int updateCart(@Param("sId") String sId
			, @Param("product_id") String product_id);
	// 장바구니 판별 후 DB 작업 처리 한 cartList
	List<CartVO> resultCartList(String sId);
	
	// 스토어 결재를 위한 SELECT 결과 조회
	List<StoreVO> selectStore(StoreVO store);

	// 현재 나의 장바구니 조회
	List<StoreVO> selectMyStoreList(String sId);
	
	
	List<CartVO> selectCart2(MemberVO member);

	CartVO selectCart1(String product_count);

	MemberVO selectMemberInfo(MemberVO member);

	// 장바구니에서 수량 변경 시 UPDATE 처리 
	int updateQuan(@Param("sId") String sId
			, @Param("product_count") int product_count
			, @Param("product_id") String product_id);

	int sumPrice(@Param("sId") String sId
			, @Param("product_id") String product_id);
	
	// 업데이트 후 상품 수량및 가격 리턴을 위한 조회
	List<CartVO> updateAfter(@Param("sId") String sId, @Param("product_id") String product_id);
	
	// 장바구니 X 버튼 클릭 시 해당 상품 내역 삭제
	int cartDelete( @Param("sId")String sId, @Param("product_id") String product_id);

	// 장바구니에서 결제하기로 테스트
	List<StoreVO> selectCart3(@Param("arrPro") String arrPro, @Param("sId") String sId);

	List<StoreVO> selectCart4(@Param("productId")String productId,@Param("sId") String sId);

	

	

	

	

	
	
	

	
	



	
	
}
