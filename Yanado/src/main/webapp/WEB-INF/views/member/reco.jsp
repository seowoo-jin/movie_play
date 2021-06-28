<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>

<title>Reco</title>

<link href="${pageContext.request.contextPath}/resources/css/reco.css" rel="stylesheet" type="text/css">
</head>

<body style="background-color: #2f2e2f;">



<c:forEach items="${posters }" var="posters" varStatus="status">
	<div class="entry_related">
		<a href="http://localhost:8085/yanado/video/play?trackId=${allRecord[status.index].uniqueNo }">
			<img src="${posters.poster }" class="posterImg" id="posterClk">
				<span class="mediaItemInfo">${videoInfo[status.index].title } 
					<c:if test="${videoInfo[status.index].season  ne 0}" >
						season : ${videoInfo[status.index].season }
						episode : ${videoInfo[status.index].episode }
					</c:if>
				</span>
		</a>
	</div>
</c:forEach>



</body>
</html>