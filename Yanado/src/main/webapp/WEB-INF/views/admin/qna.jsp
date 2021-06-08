<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Qna</title>
</head>
<body>
<h1>
	Qna
	
</h1>
	<div class="all">
		<c:forEach items="${allQna }" var="allQna" varStatus="status">
			<button class="accordion" onclick="accordion('${allQna.qnaSeq}');">
				${allQna.title }
				<c:if test="${allQna.isReply eq 'Y' }">
					<div id="isReply">답변완료</div>
				</c:if>
			</button>
			<div class="panel" id="panel_${allQna.qnaSeq}" style="display: none">
				<p>
					${allQna.cont }
				<button type="button" id="btn" onclick="loadDoc('qna/deleteQna?qnaSeq='+${allQna.qnaSeq })">삭제</button>
					
				<hr>
				<c:if test="${allQna.isReply eq 'Y' }">
					${allQna.replyDate}<br>
					답변 : ${allQna.reply }<br>
					작성자 : ${allQna.replyAdmin }
				</c:if><br>
					<input type="text" id="replyString_${allQna.qnaSeq }" name="replyString_${allQna.qnaSeq }">
					<button type="button" id="replyBtn" name="replyBtn" onclick="reply(${allQna.qnaSeq })"> 답변하기</button>
				<p>
				
			</div>
		</c:forEach>
	</div>

</body>
</html>
