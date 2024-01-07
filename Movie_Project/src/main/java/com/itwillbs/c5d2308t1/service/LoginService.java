package com.itwillbs.c5d2308t1.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.mapper.LoginMapper;
import com.itwillbs.c5d2308t1.vo.*;
@Service
public class LoginService {
	
	@Autowired
	private LoginMapper mapper;

	public MemberVO getMember(MemberVO member) {
//		System.out.println("LoginService - getMember()" + member);
		return mapper.selectMember(member);
	}
	
	public int editMember(MemberVO member, String newEmail, String newPasswd) {
		return mapper.updateMember(member, newEmail, newPasswd);
	}

	public int getMovieListCount(String searchKeyword) {
		return mapper.selectMovieListCount(searchKeyword);
	}

	// 한 페이지에 표시할 영화 목록 조회 작업 요청
	public List<MoviesVO> getMovieList(String searchKeyword, PageDTO page) {
		return mapper.selectMovieList(searchKeyword, page);
	}


//	public List<RefundVO> getReserveList2(RefundVO refund, String sId) {
//		
//		return mapper.getReserveList2(refund, sId);
//	}


	public List<RefundVO> getReserveList(RefundVO refund) {
		
		return mapper.getReserveList(refund);
	}

	




// ============================================================================	
// =====================마이페이지 나의게시글 1대1문의 내역==================	
	// 마이페이지 나의 게시글 1대1문의 글 목록 조회 작업 요청
	public List<HashMap<String, Object>> getMyOneOnOnePosts(String sId, PageDTO page) {
		return mapper.selectMyOneOnOneList(sId, page);
	}
	
//	public List<HashMap<String, Object>> getMyOneOnOnePosts(String sId) {
//		return mapper.selectMyOneOnOneList(sId);
//	}
	
	// 마이페이지 나의 게시글 1대1문의 페이징 처리를 위한 게시물 개수 조회 작업 요청 
	public int getMyOneOnOnePostsCount(String sId) {
		return mapper.selectMyOneOnOnePostsCount(sId);
	}

	// 마이페이지 나의 게시글 1대1문의 글 상세 조회 작업 요청
	public Map<String, Object> getMyOneOnOneDetail(CsVO cs) {
		return mapper.selectMyOneOnOneDetail(cs);
	}

	// 마이페이지 나의 게시글 1대1문의 글 삭제 작업 요청
	public int removeMyOneOnOne(CsVO cs) {
		return mapper.deleteMyOneOnOne(cs);
	}
	
	// =====================마이페이지 나의게시글 분실물 문의 내역==================
	// 마이페이지 고객센터 분실물 조회
	public List<CsVO> getLostBoardList(CsVO myCs) {
	return mapper.selectLostList(myCs);
	}

	public HashMap<String, Object> getlostnfound(CsVO cs) {
		return  mapper.selectMyLost(cs);
		}

	// =====================마이페이지 리뷰 내역==================
	// 마이페이지 리뷰 조회
	public List<ReviewsVO> getReviewList(ReviewsVO review) {
		return mapper.selectMyreview(review);
	}

	// 마이페이지 리뷰삭제
	public int reviewBoard(ReviewsVO review) {
		return mapper.deleteMyreview(review);
	}

	
	// 회원정보 수정 업데이트
	public int checkMember(String sId, String newPasswd) {
		return mapper.checkMember(sId,newPasswd);
	}


	public List<ReviewsVO> getReviewDetailList(ReviewsVO review) {
		
		return mapper.selectMyreviewDetail(review);
	}

	// 아이디, 비밀번호 찾기 수행
	public MemberVO findMember(MemberVO member) {
		MemberVO dbMember = null;
		if(member.getMember_id() == null) {
			dbMember = mapper.selectFindId(member);
		} else {
			dbMember = mapper.selectFindPasswd(member);
		}
		return dbMember;
	}
	
	// 비밀번호 찾기를 통한 비밀번호 수정
	public int modifyMemberPw(MemberVO member, String newPasswd) {
		return mapper.updateMemberPw(member, newPasswd);
	}
	
	public MemberVO selectMemberPs(MemberVO member) {
		
		return mapper.selectMemberPs(member);
	}
	// 회원상태 업데이터
	public int statusMember(MemberVO member) {
		
		return mapper.statusMember(member);
	}

	public int deleteReview(ReviewsVO review) {
		return mapper.deleteMyreview(review);
	}
	
	// ====================== 마이 페이지 상품 구매 내역==================================================
	// 마이페이지 상품 구매를 위한 페이지 수 조회
	public int getStoreListCount(String sId) {
		return mapper.getStoreListCount(sId);
	}
	
	// 마이페이지 상품 구매 내역 리스트 조회
	public List<RefundVO> getMyStoreList(String sId,PageDTO page) {
		return mapper.getMyStoreSelect(sId, page);
	}
	
	// 마이페이지 상품구매내역 업데이트
	public int getMyStoreBuyCancel(Map<String, String> map) {
		
		return mapper.updateMyBuy(map);
	}
	public RefundVO getMyStoreDetail(RefundVO refund) {
		return mapper.getMyStoreDetail(refund);
	}



	
	
}
