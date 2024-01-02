package com.itwillbs.c5d2308t1.mapper;

import java.util.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;


import com.itwillbs.c5d2308t1.vo.*;
@Mapper
public interface LoginMapper {
	
	//회원 상세정보 조회
	MemberVO selectMember(MemberVO member);
	
	//회원 정보 수정
	int updateMember(@Param("member")MemberVO member, @Param("newEmail")String newEmail, @Param("newPasswd")String newPasswd);

	int selectMovieListCount(String searchKeyword);

	// 한 페이지에 표시할 영화 목록 조회 작업
	List<MoviesVO> selectMovieList(@Param("searchKeyword") String searchKeyword, @Param("page") PageDTO page);
	
	// 예매 페이지에 있는 영화제목,예약시간,예약상태 조회 작업
	Map<String, String> getReserveList();
	
	// 예매 페이지에 있는 영화제목,예약시간,예약상태 조회 작업
//	List<RefundVO> getReserveList2(@Param("refund")RefundVO refund, @Param("sId")String sId);
	
	// 마이페이지 예매취소내역 조회
	List<RefundVO> getReserveList(RefundVO refund);

	// 마이페이지 상품구매 내역 조회
	List<RefundVO> getMyStoreSelect(RefundVO refund);




	
// ============================================================================	
// =====================마이페이지 나의게시글 1대1문의 내역==================
	// 마이페이지 나의 게시글 1대1문의 글 목록 조회 작업
	List<HashMap<String, Object>> selectMyOneOnOneList(@Param("sId") String sId, @Param("page") PageDTO page);
//	List<HashMap<String, Object>> selectMyOneOnOneList(String sId);
	
	// 마이페이지 나의 게시글 1대1문의 페이징 처리를 위한 게시물 개수 조회 작업 
	int selectMyOneOnOnePostsCount(String sId);

	// 마이페이지 나의 게시글 1대1문의 글 상세 조회 작업
	Map<String, Object> selectMyOneOnOneDetail(CsVO cs);

	// 마이페이지 나의 게시글 1대1문의 글 삭제 작업
	int deleteMyOneOnOne(CsVO cs);
	
// =====================마이페이지 나의게시글 분실물 문의 내역==================
	// 마이페이지 분실물 조회
	List<CsVO> selectLostList(CsVO myCs);
	
	// 마이페이지 분실물 상세 조회
	HashMap<String, Object> selectMyLost(CsVO cs);

// =====================마이페이지 리뷰 내역==================
	//마이페이지 리뷰 조회
	List<ReviewsVO> selectMyreview(ReviewsVO review);

	//마이페이지 리뷰 삭제
	int deleteMyreview(ReviewsVO review);
	
	// 마이페이지 상품구매내역 업데이트
	int updateMyStore(RefundVO refund);


}
