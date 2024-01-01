package com.itwillbs.c5d2308t1.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;
import com.itwillbs.c5d2308t1.service.AdminService;
import com.itwillbs.c5d2308t1.service.StoreService;
import com.itwillbs.c5d2308t1.vo.CsVO;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.MoviesVO;
import com.itwillbs.c5d2308t1.vo.PageCount;
import com.itwillbs.c5d2308t1.vo.PageDTO;
import com.itwillbs.c5d2308t1.vo.PageInfo;
import com.itwillbs.c5d2308t1.vo.PlayVO;
import com.itwillbs.c5d2308t1.vo.ReviewsVO;
import com.itwillbs.c5d2308t1.vo.StoreVO;
import com.itwillbs.c5d2308t1.vo.TheaterVO;

@Controller
public class AdminController {
	
	@Autowired
	AdminService service;
	
	@Autowired
	StoreService storeService;
	
	// =============== 2023.12.19 임은령 주석 ============================
	// 1. 자바스크립트 처리가 동일하여 서블릿 매핑을 모듈화 하였으나 사용하는 것이 적합하지않다고 판명되어 
	// 이전처럼 개별 서블릿 주소를 이용하는 방식으로 수정해야할 것 같습니다.
	// 기존에 만들어놓은 서블릿 이름은 아래에 있으므로 각 페이지 작업하실 때 매핑만 해주시면 됩니다.
	
	// 2. 공통되는 자바스크립트는
	// 1) 등록
	//	 	confirm() 등으로 "XXX를 등록하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	// 2) 수정
	//	 	confirm() 등으로 "XXX를 수정하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	// 3) 삭제
	//	 	confirm() 등으로 "XXX를 삭제하시겠습니까?" 모달창 띄운 후
	//	    비즈니스 로직 처리를 위한 서블릿으로 넘어가기
	//	    입니다. 지금 시점에서는 페이지별로 각자 작업하는 것이 효율적이라고 판단해 다시 수정하지 않았습니다.
	//	    번거롭지만 추가 부탁 드립니다. 
	// => XXX은 각 페이지 별 수행할 작업을 뜻합니다.
	//	  예시) 상영스케쥴 페이지의 경우 : "상영 일정을 등록하시겠습니까?"
	
	// 3. 기본적으로 post 방식으로 매핑해두었으나 각 페이지별로 작업하시다가 
	//	  적절한 방식으로 변경, 추가해주시면 됩니다
	
	// 4. 상영일정관리, 1대1문의 답변, 분실물 문의 답변, 영화 예매 팝업, 회원정보 상세
	//	  자주묻는질문 상세, 공지사항 상세 페이지 등은 하나의 폼에서 여러개의 서브밋을 사용하는데
	//	  따로 자료 링크를 보내드릴테니 참고해 작업하실 수 있을 것 같습니다
	
	//	  급하게 서블릿 매핑을 몇 번씩 갈아엎다보니 중복되거나 누락되는 부분이 많을 것으로 예상됩니다.
	//	  필요 시 코드는 편하게 수정하시면 됩니다. 협조 감사 드립니다.

	// ===========================================================================================
	// *********************** 영화관리 페이지 *************
	// 관리자페이지 영화 정보 관리 페이지로 이동
	@GetMapping("adminMovie")
	public String adminMovie(@RequestParam(defaultValue = "") String searchKeyword, 
						     @RequestParam(defaultValue = "1") int pageNum, 
						     MemberVO member, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = service.getMovieListCount(searchKeyword);
		System.out.println(listCount);
		// 페이징 처리
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// 한 페이지에 불러올 영화 목록 조회
		List<MoviesVO> movieList = service.getMovieList(searchKeyword, page);
		
		model.addAttribute("movieList", movieList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/admin_movie";
	}
	
	@GetMapping("adminMovieRgst")
	public String movieRgst(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "admin/admin_movie_regist";
	}
	
	
	// 관리자페이지 영화 정보 등록 페이지로 이동
	@GetMapping("adminMovieUdt")
	public String adminMovieUdt(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "admin/admin_movie_update";
	}
	
	//관리자페이지 영화검색 페이지로 이동
	@GetMapping("adminMovieSearch")
	public String adminMovieSearch(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "admin/admin_movie_search";
	}
	
	//영화검색 페이지에서 검색버튼 누를시 데이터 조회
	@PostMapping("adminMovieDetails")
	public String adminMovieDetails(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";		
		}
		return "admin/admin_movie_search";
	}	
	

	// DB에 등록된 영화 중복 판별 작업
	@ResponseBody
	@GetMapping("movieDupl")
	public String movieDupl(MoviesVO movie) {
		System.out.println(movie.getMovie_id());
		
		movie = service.getMovie(movie);
		
		if(movie != null) {
			return "true";
		} else {
			return "false";
		}
	}
	
	@PostMapping("movieRgst") // 영화 등록 팝업 : admin_movie_update.jsp
	public String movieRgst(@RequestParam Map<String, Object> map, Model model) {
		int insterCount = service.registMovie(map);
		
		if(insterCount > 0) {
			return "redirect:/adminMovie";
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 관리자페이지 영화 정보 수정 페이지로 이동
	@GetMapping("adminMovieMod")
	public String adminMovieMod(@RequestParam(defaultValue = "1") int pageNum, 
							MoviesVO movie, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		MoviesVO dbMovie = service.getMovie(movie);
		
		if(dbMovie != null) {
			model.addAttribute("movie", dbMovie);
			model.addAttribute("pageNum", pageNum);
			return "admin/admin_movie_modify";
		} else {
			model.addAttribute("msg", "없는 영화입니다!");
			return "fail_back";
		}
	}
	
	// 관리자페이지 영화 정보 삭제 
	@PostMapping("adminMovieDlt")
	public String adminMovieDlt(@RequestParam(defaultValue = "1") int pageNum, 
							MoviesVO movie, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		int deleteCount = service.deleteMovie(movie);
		
		if(deleteCount > 0) {
			model.addAttribute("pageNum", pageNum);
			return "redirect:/adminMovie";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다!");
			return "fail_back";
		}
	}
	
	@PostMapping("movieMod") // 영화 정보 수정 팝업 : admin_movie_modify.jsp
	public String movieMod(@RequestParam(defaultValue = "1") int pageNum, MoviesVO movie, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 영화 DB 수정
		int updateCount = service.modifyMovie(movie);
		
		if(updateCount > 0) {
			model.addAttribute("pageNum", pageNum);
			return "redirect:/adminMovie";
		} else {
			model.addAttribute("msg", "수정에 실패했습니다!");
			return "fail_back";
		}
	}

	
	
	// ===========================================================================================
	// ************************ 상영일정관리 페이지 *************
	// 1) 상영일정 메인 페이지
	// 상영 일정 메인 페이지로 이동(기본 조회 작업 포함)
	@GetMapping("adminMovieSchedule")
	public String adminMovieSchedule(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		List<Map<String, Object>> playList = service.getMainScheduleInfo();
		System.out.println("리스트가 갖고있는 것 : " + playList);
		model.addAttribute("playList", playList);
		
		return "admin/admin_movie_schedule";
	}
	
	//상영 일정 메인 페이지의 상영 일정 조회
	@ResponseBody
	@GetMapping("ScheduleSearch")
	public List<Map<String, Object>> ScheduleSearch(
			@RequestParam Map<String, String> map) {
//		System.out.println("파라미터로 받아온 theater_id : " + map.get("theater_id"));
//		System.out.println("파라미터로 받아온 play_date : " + map.get("play_date"));
		// System.out.println(theater_id);
		// System.out.println(play_date);
		List<Map<String, Object>> playList = service.getScheduleInfo(map);
		
		return playList;
	}


	// 2) 상영일정 관리 페이지
	// 관리자페이지 영화 상영 일정 관리 페이지로 이동(기본 조회 작업 포함)
	@GetMapping("movieScheduleMod")
	public String movieScheduleMod(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		List<HashMap<String, Object>> playRegistList = service.getPlayRegistList();
		
		System.out.println("반영이 됐는가4 : " + playRegistList);
		
		model.addAttribute("playRegistList", playRegistList);
		
		return "admin/admin_movie_schedule_modify";
	}
	
	// ajax 이용하여 선택된 지점에 따른 상영관 불러오기
	@ResponseBody
	@GetMapping("getRoom")
	public List<HashMap<String, Object>> roomList(@RequestParam String theater_id) {
		List<HashMap<String, Object>> roomList = service.getRoomList(theater_id);
		return roomList;
	}
	
	// ajax 이용하여 상영중인 영화 불러오기
	@ResponseBody
	@GetMapping("nowPlaying")
	public List<HashMap<String, Object>> playingList() {
		List<HashMap<String, Object>> playingList = service.getPlayingList();
		return playingList;
	}
	
	// ajax 이용하여 선택한 영화 정보 불러오기
	@ResponseBody
	@GetMapping("getMovieInfo")
	public HashMap<String, Object> movieInfo(@RequestParam String movie_id) {
		HashMap<String, Object> movieInfo = service.getMovieInfo(movie_id);
		return movieInfo;
	}
	
	// 상영 일정 등록하기
	@PostMapping("registPlay")
	public String registPlay(PlayVO play, HttpSession session, Model model, @RequestParam String play_date) {
		// 관리자가 아니면 등록을 하지 못하도록 하기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		int insertCount = service.registPlay(play);
		
		if(insertCount > 0) { // 성공 시
			return "redirect:/movieScheduleMod";
			
		} else { // 실패 시
			model.addAttribute("msg", "상영 일정 등록에 실패했습니다!");
			return "fail_back";
			
		}
		
	}
	
	// 상영일정 삭제하기
	@PostMapping("deletePlay")
	public String deletePlay(HttpSession session, Model model, @RequestParam int play_id) {
		System.out.println("파라미터로 받아온 상영코드 : " + play_id);
		// 관리자가 아니면 삭제 하지 못하도록 하기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		int deleteCount = service.removePlay(play_id);
		
		if(deleteCount == 0) {
			model.addAttribute("msg", "상영 일정 삭제에 실패했습니다!");
			return "fail_back";
		} else {
			return "redirect:/movieScheduleMod";
		}
	}
	
	// 상영일정 수정하기
//	@ResponseBody
//	@PostMapping("modifyPlay")
//	public String modifyPlay(@RequestParam Map<String, String> formData, Model model) {
//		System.out.println("넘어온 전체 파라미터 확인: " + formData);
//		System.out.println("play_id 출력 : " + formData.get("play_id"));
//		System.out.println("theater_id 출력 : " + formData.get("theater_id"));
//		System.out.println("room_id 출력 : " + formData.get("room_id"));
//		System.out.println("movie_title 출력 : " + formData.get("movie_title"));
//		System.out.println("play_date2 출력 : " + formData.get("play_date2"));
//		System.out.println("play_start_time2 출력 : " + formData.get("play_start_time2"));
//		System.out.println("play_end_time2 출력 : " + formData.get("play_end_time2"));
//
//        
//        int updateCount = service.modifySchedule(formData);
//        if(updateCount == 0) {
//        	model.addAttribute("msg", "상영 일정 수정에 실패했습니다!");
//        	return "fail_back";
//        	System.out.println("상영일정 수정 실패");
//        	return "";
//        } else {
//        	model.addAttribute("formData", formData);
//        	return "formData";
//        }
//
//	}
	
	
	
	
	// ===========================================================================================
	// ******************** 영화 예매 관리 페이지 *************
	// 관리자페이지 영화 예매 관리 페이지로 이동
	@GetMapping("adminMovieBooking")
	public String adminMovieBooking() {
		return "admin/admin_movie_booking";
	}

	// 관리자페이지 영화 예매 정보 상세 조회 및 수정/삭제 페이지로 이동
	@GetMapping("adminMovieBookingMod")
	public String adminMovieBookingMod() {
		return "admin/admin_movie_booking_modify";
	}
	
	@PostMapping("movieBooking") // 영화 예매 팝업(수정/삭제) : admin_movie_booking_modify.jsp
	public String movieBooking() {
		return "";
	}

	
	// ===========================================================================================
	// ******************** 스토어 결제 관리 페이지 *************
	// 관리자페이지 스토어 상품 관리 페이지로 이동
	@GetMapping("adminProduct")
	public String adminProduct(HttpSession session, Model model, 
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "") String searchType,
			@RequestParam(defaultValue = "") String searchKeyword) {
		
		// 관리자가 아니면 등록을 하지 못하도록 하기
		String sId = (String)session.getAttribute("sId");
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = storeService.getProductListCount(searchKeyword);
		// 페이징 처리
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// 모든 상품 조회
		List<StoreVO> storeList = storeService.getStoreList(searchType, searchKeyword, page);
		
		model.addAttribute("storeList", storeList);
		model.addAttribute("pageInfo", pageInfo);

		return "admin/admin_product";
	}
	
	// 관리자 페이지 스토어상품 등록 페이지로 이동
	@GetMapping("adminProductWrite")
	public String adminProductInsert(HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		return "admin/admin_product_write";
	}
	
	// 스토어 상품 등록시 상품 코드 비교
	@ResponseBody
	@GetMapping("productDupl")
	public String productDupl(StoreVO store, Model model) {
		
		System.out.println("상품 아이디 " + store);
		store = storeService.adminProductSelect(store);
		
		if(store != null) {
			return "true";
		} else {
			return "false";
		}
	}
	
	// 관리자페이지 스토어상품 관리 상품 등록
	@PostMapping("adminProductInsert")
	public String productInsert(HttpSession session, StoreVO store, Model model) {
		
		String uploadDir = "/resources/upload"; // 가상의 경로 지정(이클립스 프로젝트 상에 생성한 경로)
		String saveDir = session.getServletContext().getRealPath(uploadDir); // 세션도 가능(마침 request 객체 호출해서 사용했음)
		String subDir = "";
		LocalDate now = LocalDate.now();
		System.out.println(now); // 2023-12-19 
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		subDir = now.format(dtf);
		saveDir += File.separator + subDir; // File.separator 대신 \ 또는 / 지정도 가능
		try {
			Path path = Paths.get(saveDir); // 파라미터로 업로드 경로 전달
			Files.createDirectories(path); // 파라미터로 Path 객체 전달
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile imgFile = store.getImgFile();
		System.out.println("원본파일명1 : " + imgFile.getOriginalFilename());
		
		store.setProduct_img("");
		
		String fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + imgFile.getOriginalFilename();
		if(!imgFile.getOriginalFilename().equals("")) store.setProduct_img(subDir + "/" + fileName1);
		System.out.println("실제 업로드 파일명1 : " + store.getProduct_img()); // ba278eaa_1.jpg
		
		int insertCount = storeService.productInsert(store);
		
		if(insertCount > 0) {
			try {
				// 업로드 된 파일들은 MultipartFile 객체에 의해 임시 디렉토리에 저장되며
				// 글쓰기 작업 성공 시 임시 디렉토리 -> 실제 디렉토리 이동 작업 필요
				// => MultipartFile 객체의 transferTo() 메서드를 호출하여 실제 위치로 이동(=업로드)
				// => 파일이 선택되지 않은 경우(파일명이 널스트링) 이동이 불가능(예외 발생)하므로 제외
				// => transfetTo() 메서드 파라미터로 java.io.File 타입 객체 전달
				
				if(!imgFile.getOriginalFilename().equals("")) imgFile.transferTo(new File(saveDir, fileName1));
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
				
				
				// 글목록(BoardList) 서블릿 리다이렉트
				return "redirect:/adminProduct";
			} else {
				// "글쓰기 실패!" 메세지 처리(fail_back)
				model.addAttribute("msg", "글쓰기 실패!");
				return "fail_back";
			}
	}
	
	// 관리자페이지 스토어 상품관리 상품 상세페이지로 이동
	@GetMapping("adminProductDtl")
	public String adminProductDtl(HttpSession session, Model model, StoreVO store) {
		
		// 관리자 페이지 상품 조회를 위한 SELECT
		StoreVO product = storeService.getStore(store.getProduct_id());
		
		model.addAttribute("product", product);
		return "admin/admin_product_detail";
	}
	
	// 관리자 페이지 상품 상세페이지 싱픔 정보 삭제
	@GetMapping("adminProductDel")
	public String adminProductDel(HttpSession session, Model model, StoreVO store
			, @RequestParam(defaultValue = "1") String pageNum) {
		System.out.println("상품 : " + store.getProduct_id());
		String sId = (String)session.getAttribute("sId");
		if(!sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		StoreVO product = storeService.getStore(store.getProduct_id());
		
		int resultDel = storeService.adminProductDel(store); 
//		int resultDel = 1; 
		if(resultDel > 0) {
			try {
				// [ 서버에서 파일 삭제 ]
				// 실제 업로드 경로 알아내기
				String uploadDir = "/resources/upload"; // 가상의 경로(이클립스 프로젝트 상에 생성한 경로)
				String saveDir = session.getServletContext().getRealPath(uploadDir);
				String fileName = product.getProduct_img();
				
				if(!fileName.equals("")) {
					Path path = Paths.get(saveDir + "/" + fileName);
					Files.deleteIfExists(path);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			return "redirect:/adminProduct?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
	}
	
	@ResponseBody
	@PostMapping("ProductDeleteFile")
	public String deleteFile(StoreVO store, HttpSession session) {
//		System.out.println(board.getBoard_num() + ", " + board.getBoard_file1());
		
		// BoardService - removeBoardFile() 메서드 호출하여 지정된 파일명 삭제 요청
		// => 파라미터 : BoardVO 객체   리턴타입 : int(removeCount)
		int removeCount = storeService.removeProductImg(store);
//		System.out.println(removeCount);
		try {
			if(removeCount > 0) { // 레코드의 파일명 삭제(수정) 성공 시
				// 서버에 업로드 된 실제 파일 삭제
				String uploadDir = "/resources/upload"; // 가상의 경로(이클립스 프로젝트 상에 생성한 경로)
				String saveDir = session.getServletContext().getRealPath(uploadDir);
				
				// 파일명이 널스트링이 아닐 경우에만 삭제 작업 수행
				if(!store.getProduct_img().equals("")) {
					Path path = Paths.get(saveDir + "/" + store.getProduct_img());
					Files.deleteIfExists(path);
					// 예외가 발생하지 않을 경우 정상적으로 파일 삭제가 완료되었으므로 "true" 리턴
					return "true";
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		// DB 파일명 삭제 실패 또는 서버 업로드 파일 삭제 실패 등의 문제 발생 시 "false" 리턴
		return "false";
	}
	
	// 관리자 페이지 상품 상세페이지 싱픔 정보 수정
	@PostMapping("adminProductReply")
	public String adminProductReply(StoreVO store, HttpSession session, Model model) {
		
		String uploadDir = "/resources/upload"; // 가상의 경로 지정(이클립스 프로젝트 상에 생성한 경로)
		String saveDir = session.getServletContext().getRealPath(uploadDir); // 세션도 가능(마침 request 객체 호출해서 사용했음)
		String subDir = "";
		LocalDate now = LocalDate.now();
		System.out.println(now); // 2023-12-19 
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		subDir = now.format(dtf);
		saveDir += File.separator + subDir; // File.separator 대신 \ 또는 / 지정도 가능
		
		try {
			Path path = Paths.get(saveDir); // 파라미터로 업로드 경로 전달
			Files.createDirectories(path); // 파라미터로 Path 객체 전달
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile imgFile = store.getImgFile();
		
		store.setProduct_img("");
		
		System.out.println("22222222222222222222222222222222222222222222222222222222222222222222");
		String fileName = UUID.randomUUID().toString().substring(0, 8) + "_" + imgFile.getOriginalFilename();
		if(!imgFile.getOriginalFilename().equals("")) store.setProduct_img(subDir + "/" + fileName);
		
		System.out.println("33333333333333333333333333333333333333333333333333333333333333333333333333333");
		int updateCount = storeService.productReply(store);
		
		System.out.println("4444444444444444444444444444444444444444444444444444444444444");
		if(updateCount > 0) {
			try {
				if(!imgFile.getOriginalFilename().equals("")) {
					imgFile.transferTo(new File(saveDir, fileName));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
			// 글목록(BoardList) 서블릿 리다이렉트
			return "redirect:/adminProduct";
		} else {
			// "답글 쓰기 실패!" 메세지 처리(fail_back)
			model.addAttribute("msg", "답글 쓰기 실패!");
			return "fail_back";
		}
	}
	
	
	// 관리자페이지 스토어결제 관리 페이지로 이동
	@GetMapping("adminPayment")
	public String adminPayment() {
		return "admin/admin_payment";
	}
	
	// 관리자페이지 스토어 결제 상세 조회 및 취소 페이지로 이동
	@GetMapping("adminPaymentDtl")
	public String adminPaymentDtl() {
		return "admin/admin_payment_detail";
	}
	
	
	
	
	// ===========================================================================================
	// ******************** 회원 정보 관리 페이지 *************
	// 관리자페이지 회원정보 관리 페이지로 이동
	@GetMapping("adminMember")
	public String adminMember(@RequestParam(defaultValue = "") String searchType,
							  @RequestParam(defaultValue = "") String searchKeyword, 
							  @RequestParam(defaultValue = "1") int pageNum, 
							  MemberVO member, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = service.getMemberListCount(searchType, searchKeyword);
		// 페이징 처리
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// 한 페이지에 표시할 회원 목록 조회
		List<MemberVO> memberList = service.getMemberList(searchType, searchKeyword, page);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_member";
	}
	
//	@PostMapping("memberDlt") // 회원 정보 관리 메인(탈퇴, 비회원) : admin_member.jsp
//	public String memberDlt() {
//		return "";
//	}
	
	// 관리자페이지 회원정보 상세 조회 및 수정/삭제 페이지로 이동
	@GetMapping("adminMemberMod")
	public String adminMemberMod(MemberVO member, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		if(!sId.equals("admin") || sId.equals("admin") && (member.getMember_id() == null || member.getMember_id().equals(""))) {
			member.setMember_id(sId);
		}
		
		MemberVO dbMember = service.getMember(member); 
//		// input[type=date] 입력을 위한 처리
//		dbMember.setMember_birth(dbMember.getMember_birth().replace(".", "-"));
		
		model.addAttribute("member", dbMember);
		
		return "admin/admin_member_modify";
	}
	// 관리자페이지 회원정보 수정/ 삭제 작업
	@PostMapping("memberModOrDlt") // 회원정보 상세(회원) : admin_member_modify.jsp
	public String memberModOrDlt(@RequestParam(defaultValue = "1") int pageNum, MemberVO member, String newPasswd, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		if(sId.equals("admin") && (member.getMember_id() == null || member.getMember_id().equals(""))) {
			member.setMember_id(sId);
		}
		
		// 새 비밀번호가 있을 경우 암호화 처리
		BCryptPasswordEncoder passwoedEncoder = new BCryptPasswordEncoder();
		if(newPasswd != null && !newPasswd.equals("")) {
			newPasswd = passwoedEncoder.encode(newPasswd);
		}
		// 회원 정보 수정 및 탈퇴 작업
		int updateCount = service.memberModOrDlt(member, newPasswd);
		
		if(updateCount > 0) {
			return "redirect:/adminMember?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "수정에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 회원정보 수정 시 DB의 정보와 일치하는지 여부 판별
	// 기존 비밀번호와 새 비밀번호가 일치하는지 확인
	@ResponseBody
	@GetMapping("passwdCheck")
	public String passwdCheck(String member_passwd, String newPasswd) {
		System.out.println(member_passwd);
		System.out.println("새 비밀번호 : " + newPasswd);
		
//	    MemberVO dbMember = service.getMember(member);

	    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
	    
	    if(passwordEncoder.matches(newPasswd, member_passwd)) {
	    	return "true";
	    } else {
	    	return "false";
	    }
		
	}
	
	// ===========================================================================================
	// ****************** 자주 묻는 질문 관리 페이지 *************
	// 관리자페이지 자주묻는질문 관리 페이지로 이동
	@GetMapping("adminFaq")
	public String adminFaq(CsVO cs, Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1") int pageNum, HttpSession session,
			@RequestParam(defaultValue = "") String searchValue) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 자주묻는질문 버튼을 눌렀을 때 cs_type을 자주묻는질문으로 설정
		cs.setCs_type("자주묻는질문");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 자주 묻는 질문 출력
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<HashMap<String, Object>> faqList = service.getFaqList(cs, startRow, listLimit, searchValue);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getFaqListCount(cs, searchValue);
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
		model.addAttribute("pageNum", pageNum);
		
		return "admin/admin_board_faq";
	}

	// 관리자페이지 자주묻는질문 글쓰기 페이지로 이동
	@GetMapping("adminFaqWriteForm")
	public String adminFaqWriteForm(HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		return "admin/admin_board_faq_write";
	}

	// 관리자페이지 자주묻는질문 글 등록하기
	@PostMapping("adminFaqWritePro") // 자주묻는 질문 글쓰기 : admin_board_faq_write.jsp
	public String boardFaqWritePro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		int insertCount = service.registBoard(cs);

		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount > 0) {
			
			return "redirect:/adminFaq";
			
		} else {			
			model.addAttribute("msg", "자주묻는질문 등록 실패!");
			return "fail_back";
		}
				
	}

	
	// 관리자페이지 자주묻는질문 상세 조회 페이지로 이동
	@GetMapping("adminFaqView")
	public String adminFaqView(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}

		HashMap<String, Object> faqDetail = service.boardfaqDetailPage(cs);
		System.out.println(faqDetail);
		model.addAttribute("faqDetail", faqDetail);
		
		return "admin/admin_board_faq_view";
	}
	
	@PostMapping("adminFaqModifyForm") // 자주 묻는 질문 수정 : admin_board_faq_write.jsp 재사용
	public String adminFaqModifyForm(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// DB에 등록되어있는 값 가져오기
		HashMap<String, Object> faqDetail = service.boardfaqDetailPage(cs);
		System.out.println(faqDetail);
		model.addAttribute("faqDetail", faqDetail);	
		
		return "admin/admin_board_faq_modify";
	}
	
	// 관리자페이지 자주묻는질문 글 수정하기
	@PostMapping("adminFaqModifyPro") // 자주묻는 질문 글쓰기 : admin_board_faq_write.jsp
	public String boardFaqModifyPro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// AdminService - registBoard() 메서드 호출하여 문의글 수정 요청
		int updateCount = service.updateBoard(cs);
		System.out.println("updateCount :" + updateCount);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(updateCount > 0) {
			
			return "redirect:/adminFaq";
			
		} else {			
			model.addAttribute("msg", "자주묻는질문 수정 실패!");
			return "fail_back";
		}
			
	}
	
	
	@GetMapping("adminFaqDelete")
	public String adminFaqDelete(CsVO cs, @RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		HashMap<String, Object> board = service.boardfaqDetailPage(cs);
		
		int deleteCount = service.removeBoard(board);
		
		if(deleteCount > 0) { // 삭제 성공
			
			return "redirect:/adminNotice?pageNum=" + pageNum;
			
		} else { // 삭제 실패
			// "글 삭제 실패!" 메세지 처리
			model.addAttribute("msg", "글 삭제 실패!");
			return "fail_back";
		}

	}

	// ===========================================================================================
	// ********************** 공지사항 관리 페이지 *************
	// 관리자페이지 공지사항 관리 페이지로 이동
	@GetMapping("adminNotice")
	public String adminNotice(CsVO cs, Model model, HttpServletRequest request,
			@RequestParam(defaultValue = "1") int pageNum, HttpSession session,
			@RequestParam(defaultValue = "") String searchValue) {
		
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// 공지사항 버튼을 눌렀을 때 cs_type을 자주묻는질문으로 설정
		cs.setCs_type("공지사항");
		
		// 한 페이지에서 표시할 글 목록 갯수 지정 (테스트)
		int listLimit = 5;
		
		// 조회 시작 행번호
		int startRow = (pageNum - 1) * listLimit;
		
		// CsService - getFaqList() 메서드 호출하여 공지사항 출력(재사용)
		// => 파라미터 : 시작행번호, 목록갯수   리턴타입 : List<CsVO>(noticeList)
		List<HashMap<String, Object>> NoticeList = service.getNoticeList(cs, startRow, listLimit, searchValue);
	//	System.out.println(noticeList);
		
		// ======================================================
		int listCount = service.getNoticeListCount(cs, searchValue);
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
		model.addAttribute("NoticeList", NoticeList);
		model.addAttribute("pageNum", pageNum);
		System.out.println(NoticeList);
		
		return "admin/admin_board_notice";
	}

	// 관리자페이지 공지사항 글등록 페이지로 이동
	@GetMapping("adminNoticeWriteForm")
	public String adminNoticeWriteForm(HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		return "admin/admin_board_notice_write";
	}

	@PostMapping("adminNoticeWritePro") // 공지사항 글쓰기 : admin_board_notice_write.jsp
	public String adminNoticeWritePro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// CsService - registBoard() 메서드 호출하여 문의글 등록 요청
		// => 파라미터 : CsVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registBoard(cs);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount > 0) {
			return "redirect:/adminNotice";
			
		} else {			
			model.addAttribute("msg", "공지사항 등록 실패!");
			return "fail_back";
		}
			
		
	}

	// 관리자페이지 공지사항 상세 조회 페이지로 이동
	@GetMapping("adminNoticeView")
	public String adminNoticeView(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}

		HashMap<String, Object> noticeDetail = service.boardNoticeDetailPage(cs);
		System.out.println(noticeDetail);
		model.addAttribute("noticeDetail", noticeDetail);
				

		return "admin/admin_board_notice_view";
	}
	
	// 공지사항 수정
	@PostMapping("adminNoticeModifyForm")
	public String adminNoticeModifyForm(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// DB에 등록되어있는 값 가져오기
		HashMap<String, Object> noticeDetail = service.boardNoticeDetailPage(cs);
		System.out.println(noticeDetail);
		model.addAttribute("noticeDetail", noticeDetail);	
		
		return "admin/admin_board_notice_modify";
	}
	
	
	@PostMapping("adminNoticeModifyPro") // 공지사항 글쓰기 : admin_board_notice_write.jsp
	public String adminNoticeModifyPro(CsVO cs, HttpSession session, Model model) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}

		int updateCount = service.updateBoard(cs);
		System.out.println("updateCount :" + updateCount);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(updateCount > 0) {
			return "redirect:/adminNotice";
				
		} else {			
			model.addAttribute("msg", "공지사항 수정 실패!");
			return "fail_back";
		}
	}
	
	@GetMapping("adminNoticeDelete")
	public String adminNoticeDelete(CsVO cs, @RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		// 세션아이디 판별하여 관리자(admin)가 아니면 접근을 막기
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		HashMap<String, Object> board = service.boardfaqDetailPage(cs);
		
		int deleteCount = service.removeBoard(board);
		
		if(deleteCount > 0) { // 삭제 성공
			return "redirect:/adminNotice?pageNum=" + pageNum;
			
		} else { // 삭제 실패
			// "글 삭제 실패!" 메세지 처리
			model.addAttribute("msg", "글 삭제 실패!");
			return "fail_back";
		}

	}
	
	// ===========================================================================================
	// *********************** 1대1문의 관리 페이지 *************
	// 관리자페이지 1대1문의 관리 페이지로 이동
	@GetMapping("adminOneOnOne")
	public String adminOneOnOne(@RequestParam(defaultValue = "1") int pageNum, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		
		// AdminService - getOneOnOneListCount() 메서드 호출해 전체 게시글 개수 조회
		// => 파라미터 : 없음	 리턴타입 : int
		int listCount = service.getOneOnOneListCount();

		// PageDTO 객체와 게시글 갯수, 페이지 번호 갯수를 파라미터로 전달
		PageCount pageInfo = new PageCount(page, listCount, 3);
		
		// AdminService - getOneOnOnePosts() 메서드 호출해 글 목록 조회
		// => 파라미터 : PageDTO 객체(page)	 리턴타입 : List<CsVO>(oneOnOneList)
		List<CsVO> oneOnOneList = service.getOneOnOnePosts(page);
		
		
		System.out.println(oneOnOneList);
		
		// Model 객체에 저장
		model.addAttribute("oneOnOneList", oneOnOneList);
		model.addAttribute("sId", sId);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_board_one_on_one";
	}

	// 관리자페이지 1대1문의 상세 조회 페이지로 이동
	@GetMapping("OneOnOneDetail")
	public String OneOnOneDetail(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
//		// AdminService - getOneOnOnePostById() 메서드 호출해 해당 글 조회
//		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : Map<String, Object> (oneOnOne)
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		
		System.out.println(oneOnOne);
		
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
		
		return "admin/admin_board_one_on_one_detail";
	}
	
	// 관리자페이지 1대1문의 등록 페이지로 이동
	@GetMapping("OneOnOneMoveToRegister")
	public String OneOnOneRsp(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
//		// AdminService - getOneOnOnePostById() 메서드 호출해 글 목록 조회
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
		
		return "admin/admin_board_one_on_one_response";
	}
	
	
	
	// 관리자 페이지 1대1문의 답변 등록
	@PostMapping("OneOnOneResponse") 
	public String OneOnOneResponse(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "1") int cs_id, CsVO cs) {
//		System.out.println(cs);
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		// AdminService - writeOneOnOneReply() 메서드 호출해 답변 등록
		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : int(updateCount)
		int updateCount = service.writeOneOnOneReply(cs);
		
		if(updateCount > 0) { // 등록 성공
			model.addAttribute("pageNum", pageNum);
			// 답변 등록 완료 후 해당 글이 속해있는 1대1문의 관리페이지로 이동해 버튼으로 답변 상태 확인
			return "redirect:/OneOnOneDetail?cs_id=" + cs_id + "&pageNum=" + pageNum;
			
		} else { // 등록 실패
			model.addAttribute("msg", "1대1 답변 등록 실패!");
			return "fail_back";
		}
		
	}
	
	// 관리자페이지 1대1문의 기존 답변 수정페이지로 이동
	@PostMapping("OneonOneMoveToModify")
	public String OneonOneMoveToModify(HttpSession session, Model model, CsVO cs) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
//		// AdminService - getOneOnOnePostById() 메서드 호출해 해당 글 조회
//		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : Map<String, Object> (oneOnOne)
		Map<String, Object> oneOnOne = service.getOneOnOnePostById(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)oneOnOne.get("cs_date");
		oneOnOne.put("cs_date", date.format(dtf));
		// Model 객체에 저장
		model.addAttribute("oneOnOne", oneOnOne);
				
		
		return "admin/admin_board_one_on_one_response";
	}
	
	// 관리자 페이지 1대1문의 기존 답변 수정
	@PostMapping("OneOnOneModify")
	public String OneOnOneModify(HttpSession session, Model model, CsVO cs, @RequestParam(defaultValue = "1") int pageNum, @RequestParam(defaultValue = "1") int cs_id) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		System.out.println(cs_id);
		System.out.println(pageNum);
		
		// AdminService - writeOneOnOneReply() 메서드 호출해 등록된 답변 수정
		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : int(updateCount)
		int updateCount = service.writeOneOnOneReply(cs);
		
		if(updateCount > 0) { // 등록 성공
			model.addAttribute("pageNum", pageNum);
			model.addAttribute("cs_id", cs_id);
			// 답변 등록 완료 후 해당 글이 속해있는 1대1문의 관리페이지로 이동해 버튼으로 답변 상태 확인
			return "redirect:/OneOnOneDetail?cs_id="+ cs_id +"&pageNum=" + pageNum;
			
		} else { // 등록 실패
			model.addAttribute("msg", "1대1 답변 등록 실패!");
			return "fail_back";
		}
		
	}
	
	// 관리자 페이지 1대1문의 답변 삭제
	@PostMapping("OneOnOneDelete")
	public String OneOnOneDelete(HttpSession session, Model model, CsVO cs, @RequestParam(defaultValue = "1") int pageNum) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "memberLogin");
			return "forward";
		}
		
		// AdminService - removeOneOnOneReply() 메서드 호출해 등록된 답변 삭제
		// => 파라미터 : CsVO 객체(cs)	 리턴타입 : int(deleteCount)
		int deleteCount = service.removeOneOnOneReply(cs);
		
		if(deleteCount == 0 ) {
			model.addAttribute("msg", "1대1 답변 삭제 실패!");
			return "fail_back";
		} else {
			model.addAttribute("pageNum", pageNum);
			return "redirect:/adminOneOnOne?pageNum=" + pageNum; 
		}
		
	}
	
	// ===========================================================================================
	// ********************* 분실물 문의 관리 페이지 *************
	// 관리자페이지 분실물 문의 관리 페이지로 이동
	// 파라미터로 pageNum을 넘겨주고 파라미터가 없을 경우 기본값으로 1을 넘겨줍니다.
	@GetMapping("adminLostNFound")
	public String adminLostNFound(@RequestParam(defaultValue = "1") int pageNum,@RequestParam(defaultValue = "") String searchValue, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 페이지 번호와 글의 개수를 파라미터로 전달
		PageDTO page = new PageDTO(pageNum, 5);
		// 전체 게시글 갯수 조회
		int listCount = service.getlostnfoundListCount(searchValue);
		// PageDTO 객체와 게시글 갯수, 페이지 번호 갯수를 파라미터로 전달
		PageCount pageInfo = new PageCount(page, listCount, 3);
		// page 객체를 파라미터로 글 목록 조회(극장명이 포함되어 HashMap 객체로 저장)
		List<HashMap<String, Object>> lostnfoundList = service.getLostnfoundList(page, searchValue);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		for(HashMap<String, Object> map : lostnfoundList) {
			// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
			LocalDateTime date = (LocalDateTime)map.get("cs_date");
			map.put("cs_date", date.format(dtf));
		}
		// 모델 객체에 담아서 전송
		model.addAttribute("lostnfoundList", lostnfoundList);
		model.addAttribute("sId", sId);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_board_lostnfound";
	}
	

	// 관리자페이지 분실물 문의 등록 페이지로 이동
	@GetMapping("LostNFoundMoveToRegister")
	public String lostNFoundResp(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// cs_id가 저장된 cs 객체 전달하여 게시글 가져오기(극장명이 포함되어 HashMap 객체로 저장)
		Map<String, Object> lostnfound = service.getlostnfound(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)lostnfound.get("cs_date");
		lostnfound.put("cs_date", date.format(dtf));
		model.addAttribute("lostnfound", lostnfound);
		
		return "admin/admin_board_lostnfound_response";
	}
	
	// 분실물 문의 답변 등록
	@PostMapping("LostNFoundResponse") // 분실물문의 답변 등록 : admin_board_lostnfound_response.jsp
	public String lostnFoundResponse(@RequestParam(defaultValue = "1") int pageNum, CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 등록 작업
		int updateCount = service.LostnfoundReply(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// 관리자페이지 분실물 문의 상세 조회 페이지로 이동
	@GetMapping("LostNFoundDetail")
	public String lostNFoundDetail(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		// cs_id가 저장된 cs 객체 전달하여 게시글 가져오기(극장명이 포함되어 HashMap 객체로 저장)
		Map<String, Object> lostnfound = service.getlostnfound(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)lostnfound.get("cs_date");
		lostnfound.put("cs_date", date.format(dtf));
		model.addAttribute("lostnfound", lostnfound);
		
		return "admin/admin_board_lostnfound_detail";
	}
	
	// 관리자페이지 분실물 문의 기존 답변 수정 페이지로 이동
	@PostMapping("LostNFoundMoveToModify")
	public String lostNFoundMoveToModify(CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// cs_id가 저장된 cs 객체 전달하여 게시글 가져오기(극장명이 포함되어 HashMap 객체로 저장)
		Map<String, Object> lostnfound = service.getlostnfound(cs);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		// map으로 받아온 cs_date는 datetime 컬럼이기에 LocalDateTime 타입으로 가져온다.
		LocalDateTime date = (LocalDateTime)lostnfound.get("cs_date");
		lostnfound.put("cs_date", date.format(dtf));
		model.addAttribute("lostnfound", lostnfound);
		
		return "admin/admin_board_lostnfound_response";
	}
	
	// 관리자페이지 분실물 문의 기존 답볍 수정 
	@PostMapping("LostNFoundModify")
	public String lostnFoundModify(@RequestParam(defaultValue = "1") int pageNum, CsVO cs, HttpSession session, Model model) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 등록 작업
		int updateCount = service.LostnfoundReply(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "등록에 실패했습니다!");
			return "fail_back";
		}
	}

	// 분실물 문의 답변 삭제
	@PostMapping("LostNFoundDelete") // 분실문 문의 답변삭제 : admin_board_lostnfound.jsp
	public String lostNFoundDelete(@RequestParam(defaultValue = "1") int pageNum, CsVO cs, HttpSession session, Model model) {
		System.out.println("넘어온 정보" + cs);
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		// 분실물 문의 답변 삭제 작업 요청
		int updateCount = service.lostnfoundDlt(cs);
		
		if(updateCount > 0) {
			return "redirect:/adminLostNFound?pageNum=" + pageNum;
		} else {
			model.addAttribute("msg", "삭제에 실패했습니다!");
			return "fail_back";
		}
	}
	
	// ===========================================================================================
	// ********************* 영화리뷰 관리 페이지 *************
	// 관리자페이지 영화 리뷰 관리 페이지로 이동
	@GetMapping("adminReview")
	public String adminReview(HttpSession session, Model model, ReviewsVO review) {
		String sId = (String)session.getAttribute("sId");
		if(sId == null || !sId.equals("admin")) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			return "fail_back";
		}
		
		List<ReviewsVO> adminReview = service.getReviewLiset(review);
		model.addAttribute("adminReview",adminReview);
		System.out.println(adminReview);
		return "admin/admin_review";
	}

	@PostMapping("reviewDlt") // 리뷰 관리 : admin_review.jsp
	public String reviewDlt() {
		return "";
	}
	

}