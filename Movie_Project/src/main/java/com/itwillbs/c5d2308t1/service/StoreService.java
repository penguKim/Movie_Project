package com.itwillbs.c5d2308t1.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.c5d2308t1.mapper.StoreMapper;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Service
public class StoreService {
	
	@Autowired
	StoreMapper mapper;
	
	public StoreVO selectTest(String product_id) {
		
		return mapper.selectPro(product_id);
	}
	
	
}
