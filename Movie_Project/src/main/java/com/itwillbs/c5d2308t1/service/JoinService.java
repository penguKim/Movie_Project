package com.itwillbs.c5d2308t1.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.JoinMapper;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.handler.SendMailClient;
import com.itwillbs.c5d2308t1.handler.GenerateRandomCode;

@Service
public class JoinService {
	// 마이바티스를 통해 SQL 구문 처리를 담당할 XXXMapper.xml 파일과 연동되는
	// XXXMapper 객체(인터페이스)를 자동 주입받기 위해 @Autowired 어노테이션으로 멤버변수 선언
	@Autowired
	private JoinMapper mapper;
	
	@Autowired
	private SendMailClient mailClient;

	// 인증 메일 발송 요청을 위한 sendAuthMail() 메서드
	public String sendAuthMail(String member_email) {
		// 인증 메일에 포함시켜 전달할 난수 생성
		String auth_code = GenerateRandomCode.getRandomCode(6);
		System.out.println("생성된 난수 : " + auth_code);
		
		// -------------------------------------------------
		// 인증 메일에 포함할 제목과 본문 생성
		String subject = "[iTicket] 가입 인증 메일입니다.";
	//			String content = "인증코드 : " + auth_code;
		// 이메일 본문에 인증에 사용될 주소 및 각종 정보를 포함하는 하이퍼링크를 표시할 경우
		// => URL 파라미터로 아이디와 인증코드 전달
		String content = "인증코드 : " + auth_code;
		// -------------------------------------------------
		// SendMailClient - sendMail() 메서드 호출하여 메일 발송 요청
		
//		// 쓰레드 생성
//		new Thread(new Runnable() {
//			@Override
//			public void run() {
//				mailClient.sendMail(email, subject, content);
//			}
//		}).start();
		mailClient.sendMail(member_email, subject, content);
		
		// 발송된 인증코드 리턴
		return auth_code;
	}
	
	// 회원 정보 등록
	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}

	// 회원 정보를 조회하여 중복값 비교
	public MemberVO getDup(MemberVO member) {
		return mapper.selectDup(member);
	}

	// 회원 정보 불러오기
	public Integer getMember(MemberVO member) {
		return mapper.selectMember(member);
	}

	// (차트)일일 가입 회원수 알아보기
	public int getJoinCount(String date) {
		return mapper.selectJoinCount(date);
	}

	
}
