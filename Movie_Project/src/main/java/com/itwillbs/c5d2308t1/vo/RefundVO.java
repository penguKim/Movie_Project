package com.itwillbs.c5d2308t1.vo;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;

@Data
public class RefundVO {
	
	private String product_id; // 상품이름
	private String member_id; // 회원아이디
	private int cart_total_price; // 상품가격
	private int product_count; // 상품갯수
	private int payment_status; // 결제상태
	private String movie_title; // 영화제목
	private LocalDateTime payment_datetime; // 예약시간? / 취소시간 
}
