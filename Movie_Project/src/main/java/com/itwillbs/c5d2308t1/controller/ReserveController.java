package com.itwillbs.c5d2308t1.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.c5d2308t1.service.ReserveService;
import com.itwillbs.c5d2308t1.vo.PageInfo;
import com.itwillbs.c5d2308t1.vo.ReserveVO;

@Controller
public class ReserveController {
	
	@Autowired
	ReserveService reserve;
	
	
	// 영화선택 페이지
	@GetMapping("movieSelect")
	public String movie_select(Model model, @RequestParam(defaultValue = "") String movie_title) {
		System.out.println("movie_select");
		System.out.println("movie_title : " + movie_title);
		
		List<ReserveVO> movieList = reserve.getMovieList();
		List<ReserveVO> theaterList = reserve.getTheaterList();
		List<ReserveVO> playList = reserve.getPlayDate();
		model.addAttribute("movieList",movieList);
		model.addAttribute("theaterList",theaterList);
		model.addAttribute("playList",playList);
		model.addAttribute("param_movie_title",movie_title);
	
		return "reserve/movie_select";
	}
	
	// 할인정보
	@GetMapping("DiscountInfo")
	public String discountInfo() {
		return "reserve/DiscountInfo";
	}
	
	// 영화 선택페이지의 Ajax1
	@ResponseBody
	@GetMapping("reserveAjax")
	public List<ReserveVO> scheduleCheck(ReserveVO reserveVO, Model model) {
		List<ReserveVO> scheduleList = reserve.getScheduleList(reserveVO);
		System.out.println("ajax연결성공!");
		return scheduleList;
	}
	// 영화 선택페이지의 Ajax2
	@ResponseBody
	@GetMapping("MTDAjax")
	public List<ReserveVO> mtdAjax(@RequestParam Map<String, String> map, Model model){
		List<ReserveVO> MTD = reserve.getMTDList(map);
		return MTD;
	}
	
	// 좌석선택 페이지
	@GetMapping("seatSelect")
	public String seat_select(ReserveVO reserveVO, Model model, HttpSession session, String play_end_time) {
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		List<ReserveVO> SeatList = reserve.getSeatList(reserveVO);
		play_end_time = reserve.getEndTime(reserveVO);
		reserveVO.setPlay_end_time(play_end_time);
		System.out.println("test : " + reserveVO);
		model.addAttribute("SeatList",SeatList);
		model.addAttribute("reserveVO",reserveVO);
		return "reserve/seat_select";
	}
	
	// 결제하기 페이지
	@PostMapping("reservePay")
	public String reservationComplete(@RequestParam Map<String, String> map, Model model, HttpSession session){
		String sId = (String)session.getAttribute("sId");
		Map<String, String> members = reserve.getmemberInfo(sId);
		System.out.println("조회한 회원 정보 : " + members);
		model.addAttribute("members", members);
		model.addAttribute("map", map);
		System.out.println(map);
		return "reserve/reserve_pay";
	}
	
	
	// 결제(예매)완료 <실제 데이터 insert 위치>
	@GetMapping("completePay")
	public String competePayment(@RequestParam Map<String, String> map, Model model, HttpSession session) {
		String sId = (String)session.getAttribute("sId");
		map.put("sId", sId);
		int insertCount = reserve.getSeatInsert(map);
		int insertCount2 = reserve.getPaymentInsert(map);
		int insertCount3 = reserve.getReserveInsert(map);
		ReserveVO reservevo = reserve.getPayment(map);
		System.out.println("complete_pay_controller : " + map);
		model.addAttribute("reservevo",reservevo);
		
		return "reserve/complete_pay";
	}
	
	
	//마이페이지 예매내역 처리
	@GetMapping("Mypage_Reserv_boardList")
	public String mypage_Reserv_boardList(Map<String, Object> map, Model model, HttpSession session,@RequestParam(defaultValue = "1") int pageNum) { // 예매내역 게시판
		String sId = (String)session.getAttribute("sId");
		List<HashMap<String, String>> resList = reserve.getReserveList(sId);
		model.addAttribute("resList", resList);
		return "login/Mypage_Reserv_boardList";
	}
	
	//마이페이지 상세내역조회
	@GetMapping("resInfoDetailPro")
	public String resInfoDetailPro(@RequestParam String payment_id, Map<String, String> map, Model model) {
		map = reserve.getresInfoDetail(payment_id);
		model.addAttribute("map",map);
		return"login/popup1";
	}
	
	//마이페이지 -> 상세예매내역조회 -> 예매취소
	@ResponseBody
	@GetMapping("resCancle")
	public boolean resCancle(@RequestParam String payment_id,@RequestParam String seat_id, Model model) {
		System.out.println("예매취소 : " + seat_id + ", " + payment_id);
		int paymentUpdateCount = reserve.getresCancle(payment_id); //결제취소
		int seatUpdateCount = reserve.getSeatCancle(seat_id); //좌석예매취소
		if(paymentUpdateCount>0 && seatUpdateCount>0)  {
			return true;
		}else {
			return false;
		}
	}
	
	
}






















