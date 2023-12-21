package com.itwillbs.c5d2308t1.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.c5d2308t1.mapper.MoviesMapper;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

@Service
public class MoviesService {
	@Autowired
	MoviesMapper mapper;
	
	
	public List<HashMap<String, String>> getMovieList() {
		System.out.println("MoviesService - getMovieList");
		
		return mapper.selectMoviesList();
	}

	// detail 서블릿으로 영화 정보 요청
	public HashMap<String, String> getMovieDetail(String movie_id) {
		return mapper.selectMovieDetail(movie_id);
	}
	
	public int insertMovie(MoviesVO movie) {
		System.out.println("insertMovie");
		return mapper.insertMovie(movie);
	}

	// movieTest 서블릿으로 영화 DB 등록
	public int registMovie(Map<String, Object> map) {
		return mapper.insertMovies(map);
	}
	
	
	public void registMovieCd() {
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
	    
		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
	    RestTemplate restTemplate = new RestTemplate();
	    // getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
	    String result = restTemplate.getForObject(url, String.class);
	    System.out.println(result);
	    
        try {
			// JSON 문자열을 파싱할 객체 생성
			JSONParser jsonParser = new JSONParser();
			// parse() 메서드로 읽어온 데이터를 JSONObject 타입으로 저장
			JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
			// 박스오피스 결과를 JSON 객체로 저장
			JSONObject json =  (JSONObject) jsonobject.get("boxOfficeResult");
			// 영화 정보가 담긴 JSON 객체를 JSON 배열로 저장
			JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
			System.out.println(array);
			
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
			
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
	    
	    
	}

	// List 객체 전달과 ON DUPLICATE KEY UPDATE 테스트
	public int registMovieCd(List<MoviesVO> movies) {
		return mapper.upsertMovieCd(movies);
	}
	// 모든 영화 가져오기
	public List<MoviesVO> getAllMovie() {
		return mapper.selectAllMovie();
	}
	

}
