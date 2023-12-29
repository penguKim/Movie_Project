package com.itwillbs.c5d2308t1.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.PlayVO;
import com.itwillbs.c5d2308t1.vo.TheaterVO;

@Mapper
public interface AdminMapper {

	// ================ 영화 관리 게시판 ================
	// 영화 DB 등록
	int insertMovies(Map<String, Object> map);
	
	// 영화 DB 수정
	int updateMovies(MoviesVO movie);
	
	// 영화 DB 삭제
	int deleteMovies(MoviesVO movie);
	
	// 하나의 영화 정보 조회
	MoviesVO selectMovie(MoviesVO movie);
	
	// 페이징 처리를 위한 게시물 개수 조회 작업
	int selectMovieListCount(String searchKeyword);
	
	// 한 페이지에 표시할 영화 목록 조회 작업
	List<MoviesVO> selectMovieList(@Param("searchKeyword") String searchKeyword, @Param("page") PageDTO page);
	
	// ================ 분실물 게시판 ================
	// 분실물 문의 관리 게시판 조회 작업
	List<HashMap<String, Object>> selectLostnfoundList(@Param("page") PageDTO page, @Param("searchValue") String searchValue);

	// 분실문 문의 관리 게시판 상세 조회 작업
	HashMap<String, Object> selectLostnfound(CsVO cs);

	// 분실물 문의 답변 등록 작업
	int updateLnfReply(CsVO cs);

	// 분실물 문의 답변 삭제 작업
	int updateLnfDlt(CsVO cs);

	// 분실물 페이징 처리를 위한 게시물 개수 조회 작업
	int selectLostnfoundListCount(String searchValue);
	
	// ================ 회원 관리 게시판 ================
	
	// 회원 관리 게시판 페이징 처리를 위한 게시물 개수 조회 작업
	int selectMemberListCount(@Param("searchType") String searchType, @Param("searchKeyword") String searchKeyword);

	// 회원 관리 게시판 한 페이지에 표시할 회원 조회
	List<MemberVO> selectMemberList(@Param("searchType") String searchType, 
					@Param("searchKeyword") String searchKeyword, @Param("page") PageDTO page);

	// 회원 한명의 정보 조회
	MemberVO selectMember(MemberVO member);
	
	// 회원 정보 수정 작업
	int updatememberModOrDlt(@Param("member") MemberVO member, @Param("newPasswd") String newPasswd);

	
	
	// ============= 자주묻는질문관리, 공지사항관리 게시판 ===============
	// 관리자페이지 자주묻는질문 공지사항 조회 - 추상메서드 정의
	List<HashMap<String, Object>> selectFaqList(@Param("cs") CsVO cs, @Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchValue") String searchValue);
	List<HashMap<String, Object>> selectNoticeList(@Param("cs") CsVO cs, @Param("startRow") int startRow, @Param("listLimit") int listLimit, @Param("searchValue") String searchValue);
	
	// 관리자페이지 게시판별 목록 갯수 조회 - 추상메서드 정의
	int selectFaqCount(@Param("cs") CsVO cs, @Param("searchValue") String searchValue);
	int selectNoticeCount(@Param("cs") CsVO cs, @Param("searchValue") String searchValue);
	
	// 관리자페이지 자주묻는질문 상세페이지 보기
	HashMap<String, Object> selectFaqDetailPage(CsVO cs);
	
	// 관리자페이지 게시글 등록 - 추상메서드 정의
	int insertBoard(CsVO cs);
		
	// 관리자페이지 게시글 수정 - 추상메서드 정의
	int updateBoard(CsVO cs);
	
	// 고객센터 세부항목별 목록 갯수 조회 - 추상메서드 정의
	int selectFaqDetailCount(@Param("cs") CsVO cs, @Param("buttonName") String buttonName);

	// 관리자페이지 공지사항 상세페이지 보기
	HashMap<String, Object> selectNoticeDetailPage(CsVO cs);
	
	// 관리자페이지 게시글 삭제
	int deleteBoard(HashMap<String, Object> board);
	
	// =================== 1대1문의 게시판 ==========================
	// 1대1 문의 관리 게시판 조회 작업
	List<CsVO> selectOneOnOneList(PageDTO page);

	// 1대1문의 페이징 처리를 위한 게시물 개수 조회 작업
	int selectOneOnOneListCount();

//	// 1대1문의 관리 게시판 상세 조회 작업
	HashMap<String, Object> selectOneOnOne(CsVO cs);
	
	// 1대1문의 답변 등록, 수정 작업
	int updateOneOnOneReply(CsVO cs);

	// 1대1문의 답변 삭제 작업
	int deleteOneOnOneReply(CsVO cs);
	
	// =================== 상영스케쥴 관리 게시판 ==========================
	// 상영스케쥴 관리 메인페이지로 이동 시 정보 조회 작업
	List<Map<String, Object>> selectMainScheduleInfo();

	// 상영스케쥴 관리 메인페이지 상영일정 조회 작업
	List<Map<String, Object>> selectScheduleInfo(Map<String, String> map);

	// 지점명에 따른 상영관 조회
	List<HashMap<String, Object>> selectRoom(String theater_id);
	
	// 상영중인 영화 조회 작업
	List<HashMap<String, Object>> selectPlayingMovie();

	// 선택한 영화 정보 조회 작업
	HashMap<String, Object> selectMovieInfo(String movie_id);

	// 상영 일정 등록
	int insertPlay(PlayVO play);

	List<HashMap<String, Object>> selectPlayListAll();




	





	
	

}
