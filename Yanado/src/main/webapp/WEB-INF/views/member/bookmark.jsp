<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>bookmark</title>
</head>
<body>
<h1>
	bookmark
</h1>

<div id="bookMarksArea" style="overflow-y:scroll; height: 1000px; ">
	<c:forEach items="${allBookmarks }" var="allBookmarks">
		<div class="eachBookMarks" style="white-space: pre; float: left; text-align: left; 
		width: 400px; height: 200px; border: 1px solid; position: relative; margin: 10px;">
			<a  href="${pageContext.request.contextPath}/video/play?trackId=${allBookmarks.uniqueNo }&bookmarkTime=${allBookmarks.subTimestamp}">
				${allBookmarks.title}<br>
				<c:if test="${allBookmarks.season ne 00 }">
				<span>시즌 : </span>${allBookmarks.season}<br>
				<span>에피소드 : </span>${allBookmarks.episode}<br>
				</c:if>
				<span>${allBookmarks.subtitle}</span><br>
			</a>
		</div>
	</c:forEach>

</div>

</body>
</html>
