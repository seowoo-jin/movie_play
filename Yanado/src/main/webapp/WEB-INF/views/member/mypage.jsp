<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<link href="${pageContext.request.contextPath}/resources/css/header.css"
	rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<title>MyPage</title>
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
						<li><a href="javascript:void(0);" onClick="loadDoc('reco');return false;">시청기록</a></li>
						<li><a href="javascript:void(0);" onClick="loadDoc('bookmark');return false;">북마크</a></li>
						<li>
						<input class="list-hover-slide" type="checkbox" id="check">
						<label for="check" class="main-nav">Q&A</label>
							<ul class="qna-list" id="qna-list">
								<li><a href="javascript:void(0);" onClick="loadDoc('qna/board');return false;"> 게시판</a></li>
								<li><a href="javascript:void(0);" onClick="loadDoc('qna/myqna');return false;"> 내글 보기</a></li>
								<li><a href="javascript:void(0);" onClick="loadDoc('qna/write');return false;"> 글 쓰기</a></li>
							</ul>
						</li>
						<li><a href="javascript:void(0);" onClick="loadDoc('modify');return false;">개인정보</a></li>
					</ul>
				</nav>
			</div>
		</div>
		<!--사이드 메뉴 끝  -->

		<div class="article" id="article">
			<jsp:include page="reco.jsp" flush="false">
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
			xhttp.open("GET", "${pageContext.request.contextPath}/member/"+event, true);
			xhttp.send();
		}
	</script>
</body>
</html>