<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
	<title>Write</title>
<link href="${pageContext.request.contextPath}/resources/css/qna.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1>
	<c:if test="${qna.qnaSeq ne null}">
		Modify Q&A
	</c:if>
	<c:if test="${qna.qnaSeq eq null}">
		Write Q&A
	</c:if>
	
</h1>
	<div class="writeArea">
	<form action="qna/writequestion" method="post">
	
	<label for="title"> 제목 : </label><input type="text" class="title" id="title" name="title" value="${qna.title }"><br>
	
	<label for="cont"> 내용 : </label><textarea rows="10" cols="100" class="cont" id="cont" name="cont" >${qna.cont }</textarea><br>
	
	<c:if test="${qna.qnaSeq ne null}">
		<input type="hidden" id="qnaSeq" name="qnaSeq" value="${qna.qnaSeq }">
		<input type="submit" id="qnaMod" value="Modify" formaction="${pageContext.request.contextPath}/member/qna/modifyQna">
		<input type="submit" id="qnaDel" value="Delete" formaction="${pageContext.request.contextPath}/member/qna/deleteQna">
	</c:if>
	<c:if test="${qna.qnaSeq eq null}">
		<input type="submit" id="qnaWrite" value="Upload">
	</c:if>
	</form>
	</div>
	

</body>
</html>
