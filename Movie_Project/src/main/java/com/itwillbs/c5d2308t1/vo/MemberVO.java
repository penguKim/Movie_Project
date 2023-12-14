package com.itwillbs.c5d2308t1.vo;

import java.sql.Date;

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
/**
 * @author 사용자
 *
 */
public class MemberVO {
	private String member_id;
	private String member_name;
	private String member_email;
	private String member_birth;
	private Date member_date;
	private String member_phone;
	private int member_status;
	private String member_pass;
	private String member_like_genre;
	private int theater_id;
	
	// 기본 생성자 정의 - 생략 가능
	
	// Getter/Setter 정의
	public String getMember_id() {
		return member_id;
	}
	
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	
	public String getMember_name() {
		return member_name;
	}
	
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	
	public String getMember_email() {
		return member_email;
	}
	
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	
	public String getMember_birth() {
		return member_birth;
	}
	
	public void setMember_birth(String member_birth) {
		this.member_birth = member_birth;
	}
	
	public Date getMember_date() {
		return member_date;
	}
	
	public void setMember_date(Date member_date) {
		this.member_date = member_date;
	}
	
	public String getMember_phone() {
		return member_phone;
	}
	
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	
	public int getMember_status() {
		return member_status;
	}
	
	public void setMember_status(int member_status) {
		this.member_status = member_status;
	}
	
	public String getMember_pass() {
		return member_pass;
	}
	
	public void setMember_pass(String member_pass) {
		this.member_pass = member_pass;
	}

	public String getMember_like_genre() {
		return member_like_genre;
	}

	public void setMember_like_genre(String member_like_genre) {
		this.member_like_genre = member_like_genre;
	}

	public int getTheater_id() {
		return theater_id;
	}

	public void setTheater_id(int theater_id) {
		this.theater_id = theater_id;
	}


	
	// toString 정의
	@Override
	public String toString() {
		return "JoinVO [member_id=" + member_id + ", member_name=" + member_name + ", member_email=" + member_email
				+ ", member_birth=" + member_birth + ", member_date=" + member_date + ", member_phone=" + member_phone
				+ ", member_status=" + member_status + ", member_pass=" + member_pass + ", member_like_genre="
				+ member_like_genre + ", theater_id=" + theater_id + ", getMember_id()=" + getMember_id()
				+ ", getMember_name()=" + getMember_name() + ", getMember_email()=" + getMember_email()
				+ ", getMember_birth()=" + getMember_birth() + ", getMember_date()=" + getMember_date()
				+ ", getMember_phone()=" + getMember_phone() + ", getMember_status()=" + getMember_status()
				+ ", getMember_pass()=" + getMember_pass() + ", getMember_like_genre()=" + getMember_like_genre()
				+ ", getTheater_id()=" + getTheater_id() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}

	
	
}
