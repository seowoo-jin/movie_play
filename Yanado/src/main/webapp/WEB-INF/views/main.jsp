<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Main</title>
	
	<style type="text/css">
	#header{
		text-align: center;
	}
	</style>
</head>

<body>


<div id="head" style="border: 1px solid" >
	<jsp:include page="header.jsp" flush="false">
		<jsp:param name="param1" value=""/>
	</jsp:include>
</div>
<!-- Main Contents  -->
	<div id="mainContent" >
		<c:if test="${isLogin eq 'Y' || isLogin eq 'A'}">
		poster and video 
		<%-- <div id="mainContents">
		<video>
		
		</video>
		<p>실시간 인기 드라마 </p>
		<c:forEach items="${posters }" var="poster">
			<div>
				<img alt="" src="">
			</div>
		</c:forEach>
		</div> --%>
		</c:if>
	</div>

	
	<c:if test="${isLogin eq 'N' }">
		Nothing on Main Page
	</c:if> 
	<P>  The time on the server is. </P>





</body>
</html>
