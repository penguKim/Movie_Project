package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

@Data
public class MoviesVO {
	
	// 영화 코드
	private int movie_id;
	// 영화 제목
	private String movie_title;
	// 제작 국가
	private String movie_nation;
	// 제작 년도
	private int movie_prdtYear;
	// 감독명
	private String movie_director;
	// 배우명
	private String movie_actor;
	// 장르
	private String movie_genre;
	// 관람등급
	private String movie_rating;
	// 줄거리
	private String movie_plot;
	// 상영 시작일
	private String movie_release_date;
	// 상영 종료일
	private String movie_close_date;
	// 상영시간
	private int movie_runtime;
	// 포스터 주소
	private String movie_poster;
	// 스틸샷1 주소
	private String movie_still1;
	// 스틸샷2 주소
	private String movie_still2;
	// 스틸샷3 주소
	private String movie_still3;
	// 트레일러 주소
	private String movie_trailer;
	// 총 관람객 수
	private int movie_audience;
	// 개봉 상태
	private int movie_status;
	
	
	
}
