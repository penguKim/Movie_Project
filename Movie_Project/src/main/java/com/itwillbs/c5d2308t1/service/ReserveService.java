package com.itwillbs.c5d2308t1.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<ReserveVO> getPlayDate() {
		return mapper.selectPlayDate();
	}
	public List<ReserveVO> getSeatList(ReserveVO reserveVO) {
		return mapper.selectSeatName(reserveVO);
	}
	public List<ReserveVO> getScheduleList(ReserveVO reserveVO) {
		return mapper.selectSchedule(reserveVO);
	}
	public String getEndTime(ReserveVO reserveVO) {
		return mapper.selectPlayEndTime(reserveVO);
	}
	// 마이페이지에서 예매내역 조회
	public List<HashMap<String, String>> getReserveList(String sId) {
		return mapper.selectReserveList(sId);
	}
	// 마이페이지에서 예매 취소 업데이트
	public int getresCancle(String payment_id) {
		return mapper.updateResCancle(payment_id);
	}
	// 좌석 예매 취소 처리 업데이트
	public int getSeatCancle(String seat_id) {
		return mapper.updateSeatCancle(seat_id);
	}
	public Map<String, String> getresInfoDetail(String payment_id) {
		return mapper.selectresInfoDetail(payment_id);
	}
	
//	 payment table insert
	public int getPaymentInsert(Map<String, String> map) {
		return mapper.insertPayment(map);
	}
//	
//	// seats table insert
	public int getSeatInsert(Map<String, String> map) {
		return mapper.insertSeats(map);
	}
//	
//	// reserve table insert
	public int getReserveInsert(Map<String, String> map) {
		return mapper.insertReserve(map);
	}

}
