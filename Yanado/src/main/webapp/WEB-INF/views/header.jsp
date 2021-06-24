<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Header</title>
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="${pageContext.request.contextPath}/login" method="post">
		<table class="headerClass">
			<tr>
				<td>
					<a href="${pageContext.request.contextPath}/">
					<img src="${pageContext.request.contextPath}/resources/ci/yanado_brand.png" align="left"></a>
				</td>
				<td class="innerTable">
					<input class="headSearch" type="text"> 
					<input class="headBtn" type="button" value="Search">
				</td>
				<td class="innerTable">
					<c:if test="${isLogin eq 'N' }">
						<input class="headBtn" type="submit" value="Login"">
					</c:if> 
					<c:if test="${isLogin eq 'Y' }">
						<input class="headBtn" type="submit" value="myPage" formaction="${pageContext.request.contextPath}/member/mypage" />
					</c:if>
					<c:if test="${isLogin eq 'A' }">
						<input class="headBtn" type="submit" value="admin" formaction="${pageContext.request.contextPath}/admin/adminpage" />
					</c:if>
					<input class="headBtn" type="submit" value="log out" formaction="${pageContext.request.contextPath}/logout" />
				</td>
			</tr>
		</table>
	</form>

	<script type="text/javascript">
		
	</script>

</body>
</html>
