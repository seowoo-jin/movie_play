<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Login</title>
	<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet" type="text/css">
</head>
<body>
<a href="/yanado/">
<img src="${pageContext.request.contextPath}/resources/ci/ya.png">
</a>
<div class="loginArea">
<h1>Sign In</h1>

<form action="CheckLogin" method="post">
	<p class="space"/>
	<p>${message }</p>
	<input type="text" name="id" placeholder="Username"><br><br>
	<input type="password" name="pw" placeholder="Password"><br><br>
	<input type="submit" class="btnLoginL" value="LOGIN"><br>
	<p id="line"></p>
	 <a href="https://kauth.kakao.com/oauth/authorize?client_id=bd66f03d70e74c8f9ade0bbb87d38df3&redirect_uri=localhost:8086/yanado/kakaologin&response_type=code">

	<input type="button" class="btnKakaoLogin" value="Login with Kakao">
	</a>
	<p class="space"/>
	New around here? <a href="joinForm">Sign up</a><br>
	<a href="find">Forgot Id / password</a> 
	
</form>
</div>
</body>
</html>
