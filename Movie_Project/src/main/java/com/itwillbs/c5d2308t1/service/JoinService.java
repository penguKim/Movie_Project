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

	// 회원 정보 등록
	public int registMember(MemberVO member) {
		return mapper.insertMember(member);
	}

	// 회원 정보를 조회하여 중복값 비교
	public MemberVO getDup(MemberVO member) {
		return mapper.selectDup(member);
	}

	public int naverLogin(MemberVO member) {
		return mapper.insertMember(member);
	}


	
}
