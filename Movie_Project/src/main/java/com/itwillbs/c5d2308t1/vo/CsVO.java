package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/*
cs 테이블 정의
------------------------------
고객관리코드(cs_id) - INT, PK, AUTO INCREMENT
문의제목(cs_subject) - VARCHAR(100)	
문의내용(cs_content) - VARCHAR(1000)		
문의일시(cs_date) - DATETIME	
문의유형(cs_type) - VARCHAR(20)			
문의세부유형(cs_type_detail) - VARCHAR(20)			
첨부파일(cs_file) - VARCHAR(200)
새첨부파일(cs_file_renew) - VARCHAR(200)		
글번호(cs_type_list_num) - INT
문의답변(cs_reply) - VARCHAR(1000)			
회원아이디(member_id) - VARCHAR(20), FK(members)
극장번호(theater_id) - int
-----------------------------------------
create table cs (
	cs_id INT PRIMARY key AUTO_INCREMENT,
	cs_subject VARCHAR(100),
	cs_content VARCHAR(1000),	
	cs_date DATETIME,	
	cs_type VARCHAR(20),			
	cs_type_detail VARCHAR(20),			
	cs_file VARCHAR(200),
	cs_file_renew VARCHAR(200),		
	cs_type_list_num INT,
	cs_reply VARCHAR(1000),			
	member_id VARCHAR(20),
	theater_id int,
	FOREIGN KEY(member_id) REFERENCES members(member_id)
	FOREIGN KEY(theater_id) REFERENCES theater(theater_id)
)
*/

//회원 테이블(members)과 매핑되는 VO 클래스 정의

@Data
public class CsVO {
	private int cs_id;
	private String cs_subject;
	private String cs_content;
	private Date cs_date;
	private String cs_type;
	private String cs_type_detail;
	private String cs_file;
	private String cs_file_renew;
	private int cs_type_list_num;
	private String cs_reply;
	private String member_id;
	private int theater_id;
	private String theater_name;
	
	private MultipartFile mFile;
	
}
