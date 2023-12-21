package com.itwillbs.c5d2308t1.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.c5d2308t1.service.CsService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.PageInfo;

@Controller
public class CsController {
	
	// 의존성 주입받을 멤버변수 선언 시 @Autowired 어노테이션을 지정
	@Autowired
	private CsService service;
	
	
	// -------------  고객센터 메인 페이지 ----------------
	
	// 고객센터 메인 페이지로 이동
	// 메인페이지 하단에 자주묻는질문, 공지사항 미리보기 출력
	@GetMapping("csMain")
	public String csMain(CsVO cs, Model model) {
		
		// CsService - getFaqMainList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(faqMainList)
		List<CsVO> faqMainList = service.getFaqMainList();
		System.out.println(faqMainList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqMainList")
		model.addAttribute("faqMainList", faqMainList);
		
		
		// CsService - getNoticeMainList() 메서드 호출하여 공지사항 출력
		// => 파라미터 : 없음   리턴타입 : List<CsVO>(noticeMainList)
		List<CsVO> noticeMainList = service.getNoticeMainList();
		System.out.println(noticeMainList);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeMainList")
		model.addAttribute("noticeMainList", noticeMainList);
		
		
		return "cs/cs_main";
	}
		
	// 고객센터 자주묻는질문 페이지로 이동
	@GetMapping("csFaq")
	public String csFaq(CsVO cs, Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1") int pageNum) {
		// 자주묻는질문 버튼을 눌렀을 때 cs_type을 자주묻는질문으로 설정
		cs.setCs_type("자주묻는질문");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<HashMap<String, Object>> faqList = service.getCsList(cs, startRow, listLimit);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getCsTypeListCount(cs);
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + ((listCount % listLimit) > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, maxPage, pageListLimit, startPage, endPage);
		// ------------------------------------------------------
		// 글목록(List 객체)과 페이징정보(pageInfo 객체) 를 request 객체에 저장
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("faqList", faqList);
			
		return "cs/cs_FAQ";
	}
	
	
	// 고객센터 공지사항 페이지로 이동
	@GetMapping("csNotice")
	public String csNotice(CsVO cs, Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1") int pageNum) {
		// 공지사항 버튼을 눌렀을 때 cs_type을 공지사항으로 설정
		cs.setCs_type("공지사항");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<HashMap<String, Object>>(noticeList)
		List<HashMap<String, Object>> noticeList = service.getCsList(cs, startRow, listLimit);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getCsTypeListCount(cs);
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + ((listCount % listLimit) > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
			
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, maxPage, pageListLimit, startPage, endPage);
		// ------------------------------------------------------
		// 글목록(List 객체)과 페이징정보(pageInfo 객체) 를 request 객체에 저장
		model.addAttribute("pageInfo", pageInfo);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeList")
		model.addAttribute("noticeList", noticeList);
		System.out.println("noticeList : " +noticeList);
		return "cs/cs_notice";
	}
	
	// 자주묻는질문 항목별 모아보기 기능
	@ResponseBody
	@GetMapping("faqDetail")
	public List<CsVO> faqDetail(CsVO cs, Model model, HttpServletRequest request, String buttonName, @RequestParam(defaultValue = "1") int pageNum) {
		
		// 자주묻는질문 버튼을 눌렀을 때 cs_type을 자주묻는질문으로 설정
		cs.setCs_type("자주묻는질문");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// ======================================================
		int listCount = service.getFaqDetailCount(cs, buttonName);
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + ((listCount % listLimit) > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		System.out.println("listCount "+ listCount + "maxPage " + maxPage + "pageListLimit " + pageListLimit + "startPage " + startPage + "endPage " + endPage);
		
		// 계산된 페이징 처리 관련 값을 PageInfo 객체에 저장
		PageInfo pageInfo = new PageInfo(listCount, maxPage, pageListLimit, startPage, endPage);
		// ------------------------------------------------------
		
		// CsService - getFaqDetail() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : cs, buttonName, startRow, listLimit   리턴타입 : List<CsVO>(faqDetail)
		List<CsVO> faqDetail = service.getFaqDetail(cs, buttonName, startRow, listLimit);
		System.out.println(faqDetail);
		
		// 글목록(List 객체)과 페이징정보(pageInfo 객체) 를 request 객체에 저장
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("faqDetail", faqDetail);
		model.addAttribute("pageNum", pageNum);
		
		return faqDetail;			
		
	}
	
	// 자주묻는질문 검색 기능
	@ResponseBody
	@GetMapping("faqSearch")
	public List<CsVO> faqSearch(Model model, String searchValue) {
		// CsService - getFaqSearch() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : searchValue   리턴타입 : List<CsVO>(faqSearch)
		List<CsVO> faqSearch = service.getFaqSearch(searchValue);
		System.out.println(faqSearch);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "faqSearch")
		model.addAttribute("faqSearch", faqSearch);
		
		return faqSearch;			
	
	}

	// 공지사항 검색 기능
	@ResponseBody
	@GetMapping("noticeSearch")
	public List<HashMap<String, Object>> noticeSearch(Model model, String theater_id, String searchValue) {
		// CsService - getNoticeSearch() 메서드 호출하여 고객센터 검색하기
		// => 파라미터 : theater_id, searchValue   리턴타입 : List<HashMap<String, Object>>(noticeSearch)
		List<HashMap<String, Object>> noticeSearch = service.getNoticeSearch(theater_id, searchValue);
		System.out.println(noticeSearch);
		
		// 리턴받은 List 객체를 Model 객체에 저장(속성명 : "noticeSearch")
		model.addAttribute("noticeSearch", noticeSearch);
		
		return noticeSearch;			
		
	}
	
	// 고객센터 공지사항 상세 페이지로 이동
	@GetMapping("csNoticeDetail")
	public String csNoticeDetail(CsVO cs, Model model) {
		System.out.println("종류 : " + cs.getCs_type());
		System.out.println("글번호 : " + cs.getCs_type_list_num());
		
		HashMap<String, Object> csNoticeDetail = service.csNoticeDetail(cs);
		
		model.addAttribute("csNoticeDetail", csNoticeDetail);
		
		Integer maxCount = service.getCsTypeListCount(cs);
		model.addAttribute("maxCount", maxCount);
		
		return "cs/cs_notice_detail";
	}
	
	// 고객센터 1대1문의 페이지로 이동
	@GetMapping("csOneOnOneForm")
	public String csOneOnOneForm(Model model, HttpSession session) {
		// 세션 아이디 가져와서 저장하기
		String sId = (String)session.getAttribute("sId");
		
		// 세션 아이디가 존재하지 않을 경우(null)
		// 자바스크립트 사용하여 "잘못된 접근입니다!" 출력 후 메인페이지로 이동
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		model.addAttribute("sId", sId);
		
		return "cs/cs_OneOnOne";
	}
	
	// 고객센터 분실물문의 페이지로 이동
	@GetMapping("csLostForm")
	public String csLostForm(Model model, HttpSession session) {
		// 세션 아이디 가져와서 저장하기
		String sId = (String)session.getAttribute("sId");
		
		// 세션 아이디가 존재하지 않을 경우(null)
		// 자바스크립트 사용하여 "잘못된 접근입니다!" 출력 후 메인페이지로 이동
		if(sId == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		model.addAttribute("sId", sId);
		
		return "cs/cs_lost";
	}
	
	// 문의글 영화관 이름 전송
	@ResponseBody
	@GetMapping("getTheater")
	public List<HashMap<String, Object>> getTheater(Model model) {
		List<HashMap<String, Object>> theaterList = service.getTheaterList();
		return theaterList;
	}
	
	// 고객센터 1대1문의, 분실물문의 폼에 입력된 정보를 DB에 입력하고
	// 고객센터 메인 페이지로 이동
	@PostMapping("csBoardPro")
	public String csBoardPro(CsVO cs, Model model, HttpServletRequest request, HttpSession session) {
System.out.println(cs);
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인이 필요합니다");
			// targetURL 속성명으로 로그인 폼 페이지 서블릿 주소 저장
			model.addAttribute("targetURL", "MemberLoginForm");
			return "forward";
		}
		
		// --------------------------------------------------------
		// 파일업로드를 위한 준비
		// resources 디렉토리 내에 upload 파일 생성
		String uploadDir = "/resources/upload"; // 가상 디렉토리
		String saveDir = session.getServletContext().getRealPath(uploadDir); // 실제 디렉토리
		String subDir = "";
//		
		// 날짜별로 서브디렉토리 생성하기
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		subDir = now.format(dtf);
		
		saveDir += File.separator + subDir;
		
		// 해당 디렉토리가 존재하지 않을 때에만 자동생성
		try {
			Path path = Paths.get(saveDir); // 업로드 경로
			Files.createDirectories(path); // Path 객체
		} catch (IOException e) {
			e.printStackTrace();
		}
		
//		// MultipartFile 타입 객체 꺼내기
		MultipartFile mFile = cs.getMFile();
		
		// 파일명 중복을 방지하기 위해 난수 생성하기
		cs.setCs_file("");
		String fileName = UUID.randomUUID().toString() + "_" + mFile.getOriginalFilename();
		
		if(!mFile.getOriginalFilename().equals("")) {
			cs.setCs_file(subDir + "/" + fileName);
		}
		
		System.out.println("업로드 파일명 확인 : " + cs.getCs_file());
		
		
		// CsService - registMember() 메서드 호출하여 문의글 등록 요청
		// => 파라미터 : CsVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registBoard(cs);
		System.out.println(cs.getTheater_id());
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount > 0) {
			// 파일이 있을 경우에만 파일 생성
			try {
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "redirect:/SideMyboard";
			
		} else {			
			model.addAttribute("msg", "문의글 등록 실패!");
			return "fail_back";
		}

	}
	

}
