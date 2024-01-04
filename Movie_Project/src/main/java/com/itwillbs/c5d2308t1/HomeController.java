package com.itwillbs.c5d2308t1;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.c5d2308t1.service.MoviesService;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	MoviesService movieService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		// 트레일러가 존재하는 영화 중 랜덤으로 하나를 가져온다.
		MoviesVO movie = movieService.getMovieTrailer();
		
		model.addAttribute("movie",movie);
		return "main";
	}
	
}
