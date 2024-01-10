package com.itwillbs.c5d2308t1.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.ReserveMapper;
import com.itwillbs.c5d2308t1.vo.PageDTO;
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
	// 영화선택 페이지 ajax1
	public List<ReserveVO> getScheduleList(ReserveVO reserveVO) {
		return mapper.selectSchedule(reserveVO);
	}
	// 영화선택 페이지 ajax2
	public List<ReserveVO> getMTDList(Map<String, String> map) {
		return mapper.selectMTB(map);
	}
	public String getEndTime(ReserveVO reserveVO) {
		return mapper.selectPlayEndTime(reserveVO);
	}
	// 좌석 예매 취소 처리 업데이트
	public int getSeatCancle(String seat_id) {
		return mapper.updateSeatCancle(seat_id);
	}
	public Map<String, String> getresInfoDetail(String payment_id) {
		return mapper.selectresInfoDetail(payment_id);
	}
	
	// payment table insert
	public int getPaymentInsert(Map<String, String> map) {
		return mapper.insertPayment(map);
	}

	// seats table insert
	public int getSeatInsert(Map<String, String> map) {
		return mapper.insertSeats(map);
	}
	
	// reserve table insert
	public int getReserveInsert(Map<String, String> map) {
		return mapper.insertReserve(map);
	}
	
	// 예매완료 step2페이지에서 결제 정보 출
	public ReserveVO getPayment(Map<String, String> map) {
		return mapper.selectPayment(map);
	}
	
	//결제페이지 회원정보 조회
	public Map<String, String> getmemberInfo(String sId) {
		return mapper.selectMemberInfo(sId);
	}
	
	//마이페이지 홈 정보 최신 2개 조회
	public List<Map<String, String>> getMypage(String sId) {
		return mapper.selectMypageInfo(sId);
	}
	
	//마이페이지 예매내역을 위한 페이징 처리
	public int getMyReserveListCount(String searchKeyword, String sId) {
		// TODO Auto-generated method stub
		return mapper.selectMyReserveListCount(searchKeyword,sId);
	}
	// 마이페이지에서 예매내역 조회
	public List<HashMap<String, String>> getMyReserveList(String sId, PageDTO page, String searchKeyword) {
		return mapper.selectMyReserveList(sId,page,searchKeyword);
	}
	// 마이페이지에서 예매 취소 업데이트
	public int getresCancle(String payment_id) {
		return mapper.updateResCancle(payment_id);
	}

}
