package com.itwillbs.c5d2308t1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.ReserveMapper;
import com.itwillbs.c5d2308t1.vo.ReserveVO;

@Service
public class ReserveService {
	@Autowired
	ReserveMapper mapper;
	
	public List<ReserveVO> getMovieList() {
		return mapper.selectMovietitle();
	}
	public List<ReserveVO> getTheaterList() {
		return mapper.selectTheaterName();
	}
	public List<ReserveVO> getPlayList() {
		return mapper.selectPlayDate_PlayTime();
	}

}
