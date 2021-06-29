<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>
<head>
<title>QNA</title>
<link href="${pageContext.request.contextPath}/resources/css/qna.css" rel="stylesheet" type="text/css">	
</head>

<body style="background-color: #2f2e2f;">
<h1>Q&A</h1>
	<div class="all">
		<c:forEach items="${allQna }" var="allQna" varStatus="status">
			<button class="accordion" onclick="accordion('${allQna.qnaSeq}');">
				${allQna.title }
				<c:if test="${allQna.isReply eq 'Y' }">
					<div id="reply">Replied</div>
				</c:if>
			</button>
			<div class="panel" id="panel_${allQna.qnaSeq}" style="display: none">
				<p>
					${allQna.cont }
					<c:if test="${allQna.isReply eq 'N' }">
						<c:if test="${member.id eq allQna.id}">
								<button type="button" id="btnModify" onclick="loadDoc('qna/selectQna?qnaSeq='+${allQna.qnaSeq })">Modify</button>
						</c:if>
					</c:if>				
				<p class="space"/>
				<c:if test="${allQna.isReply eq 'Y' }">
					<div id="re">↳Re : </div> ${allQna.reply }
					<fmt:formatDate var="date" value="${allQna.replyDate }" pattern="yyyy.MM.dd"/>
					<div id="replyDate"> ${date }</div> <br>
					<div id="replyAdmin"> ${allQna.replyAdmin }</div> <br>
				</c:if>
				<p>
			</div>
		</c:forEach>
	</div>
</body>



</html>