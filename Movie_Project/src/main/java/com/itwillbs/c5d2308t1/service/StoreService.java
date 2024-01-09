package com.itwillbs.c5d2308t1.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.StoreMapper;
import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Service
public class StoreService {
	
	@Autowired
	StoreMapper mapper;
	
	// 관리자 페이지 상품 관리
	// ===================================================
	// 관리자 페이지 상품 조회를 위한 SELECT
	public StoreVO getStore(String product_id) {
		return mapper.getStoreSelect(product_id);
	}
	
	// 관리자 페이지 상품 등록 - INSERT 
	public int productInsert(StoreVO store) {
		return mapper.productInsert(store);
	}
	
	// 관리자페이지 상품 등록 시 상품 id 중복 판별을 위한 셀렉트
	public StoreVO adminProductSelect(StoreVO store) {
		return mapper.adminProductSelect(store);
	}
	
	// 모든 상품 조회
	public List<StoreVO> allSelectStore() {
		return mapper.allSelectStore();
	}
	
	// 상세 페이지 조회를 위한 SELECT
	public List<StoreVO> selectStore(String product_id) {
		return mapper.selectStorePro(product_id);
	}
	
	// 관리자 페이지 상품 삭제를 위한 DELETE
	public int adminProductDel(StoreVO store) {
		return mapper.adminProductDel(store);
	}
	
	// 관리자 페이지 상품 수정 - 파일 삭제 요청
	public int removeProductImg(StoreVO store) {
		return mapper.updateStoreImg(store);
	}
	
	// 관리자 페이지 상품 수정 요청
	public int productReply(StoreVO store) {
		return mapper.updateProduct(store);
	}

	// 페이징 처리를 위한 게시글 카운트 조회
	public int getProductListCount(String searchKeyword) {
		return mapper.selectProductListCount(searchKeyword);
	}
	
	// 관리자 페이지 상품 리스트 조회
	public List<StoreVO> getStoreList(String searchType, PageDTO page) {
		return mapper.selectStoreList(searchType, page);
	}
	
	// ========================= 스토어 페이지 =================================================
	//-----------------------------
	// 메인스토어에서 장바구니 선택시 사항
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
	public List<StoreVO> myStoreList(String sId) {
		
		return mapper.selectMyStoreList(sId);
	}
	
	// 판별된 장바구니에 담긴 값 조회
	// store_cart 페이지 출력할 List 조회
	public List<CartVO> resultCartList(String sId) {
		return mapper.resultCartList(sId);
	}

	public MemberVO selectMemberInfo(MemberVO member) {
		return mapper.selectMemberInfo(member);
	}

	// 장바구니에서 수량 변경 시 UPDATE 처리 
	public int updateQuan(String sId, int product_count, String product_id) {
		return mapper.updateQuan(sId, product_count, product_id);
	}
	
	// 장바구니 수량 변경 시 totalPrice 업데이트
	public int totalPrice(String sId, String product_id) {
		return mapper.sumPrice(sId,  product_id);
	}
	
	// 업데이트 후 셀렉트 조회 // 나중에 selectKey 처리
	public List<CartVO> updateAfter(String sId, String product_id) {
		return mapper.updateAfter(sId, product_id);
	}
	
	// 장바구니 X버튼 클릭 시 해당하는 상품 내역 삭제
	public int cartDelete(String sId, String product_id) {
		return mapper.cartDelete(sId, product_id);
	}

	public List<StoreVO> selectCartIf(String product_id, String sId) {
		return mapper.selectCart4(product_id, sId);
	}



	
	

	

	

	
	
	
	

	

	

	
	
}
