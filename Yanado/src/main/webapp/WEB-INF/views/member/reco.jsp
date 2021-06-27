<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>

<title>Reco</title>
<link href="${pageContext.request.contextPath}/resources/css/qna.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class="media-wrap entry__media">
    <div class="entry__post-thumb">
        <img src="images/ran.jpg" 
            sizes="(max-width: 2000px) 100vw, 2000px" alt="">
    </div>
</div>
<div class="content__page-header entry__header">
    <h1 class="display-1 entry__title">
        Recent Watch History
    </h1>
    <ul class="entry__header-meta">
        <li class="author">By <a href="#0">${member.name}</a></li>
    </ul>
</div> <!-- end entry__header -->
    
<div class="entry__content">
	<blockquote>
	        <p>
	        회원님께서 최근 시청하신 contents list입니다. 만약 이어서 시청하길 원하신다면, 해당 poster를 클릭하세요.
	        </p>
		<cite>From : YANADO Team</cite>
	</blockquote>
</div>

<c:forEach items="${posters }" var="posters" varStatus="status">
	<div class="entry__related">
		<a href="http://localhost:8085/yanado/video/play?trackId=${allRecord[status.index].uniqueNo }">
			<img src="${posters.poster }" class="posterImg" id="posterClk">
				${videoInfo[status.index].title } 
				<c:if test="${videoInfo[status.index].season  ne 0}" >
					season : ${videoInfo[status.index].season }
					episode : ${videoInfo[status.index].episode }
				</c:if>
		</a>
	</div>
</c:forEach>



</body>
</html>