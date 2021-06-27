<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
	<title>Search</title>
<link href="${pageContext.request.contextPath}/resources/css/uploadVideo.css" rel="stylesheet" type="text/css">
<link href="resources/css/poster.css" rel="stylesheet" type="text/css">
</head>
<body>
   <div id="head">
      <jsp:include page="header.jsp" flush="false">
         <jsp:param name="param1" value="" />
      </jsp:include>
   </div>
	<!-- Main Contents  -->
	
	<div id="posterArea">
		<c:forEach items="${posters }" var="posters" varStatus="status">
			<div class="posterItem" onclick="getEpsoideFcn('${posters.titleSeq}' + '${posters.season }')">
				<img src="${posters.poster }" class="posterImg" id="posterClk" >
				<div class="selectEpDiv" id='${posters.titleSeq}${posters.season }' ></div>
				<div class="videoInformation" >
					<p>제목 : ${videoInfo[status.index].title }</p>
					<p>감독 및 출연진 : ${videoInfo[status.index].people }</p>
					<p>줄거리 : ${videoInfo[status.index].synop }</p>
				</div>
			</div>
		</c:forEach>
	</div>
	
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mediaSelection.js" defer="defer"></script>
</html>
