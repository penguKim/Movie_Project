package com.itwillbs.c5d2308t1.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.JoinMapper;
import com.itwillbs.c5d2308t1.vo.MemberVO;

@Service
public class JoinService {
	// 마이바티스를 통해 SQL 구문 처리를 담당할 XXXMapper.xml 파일과 연동되는
	// XXXMapper 객체(인터페이스)를 자동 주입받기 위해 @Autowired 어노테이션으로 멤버변수 선언
	@Autowired
	private JoinMapper mapper;

	public int registMember(MemberVO member) {
		System.out.println("JoinService - registMember()");
		
		// JoinMapper - insertMember() 메서드를 호출하여 회원정보 등록 요청
		// => 파라미터 : MemberVO 객체   리턴타입 : int
		return mapper.insertMember(member);
	}

	public MemberVO getDup(MemberVO member) {
		// JoinMapper - getMember() 메서드를 호출하여 회원정보 조회
		// => 파라미터 : MemberVO 객체   리턴타입 : MemberVO
		return mapper.selectDup(member);
	}


	
}
