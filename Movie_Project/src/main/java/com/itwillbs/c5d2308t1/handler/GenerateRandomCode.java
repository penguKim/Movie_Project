package com.itwillbs.c5d2308t1.handler;

import org.apache.commons.lang3.RandomStringUtils;

// 난수 생성에 사용할 클래스
public class GenerateRandomCode {
	// 난수 생성하여 문자열로 리턴할 getRandomCode() 메서드 정의
	// => 파라미터 : 난수 길이 (정수)   리턴타입 : String
	// => 인스턴스 생성없이 즉시 호출 가능하도록 static 메서드 활용
	public static String getRandomCode(int length) {
		// RandomStringUtils 클래스의 randomAlphanumeric() 메서드 호출하여
		// 알파벳, 숫자 조합 난수 생성하여 리턴
		return RandomStringUtils.randomAlphanumeric(length);
	}
}
