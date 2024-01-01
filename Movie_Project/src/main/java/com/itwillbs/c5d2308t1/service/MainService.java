package com.itwillbs.c5d2308t1.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.MainMapper;
import com.itwillbs.c5d2308t1.vo.EventsVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Service
public class MainService {
	
	@Autowired
	MainMapper mapper;
	
	// 메인 페이지에 출력할 영화목록 조회
	public List<MoviesVO> getMainMovieList(int status, String sortType) {
		return mapper.selectMainMovieList(status, sortType);
	}

	// 메인페이지에 출력할 이벤트목록 조회
	public List<EventsVO> getEventList() {
		return mapper.selectEventList();
	}
}
