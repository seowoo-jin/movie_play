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
	<script defer src="https://unpkg.com/smoothscroll-polyfill@0.4.4/dist/smoothscroll.min.js"></script>
	
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
				
				<p class="MediaTitle">실시간 인기 드라마</p>
				<div class="totalMedia" >
					<div class="leftSlideBtn" id="posterChangeLeft" > 
						<img src="${pageContext.request.contextPath}/resources/image/left_arrow.png" class="arrowImg">
					</div>
					<div class="posterArea" id="posterArea" >
						<c:forEach items="${posters }" var="posters" varStatus="status">
							<div class="posterItem" id="posterIndex_${status.index }" >
								<img src="${posters.poster }" class="posterImg"  >
								<div class="selectEpDiv" id='${posters.titleSeq}${posters.season }' ></div>
								<div class="videoInformation" onclick="getEpsoideFcn('${posters.titleSeq}' + '${posters.season }')">
									<p class="infoText">제목 : ${videoInfo[status.index].title }</p>
									<p class="infoText">감독 및 출연진 : ${videoInfo[status.index].people }</p>
									<p class="infoText">줄거리 : ${videoInfo[status.index].synop }</p>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="rightSlideBtn" id="posterChangeRight"> 
						<img src="${pageContext.request.contextPath}/resources/image/right_arrow.png" class="arrowImg">
					</div>
				</div>
				
				<c:if test="${isLogin eq 'Y'}">
					<p class="MediaTitle">시청 중인 영상</p>
					<div class="totalMedia">
						<div class="leftSlideBtn" id="recoPosterChangeLeft"> 
							<img src="${pageContext.request.contextPath}/resources/image/left_arrow.png" class="arrowImg">
						</div>
						<div class="posterArea" id="recoPosterArea">
							
							<c:forEach items="${posterReco }" var="posters" varStatus="status">
								<div class="posterItem" id="recoPosterIndex_${status.index }">
									<a class="posterImg" >
										<img src="${posters.poster }" class="posterImg" id="posterClk">
									</a>
									<span class="recoInfo" onclick="location.href='${pageContext.request.contextPath}/video/play?trackId=${allRecord[status.index].uniqueNo }'">
											<span class="infoText">제목 : ${videoInfoReco[status.index].title }<br>
												<c:if test="${videoInfoReco[status.index].season  ne 0}" >
													<p class="infoText">season : ${videoInfoReco[status.index].season }</p>
													<p class="infoText">episode : ${videoInfoReco[status.index].episode }</p>
												</c:if>
											</span> 
									</span>
								</div>
							</c:forEach>
						</div>
						<div class="rightSlideBtn" id="recoPosterChangeRight"> 
							<img src="${pageContext.request.contextPath}/resources/image/right_arrow.png" class="arrowImg">
						</div>
					</div>
				</c:if>
				
			</div>
		</c:if>
	</div>
	<c:if test="${isLogin eq 'N' }">
		<img src="${pageContext.request.contextPath}/resources/image/zzz.jpeg" style="opacity:0.4; width: 100%; height: 100%;">
	</c:if> 
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mediaSelection.js" defer="defer"></script>
</body>
</html>
