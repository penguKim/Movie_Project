package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Mapper
public interface MoviesMapper {

	List<MoviesVO> selectMoviesList();

	int insertMovie(MoviesVO movie);
	
}
