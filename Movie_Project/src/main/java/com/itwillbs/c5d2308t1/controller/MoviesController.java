
package com.itwillbs.c5d2308t1.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.net.URLEncoder;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itwillbs.c5d2308t1.service.MoviesService;
import com.itwillbs.c5d2308t1.vo.KobisAPI;
import com.itwillbs.c5d2308t1.vo.CrawlVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Controller
public class MoviesController {
	@Autowired
	MoviesService movie;
	
	@GetMapping("release")
	public ModelAndView release(Map<String, Object> map) {
		// 현재 상영작
		try {
			// ft=0 => 무비차트, ft=1 => 현재 상영작
			String url = "http://www.cgv.co.kr/movies/?lt=1&ft=1";
			
			Connection con = Jsoup.connect(url);
			Document doc = con.get();
			Elements titleElements = doc.select("div.box-contents strong.title"); // 제목
			Elements posterElements = doc.select("div.box-image span.thumb-image img"); // 포스터 썸네일
			Elements percentElements = doc.select("div.box-contents div.score strong.percent span"); // 예매율
			Elements releaseElements = doc.select("div.box-contents span.txt-info strong"); // 개봉일
			Elements detailElements = doc.select("div.sect-movie-chart div.box-image>a"); // 개봉일
//			System.out.println(detailElements);
			
			List<CrawlVO> movieList = new ArrayList<CrawlVO>();
			
			for(int i = 0; i < titleElements.size(); i++) {
				CrawlVO movie = new CrawlVO();
				movie.setTitle(titleElements.get(i).text());
				movie.setPoster(posterElements.get(i).attr("src"));
				movie.setPercent(percentElements.get(i).text());
				movie.setRelease(releaseElements.get(i).text());
				movie.setDetailNum(detailElements.get(i).attr("href").
						substring(detailElements.get(i).attr("href").lastIndexOf("/")).replace("/?midx=", ""));
				System.out.println(movie.getDetailNum());
				movieList.add(movie);
			}
			
			map.put("movieList", movieList);
		} catch (IOException e) {
			System.out.println("크롤링 실패");
			e.printStackTrace();
		}
		
		ModelAndView mav = new ModelAndView("movie/release", map);
		
		return mav;
	}
	
	@GetMapping("comming")
	// 상영 예정작
	public ModelAndView comming(Map<String, Object> map) {
		try {
			
			String url = "http://www.cgv.co.kr/movies/pre-movies.aspx";
			
			Connection con = Jsoup.connect(url);
			Document doc = con.get();
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
	
	@GetMapping("detail")
	public ModelAndView detail(String detailNum, Model model) {
		System.out.println("영화 상세페이지");
		
		try {
			String url = "http://www.cgv.co.kr/movies/detail-view/?midx=" + detailNum;
			
			Connection con = Jsoup.connect(url);
			Document doc = con.get();
			Elements titleElements = doc.select("div.box-contents div.title strong");
			Elements posterElements = doc.select("div.box-image span.thumb-image img");
			Elements plotElements = doc.select("div#menu.cols-content div.col-detail div.sect-story-movie");
			Elements percentElements = doc.select("div.box-contents div.score strong.percent span");
//			Elements releaseElements = doc.select("div.box-contents span.txt-info strong");
			System.out.println(titleElements.text());
			System.out.println(posterElements.attr("src"));
			System.out.println(plotElements.toString());
			System.out.println(percentElements.text());
			
				CrawlVO movie = new CrawlVO();
				movie.setTitle(titleElements.text());
				movie.setPoster(posterElements.attr("src"));
				movie.setPlot(plotElements.toString());
				movie.setPercent(percentElements.text());
			
			model.addAttribute("movie", movie);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		ModelAndView mav = new ModelAndView("movie/detail", map);
		return mav;
	}
	
	@GetMapping("Test2")
	public String test2() {
		System.out.println("kmdb 테스트");
		try {
			StringBuilder urlBuilder = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&nation=대한민국"); /*URL*/ 
			urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=08P2788CP12T24B2US8F"); /*Service Key*/ 
			urlBuilder.append("&" + URLEncoder.encode("title","UTF-8") + "=" + URLEncoder.encode("서울의", "UTF-8")); /*상영년도*/ 
//			urlBuilder.append("&" + URLEncoder.encode("val002","UTF-8") + "=" + URLEncoder.encode("01", "UTF-8")); /*상영 월*/ 
			URL url = new URL(urlBuilder.toString()); 
			System.out.println(urlBuilder);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection(); 
			conn.setRequestMethod("GET"); 
			conn.setRequestProperty("Content-type", "application/json"); 
			System.out.println("Response code: " + conn.getResponseCode()); 
			BufferedReader rd; 
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) { 
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream())); 
			} else { 
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream())); 
			} 
			StringBuilder sb = new StringBuilder(); 
			String line; 
			while ((line = rd.readLine()) != null) { 
				sb.append(line); 
			} 
			rd.close(); 
			conn.disconnect(); 
			System.out.println(sb.toString());
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		
		return "";
	}
	
	@GetMapping("Test")
	public ModelAndView test(Map<String, MoviesVO> map) {
		System.out.println("kobis 일일 박스오피스");
		
	    //발급키
	    String key = "811a25b246549ad749b278bba8257502";

	    //전날 박스오피스 조회
	    String targetDt = "20231208";
	    
	    // 기본 요청 URL
	    String url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key + "&targetDt=" + targetDt;
        
	    //ROW 개수
	    String itemPerPage = "10";
	    
	    //다양성영화(Y)/상업영화(N)/전체(default)
	    String multiMovieYn = "";
	    
	    //한국영화(K)/외국영화(F)/전체(default)
	    String repNationCd = "";
	    
	    //상영지역별 코드/전체(default)
	    String wideAreaCd = "";
	    
	    
	    try {
	    	
            URL urlObj = new URL(url);
            HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
            String inputLine;
            StringBuffer content = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                content.append(inputLine);
            }

            // close connections
            br.close();
            con.disconnect();
	    	
	    	JSONParser jsonParser = new JSONParser();
	    	JSONObject jsonobject = (JSONObject)jsonParser.parse(content.toString());
	    	JSONObject json =  (JSONObject) jsonobject.get("boxOfficeResult");
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
	    		
	    	}
	    	
	    	// 코드, 이름, 개봉일, 관객수를 DB에 등록한다.
//	    	for(MoviesVO movie : movies) {
//	    		this.movie.insertMovie(movie);
//	    	}
	    	
	    	
//	    } catch (ParseException e) {
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    
	           
		ModelAndView mav = new ModelAndView("", map);
		
		return mav;
	}
	
	
	@GetMapping("searchTest")
	public String searchTest() {
		
	    try {
	    	// DB에 저장된 영화정보 불러오기
	    	List<MoviesVO> movieList = movie.getMovieList();
	    	
	    	//발급키
	    	String key = "811a25b246549ad749b278bba8257502";
	    	
	    	//영화 ID
	    	int movie_id = 0;
	    	
	    	// 기본 요청 URL
	    	String url = "";
	    	
	    	for(MoviesVO movie : movieList) {
	    		// 영화별 영화 코드 불러와 저장
	    		movie_id = movie.getMovie_id();
	    		
	    		url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key +  "&movieCd=" + movie_id;
	    		System.out.println(url);
	    	
	            URL urlObj = new URL(url);
	            HttpURLConnection con = (HttpURLConnection) urlObj.openConnection();
	            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
	            String inputLine;
	            StringBuffer content = new StringBuffer();
	            while ((inputLine = br.readLine()) != null) {
	                content.append(inputLine);
	            }
	
	            // close connections
	            br.close();
	            con.disconnect();
		    	
		    	JSONParser jsonParser = new JSONParser();
		    	JSONObject jsonobject = (JSONObject)jsonParser.parse(content.toString());
		    	JSONObject movieInfoResult =  (JSONObject) jsonobject.get("movieInfoResult");
		    	JSONObject movieInfo =  (JSONObject) movieInfoResult.get("movieInfo");
		    	if(movieInfo.get("movieCd") != null) {
		    		JSONArray nation = (JSONArray) movieInfo.get("nation");
		    		
		    	}
		    	
	//	    	JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
		    
	    	}
	    	
	    	
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
		
		return "";
	}
	
	
}


class BoxOfficeResult {
    private List<KobisAPI> boxOfficeResult;

	public List<KobisAPI> getBoxOfficeResult() {
		return boxOfficeResult;
	}

	public void setBoxOfficeResult(List<KobisAPI> boxOfficeResult) {
		this.boxOfficeResult = boxOfficeResult;
	}
    
    
}
