package com.itwillbs.c5d2308t1.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.itwillbs.c5d2308t1.service.JoinService;
import com.itwillbs.c5d2308t1.vo.MemberVO;
import com.itwillbs.c5d2308t1.vo.NaverLoginVO;

@Controller
public class JoinController {
	
	// 의존성 주입받을 멤버변수 선언 시 @Autowired 어노테이션을 지정
	@Autowired
	private JoinService service;
	
	 /* NaverLoginVO */
    private NaverLoginVO NaverLoginVO;
    private String apiResult = null;
    
    @Autowired
    private void setNaverLoginVO(NaverLoginVO NaverLoginVO) {
        this.NaverLoginVO = NaverLoginVO;
    }
    
    /* GoogleLogin */
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameters;

	// 회원가입(인증) 페이지로 이동
	@GetMapping("memberJoin")
	public String memberJoin(HttpSession session, Model model) {

        /* 네이버아이디로 인증 URL을 생성하기 위하여 NaverLoginVO클래스의 getAuthorizationUrl메소드 호출 */
        String naverAuthUrl = NaverLoginVO.getAuthorizationUrl(session);
        
        System.out.println("네이버:" + naverAuthUrl);
        
        //네이버 
        model.addAttribute("url", naverAuthUrl);
        
        
        /* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		System.out.println("구글:" + url);

		model.addAttribute("google_url", url);
        
		
		return "join/join_certification";
	}
	

    //네이버 로그인 성공시 callback호출 메소드
	@GetMapping("callback")
    public String callback(MemberVO member, Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
            throws IOException {
        OAuth2AccessToken oauthToken;
        oauthToken = NaverLoginVO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
        apiResult = NaverLoginVO.getUserProfile(oauthToken);
        model.addAttribute("result", apiResult);
        
        // json에 담긴 정보를 파싱하여 변수에 저장
        JSONParser parser = new JSONParser();
        try {
            JSONObject jsonObject = (JSONObject) parser.parse(apiResult);
            JSONObject responseObj = (JSONObject) jsonObject.get("response");
            String name = (String) responseObj.get("name");
            String email = (String) responseObj.get("email");
            String phone = (String) responseObj.get("mobile");
            String birth = (String) responseObj.get("birthyear") + "-" + responseObj.get("birthday");
            String gender = (String) responseObj.get("gender");

            member.setMember_id(email);
            member.setMember_name(name);
            member.setMember_email(email);
            member.setMember_phone(phone);
            member.setMember_birth(birth.replace("-", "."));
            member.setMember_gender(gender);
            
            Integer memberCount = service.getMember(member);
            if(memberCount == null || memberCount == 0) { // 새로 가입한 아이디
            	int insertCount = service.registMember(member);
            	
            	if(insertCount > 0) { // 등록 성공
            		/* 네이버 로그인 성공 페이지 View 호출 */
            		session.setAttribute("sId", member.getMember_id());
            		return "main";
            	} else {
            		model.addAttribute("msg", "네이버 회원가입 실패!");
            		return "fail_back";
            	}	
            } else { // 이미 가입한 아이디
            	session.setAttribute("sId", member.getMember_id());
            	return "main";            	
            }
        
        } catch (ParseException e) {
            e.printStackTrace();
        }
		return "";
    }
	
	// 구글 Callback호출 메소드
	@RequestMapping(value = "/oauth2callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(Model model, @RequestParam String code) throws IOException {
		System.out.println("여기는 googleCallback");

		return "join/googleSuccess";
	}

	// 카카오 api
	@ResponseBody
	@GetMapping("kakaocallback")
    public String kakaocallback(String code) {

		// POST 방식으로 key=value 데이터를 요청 (카카오쪽으로)
		// 이 때 필요한 라이브러리가 RestTemplate, 얘를 쓰면 http 요청을 편하게 할 수 있다.
		RestTemplate rt = new RestTemplate();

		// HTTP POST를 요청할 때 보내는 데이터(body)를 설명해주는 헤더도 만들어 같이 보내줘야 한다.
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

		// body 데이터를 담을 오브젝트인 MultiValueMap를 만들어보자
		// body는 보통 key, value의 쌍으로 이루어지기 때문에 자바에서 제공해주는 MultiValueMap 타입을 사용한다.
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "f165f9545708875e8004b990573d1f65");
		params.add("redirect_uri", "http://localhost:8081/c5d2308t1/kakaocallback");
		params.add("code", code);

		// 요청하기 위해 헤더(Header)와 데이터(Body)를 합친다.
		// kakaoTokenRequest는 데이터(Body)와 헤더(Header)를 Entity가 된다.
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

		// POST 방식으로 Http 요청한다. 그리고 response 변수의 응답 받는다.
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token", // https://{요청할 서버 주소}
				HttpMethod.POST, // 요청할 방식
				kakaoTokenRequest, // 요청할 때 보낼 데이터
				String.class // 요청 시 반환되는 데이터 타입
		);
		return "카카오 토큰 요청 완료 : 토큰 요청에 대한 응답 : "+response;
	}
	
	// 이메일 인증
	@ResponseBody
	@GetMapping("authEmail")
	public String authEmail(String member_email) {
		String auth_code = service.sendAuthMail(member_email);
		System.out.println("인증코드 : " + auth_code);
		
		return auth_code;
	}
	
	// 회원가입(동의) 페이지로 이동
	@PostMapping("memberJoinAgree")
	public String memberJoinAgree() {
		return "join/join_agree";
	}
	
	// 회원가입(폼) 페이지로 이동
	@PostMapping("memberJoinForm")
	public String memberJoinForm() {
		return "join/join_form";
	}
	
	// 회원가입 폼에 입력된 정보를 DB에 저장하고
	// 회원가입 완료 페이지로 이동
	@PostMapping("memberJoinPro")
	public String memberJoinPro(MemberVO member, Model model) {
		// 입력된 비밀번호 암호화
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String securePasswd = passwordEncoder.encode(member.getMember_passwd());
		
		// 암호화된 비밀번호를 member에 저장
		member.setMember_passwd(securePasswd);
		
		// JoinService - registMember() 메서드 호출하여 회원정보 등록 요청
		// => 파라미터 : StudentVO 객체   리턴타입 : int(insertCount)
		int insertCount = service.registMember(member);
		
		// 등록 실패 시 fail_back.jsp 페이지로 포워딩(디스패치)
		// => 포워딩 출력할 오류메세지를 "msg" 라는 속성명으로 Model 객체에 저장
		//    (현재 메서드 파라미터에 Model 타입 파라미터 변수 선언 필요)
		if(insertCount == 0) {
			model.addAttribute("msg", "회원정보 등록 실패!");
			return "fail_back";
		}
		
		return "join/join_completion";
	}
	
	// 아이디, 이메일, 휴대폰번호 중복검사 실행
	@ResponseBody
	@GetMapping("checkDup")
	public String checkDup(MemberVO member) {
		MemberVO dbMember = service.getDup(member);
		
		if(dbMember == null) { // 중복된 아이디 없음 = 사용가능
			return "false";
		} else { // 아이디 중복
			return "true";
		}
	}
	
	// 메인 페이지로 이동
	@GetMapping("main")
	public String main() {
		return "main";
	}
		
}