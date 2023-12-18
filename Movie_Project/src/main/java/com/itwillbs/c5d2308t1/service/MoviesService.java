package com.itwillbs.c5d2308t1.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.itwillbs.c5d2308t1.mapper.MoviesMapper;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Service
public class MoviesService {
	@Autowired
	MoviesMapper mapper;
	
//	public List<MoviesVO> getMovieList() {
	public List<HashMap<String, String>> getMovieList() {
		System.out.println("MoviesService - getMovieList");
		
		return mapper.selectMoviesList();
	}

	// detail 서블릿으로 영화 정보 요청
	public HashMap<String, String> getMovieDetail(String movie_id) {
		return mapper.selectMovieDetail(movie_id);
	}
	
	public int insertMovie(MoviesVO movie) {
		System.out.println("insertMovie");
		return mapper.insertMovie(movie);
	}

	// movieTest 서블릿으로 영화 DB 등록
	public int registMovie(Map<String, Object> map) {
		return mapper.insertMovies(map);
	}
	

}
