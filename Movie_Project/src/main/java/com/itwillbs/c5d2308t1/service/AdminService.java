package com.itwillbs.c5d2308t1.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.AdminMapper;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.TheaterVO;

@Service
public class AdminService {

	@Autowired
	AdminMapper mapper;
	
	
	// ================ 영화 관리 게시판 ================
	
	// 영화 DB 등록
	public int registMovie(Map<String, Object> map) {
		return mapper.insertMovies(map);
	}
	
	// 영화 DB 수정
	public int modifyMovie(MoviesVO movie) {
		return mapper.updateMovies(movie);
	}
	
	// 하나의 영화 정보 조회
	public MoviesVO getMovie(MoviesVO movie) {
		return mapper.selectMovie(movie);
	}
	
	// 페이징 처리를 위한 게시물 개수 조회 작업 요청
	public int getMovieListCount(String searchKeyword) {
		return mapper.selectMovieListCount(searchKeyword);
	}
	
	// 한 페이지에 표시할 영화 목록 조회 작업 요청
	public List<MoviesVO> getMovieList(String searchKeyword, PageDTO page) {
		return mapper.selectMovieList(searchKeyword, page);
	}
	
	// ================ 분실물 게시판 ================
	// 분실물 문의 관리 게시판 조회 작업 요청
	public List<HashMap<String, Object>> getLostnfoundList(PageDTO page) {
		return mapper.selectLostnfoundList(page);
	}

	// 분실문 문의 관리 게시판 상세 조회 작업 요청
	public HashMap<String, Object> getlostnfound(CsVO cs) {
		return mapper.selectLostnfound(cs);
	}
	
	// 분실물 문의 답변 등록 작업 요청
	public int LostnfoundReply(CsVO cs) {
		return mapper.updateLnfReply(cs);
	}
	
	// 분실물 문의 답변 삭제 작업 요청
	public int lostnfoundDlt(CsVO cs) {
		return mapper.updateLnfDlt(cs);
	}
	
	// 분실물 페이징 처리를 위한 게시물 개수 조회 작업 요청
	public int getlostnfoundListCount() {
		return mapper.selectLostnfoundListCount();
	}
	
	// ================ 회원 관리 게시판 ================
	// 회원 관리 게시판 페이징 처리를 위한 게시물 개수 조회 작업 요청
	public int getMemberListCount(String searchType, String searchKeyword) {
		return mapper.selectMemberListCount(searchType, searchKeyword);
	}

	// 회원 관리 게시판 한 페이지에 표시할 회원 조회
	public List<MemberVO> getMemberList(String searchType, String searchKeyword, PageDTO page) {
		return mapper.selectMemberList(searchType, searchKeyword, page);
	}
	// 회원 한명의 정보 조회
	public MemberVO getMember(MemberVO member) {
		return mapper.selectMember(member);
	}

	// 회원 정보 수정 및 탈퇴 작업
	public int memberModOrDlt(MemberVO member, String newPasswd) {
		return mapper.updatememberModOrDlt(member, newPasswd);
	}

	// ****************** 1대1문의 게시판 *********************
	// 1대1문의 관리 게시판 글 목록 조회 작업 요청
	public List<CsVO> getOneOnOnePosts(PageDTO page) {
		return mapper.selectOneOnOneList(page);
	}

	// 1대1문의 페이징 처리를 위한 게시물 개수 조회 작업 요청
	public int getOneOnOneListCount() {
		return mapper.selectOneOnOneListCount();
	}

//	// 1대1문의 관리 게시판 상세 조회 작업 요청
//	public CsVO getOneOnOnePostById(CsVO cs) {
//		return mapper.selectOneOnOne(cs);
//	}

	// 1대1문의 답변 등록 작업 요청
	public int writeOneOnOneReply(CsVO cs) {
		return mapper.updateOneOnOneReply(cs);
	}

	public HashMap<String, Object> getOneOnOnePostById(CsVO cs) {
		return mapper.selectOneOnOne(cs);
	}

	
	// ****************** 1대1문의 게시판 *********************
	// 상영스케쥴 관리 메인페이지 정보 조회 작업 요청
	public TheaterVO getMainScheduleInfo(TheaterVO theater) {
		return mapper.selectMainScheduleInfo(theater);
	}




}
