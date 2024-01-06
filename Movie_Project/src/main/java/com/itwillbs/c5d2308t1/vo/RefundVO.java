package com.itwillbs.c5d2308t1.vo;

import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Data;

@Data
public class RefundVO {
	
	private int payment_id; // // 결제번호
	private String payment_name; // // 결제번호
	private String product_id; // 상품번호(P005)
	private String product_name; // 상품이름
	private String member_id; // 회원아이디
	private String movie_id; // 영화코드
	private String member_name; // 회원이름
	private int cart_total_price; // 장바구니 총 가격
	private int payment_total_price; // 결제 총 가격
	private int product_count; // 상품갯수
	private int quantity; // 상품갯수
	private int payment_status; // 결제상태
	private String payment_card_name;
	private String movie_title; // 영화제목
	private LocalDateTime payment_datetime; // 예약시간? / 취소시간 
	
	
	
}
