package com.itwillbs.c5d2308t1.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	// 이벤트 페이지 이동
	@GetMapping("event")
	public String event() {
		return "event/event_movie";
	}
	
	// 스토어 상세페이지 매핑
	@GetMapping("storeDetail")
	public String storeDetail(HttpSession session, String product_id, Model model, CartVO cart) {
//		System.out.println("상품명 : " + product_id);
		StoreVO store = service.selectStore(product_id); 
//		System.out.println("출력값 : " + store);
		
		model.addAttribute("store", store);
		
		model.addAttribute("product_id", store.getProduct_id());
		
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
		List<StoreVO> StoreList = service.myCartList(sId);
		
		System.out.println("카트리스트 : " + StoreList);
		// 장바구니 비즈니스 로직(insert, update) 성공여부 확인을 위한 insertSuccess 변수 초기화
		System.out.println("사이즈 : " + StoreList.size());
		
		// 장바구니 내역 유무 및 DB작업 판별을 위한 boolean 타입 변수 선언
		boolean isDuplicate = false;
		
		// 장바구니의 행 갯수가 하나라도 있는 경우
		// 장바구니안의 상품id 값을 비교 해서 isDuplicate = true
		if(StoreList.size() > 0) {
			for(StoreVO item : StoreList) {
				if(item.getProduct_id().equals(product_id)){
					isDuplicate = true;
				} 
			}
		}
		if (!isDuplicate) {
		    // 장바구니에 상품 추가
		    int cartDbSuccess = service.insertCart(sId, product_id);
		    if (cartDbSuccess > 0) {
		        return "redirect:/storeCart2";
		    } else {
		        model.addAttribute("msg", "잘못된 접근입니다");
		        return "forward2";
		    }
		} else {
		    // 장바구니 상품 업데이트
		    int cartDbSuccess = service.updateCart(sId, product_id);
		    if (cartDbSuccess > 0) {
		        return "redirect:/storeCart2";
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
		
		List<StoreVO> StoreList = service.myCartList(sId);
		
		// INSERT & UPDATE 처리 후 장바구니 내역 조회 후 입력
		List<CartVO> cartList = service.resultCartList(sId);
		
		// 나의 현재 장바구니 내역과, 상품 내역을 모두 담을 Map 객체 생성
		Map<Object, Object> myCartList = new HashMap<>();
		
		// 나의 현재 장바구니 내역과, 상품 내역 저장
		myCartList.put("myCartList1", cartList);
		myCartList.put("myCartList2", StoreList);
		
		model.addAttribute("cartList", myCartList);
		
		return "store/store_cart";
		
	}
	
	// 장바구니 내부 수량 변경 시 업데이트 처리 
	@PostMapping("cartQuanUpdate")
	@ResponseBody
	public List<CartVO> quanUpdate(HttpSession session, int product_count, String product_id) {
		System.out.println(product_count + ", " + product_id);
		
		String sId = (String)session.getAttribute("sId");
		
		int resultUpdate = service.updateQuan(sId, product_count, product_id);
		System.out.println("1");
		 
		int resultUpdate2 = service.totalPrice(sId, product_count, product_id);
		System.out.println("22222222222222222222222222222222222");
		System.out.println(sId);
		List<CartVO> cartList = service.resultCartList(sId); 
		System.out.println("3333333333333333333333333333333");
				
		System.out.println("리스트 : " + cartList);
		return cartList;
	}
		

	
	@GetMapping("storePay")
	public String storePay(HttpSession session, Model model, StoreVO store, String product_count, MemberVO member) {
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
		
		System.out.println("나는 누구 인가? : " + members);
//		System.out.println("스토어아이디: " + store);
		List<StoreVO> storeList = service.selectStore(store);
		// List<CartVO> storeList = service.selectStore(store);
			
		List<CartVO> cartList2 = service.selectCart2(member);
		
		model.addAttribute("cartList2", cartList2);
//		System.out.println(cartList2);
		
		// 결제 페이지에 상품수량(product_count) / 상품 금액을 조회해서 뿌려야댄다
		// 뭘 조회해서 뭘 뿌릴거임?
		
		// 1안
		// List 객체에 CartVO 하나더 정의해서 model객체에 저장 후
		// 두 List를 한번에 꺼내 쓰는건 어떨까???
		
		model.addAttribute("storeList", storeList);
		
		// 2안
		// quantity 변수를 사용해서 강제적으로 사용
//		model.addAttribute("storeList", quantity);
		
		return "store/store_pay";
	}
	
}
