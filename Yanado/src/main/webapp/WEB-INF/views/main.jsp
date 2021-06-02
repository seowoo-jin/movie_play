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

<link href="${pageContext.request.contextPath}/resources/css/main.css"
	rel="stylesheet" type="text/css">
</head>

<body>


<div id="head" style="border: 1px solid" >
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
				
				
				<p>실시간 인기 드라마 </p>
				<c:forEach items="${posters }" var="posters">
				<div class="posterItem">
						<img src="${posters.poster }" class="posterImg" id="posterClk">
						<div class="selectEp"> </div>
				</div>
				</c:forEach>
			
			</div>
		</c:if>
	</div>
	<c:if test="${isLogin eq 'N' }">
		Nothing on Main Page
	</c:if> 

<script type="text/javascript" >
	document.getElementById("posterClk").addEventListener('click', function(){
		alert("aa");
		
	})
</script>
</body>
</html>
