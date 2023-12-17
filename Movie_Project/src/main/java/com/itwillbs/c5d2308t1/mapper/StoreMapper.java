package com.itwillbs.c5d2308t1.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.c5d2308t1.vo.StoreVO;

@Mapper
public interface StoreMapper {

	StoreVO selectPro(String product_id);
	
}
