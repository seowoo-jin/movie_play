<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<html>
<head>
	<title>Main</title>
	
	<style type="text/css">
	#header{
		text-align: center;
	}
	</style>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/favicon-16x16.png">
	
<link href="resources/css/poster.css" rel="stylesheet" type="text/css">
</head>

<body style="background-color: #2f2e2f;">


	<div id="head"  >
		<jsp:include page="header.jsp" flush="false">
			<jsp:param name="param1" value=""/>
		</jsp:include>
	</div>
	<!-- Main Contents  -->
	


	<div id="mainContent" >
		<c:if test="${isLogin eq 'Y' || isLogin eq 'A'}">
			<div id="mainContents"> 
				
				<div class="teaserArea">
					<video  class="teaser" crossorigin="anonymous" controls autoplay="autoplay" muted="muted">
						<source src="${teaserVid.teaserLink}" type="video/mp4">
					</video>
				</div>
				
				<div id="testSel"></div>
				
				<p>실시간 인기 드라마</p>
				
				<div class="posterArea" id="posterArea">
					<c:forEach items="${posters }" var="posters" varStatus="status">
						<div class="posterItem" id="posterIndex_${status.index }" onclick="getEpsoideFcn('${posters.titleSeq}' + '${posters.season }')">
							<img src="${posters.poster }" class="posterImg"  >
							<div class="selectEpDiv" id='${posters.titleSeq}${posters.season }' ></div>
							<div class="videoInformation" >
								<p class="infoText">제목 : ${videoInfo[status.index].title }</p>
								<p class="infoText">감독 및 출연진 : ${videoInfo[status.index].people }</p>
								<p class="infoText">줄거리 : ${videoInfo[status.index].synop }</p>
							</div>
						</div>
					</c:forEach>
				</div>
				<button id="posterChangeLeft"> 좌 </button>
				<button id="posterChangeRight"> 우 </button>
			</div>
		</c:if>
	</div>
	<c:if test="${isLogin eq 'N' }">
		Nothing on Main Page
	</c:if> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mediaSelection.js"></script>
</body>
</html>
