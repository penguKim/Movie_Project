 	$(function() {
		let key = "811a25b246549ad749b278bba8257502"; // 발급 키
		// 어제 날짜 호출
		let targetDt = new Date().toLocaleDateString().replace(/[\.\s]/g, '') - 1;
// 		console.log(targetDt);
// 		let openDt = "";
		
		$.ajax({
			// 일일 박스오피스
			url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
			data: {
				key: key,
				targetDt: targetDt
			},
			dataType: "json",
// 			async: false,
			success: function(result) { // 영화코드, 제목, 개봉일, 누적관객수
				let boxOfficeResult = result.boxOfficeResult;
				let dailyBoxOfficeList = boxOfficeResult.dailyBoxOfficeList;
				
				// 셀렉트 박스에 영화코드와 제목을 합쳐서 출력
				for(let movie of dailyBoxOfficeList) {
					// data 속성 알아보기
					$("#dailyBox").append("<option data-audiacc='" + movie.audiAcc + "' data-moviecd='" + movie.movieCd + "' data-opendt='" + movie.openDt + "'>" + movie.movieNm + "</option>");
// 					$("#dailyBox").append("<option>" + movie.movieCd + ":" + movie.movieNm + "</option>");
				}
				
				// 셀렉트 박스의 영화 제목 클릭 시 상세정보 조회
				$("#dailyBox").on("change", function() {
					let movieCd = $("#dailyBox option:selected").data("moviecd");
					console.log(movieCd);
					let movieNm = $("#dailyBox option:selected").val();
// 					console.log(movieNm);
					let audiAcc = $("#dailyBox option:selected").data("audiacc");
					let ServiceKey = "08P2788CP12T24B2US8F";
					let releaseDts = $("#dailyBox option:selected").data("opendt").replace(/[-]/g, '');
// 					console.log(releaseDts);
					$.ajax({
						type: "GET",
						url: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp?collection=kmdb_new2",
						data: {
							ServiceKey: ServiceKey,
							title: movieNm,
							detail: "Y",
							releaseDts: releaseDts
						},
						dataType: "json",
						success: function(kmdb) {
// 							let movieList = kmdb.Data[0].Result;
// 							console.log(movieList.length);
// 							for(let movie of movieList) {
// 								console.log(movie.nation);
// 							}
							
							// 타이틀
							let rawTitle = kmdb.Data[0].Result[0].title;
							// 타이틀 특문 수정
						  	let title = rawTitle.replace(/!HS/g, "")
												    .replace(/!HE/g, "")
												    .replace(/^\s+|\s+$/g, "")
												    .replace(/ +/g, " ");
							$("#movieNm").val(title);
							// 장르
						  	let genre = kmdb.Data[0].Result[0].genre;
							$("#genre").val(genre);
							// 국가
						  	let nation = kmdb.Data[0].Result[0].nation;
							$("#nation").val(nation);
							// 줄거리
						  	let plot = kmdb.Data[0].Result[0].plots.plot[0].plotText;
							$("#plot").val(plot);
							// 포스터 문자열
						  	let posters = kmdb.Data[0].Result[0].posters.split("|");
							// 첫번째 포스터
						  	let poster = posters[0];
							$("img.poster").attr("src", poster);
							$("input.poster").val(poster);
							// 제작년도
							let prodYear = kmdb.Data[0].Result[0].prodYear;
							$("#prdtYear").val(prodYear);
							// 관람등급
							let rating = kmdb.Data[0].Result[0].rating;
							$("#watchGradeNm").val(rating);
							// 상영일
						  	let repRlsDate = kmdb.Data[0].Result[0].repRlsDate.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3');
							$("#openDt").val(repRlsDate);
							// 상영시간
							let runtime = kmdb.Data[0].Result[0].runtime;
							$("#showTm").val(runtime);
							// 스틸샷 문자열
							let stills = kmdb.Data[0].Result[0].stlls.split("|").slice(0, $('.still').length);
							$(".still").each(function(index) {
								$(this).val(stills[index]);
							});
							// 트레일러
							// 가져오는 주소는 embed 태그의 src로 넣을시 작동되지 않으면 아래처럼 변환하자.
							let vod = kmdb.Data[0].Result[0].vods.vod[0].vodUrl == null ? '' : kmdb.Data[0].Result[0].vods.vod[0].vodUrl.replace('trailerPlayPop?pFileNm=', 'play/');
//							let vod = kmdb.Data[0].Result[0].vods.vod[0].vodUrl == null ? '' : kmdb.Data[0].Result[0].vods.vod[0].vodUrl;
							$("#vod").val(vod);
							// 감독명
							let directors = kmdb.Data[0].Result[0].directors.director[0].directorNm == null ? '' : kmdb.Data[0].Result[0].directors.director[0].directorNm;
							$("#directors").val(directors);
							// 배우 배열
							let actors = kmdb.Data[0].Result[0].actors.actor.length <= 3 ? kmdb.Data[0].Result[0].actors.actor : kmdb.Data[0].Result[0].actors.actor.slice(0,4);
							let actor = '';
							for(let el of actors) {
								actor += el.actorNm + '/';
							}
							$("#actors").val(actor.substring(0, actor.length - 1));
							
							$("#audiAcc").val(audiAcc);
							$("#movieCd").val(movieCd);
// 							if($("#movieCd").val() != '') {
// 								$("movie_status option[value='1']").attr("selected", true);
// 							}
							
						},
						error: function(xhr, textStatus, errorThrown) {
							alert("박스오피스 로딩중입니다.");
						}
					});
				}); // onchange() 메서드 끝
				
			}, // 일일 박스오피스 success 끝
			error: function(xhr, textStatus, errorThrown) {
				alert("박스오피스 로딩중입니다.");
			}
		}); // 일일 박스오피스 ajax 요청 끝
	}); // document.ready 끝