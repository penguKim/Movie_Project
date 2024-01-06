package com.itwillbs.c5d2308t1.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.c5d2308t1.vo.MemberVO;

@Mapper
public interface JoinMapper {

	// 회원정보 등록 - 추상메서드 정의
	int insertMember(MemberVO member);

	// 중복체크 - 추상메서드 정의
	MemberVO selectDup(MemberVO member);
	
	// 회원정보 불러오기
	Integer selectMember(MemberVO member);

}
