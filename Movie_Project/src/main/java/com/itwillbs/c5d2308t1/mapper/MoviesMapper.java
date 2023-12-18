package com.itwillbs.c5d2308t1.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.ui.Model;

import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Mapper
public interface MoviesMapper {
	
	
	
//	List<MoviesVO> selectMoviesList();
	List<HashMap<String, String>> selectMoviesList();

	int insertMovie(MoviesVO movie);
	
	// movieTest 서블릿으로 영화 DB 등록
	int insertMovies(Map<String, Object> map);

	// detail 서블릿으로 영화 상세정보 요청 작업 수행
	HashMap<String, String> selectMovieDetail(String movie_id);
	
}
