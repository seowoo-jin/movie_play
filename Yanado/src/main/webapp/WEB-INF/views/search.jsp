<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
	<title>Search</title>
<link href="${pageContext.request.contextPath}/resources/css/uploadVideo.css" rel="stylesheet" type="text/css">
<link href="resources/css/poster.css" rel="stylesheet" type="text/css">
</head>
<body style="background-color: #2f2e2f;">
   <div id="head">
      <jsp:include page="header.jsp" flush="false">
         <jsp:param name="param1" value="" />
      </jsp:include>
   </div>
	<!-- Main Contents  -->
				<p class="MediaTitle">검색 결과</p>
				<div class="totalMedia" >
					<div class="leftSlideBtn" id="posterChangeLeft" > 
						<img src="${pageContext.request.contextPath}/resources/image/left_arrow.png" class="arrowImg">
					</div>
					<div class="resultPosterArea" id="resultPosterArea" >
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
	
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mediaSelection.js" defer="defer"></script>
</html>

