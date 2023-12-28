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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
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
import com.itwillbs.c5d2308t1.vo.CrawlVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.ReviewBoardVO;
import com.itwillbs.c5d2308t1.vo.ReviewsVO;

@Controller
public class MoviesController {
	@Autowired
	MoviesService service;
	
	// DB에 저장된 영화정보 가져와서 현재상영작에 뿌리기
	@GetMapping("release")
	public ModelAndView release(Map<String, Object> map, @RequestParam(defaultValue = "1") int sortType) {
		
		// DB에 저장된 영화정보를 HashMap 객체의 List로 리턴
		List<Map<String, String>> movieList = service.getMovieList(sortType);
		// 상영작 페이지의 관람등급 표시를 위해 "관" 이전의 문자열 추출
		for(Map<String, String> movie : movieList) {
			movie.put("movie_rating", movie.get("movie_rating")
					.substring(0, movie.get("movie_rating").indexOf("관")));
		}
		map.put("movieList", movieList);
		map.put("data", "테스트");
		ModelAndView mav = new ModelAndView("movie/release", map);
		
		return mav;
	}
	
	// 상영 예정작
	@GetMapping("comming")
	public ModelAndView comming(Map<String, Object> map) {
		try {
			// 요청할 URL 주소
			String url = "http://www.cgv.co.kr/movies/pre-movies.aspx";
			// 크롤링을 위한 Jsoup 객체에 url 전달하여 Connection 객체 생성
			Connection con = Jsoup.connect(url);
			// 가져온 데이터를 Document 객체로 저장
			Document doc = con.get();
			// 해당하는 요소를 Elements타입의 List로 저장
			Elements titleElements = doc.select("div.box-contents strong.title");
			Elements posterElements = doc.select("div.box-image span.thumb-image img");
//			Elements detailElements = doc.select("div.box-image a");
			Elements percentElements = doc.select("div.box-contents div.score strong.percent span");
			Elements releaseElements = doc.select("div.box-contents span.txt-info strong");
			
			List<CrawlVO> movieList = new ArrayList<CrawlVO>();
			// 상영 예정작의 0~2 인덱스는 이달의 추천영화이므로 실제 상영 예정작이랑 중복된다.
			for(int i = 3; i < titleElements.size(); i++) {
				CrawlVO movie = new CrawlVO();
				movie.setTitle(titleElements.get(i).text());
				movie.setPoster(posterElements.get(i).attr("src"));
				movie.setPercent(percentElements.get(i).text());
				movie.setRelease(releaseElements.get(i).text());
				movieList.add(movie);
			}
			
			map.put("movieList", movieList);
		} catch (IOException e) {
			System.out.println("크롤링 실패");
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("movie/comming", map);
		
		return mav;
	}
	
	
	// 영화 상세 페이지
	@GetMapping("detail")
	public ModelAndView detail(int movie_id, Map<String, String> map) {
		
		// 영화코드를 사용하여 영화 상세정보 가져오기
		map = service.getMovieDetail(movie_id);
		
		ModelAndView mav = new ModelAndView("movie/detail", map);
		return mav;
	}
	
	// 찜하기 기능
	@ResponseBody
	@GetMapping("likeCheck")
	public String likeCheck(LikesVO like) {
		System.out.println(like);
		
		LikesVO dBlike = service.getLike(like);
		
		if(dBlike != null) { // 해당 영화를 찜한 경우
			// 찜하기 삭제 수행
			int deleteCount = service.removeLike(like);
			return "false";
		} else { // 찜을 안한 경우
			// 찜하기 등록 수행
			int insertCount = service.registLike(like);
			return "true";
		}
	}
	
	// 찜하기 불러오기
	@ResponseBody
	@GetMapping("likeShow")
	public List<LikesVO> likeShow(String member_id) {
		List<LikesVO> likeList = service.getLikeList(member_id);
		
		return likeList;
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
	
	// =====================================================================================
	// 자바 코드로 API 정보 가져오는 테스트 ============================
	
	
	@GetMapping("Test")
	public ModelAndView test(Map<String, MoviesVO> map) {
		System.out.println("kobis 일일 박스오피스");
	    //발급키
	    String key = "811a25b246549ad749b278bba8257502";
	    //전날 박스오피스 조회
	    String targetDt = "20231220";
	    //ROW 개수
//	    String itemPerPage = "10";
	    //다양성영화(Y)/상업영화(N)/전체(default)
//	    String multiMovieYn = "";
	    //한국영화(K)/외국영화(F)/전체(default)
//	    String repNationCd = "";
	    //상영지역별 코드/전체(default)
//	    String wideAreaCd = "";
	    // 기본 요청 URL
	    String url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key + "&targetDt=" + targetDt;
	    // ------------------------------------
		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
	    RestTemplate restTemplate = new RestTemplate();
	    // getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
	    String result = restTemplate.getForObject(url, String.class);
	    
        try {
			// JSON 문자열을 파싱할 객체 생성
			JSONParser jsonParser = new JSONParser();
			// parse() 메서드로 읽어온 데이터를 JSONObject 타입으로 저장
			JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
			// 박스오피스 결과를 JSON 객체로 저장
			JSONObject json =  (JSONObject) jsonobject.get("boxOfficeResult");
			// 영화 정보가 담긴 JSON 객체를 JSON 배열로 저장
			JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
			
	    	List<MoviesVO> movies = new ArrayList<MoviesVO>();
	    	for(int i = 0 ; i < array.size(); i++){
	    		MoviesVO movie = new MoviesVO();
	    		JSONObject entity = (JSONObject)array.get(i);
	    		movie.setMovie_id(Integer.parseInt((String)entity.get("movieCd"))); // 영화코드
	    		movie.setMovie_title((String)entity.get("movieNm")); // 영화 이름
	    		movie.setMovie_release_date((String)entity.get("openDt")); // 개봉일
	    		movie.setMovie_audience(Integer.parseInt((String)entity.get("audiAcc"))); // 관객수
	    		movies.add(movie);
	    		System.out.println(movie);
	    	}
	    	
	    	int insupdCount = service.registMovieCd(movies);
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
		ModelAndView mav = new ModelAndView("", map);
		
		return mav;
	}
	
	@GetMapping("Test2")
	public ModelAndView test2(Map<String, MoviesVO> map) {
		System.out.println("kobis 영화 상세 검색");
		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
	    //발급키
	    String key = "811a25b246549ad749b278bba8257502";
	    List<MoviesVO> movieList = service.getAllMovie();
	    List<MoviesVO> movieDirectorList = new ArrayList<MoviesVO>();
	    	try {
	    		for(MoviesVO movie : movieList) {
//	    			System.out.println(movie.getMovie_id());
	    			// 기본 요청 URL
	    			String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key + "&movieCd=" + movie.getMovie_id();
	    			System.out.println(url);
	    			// ------------------------------------
		    		// getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
		    		String result = restTemplate.getForObject(url, String.class);
		    		
		    		// JSON 문자열을 파싱할 객체 생성
		    		JSONParser jsonParser = new JSONParser();
		    		// parse() 메서드로 읽어온 데이터를 JSONObject 타입으로 저장
		    		JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
		    		// 박스오피스 결과를 JSON 객체로 저장
		    		JSONObject json =  (JSONObject) jsonobject.get("movieInfoResult");
		    		// 영화 정보가 담긴 JSON 객체를 JSON 배열로 저장
		    		JSONObject movieInfo = (JSONObject)json.get("movieInfo");
		    		System.out.println(movieInfo);
	    		
	    		
	    		
	    		
	    		Thread.sleep(5000);
	    		
	    		
	    		
	    		}
	    	} catch (ParseException e) {
	    		e.printStackTrace();
	    	} catch (InterruptedException e) {
				e.printStackTrace();
			}
	    		
//	    		List<MoviesVO> movies = new ArrayList<MoviesVO>();
//	    		for(int i = 0 ; i < array.size(); i++){
//	    			MoviesVO mv = new MoviesVO();
//	    			JSONObject entity = (JSONObject)array.get(i);
//	    			mv.setMovie_id(Integer.parseInt((String)entity.get("movieCd"))); // 영화코드
//	    			mv.setMovie_title((String)entity.get("movieNm")); // 영화 이름
//	    			mv.setMovie_release_date((String)entity.get("openDt")); // 개봉일
//	    			mv.setMovie_audience(Integer.parseInt((String)entity.get("audiAcc"))); // 관객수
//	    			movies.add(mv);
//	    			System.out.println(mv);
//	    		}
//	    		
//	    		int insupdCount = service.registMovieCd(movies);

	    	

	    
		ModelAndView mav = new ModelAndView("", map);
		
		return mav;
	}
	
	
	@GetMapping("Test3")
	public ModelAndView test3(Map<String, Object> map) {
		System.out.println("kobis 영화 상세 검색");
		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
	    //발급키
	    String key = "811a25b246549ad749b278bba8257502";
		// 기본 요청 URL
		String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key + "&movieCd=" + "서울의 봄";
		System.out.println(url);
		// ------------------------------------
		// getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
		String result = restTemplate.getForObject(url, String.class);
		
		try {
			ObjectMapper mapper = new ObjectMapper();
			
			map = mapper.readValue(url, Map.class);
			
			JsonNode root = mapper.readTree(result);
			JsonNode data = root.path("Data");
			
			for (JsonNode node : data) {
			    String title = node.path("title").asText();
			    String director = node.path("director").asText();
			    System.out.println("제목: " + title);
			    System.out.println("감독: " + director);
			}
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	    		
//		Thread.sleep(5000);
	    		
	    
		ModelAndView mav = new ModelAndView("", map);
		
		return mav;
	}
	
	
	@GetMapping("kmdbTest")
	public String test2() {
		System.out.println("kmdb 테스트");
		String ServiceKey = "08P2788CP12T24B2US8F";
		
		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		List<MoviesVO> movieList = service.getAllMovie();
		
		 try {
			 for(MoviesVO movie : movieList) {
				 String url = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=" 
						 + ServiceKey + "&detail=Y&title=" + movie.getMovie_title() + "&releaseDts=" + movie.getMovie_release_date().replace("-", ""); 
				 System.out.println(url);
	    		// getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
	    		String result = restTemplate.getForObject(url, String.class);
		    	JSONParser jsonParser = new JSONParser();
		    	JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
		    	JSONArray data =  (JSONArray) jsonobject.get("Data");
		    	System.out.println(data);
		    	JSONArray resultMovie = (JSONArray) data.get(0);
		    	System.out.println(resultMovie);
		    	
//		    	List<MoviesVO> movies = new ArrayList<MoviesVO>();
//		    	for(int i = 0 ; i < array.size(); i++){
//		    		MoviesVO movie = new MoviesVO();
//		    		JSONObject entity = (JSONObject)array.get(i);
//		    		movie.setMovie_id(Integer.parseInt((String)entity.get("movieCd"))); // 영화코드
//		    		movie.setMovie_title((String)entity.get("movieNm")); // 영화 이름
//		    		movie.setMovie_release_date((String)entity.get("openDt")); // 개봉일
//		    		movie.setMovie_audience(Integer.parseInt((String)entity.get("audiAcc"))); // 관객수
//		    		movies.add(movie);
//		    		
//		    	}
		    	
		    	
		    	Thread.sleep(5000);
		    	
		    	// 코드, 이름, 개봉일, 관객수를 DB에 등록한다.
//		    	for(MoviesVO movie : movies) {
//		    		this.movie.insertMovie(movie);
//		    	}
		    	
			 	}
		    } catch (ParseException e) {
		    	e.printStackTrace();
		    } catch (Exception e) {
		    	e.printStackTrace();
		    }
		    
		return "";
	}
	
	@ResponseBody
	@GetMapping("movieRegistTest")
	public String movieRegist(@RequestParam Map<String, String> map) {
		System.out.println(map);
		
		return "";
	}

	
	
//	@GetMapping("searchTest")
//	public String searchTest() {
//		
//	    try {
//	    	// DB에 저장된 영화정보 불러오기
//	    	List<MoviesVO> movieList = movie.getMovieList();
//	    	
//	    	//발급키
//	    	String key = "811a25b246549ad749b278bba8257502";
//	    	
//	    	//영화 ID
//	    	int movie_id = 0;
//	    	
//	    	// 기본 요청 URL
//	    	String url = "";
//	    	
//	    	for(MoviesVO movie : movieList) {
//	    		// 영화별 영화 코드 불러와 저장
//	    		movie_id = movie.getMovie_id();
//	    		
//	    		url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key +  "&movieCd=" + movie_id;
//	    	
//	            URL urlObj = new URL(url);
//	            HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
//	            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
//	            String inputLine;
//	            StringBuffer content = new StringBuffer();
//	            while ((inputLine = br.readLine()) != null) {
//	                content.append(inputLine);
//	            }
//	
//	            // close connections
//	            br.close();
//	            con.disconnect();
//		    	
//		    	JSONParser jsonParser = new JSONParser();
//		    	JSONObject jsonobject = (JSONObject)jsonParser.parse(content.toString());
//		    	JSONObject movieInfoResult =  (JSONObject) jsonobject.get("movieInfoResult");
//		    	JSONObject movieInfo =  (JSONObject) movieInfoResult.get("movieInfo");
//		    	if(movieInfo.get("movieCd") != null) {
//		    		JSONArray nation = (JSONArray) movieInfo.get("nation");
//		    		
//		    	}
//		    	
//	//	    	JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
//		    
//	    	}
//	    	
//	    	
//	    } catch (Exception e) {
//	    	e.printStackTrace();
//	    }
//		
//		return "";
//	}
	
	//리뷰-----
	//member_id값이 있고 영화상영일 + 상영종료시간 이후에 리뷰작성이 가능함
	// 리뷰 작성후 등록 버튼 클릭시 데이터 출력하기
	@GetMapping("reviewPro")
	public String reviewBoard(Map map) {
		System.out.println(map.get("movie_id"));
		
		return "detail";
	}//reviewPro 끝
	
} //MoviesController 끝


//class BoxOfficeResult {
//    private List<KobisAPI> boxOfficeResult;
//
//	public List<KobisAPI> getBoxOfficeResult() {
//		return boxOfficeResult;
//	}
//
//	public void setBoxOfficeResult(List<KobisAPI> boxOfficeResult) {
//		this.boxOfficeResult = boxOfficeResult;
//	}
    
    
//}
