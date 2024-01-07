<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<!-- 카카오 api를 위한 script -->
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.6.0/kakao.min.js"
  integrity="sha384-6MFdIr0zOira1CHQkedUqJVql0YtcZA1P0nbPrQYJXVJZUkTk/oX4U9GhUIs3/z8" crossorigin="anonymous"></script>
<script type="text/javascript">
var kakao_message = new Object();   
	
$(function() {
	var ACCESS_TOKEN= $("#access_token").val();	
	
	//할당받은 토큰을  세팅
	Kakao.Auth.setAccessToken(ACCESS_TOKEN);
	console.log(Kakao.Auth.getAccessToken());		
	Kakao.API.request({
	    url: '/v2/user/me',
	    success: function(response) {
	        console.log(response);
	        kakao_message['id']=response['id'];
			kakao_message['email']=response['kakao_account']['email'];
			kakao_message['nickname']=response['kakao_account']['profile']['nickname'];
	        console.log(kakao_message);
	        var m_uid = 'KAKAO_'+kakao_message['id'];
			console.log(""+window.location.hostname+"");
			var data = JSON.stringify({
				uid : m_uid
				, uname : kakao_message['nickname']
				, uemail : kakao_message['email']
				, join_pass : 'KAKAO'
			});
			
			
// 			// 로그인시 서버에서 넘어왔음.. 
// 			//로그인정보가 있다면 로그인 시도하기.. 
// 			var url = '/user/userid_duplicate_check';
// 			getPostData(url,data,callback_userid_duplicate_check, false);	
			
// 			if(!is_userid) //sns가입된 id가 있다면 로그인 시도.
// 			{
// 				url = '/user/naver_kakao_sns_login';					
// 				getPostData(url,data,callback_join_ok, false);
// 			}
// 			else if(is_userid) //sns로 가입된 id가 없다면 가입시도..
// 			{
// 				$("#i_id").val(m_uid);
// 				$("#i_name").val(kakao_message['nickname']);
// 				$("#i_email").val(kakao_message['email']);
// 			}
	    },
	    fail: function(error) {
	        console.log(error);
	    }
	});
});
	
</script>
  
</head>
<body>
<input type="text" id="access_token" value="${access_token}">
</body>
</html>