package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewBoardVO { //리뷰게시글 출력을 위해서 뷰테이블 생성
	private int review_id;
	private int review_rating;
	private String review_content;
	private Date review_date;
	private int movie_id;
	private String movie_title;
	private String member_id;
	

}