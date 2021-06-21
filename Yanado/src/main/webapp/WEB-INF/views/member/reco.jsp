<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>

<title>Reco</title>
</head>

<body>

<c:forEach items="${posters }" var="posters" varStatus="status">
	<div class="posterItem">
		<a href="http://localhost:8085/yanado/video/play?trackId=${allRecord[status.index].uniqueNo }">
			<img src="${posters.poster }" class="posterImg" id="posterClk">
			
			${videoInfo[status.index].title } 
			${videoInfo[status.index].season }
			${videoInfo[status.index].episode }
			<%-- <c:if test="${season[status.index] ne 0}" >
				season : ${season[status.index] } 
				episode : ${episode[status.index] }
			</c:if> --%>
			
		</a>
		
	</div>
	
</c:forEach>



</body>
</html>