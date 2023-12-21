package com.itwillbs.c5d2308t1.vo;

import lombok.Data;

/*
극장(theaters) 테이블 정의
------------------------
극장코드(theater_id) - INT, PK, AUTO_INCREMENT
극장이름(theater_name) - VARCHAR(50), NN
도로명주소(road_address) - VARCHAR(50), NN
상세주소(detail_address) - VARCHAR(50)
지역분류(area) - VARCHAR(10), NN
 */

//극장 테이블(theaters)과 매핑되는 VO 클래스 정의
@Data
public class TheaterVO {
	private int theater_id;
	private String theater_name;
	private String road_address;
	private String detail_address;
	private String area;
}
