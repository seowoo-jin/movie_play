<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<link href="${pageContext.request.contextPath}/resources/css/header.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<title>admin page</title>
</head>

<body>
	<div id="head">
		<jsp:include page="../header.jsp" flush="false">
			<jsp:param name="param1" value="" />
		</jsp:include>
	</div>

	<!--사이드 메뉴 시작  -->
	<div class="container">
		<div class="sidemenu" role="banner">
			<div class="nav-wrap">
				<nav class="main-nav" role="navigation">
					<ul class="unstyled list-hover-slide">
						<li><a href="javascript:void(0);" onClick="loadDoc('stat');return false;">통계</a></li>
						<li>
						<input class="list-hover-slide" type="checkbox" id="check">
						<label for="check" class="main-nav">영화 관리</label>
							<ul class="qna-list" id="qna-list">
								<li><a href="javascript:void(0);" onClick="loadDoc('video/board');return false;"> 영화 관리</a></li>
								<li><a href="javascript:void(0);" onClick="loadDoc('video/write');return false;"> 영화 등록</a></li>
								<li><a href="javascript:void(0);" onClick="loadDoc('video/teaser');return false;"> 예고편</a></li>
							</ul>
						</li>
						<li><a href="javascript:void(0);" onClick="loadDoc('member');return false;">맴버관리</a></li>
						<li><a href="javascript:void(0);" onClick="loadDoc('qna');return false;">Q&A</a></li>
					</ul>
				</nav>
			</div>
		</div>
		<!--사이드 메뉴 끝  -->

		<div class="article" id="article">
			<jsp:include page="stat.jsp" flush="false">
			<jsp:param name="param1" value="" />
		</jsp:include>
		</div>
	</div>



	<script>
		
	
	/* ajax를 javascript로 나타낸 것 */
		function loadDoc(event) {
			console.log(event);
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
					document.getElementById("article").innerHTML = this.responseText;
			};
			xhttp.open("GET", "${pageContext.request.contextPath}/admin/"+event, true);
			xhttp.send();
		}
		
		/* 파일을 선택하면 비동기 방식으로 filePath 메소드를 실행시켜 선택된 파일의 경로를 가져온다. */
		function FilePath(event){
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
					document.getElementById(event).value = this.responseText;
			};
			xhttp.open("GET", "${pageContext.request.contextPath}/admin/filePath", true);
			xhttp.send();
			
		}

		/* 제목을 선택했을때 실행되는 함수  */
		function selectedTitle(){
			var title = document.getElementById("selectTitle");    // 드롭박스에서 선택했을때 드롭박스 정보를 가져온다.
			var text= title.options[title.selectedIndex].text;		// 선택된 아이템의 이름을 가져온다. 
			var value= title.options[title.selectedIndex].value;	// 선택된 아이템의 고유번호를 가져온다. 
			
			document.getElementById("title").value=text;   			// title란에 선택된 이름을 넣는다.
			document.getElementById("titleSeq").value=value;		// 히든 란에 고유번호를 넣는다.
		}
		
		/* 새로운 타이틀을 넣기위해 체크박스를 선택하면 실행된다. */
		function newTitleAval(){
			document.getElementById("title").value="";			// 타이틀란에 새로 적을 수 있게 빈칸으로 만들어 준다.
			document.getElementById("titleSeq").value = 0;		// 고유번호는 0으로 넘겨줘서 새로운 타이틀이라는 것을 알려준다.
		}
		 
		/* 테그를 선택할 때마다 실행시킨다. */
		function selectedTag(){
			var tag = document.getElementById("selectTag");		// 드롭박스 정보를 가져온다.
			var text= tag.options[tag.selectedIndex].text;		// 선택된 아이템의 텍스트 정보를 가져온다.
			var value= tag.options[tag.selectedIndex].value;	// 선택된 아이템의 값을 가져온다.
			
			if(value != 99999){			// value가 99999면 새로운 값을 넣어 주는 것이다. 그렇지 않은 경우는 기존의 값을 '&'다음에 적어준다.
				var temp = document.getElementById("tag").value;
				document.getElementById("tag").value = temp + '&' + text;
			}
			
		}

		
	</script>
</body>
</html>