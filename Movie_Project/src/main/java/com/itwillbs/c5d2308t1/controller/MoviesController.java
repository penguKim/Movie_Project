package com.itwillbs.c5d2308t1.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.c5d2308t1.service.MoviesService;
import com.itwillbs.c5d2308t1.vo.KobisAPI;
import com.itwillbs.c5d2308t1.vo.LikesVO;
import com.itwillbs.c5d2308t1.vo.MainMovieType;
import com.itwillbs.c5d2308t1.vo.CrawlVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.ReviewBoard;
import com.itwillbs.c5d2308t1.vo.ReviewBoardVO;
import com.itwillbs.c5d2308t1.vo.ReviewsVO;

@Controller
public class MoviesController {
	@Autowired
	MoviesService service;
	
	// DB에 저장된 영화정보 가져와서 현재상영작에 뿌리기
	@GetMapping("release")
	public ModelAndView release(Map<String, List<Map<String, Object>>> map, 
							@RequestParam(defaultValue = "1") int sortType) {
		
		// DB에 저장된 영화정보를 HashMap 객체의 List로 리턴
		List<Map<String, Object>> movieList = service.getMovieList(sortType);
		// 상영작 페이지의 관람등급 표시를 위해 "관" 이전의 문자열 추출
		for(Map<String, Object> movie : movieList) {
			movie.put("movie_rating", movie.get("movie_rating").toString()
					.substring(0, movie.get("movie_rating").toString().indexOf("관")));
		}
		map.put("movieList", movieList);
		ModelAndView mav = new ModelAndView("movie/release", map);
		return mav;
	}
	
	// 내가 만든 상영작
	@GetMapping("comming")
	public String comming(Model model) {
		
		List<MoviesVO> commingList = service.getAllMovie();
		// 상영작 페이지의 관람등급 표시를 위해 "관" 이전의 문자열 추출
		for(MoviesVO movie : commingList) {
			movie.setMovie_rating(movie.getMovie_rating()
					.substring(0, movie.getMovie_rating()
					.indexOf("관")));
			System.out.println(movie.getMovie_rating());
		}
		model.addAttribute("commingList", commingList);
		
		return "movie/comming";
		}
	
	// 영화 상세 페이지
	@GetMapping("detail")
	public ModelAndView detail(int movie_id, Map<String, String> map, ReviewsVO review, HttpSession session, Model model ) {
		String sId = (String)session.getAttribute("sId");
		// 영화코드를 사용하여 영화 상세정보 가져오기
		
		review.setMember_id(sId);
		
		map = service.getMovieDetail(movie_id);
		
		List<ReviewsVO> reviewSelect = service.getreview(review);
		System.out.println(reviewSelect);
		model.addAttribute("movieReview",reviewSelect );
		
		ModelAndView mav = new ModelAndView("movie/detail", map);
		return mav;
	}
	
	// 상세 페이지의 연령대 차트
	@ResponseBody
	@GetMapping("movieAgeGroup")
	public String movieAgeGroup(int movie_id) {
		
		List<Map<String, Object>> ageGroupList = service.getAgeGroupList(movie_id);
		
		System.out.println(ageGroupList);
		
		JSONArray jsonArray = new JSONArray(ageGroupList);
		
		return jsonArray.toString();
	}
	
	// 상세 페이지의 성별 차트
	@ResponseBody
	@GetMapping("movieGenderGroup")
	public String movieGenderGroup(int movie_id) {
		
		List<Map<String, Object>> genderGroupList = service.getGenderGroupList(movie_id);
		
		JSONArray jsonArray = new JSONArray(genderGroupList);
		
		return jsonArray.toString();
	}
	
	// 찜하기 기능
	@ResponseBody
	@GetMapping("likeCheck")
	public String likeCheck(LikesVO like, HttpSession session) {
//		System.out.println(like);
		
		String sId = (String)session.getAttribute("sId");
		
		if(sId == null) {
			return "login";
		}
		
		like.setMember_id(sId);
		// 찜 정보가 있을 경우와 없을 경우의 "true"/"false" 문자열 반환
		return service.getLike(like);
	}
	
	// 찜하기 불러오기
	@ResponseBody
	@GetMapping("likeShow")
	public String likeShow(HttpSession session) {
		
		String sId = (String)session.getAttribute("sId");
		
		if(sId != null) {
//			System.out.println("세션아이디가 있어서 찜정보를 불러와요");
			List<LikesVO> likeList = service.getLikeList(sId);
			
			JSONArray jsonArray = new JSONArray(likeList);
			
			return jsonArray.toString();
		}
//		System.out.println("세션아이디가 없어서 빈 배열이 넘어가요");
		return "[]";
	}
	
	// =========================================================================================
	// cgv에서 크롤링하여 현재상영작 페이지에 뿌리기
//	@GetMapping("release")
//	public ModelAndView release(Map<String, Object> map) {
//		// 현재 상영작
//		try {
//			// ft=0 => 무비차트, ft=1 => 현재 상영작
//			String url = "http://www.cgv.co.kr/movies/?lt=1&ft=1";
//			
//			// Jsoup 라이브러리와 url 연결
//			Connection con = Jsoup.connect(url);
//			// url안의 html코드를 Document 타입으로 저장
//			Document doc = con.get();
//			// select() 메서드를 사용하여 태그 지정하여 Elements 타입으로 저장
//			// 해당 요소가 여러개가 있을 경우가 있기에 Elements 타입으로 지정하고 단일일 경우 Element 타입으로 지정
//			Elements titleElements = doc.select("div.box-contents strong.title"); // 제목
//			Elements posterElements = doc.select("div.box-image span.thumb-image img"); // 포스터 썸네일
//			Elements percentElements = doc.select("div.box-contents div.score strong.percent span"); // 예매율
//			Elements releaseElements = doc.select("div.box-contents span.txt-info strong"); // 개봉일
//			Elements detailElements = doc.select("div.sect-movie-chart div.box-image>a"); // CGV 영화 코드
//			
//			// 위의 정보들을 각각의 CrawlVO 객체에 담아서 List 로 관리한다.
//			List<CrawlVO> movieList = new ArrayList<CrawlVO>();
//			
//			for(int i = 0; i < titleElements.size(); i++) {
//				CrawlVO movie = new CrawlVO();
//				movie.setTitle(titleElements.get(i).text());
//				movie.setPoster(posterElements.get(i).attr("src"));
//				movie.setPercent(percentElements.get(i).text());
//				movie.setRelease(releaseElements.get(i).text());
//				// 필요한 부분만 잘라내서 저장한다.
//				movie.setDetailNum(detailElements.get(i).attr("href").
//						substring(detailElements.get(i).attr("href").lastIndexOf("/")).replace("/?midx=", ""));
//				System.out.println(movie.getDetailNum());
//				movieList.add(movie);
//			}
//			
//			map.put("movieList", movieList);
//		} catch (IOException e) {
//			System.out.println("크롤링 실패");
//			e.printStackTrace();
//		}
//		
//		ModelAndView mav = new ModelAndView("movie/release", map);
//		
//		return mav;
//	}
	
//	// 상영 예정작
//	@GetMapping("comming")
//	public ModelAndView comming(Map<String, Object> map) {
//		try {
//			// 요청할 URL 주소
//			String url = "http://www.cgv.co.kr/movies/pre-movies.aspx";
//			// 크롤링을 위한 Jsoup 객체에 url 전달하여 Connection 객체 생성
//			Connection con = Jsoup.connect(url);
//			// 가져온 데이터를 Document 객체로 저장
//			Document doc = con.get();
//			// 해당하는 요소를 Elements타입의 List로 저장
//			Elements titleElements = doc.select("div.box-contents strong.title");
//			Elements posterElements = doc.select("div.box-image span.thumb-image img");
////			Elements detailElements = doc.select("div.box-image a");
//			Elements percentElements = doc.select("div.box-contents div.score strong.percent span");
//			Elements releaseElements = doc.select("div.box-contents span.txt-info strong");
//			
//			List<CrawlVO> movieList = new ArrayList<CrawlVO>();
//			// 상영 예정작의 0~2 인덱스는 이달의 추천영화이므로 실제 상영 예정작이랑 중복된다.
//			for(int i = 3; i < titleElements.size(); i++) {
//				CrawlVO movie = new CrawlVO();
//				movie.setTitle(titleElements.get(i).text());
//				movie.setPoster(posterElements.get(i).attr("src"));
//				movie.setPercent(percentElements.get(i).text());
//				movie.setRelease(releaseElements.get(i).text());
//				movieList.add(movie);
//			}
//			
//			map.put("movieList", movieList);
//		} catch (IOException e) {
//			System.out.println("크롤링 실패");
//			e.printStackTrace();
//		}
//		
//		ModelAndView mav = new ModelAndView("movie/comming", map);
//		
//		return mav;
//	}
	
	// cgv에서 크롤링하여 현재상영작의 영화ID를 사용하여 크롤링한 상세페이지 뿌리기
//	@GetMapping("detail")
//	public ModelAndView detail(String detailNum, Model model) {
//		System.out.println("영화 상세페이지");
//		
//		try {
//			String url = "http://www.cgv.co.kr/movies/detail-view/?midx=" + detailNum;
//			
//			Connection con = Jsoup.connect(url);
//			Document doc = con.get();
//			Elements titleElements = doc.select("div.box-contents div.title strong");
//			Elements posterElements = doc.select("div.box-image span.thumb-image img");
//			Elements plotElements = doc.select("div#menu.cols-content div.col-detail div.sect-story-movie");
//			Elements percentElements = doc.select("div.box-contents div.score strong.percent span");
////			Elements releaseElements = doc.select("div.box-contents span.txt-info strong");
//			System.out.println(titleElements.text());
//			System.out.println(posterElements.attr("src"));
//			System.out.println(plotElements.toString());
//			System.out.println(percentElements.text());
//			
//				CrawlVO movie = new CrawlVO();
//				movie.setTitle(titleElements.text());
//				movie.setPoster(posterElements.attr("src"));
//				movie.setPlot(plotElements.toString());
//				movie.setPercent(percentElements.text());
//			
//			model.addAttribute("movie", movie);
//			
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		
//		
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		ModelAndView mav = new ModelAndView("movie/detail", map);
//		return mav;
//	}
	
	
	//리뷰-----
	//member_id값이 있고 영화상영일 + 상영종료시간 이후에 리뷰작성이 가능함
	//내가 본 영화페이지에 리뷰값이 있어야한다
	// 리뷰 작성후 등록 버튼 클릭시 데이터 출력하기

	@ResponseBody
	@PostMapping("reviewPro")
    public String reviewBoard(HttpSession session, Model model, Map<String, String> map, @RequestParam String movie_id, @RequestParam String review_content, HttpServletRequest request) {
			String sId = (String)session.getAttribute("sId"); //현재 로그인 중인 아이디 sId 저장
			model.addAttribute("sId",sId);
			
			int insertCount = service.registReview(sId, review_content, movie_id);
			
			model.addAttribute("reviews", insertCount);
//			String str1 = request.getParameter("movie_id");
//			String str2 = request.getParameter("review_content");
			
        return "movie/detail"+ movie_id;
    }//reviewPro 끝 


	
} //MoviesController 끝