package com.itwillbs.c5d2308t1.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.MemberVO;
@Mapper
public interface LoginMapper {
	
	//회원 상세정보 조회
	MemberVO selectMember(MemberVO member);

}
