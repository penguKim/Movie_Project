<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<script type="text/javascript">
			var naver_id_login = new naver_id_login("nr_LTg68QmTdiTdj7ult", "http://localhost:8081/c5d2308t1");
			alert(naver_id_login.oauthParams.access_token);
			naver_id_login.get_naver_userprofile("naverSignInCallback()");
			console.log('콜백실행')  
		  
		  
		 function naverSignInCallback() {
			member_id = naver_id_login.getProfileData('id');
			member_name = naver_id_login.getProfileData('name');
			member_email = naver_id_login.getProfileData('email');
			member_gender = naver_id_login.getProfileData('gender');
			member_birth1 = naver_id_login.getProfileData('age');
			member_birth2 = naver_id_login.getProfileData('birthday');
			member_phone = naver_id_login.getProfileData('mobile');
				
			
				$.ajax({
					type: 'POST',
					url: 'naverLogin', 
					data: {
						'member_id': member_id,
						'member_name': member_name,
						'member_email': member_email,
						'member_birth': member_birth,
						'member_phone': member_phone 
						}, // data
					dataType: 'text',
					success: function(result) {
						if(result == 1) {
							console.log('성공')
							closePopupAndRedirect(); 
						} else  {
							window.close();
						}
					}, 
					error: function(result) {
						window.close();
					} 
				}) 
		  }
		  
		  	
		function closePopupAndRedirect() {
			window.opener.postMessage('naverLoginSuccess', '*'); 
			window.close(); 
		}
		  
		
	</script>
	
</body>
</html>