package com.itwillbs.c5d2308t1.mapper;

import java.util.*;

import org.apache.ibatis.annotations.*;

import com.itwillbs.c5d2308t1.vo.*;
@Mapper
public interface LoginMapper {
	
	//회원 상세정보 조회
	MemberVO selectMember(MemberVO member);

	int selectMovieListCount(String searchKeyword);

	// 한 페이지에 표시할 영화 목록 조회 작업
	List<MoviesVO> selectMovieList(@Param("searchKeyword") String searchKeyword, @Param("page") PageDTO page);
	
	// 예매 페이지에 있는 영화제목,예약시간,예약상태 조회 작업
	Map<String, String> getReserveList();


}
