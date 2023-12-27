package com.itwillbs.c5d2308t1.service;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

	public List<RefundVO> getMyStoreSelect(RefundVO refund) {
		
		return mapper.getMyStoreSelect(refund);
	}


// ============================================================================	
// =====================마이페이지 나의게시글 1대1문의 내역==================	
	// 마이페이지 나의 게시글 1대1문의 글 목록 조회 작업 요청
//	public List<MemberVO> getOneOnOnePosts() {
//		return mapper.selectMyOneOnOneList();
//	}

//	public Map<String, Object> getOneOnOnePosts(MemberVO member) {
//		return mapper.selectMyOneOnOneList(member);
//	}

//	public List<HashMap<String, Object>> getOneOnOnePosts(MemberVO member) {
//		return mapper.selectMyOneOnOneList(member);
//	}

}
