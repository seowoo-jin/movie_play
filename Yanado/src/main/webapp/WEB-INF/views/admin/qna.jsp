<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
	<title>Qna</title>
	<link href="${pageContext.request.contextPath}/resources/css/qna.css" rel="stylesheet" type="text/css">	 
</head>
<body>
<h1>Q&A	</h1>
	<div class="all">
		<c:forEach items="${allQna }" var="allQna" varStatus="status">
			<button class="accordion" onclick="accordion('${allQna.qnaSeq}');">
				${allQna.title }
				<c:if test="${allQna.isReply eq 'Y' }">
					<div id="isReply">Replied</div>
				</c:if>
			</button>
			<div class="panel" id="panel_${allQna.qnaSeq}" style="display: none">
				<p>
					${allQna.cont }
				<button type="button" class="btnDel" id="btn" onclick="loadDoc('qna/deleteQna?qnaSeq='+${allQna.qnaSeq })">Delete</button>
				<p class="space"/>
				<c:if test="${allQna.isReply eq 'Y' }">
					<div id="re">↳Re : </div> ${allQna.reply }
					<fmt:formatDate var="date" value="${allQna.replyDate }" pattern="yyyy.MM.dd"/>
					<div id="replyDate"> ${date }</div> <br>
					<div id="replyAdmin"> ${allQna.replyAdmin }</div> <br>
				</c:if><br>
					<input type="text" class="writeReply" id="replyString_${allQna.qnaSeq }" name="replyString_${allQna.qnaSeq }">
					<button type="button" id="replyBtn" name="replyBtn" onclick="reply(${allQna.qnaSeq })"> Reply</button>
				<p>
				
			</div>
		</c:forEach>
	</div>


</body>
</html>
