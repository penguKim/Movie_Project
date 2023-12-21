package com.itwillbs.c5d2308t1;

import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.c5d2308t1.vo.MoviesVO;

public class Test {

	public static void main(String[] args) {

		System.out.println("kobis 영화 상세 검색");
		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
	    //발급키
	    String key = "811a25b246549ad749b278bba8257502";
//	    List<MoviesVO> movieList = service.getAllMovie();
	    int[] arr = {20190324,20202247,20203702,20210087,20212866,20233299,20234114,20234664,20234673,20234957,20235030,20235098,20235353,20235596,20235697,20235698,20235735,20235923,20235980};
	    	try {
//	    		for(MoviesVO movie : movieList) {
    			for(int movie : arr) {
//	    			System.out.println(movie.getMovie_id());
	    			// 기본 요청 URL
	    			String url = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=" + key + "&movieCd=" + movie;
	    			System.out.println(url);
	    			// ------------------------------------
//	    		// getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
//	    		String result = restTemplate.getForObject(url, String.class);
//	    		
//	    		// JSON 문자열을 파싱할 객체 생성
//	    		JSONParser jsonParser = new JSONParser();
//	    		// parse() 메서드로 읽어온 데이터를 JSONObject 타입으로 저장
//	    		JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
//	    		// 박스오피스 결과를 JSON 객체로 저장
//	    		JSONObject json =  (JSONObject) jsonobject.get("movieInfoResult");
//	    		// 영화 정보가 담긴 JSON 객체를 JSON 배열로 저장
//	    		JSONObject movieInfo = (JSONObject)json.get("movieInfo");
//	    		System.out.println(movieInfo);
//	    		
//	    		
//				 for(MoviesVO movie : movieList) {
//					 String url = "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2&ServiceKey=" 
//							 + ServiceKey + "&detail=Y&title=" + movie.getMovie_title() + "$releaseDts=" + movie.getMovie_release_date(); 
					 
		    		// getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
		    		String result = restTemplate.getForObject(url, String.class);
			    	JSONParser jsonParser = new JSONParser();
			    	JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
			    	JSONObject json =  (JSONObject) jsonobject.get("boxOfficeResult");
			    	JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
	    		
	    		
	    		
	    		Thread.sleep(5000);
	    		
		    		}
		    	} catch (ParseException e) {
		    		e.printStackTrace();
		    	} catch (InterruptedException e) {
					e.printStackTrace();
				}
	}

}
