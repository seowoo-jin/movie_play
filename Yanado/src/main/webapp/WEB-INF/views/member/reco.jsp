<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>

<title>Reco</title>
<link href="${pageContext.request.contextPath}/resources/css/reco.css" rel="stylesheet" type="text/css">
</head>

 <body>
	
	<div class="recoArea" id="recoArea">
		<c:forEach items="${posters }" var="posters" varStatus="status">
			<div class="posterItem" id="recoPosterIndex_${status.index }">
				<a class="posterImg" >
					<img src="${posters.poster }" class="posterImg" id="posterClk">
				</a>
				<span class="recoInfo" onclick="location.href='${pageContext.request.contextPath}/video/play?trackId=${allRecord[status.index].uniqueNo }'">
						<span class="infoText">${videoInfo[status.index].title }
							<c:if test="${videoInfo[status.index].season  ne 0}" >
								<p class="infoText">season : ${videoInfo[status.index].season }</p>
								<p class="infoText">episode : ${videoInfo[status.index].episode }</p>
							</c:if>
						</span> 
				</span>
			</div>
		</c:forEach>
	</div>
    
    </body>
</html>