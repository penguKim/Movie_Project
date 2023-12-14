package com.itwillbs.c5d2308t1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
		List<ReserveVO> playList = reserve.getPlayList();
		model.addAttribute("movieList",movieList);
		model.addAttribute("theaterList",theaterList);
		model.addAttribute("playList",playList);
		return "reserve/movie_select";
	}
	
	@PostMapping("seat_select")
	public String seat_select(ReserveVO reserveVO, Model model) {
		System.out.println("seat_select");
		System.out.println(reserveVO);
		List<ReserveVO> SeatList = reserve.getSeatList(reserveVO);
		model.addAttribute("SeatList",SeatList);
		
		return "reserve/seat_select";
	}
}
