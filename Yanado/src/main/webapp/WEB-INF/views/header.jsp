<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Header</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css?ver=1" rel="stylesheet" type="text/css">
</head>
<body >
	<form action="${pageContext.request.contextPath}/login" method="post">
		<table class="headerClass">
			<tr>
				<td>
					<a href="${pageContext.request.contextPath}/">
					<img src="${pageContext.request.contextPath}/resources/ci/ya.png"></a>
				</td>
				<td class="innerTable">
					<input class="headSearch" type="text" id="searchItem" name="searchItem"> 
					<input class="searchBtn" type="button" id="searchBtn" name="searchBtn" value="Search">
				</td>
				<td class="innerTable">
					<c:if test="${isLogin eq 'N' }">
						<input class="headBtn" type="submit" value="Login">
					</c:if> 
					
					<c:if test="${isLogin eq 'Y' }">
						<input class="headBtn" type="submit" value="MyPage" formaction="${pageContext.request.contextPath}/member/mypage" />
					</c:if>
					
					<c:if test="${isLogin eq 'A' }">
						<input class="headBtn" type="submit" value="Admin" formaction="${pageContext.request.contextPath}/admin/adminpage" />
					</c:if>
					
					<input class="headBtn" type="submit" value="Log out" formaction="${pageContext.request.contextPath}/logout" />
				</td>
			</tr>
		</table>
	</form>

	<script type="text/javascript">
		document.getElementById("searchBtn").addEventListener('click', function(){
			var searchingItem = document.getElementById("searchItem").value;
			window.location.href="${pageContext.request.contextPath}/search?searchingItem="+searchingItem;
		})
	</script>

</body>
</html>
