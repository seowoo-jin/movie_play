<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>

<html>
<head>
<title>QNA</title>

</head>

<body>
	<h1>Q&A</h1>


	<div class="all">
		<c:forEach items="${allQna }" var="allQna" varStatus="status">
			<button class="accordion" onclick="accordion('${allQna.qnaSeq}');">
				${allQna.title }
				<c:if test="${allQna.isReply eq 'Y' }">
					<div id="reply">답변완료</div>
				</c:if>
			</button>
			<div class="panel" id="panel_${allQna.qnaSeq}" style="display: none">
				<p>
					${allQna.cont }
					<c:if test="${allQna.isReply eq 'N' }">
						<c:if test="${member.id eq allQna.id}">
								<button type="button" id="btn" onclick="loadDoc('qna/selectQna?qnaSeq='+${allQna.qnaSeq })">수정</button>
						</c:if>
					</c:if>
				<hr>
				<c:if test="${allQna.isReply eq 'Y' }">
					${allQna.replyDate}<br>
					답변 : ${allQna.reply }<br>
					작성자 : ${allQna.replyAdmin }
				</c:if>
				<p>
			</div>
		</c:forEach>
	</div>
</body>



</html>