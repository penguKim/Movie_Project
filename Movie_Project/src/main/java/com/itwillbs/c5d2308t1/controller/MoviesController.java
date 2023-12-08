package com.itwillbs.c5d2308t1.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.c5d2308t1.service.MoviesService;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Controller
public class MoviesController {
	@Autowired
	MoviesService movie;
	
	@GetMapping("release")
	public String release(Model model) {
		System.out.println("현재상영작 페이지");
		
		List<MoviesVO> movieList = movie.getMovieList();
		model.addAttribute("movieList", movieList);
		return "";
	}
}
