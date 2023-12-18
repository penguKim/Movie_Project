package com.itwillbs.c5d2308t1.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.LoginMapper;
import com.itwillbs.c5d2308t1.vo.MemberVO;
@Service
public class LoginService {
	
	@Autowired
	private LoginMapper mapper;

	public MemberVO getMember(MemberVO member) {
//		System.out.println("LoginService - getMember()" + member);
		return mapper.selectMember(member);
	}


}
