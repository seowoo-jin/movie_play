<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
	<title>Write</title>
</head>
<body>
<h1>
	<c:if test="${qna.qnaSeq ne null}">
		글 수정
	</c:if>
	<c:if test="${qna.qnaSeq eq null}">
		글 쓰기 
	</c:if>
	
</h1>
	<form action="qna/writequestion" method="post">
	
	<label for="title"> 제목 : </label><input type="text" class="title" id="title" name="title" value="${qna.title }"><br>
	
	<label for="cont"> 내용 : </label><textarea rows="10" cols="100" class="cont" id="cont" name="cont" >
	${qna.cont }</textarea>
	
	<c:if test="${qna.qnaSeq ne null}">
		<input type="hidden" id="qnaSeq" name="qnaSeq" value="${qna.qnaSeq }">
		<input type="submit" value="수정" formaction="${pageContext.request.contextPath}/member/qna/modifyQna">
		<input type="submit" value="삭제" formaction="${pageContext.request.contextPath}/member/qna/deleteQna">
	</c:if>
	<c:if test="${qna.qnaSeq eq null}">
		<input type="submit" value="글쓰기">
	</c:if>
	</form>
	
	

</body>
</html>
