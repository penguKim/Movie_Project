package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;

import lombok.Data;
@Data
public class ReviewsVO {
		private int id; //리뷰코드
		private int rating; //리뷰평점
		private String content; //리뷰내용
		private Date date; //작성시간
		private int payment_id;
}
