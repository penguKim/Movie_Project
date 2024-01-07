package com.itwillbs.c5d2308t1.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.ReserveVO;

@Mapper
public interface ReserveMapper {

	List<ReserveVO> selectMovietitle();
	List<ReserveVO> selectTheaterName();
	List<ReserveVO> selectPlayDate();
	List<ReserveVO> selectSeatName(ReserveVO reserve);
	List<ReserveVO> selectSchedule(ReserveVO reserveVO);
	String selectPlayEndTime(ReserveVO reserveVO);
	List<HashMap<String, String>> selectReserveList(String sId);
	int updateResCancle(String payment_id);
	int updateSeatCancle(String seat_id);
	int insertSeats(Map<String, String> map);
	int insertPayment(Map<String, String> map);
	int insertReserve(Map<String, String> map);
	Map<String, String> selectresInfoDetail(String payment_id);
	List<ReserveVO> selectMTB(Map<String, String> map);
	ReserveVO selectPayment(Map<String, String> map);
	Map<String, String> selectMemberInfo(String sId);
}
