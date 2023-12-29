package com.itwillbs.c5d2308t1.vo;

import java.sql.Time;

import java.sql.Date;

import lombok.Data;

/*
상영일정(plays) 테이블 정의
------------------------
상영코드(play_id) - INT, PK, AUTO_INCREMENT
상영일(play_date) - DATE, NN
상영회차(play_turn) - INT
상영시작시간(play_start_time) - TIME
상영종료시간(play_end_time) - TIME
상영관코드(room_id) - INT, NN, FK
영화코드(movie_id) - INT, NN, FK
**************** 극장코드(theater_id) 참조 희망
 */

@Data
public class PlayVO {
	// 임시로 PlayVO 생성
	private int play_id;
	private Date play_date;
	private int play_turn;
	private Time play_start_time;
	private Time play_end_time;
	private int room_id;
	private int movie_id;
}
