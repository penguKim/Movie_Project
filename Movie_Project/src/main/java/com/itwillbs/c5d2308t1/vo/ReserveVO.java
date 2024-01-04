package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

@Data
public class ReserveVO {
	
	//resView 컬럼
	private String payment_name;
	private String payment_datetime;
	private String payment_total_price;
	private String seat_name;
	
	// reserve 테이블 컬럼
	private int payment_id;
	private String member_id;
	private int reserve_price;
	private int seat_id;
	
	//MPRT테이블 컬럼
	private String movie_id;
	private String movie_title;
	private String movie_poster;
	private String play_id;
	private String play_date;
	private String play_start_time;
	private String play_end_time;
	private String room_id;
	private String room_name;
	private String theater_id;
	private String theater_name;
}