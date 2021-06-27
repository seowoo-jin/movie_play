<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>

<html>
<head>
<title>Home</title>
<link href="${pageContext.request.contextPath}/resources/css/qna.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/movieBoard.css" rel="stylesheet" type="text/css">
</head>

<body>
	<h1>Teaser </h1>
	
	
	<button class="movieBoardBtn" id="deleteTeaser" name="deleteTeaser" > 선택 삭제 </button>
	<button class="movieBoardBtn" id="teaserToMain" name="teaserToMain" > 메인 화면에 재생 </button>

	<div id="grid">
	
	</div>
	
<script >
</script>
</body>
</html>