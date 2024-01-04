package com.itwillbs.c5d2308t1.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.c5d2308t1.service.StoreService;
import com.itwillbs.c5d2308t1.vo.CartVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;

@Controller
public class StoreController {
	
	@Autowired
	private StoreService service;
	
	// 스토어 페이지 이동
	@GetMapping("store")
	public String store() {
		
		return "store/store_main";
	}
	
	// 스토어 상세페이지 매핑
	@GetMapping("storeDetail")
	public String storeDetail(HttpSession session, StoreVO store, Model model) {
		System.out.println("상품 ID : " + store.getProduct_id());
		List<StoreVO> dbStore = service.selectStore(store.getProduct_id());
		System.out.println("상품 정보 : " + dbStore);
		model.addAttribute("store", dbStore);
		
		return "store/store_detail";
	}
	
	
	// 스토어 장바구니 클릭시 장바구니 데이터 판별후 DB작업용 매핑
	@GetMapping("storeCart") 
	public String storeCart(HttpSession session, Model model, MemberVO member, String product_id) {
		String sId = (String)session.getAttribute("sId");
		// 장바구니 담기를 위한 세션 아이디 판별
		// 세션 아이디가 없을 경우
		if(sId == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		
		// 멤버 VO 객체에 세션 아이디 저장
		
		
		// 장바구니에 저장된 데이터 즉, 나의 현재 장바구니 내역
		List<StoreVO> storeLsit = service.myStoreList(sId);
		
		System.out.println("카트리스트 : " + storeLsit);
		// 장바구니 비즈니스 로직(insert, update) 성공여부 확인을 위한 insertSuccess 변수 초기화
		System.out.println("사이즈 : " + storeLsit.size());
		
		// 장바구니 내역 유무 및 DB작업 판별을 위한 boolean 타입 변수 선언
		boolean isDuplicate = false;
		
		// 장바구니의 행 갯수가 하나라도 있는 경우
		// 장바구니안의 상품id 값을 비교 해서 isDuplicate = true
		if(storeLsit.size() > 0) {
			for(StoreVO item : storeLsit) {
				if(item.getProduct_id().equals(product_id)){
					isDuplicate = true;
				} 
			}
		}
		if (!isDuplicate) {
		    // 장바구니에 상품 추가
		    int cartDbSuccess = service.insertCart(sId, product_id);
		    if (cartDbSuccess > 0) {
		    	model.addAttribute("msg", "장바구니에 담았습니다 장바구니 페이지로 이동하시겠습니까?");
		    	model.addAttribute("targetURL", "storeCart2");
		        return "forward2";
		    } else {
		        model.addAttribute("msg", "잘못된 접근입니다");
		        return "forward2";
		    }
		} else {
		    // 장바구니 상품 업데이트
		    int cartDbSuccess = service.updateCart(sId, product_id);
		    service.totalPrice(sId, product_id);
		    if (cartDbSuccess > 0) {
		    	model.addAttribute("msg", "장바구니에 담았습니다 장바구니 페이지로 이동하시겠습니까?");
		    	model.addAttribute("targetURL", "storeCart2");
		        return "forward2";
		    } else {
		        model.addAttribute("msg", "잘못된 접근입니다");
		        return "forward2";
		    }
		}
	}
	
	// 나의 장바구니 리스트 페이지
	@GetMapping("storeCart2")
	public String storeCart2(HttpSession session, Model model) {
		
		String sId = (String)session.getAttribute("sId");
		
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		
		List<StoreVO> storeList = service.myStoreList(sId);
		
		// INSERT & UPDATE 처리 후 장바구니 내역 조회 후 입력
		List<CartVO> cartList = service.resultCartList(sId);
		
		// 나의 현재 장바구니 내역과, 상품 내역을 모두 담을 Map 객체 생성
//		Map<Object, Object> map = new HashMap<>();
		// 나의 현재 장바구니 내역과, 상품 내역 저장
//		map.put("myCartList1", cartList);
//		map.put("myCartList2", storeLsit);
		
		model.addAttribute("storeList", storeList);
		model.addAttribute("cartList", cartList);
		if(model.equals(null) ) {
			return "store/store_cart";
		} else if(model.equals("")) {
			return "store/store_cart";
		} else {
			return "store/store_cart";
		}
	}
	
	// 장바구니 내부 수량 변경 시 업데이트 처리 
	@PostMapping("cartQuanUpdate")
	@ResponseBody
	public List<CartVO> quanUpdate(HttpSession session, int product_count, String product_id, Model model) {
		String sId = (String)session.getAttribute("sId");
		service.updateQuan(sId, product_count, product_id);
		service.totalPrice(sId, product_id);
		List<CartVO> cartList = service.resultCartList(sId); 
		
		return cartList;
	}
		
	// 장바구니 내부 X 버튼 클릭 시 선택된 상품 삭제 처리
	@PostMapping("cartDelete")
	@ResponseBody
	public Model cartDelete(Model model, HttpSession session, String product_id) {
		String sId = (String)session.getAttribute("sId");
		int successDelete = service.cartDelete(sId, product_id);
//		int successDelete =  1;
		Map<Object, Object> map = new HashMap<Object, Object>();
		System.out.println("딜리트 호출2");
		System.out.println("딜리트 호출2");
		if(successDelete > 0) {
			List<CartVO> cartList = service.resultCartList(sId);
			List<StoreVO> storeLsit = service.myStoreList(sId);
			map.put("myCartList1", cartList);
			map.put("myCartList2", storeLsit);
			model.addAttribute("cartList", map);
			System.out.println("딜리트 호출3");
		} 
		return model;
	}
	
	
	@GetMapping("storePay")
	public String storePay(HttpSession session, Model model, StoreVO store, MemberVO member) {
		String sId = (String)session.getAttribute("sId");
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		member.setMember_id(sId);
		// Member name 과 phone 을 조회하기 위한 select 구문
		MemberVO members = service.selectMemberInfo(member);
		// 로그인 되어있는 phone 번호를 변수에 저장
		String phone = members.getMember_phone();
		// 휴대폰번호 가운데 "****" 처리
		members.setMember_phone(phone.split("-")[0] + "-****-" + phone.split("-")[2]);
		// Member 객체에 조회한 name 과 phone 을 저장
		model.addAttribute("members", members);
		
		// 하나의 문자열로 들어올경우 split 처리해서 배열로 나눠서 저장
		System.out.println(store.getProduct_id());
		System.out.println(store);
		
		
		List<StoreVO> storeList = service.selectStore(store.getProduct_id());
		List<CartVO> cartList = service.selectCart2(member);
		model.addAttribute("cartList", cartList);
		model.addAttribute("storeList", storeList);
		System.out.println("내 장바구니 카운트" + cartList);
		System.out.println("내 상품 정보" + storeList);
		
		
		
		return "store/store_pay";
	}
	
	
	@PostMapping("storePay2")
//	public String storePay2(HttpSession session, Model model,@RequestParam List<String> product_id, MemberVO member) {
	public String storePay2(HttpSession session, Model model,@RequestParam("product_id") String[] selectedProductIds, MemberVO member) {
		String sId = (String)session.getAttribute("sId");
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg","로그인이 필요합니다. 로그인 하시겠습니까?");
			model.addAttribute("targetURL", "memberLogin");
			return "forward2";
		}
		// ****************************************************************
		member.setMember_id(sId); 
		MemberVO members = service.selectMemberInfo(member);
		String phone = members.getMember_phone();
		// 휴대폰번호 가운데 "****" 처리
		members.setMember_phone(phone.split("-")[0] + "-****-" + phone.split("-")[2]);
		model.addAttribute("members", members);
		//******************************************************************
		List<StoreVO> storeList = new ArrayList<StoreVO>();
		for (String productId : selectedProductIds) {
			List<StoreVO> arrProductId = service.selectCart4(productId, sId);
			storeList.addAll(arrProductId);
		}
		model.addAttribute("storeList", storeList);
//		System.out.println("내 상품 정보는 뭐지? " + storeList);
		
		
		return "store/store_pay";
	}
	
}
