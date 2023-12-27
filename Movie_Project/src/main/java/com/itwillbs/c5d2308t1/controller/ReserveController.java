package com.itwillbs.c5d2308t1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.itwillbs.c5d2308t1.service.ReserveService;
import com.itwillbs.c5d2308t1.vo.ReserveVO;

@Controller
public class ReserveController {
	
	@Autowired
	ReserveService reserve;
	
	@GetMapping("movie_select")
	public String movie_select(Model model) {
		System.out.println("movie_select");
		
		List<ReserveVO> movieList = reserve.getMovieList();
		List<ReserveVO> theaterList = reserve.getTheaterList();
		List<ReserveVO> playList = reserve.getPlayDate();
		model.addAttribute("movieList",movieList);
		model.addAttribute("theaterList",theaterList);
		model.addAttribute("playList",playList);
		return "reserve/movie_select";
	}
	
	@ResponseBody
	@GetMapping("reserveAjax")
	public List<ReserveVO> ScheduleCheck(ReserveVO reserveVO, Model model) {
		List<ReserveVO> ScheduleList = reserve.getScheduleList(reserveVO);
		System.out.println("ajax연결성공!");
		return ScheduleList;
	}
	
	@PostMapping("seat_select")
	public String seat_select(ReserveVO reserveVO, Model model, HttpSession session, String play_end_time) {
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		System.out.println("seat_select");
		System.out.println("입력받은 정보 : " + reserveVO);
		List<ReserveVO> SeatList = reserve.getSeatList(reserveVO);
		play_end_time = reserve.getEndTime(reserveVO);
	    System.out.println("조회한 상영 종료 시간 : " + play_end_time );
		reserveVO.setPlay_end_time(play_end_time);
		
		model.addAttribute("SeatList",SeatList);
		model.addAttribute("reserveVO",reserveVO);
		return "reserve/seat_select";
	}
	
	
	// 결제하기
	@PostMapping("ReservationComplete")
	public String ReservationComplete(@RequestParam Map<String, String> map, Model model){
		model.addAttribute("map", map);
		return "reserve/reserve_pay";
		
	}
	
	// 예매완료( 실제 데이터 insert 위치)
	@GetMapping("competePayment")
	public String competePayment(@RequestParam Map<String, String> map, Model model, HttpSession session) {
//		<input type="button" value="이전화면" class="back">
//		<input type="hidden" name="movie" value="${map.movie}">
//		<input type="hidden" name="Theater" value="${map.Theater}">
//		<input type="hidden" name="Room" value="${map.Room}">
//		<input type="hidden" name="Date" value="${map.Date}">
//		<input type="hidden" name="StartTime" value="${map.StartTime}">
//		<input type="hidden" name="typeCount" value="${map.typeCount}">
//		<input type="hidden" name="seat_name" value="${map.select_seat}">
//		<input type="hidden" class="totalPriceResult" name="payment_total_price" value="">
		String sId = (String)session.getAttribute("sId");
		map.put("sId", sId);
//		int insertPayCount = reserve.getPaymentInsert(map);
//		int insertSeatCount = reserve.getSeatInsert(map);
//		int insertResCount = reserve.getReserveInsert(map);
		
		
		return "reserve/complete_pay";
	}
	
	@GetMapping("DiscountInfo")
	public String DiscountInfo() {
		return "reserve/DiscountInfo";
	}
	
	//마이페이지 예매내역 처리
	@GetMapping("Mypage_Reserv_boardList")
	public String mypage_Reserv_boardList(Map<String, Object> map, Model model, HttpSession session) { // 예매내역 게시판
		String sId = (String)session.getAttribute("sId");
		List<HashMap<String, String>> resList = reserve.getReserveList(sId);
		model.addAttribute("resList", resList);
		return "login/Mypage_Reserv_boardList";
	}
	
	//마이페이지 예매내역게시판 상세내역 팝업창
	@GetMapping("resInfoDetailPro")
	public String resInfoDetailPro(@RequestParam String payment_id, Map<String, String> map, Model model) {
		map = reserve.getresInfoDetail(payment_id);
		model.addAttribute("map",map);
		return"login/popup1";
	}
	
	@PostMapping("resCancle")
	public String resCancle(@RequestParam String payment_id,@RequestParam String seat_id, Model model) {
		int paymentUpdateCount = reserve.getresCancle(payment_id); //결제취소
		int seatUpdateCount = reserve.getSeatCancle(seat_id); //좌석예매취소
		if(paymentUpdateCount>0 && seatUpdateCount>0)  {
			return "redirect:/Mypage_Reserv_boardList";
		}else {
			model.addAttribute("msg", "예매취소 실패!");
			return "fail_back";
		}
	}
	
	
	
}






















