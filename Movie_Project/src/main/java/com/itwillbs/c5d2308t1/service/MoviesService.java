package com.itwillbs.c5d2308t1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.MoviesMapper;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Service
public class MoviesService {
	@Autowired
	MoviesMapper mapper;
	
	public List<MoviesVO> getMovieList() {
		System.out.println("MoviesService - getMovieList");
		
		return mapper.selectMoviesList();
	}

}
