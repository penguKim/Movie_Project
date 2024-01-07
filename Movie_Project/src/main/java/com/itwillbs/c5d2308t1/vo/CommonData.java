package com.itwillbs.c5d2308t1.vo;

import java.util.LinkedHashMap;

public class CommonData extends LinkedHashMap {	
	public void put(String key, Object value){		
		super.put(key, value);	
	}	
		
	public String get(String key) {		
		if(super.get(key)!=null) {			
			return super.get(key).toString();		
		} else {			
			return null;		
		}			
	}	
	
	public String get(String key,String value)	{		
		if(super.get(key)!=null) {			
			return super.get(key).toString();	
		} else {			
			return value;		
		}		
	}	
	
	public Object getObj(String key) {
		return super.get(key);	
	}
}
