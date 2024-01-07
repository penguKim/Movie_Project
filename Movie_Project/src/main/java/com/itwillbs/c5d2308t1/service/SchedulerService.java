package com.itwillbs.c5d2308t1.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.c5d2308t1.mapper.MoviesMapper;
import com.itwillbs.c5d2308t1.vo.MoviesVO;

/*
 root-context.xml에 빈을 추가하여 스케쥴러 사용이 가능하다.
 <beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:util="http://www.springframework.org/schema/util"
	xmlns:task="http://www.springframework.org/schema/task"
	xmlns:mybatis-spring="http://mybatis.org/schema/mybatis-spring"
	xsi:schemaLocation="http://mybatis.org/schema/mybatis-spring http://mybatis.org/schema/mybatis-spring-1.2.xsd
		http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/task http://www.springframework.org/schema/task/spring-task-3.0.xsd
		http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-3.1.xsd">
 </beans>
 beans의 설정으로 스케쥴러를 세팅하고 bean 객체를 정의한다.
 bean의 클래스명으로는 스케쥴러를 사용할 클래스를 지정한다.
 <bean id="schedulerService" class="com.itwillbs.c5d2308t1.service.SchedulerService" />
 	 <task:scheduler id="gsScheduler" pool-size="10" />
 	 <task:executor id="gsTaskExecutor" pool-size="10" />
	 <task:annotation-driven executor="gsTaskExecutor"
 scheduler="gsScheduler" />
 */


@Service
public class SchedulerService {

	@Autowired
	MoviesMapper mapper;
	
	
//	@Scheduled(cron="*/5 * * * * *")
//	public void test() {
//		System.out.println("바오바오");
//	}
	
	
//	@Scheduled(cron="*/30 * * * * *")
	// 크론 표현식으로 매일 23시 50분 0초에 실행된다.
//	@Scheduled(cron="0 50 23 * * ?")
//	public void registMovieCd() {
//		System.out.println("스케쥴러를 실행합니다.");
//	    //발급키
//	    String key = "811a25b246549ad749b278bba8257502";
//	    //전날 박스오피스 조회
//	    String targetDt = "20231223";
//	    // 기본 요청 URL
//	    String url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=" + key + "&targetDt=" + targetDt;
//	    //ROW 개수
//	    String itemPerPage = "10";
//	    //다양성영화(Y)/상업영화(N)/전체(default)
//	    String multiMovieYn = "";
//	    //한국영화(K)/외국영화(F)/전체(default)
//	    String repNationCd = "";
//	    //상영지역별 코드/전체(default)
//	    String wideAreaCd = "";
//	    
//		// http 통신을 위한 클라이언트 RestTemplate 객체 생성
//	    RestTemplate restTemplate = new RestTemplate();
//	    // getForObject() 메서드를 호출하여 GET 방식으로 url 요청 후 String 타입으로 저장한다.
//	    String result = restTemplate.getForObject(url, String.class);
//	    System.out.println(result);
//	    
//        try {
//			// JSON 문자열을 파싱할 객체 생성
//			JSONParser jsonParser = new JSONParser();
//			// parse() 메서드로 읽어온 데이터를 JSONObject 타입으로 저장
//			JSONObject jsonobject = (JSONObject)jsonParser.parse(result);
//			// 박스오피스 결과를 JSON 객체로 저장
//			JSONObject json =  (JSONObject) jsonobject.get("boxOfficeResult");
//			// 영화 정보가 담긴 JSON 객체를 JSON 배열로 저장
//			JSONArray array = (JSONArray)json.get("dailyBoxOfficeList");
//			
////	    	List<MoviesVO> movies = new ArrayList<MoviesVO>();
//	    	for(int i = 0 ; i < array.size(); i++){
//	    		MoviesVO movie = new MoviesVO();
//	    		JSONObject entity = (JSONObject)array.get(i);
//	    		movie.setMovie_id(Integer.parseInt((String)entity.get("movieCd"))); // 영화코드
//	    		movie.setMovie_title((String)entity.get("movieNm")); // 영화 이름
//	    		movie.setMovie_release_date((String)entity.get("openDt")); // 개봉일
//	    		movie.setMovie_audience(Integer.parseInt((String)entity.get("audiAcc"))); // 관객수
//	    		
//	    		System.out.println("메서드를 호출합니다.");
//	    		Map<String, String> map = Mapper.selectMovieDetail(movie.getMovie_id());
//	    		if(map != null) {
//	    			System.out.println("등록이 가능한 영화 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + map.get("movie_title"));
////	    			movies.add(movie);
//	    			System.out.println("관객수를 업데이트합니다 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
//	    			int updateCount = Mapper.updateMovieAudiAcc(movie);
//	    		} else {
//	    			System.out.println("등록이 완전 불가능한 영화  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
//	    		}
//	    		
//	    	}
//			
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//	    
//	    
//	}
	
	
	
	// 크론 표현식으로 매일 05시 30분 0초에 실행된다.
	@Scheduled(cron="0 30 05 * * ?")
	public void movieEndingProcess() {
		System.out.println("종영일 작업 스케쥴러를 실행합니다.");
		// 기존의 상영작 조회 메서드 재활용(파라미터로 현재상영작을 뜻하는 1을 넣어준다)
		List<Map<String, Object>> movieList = mapper.selectMoviesList(1);
		
		// 현재 날짜 정보를 가진 LocalDate 객체 생성
		LocalDate today = LocalDate.now();
		System.out.println("오늘 날짜 : " + today);
		
		// 종영일이 오늘보다 이전인 영화를 담을 List 객체 생성
//		List<Map<String, Object>> movieEndingList = new ArrayList<Map<String,Object>>();
		
		for(Map<String, Object> movie : movieList) {
			// 영화의 종영일을 Date 타입으로 받아오기
			Date movieEngingDate = (Date)movie.get("movie_close_date");
			// 종영일을 LocalDate 타입으로 변환
			LocalDate movieEndingLocalDate = movieEngingDate.toLocalDate();
//			System.out.println("LocalDate로 변환된 영화의 종영일 : " + movieEndingLocalDate);
			if(today.isAfter(movieEndingLocalDate)) { // 현재 날짜가 종영일보다 이후일 경우
				System.out.println("종영작으로 수정할 영화 : " + movie.get("movie_title"));
				// 종영일이 현재날짜보다 이전인 영화만 List에 저장
//				movieEndingList.add(movie);
				// 종영작으로 수정하는 작업
				mapper.updateMovieEndingStatus(movie);
			}
			}
		}
//		System.out.println(movieEndingList);
		
	
}
