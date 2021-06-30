<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>bookmark</title>
<link href="${pageContext.request.contextPath}/resources/css/bookmark.css" rel="stylesheet" type="text/css">
</head>
<body>
<h1>
	bookmark
</h1>

<div id="bookMarksArea" >
	<c:forEach items="${allBookmarks }" var="allBookmarks">
		<div class="eachBookMarks">
			<a class="bookmark" href="${pageContext.request.contextPath}/video/play?trackId=${allBookmarks.uniqueNo }&bookmarkTime=${allBookmarks.subTimestamp}">
				${allBookmarks.title}
				<c:if test="${allBookmarks.season ne 00 }">
				시즌 : ${allBookmarks.season}
				에피소드 : ${allBookmarks.episode}
				</c:if>
				${allBookmarks.subtitle}
			</a>
		</div>
	</c:forEach>

</div>

</body>
</html>