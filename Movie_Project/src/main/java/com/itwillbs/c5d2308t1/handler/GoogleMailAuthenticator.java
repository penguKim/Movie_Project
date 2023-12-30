package com.itwillbs.c5d2308t1.handler;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

// 자바 메일 기능 사용 시 메일 서버 인증을 위한 정보 관리
public class GoogleMailAuthenticator extends Authenticator {
	// 인증정보를 관리할 변수 선언
	PasswordAuthentication passwordAuthentication;
	
	public GoogleMailAuthenticator() {
		/*
		 * 인증에 사용될 아이디와 패스워드를 갖는 PasswordAuthentication 객체 생성
		 * - 파라미터 : 메일 서버 계정명, 패스워드
		 */
		passwordAuthentication = new PasswordAuthentication("gypark619", "gmourzybpqguckde");
	}

	// 인증 정보 관리 객체(PasswordAuthentication)를 외부로 리턴하는 getPasswordAuthentication() 메서드 정의
	public PasswordAuthentication getPasswordAuthentication() {
		return passwordAuthentication;
	}
	
}
