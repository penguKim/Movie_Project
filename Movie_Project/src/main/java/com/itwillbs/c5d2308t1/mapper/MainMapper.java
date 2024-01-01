package com.itwillbs.c5d2308t1.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.c5d2308t1.vo.EventsVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Mapper
public interface MainMapper {

	// 메인 페이지에 출력할 영화목록 조회
	List<MoviesVO> selectMainMovieList(@Param("status") int status, @Param("sortType") String sortType);

	// 메인페이지에 출력할 이벤트목록 조회
	List<EventsVO> selectEventList();
}
