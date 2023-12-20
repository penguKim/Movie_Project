package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;

/*
 members 테이블 정의
 ------------------------------
회원아이디(member_id) - VARCHAR(20), PK
회원이름(member_name) - VARCHAR(5), NN		
회원이메일(member_email) - VARCHAR(40)			
회원생년월일(member_birth) - VARCHAR(8), NN		
회원가입일(member_date) - DATETIME			
회원전화번호(member_phone) - VARCHAR(11),NN		
회원상태(member_status) - INT			
회원비밀번호(member_pass) - VARCHAR(20), NN		
회원선호장르(member_like_genre) - VARCHAR(20)			
극장코드(theater_id) - INT, FK(theaters)
-----------------------------------------
create table members (
	member_id VARCHAR(20) PRIMARY key,
	member_name VARCHAR(5) not null,
	member_email VARCHAR(40),
	member_birth VARCHAR(8) not null,
	member_date DATETIME,
	member_phone VARCHAR(11) not null,
	member_status INT,
	member_pass VARCHAR(20) not null,
	member_like_genre VARCHAR(20),
	theater_id INT,
	FOREIGN KEY(theater_id) REFERENCES theaters(theater_id)
)
*/

// 회원 테이블(members)과 매핑되는 VO 클래스 정의

@Data
public class MemberVO {
	private String member_id;
	private String member_name;
	private String member_email;
	private String member_birth;
	private Date member_date;
	private String member_phone;
	private int member_status;
	private String member_passwd;
	private String member_like_genre;
	private int theater_id;

	
	
}


