package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;

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
	
	
	// 기본 생성자 정의 - 생략 가능
	
	// Getter/Setter 정의
	public int getCs_id() {
		return cs_id;
	}
	
	public void setCs_id(int cs_id) {
		this.cs_id = cs_id;
	}
	
	public String getCs_subject() {
		return cs_subject;
	}
	
	public void setCs_subject(String cs_subject) {
		this.cs_subject = cs_subject;
	}
	
	public String getCs_content() {
		return cs_content;
	}
	
	public void setCs_content(String cs_content) {
		this.cs_content = cs_content;
	}
	
	public Date getCs_date() {
		return cs_date;
	}
	
	public void setCs_date(Date cs_date) {
		this.cs_date = cs_date;
	}
	
	public String getCs_type() {
		return cs_type;
	}
	
	public void setCs_type(String cs_type) {
		this.cs_type = cs_type;
	}
	
	public String getCs_type_detail() {
		return cs_type_detail;
	}

	public void setCs_type_detail(String cs_type_detail) {
		this.cs_type_detail = cs_type_detail;
	}
	
	public int getCs_type_list_num() {
		return cs_type_list_num;
	}

	public void setCs_type_list_num(int cs_type_list_num) {
		this.cs_type_list_num = cs_type_list_num;
	}

	public String getCs_file() {
		return cs_file;
	}
	
	public void setCs_file(String cs_file) {
		this.cs_file = cs_file;
	}
	
	public String getCs_file_renew() {
		return cs_file_renew;
	}
	
	public void setCs_file_renew(String cs_file_renew) {
		this.cs_file_renew = cs_file_renew;
	}
	
	public String getCs_reply() {
		return cs_reply;
	}
	
	public void setCs_reply(String cs_reply) {
		this.cs_reply = cs_reply;
	}
	
	public String getMember_id() {
		return member_id;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public int getTheater_id() {
		return theater_id;
	}

	public void setTheater_id(int theater_id) {
		this.theater_id = theater_id;
	}

	
	@Override
	public String toString() {
		return "CsVO [cs_id=" + cs_id + ", cs_subject=" + cs_subject + ", cs_content=" + cs_content + ", cs_date="
				+ cs_date + ", cs_type=" + cs_type + ", cs_type_detail=" + cs_type_detail + ", cs_file=" + cs_file
				+ ", cs_file_renew=" + cs_file_renew + ", cs_type_list_num=" + cs_type_list_num + ", cs_reply="
				+ cs_reply + ", member_id=" + member_id + ", theater_id=" + theater_id + "]";
	}

	
	
}
