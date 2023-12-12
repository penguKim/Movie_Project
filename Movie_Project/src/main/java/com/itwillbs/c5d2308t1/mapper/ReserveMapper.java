package com.itwillbs.c5d2308t1.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.ReserveVO;

@Mapper
public interface ReserveMapper {

	List<ReserveVO> selectMovietitle();
	List<ReserveVO> selectTheaterName();
	List<ReserveVO> selectPlayDate_PlayTime();
	List<ReserveVO> selectSeatName(ReserveVO reserve);
}
