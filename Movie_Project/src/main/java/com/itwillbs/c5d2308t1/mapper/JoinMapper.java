package com.itwillbs.c5d2308t1.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.MemberVO;

@Mapper
public interface JoinMapper {

	// 회원정보 등록 - 추상메서드 정의
	int insertMember(MemberVO member);

	// 중복체크 - 추상메서드 정의
	MemberVO selectDup(MemberVO member);

}
