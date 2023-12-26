package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;
import java.sql.Time;

import lombok.Data;

@Data
public class ReviewBoard { //리뷰작성할수있는 회원인지 판별하기위한 뷰페이지
	private int movie_id;
	private String member_id;
	private Date play_date;
	private Time play_end_time;

}
