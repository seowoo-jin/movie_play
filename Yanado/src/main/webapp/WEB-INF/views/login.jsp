<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Login</title>
</head>
<body>
<h1>
	Login 
</h1>
<form action="CheckLogin" method="post">
	<input type="text" name="id"><br>
	<input type="password" name="pw"><br>
	<input type="submit" value="login"><br>

	<input type="button" value="Use Kakao Id">
	<p>New around here?</p><a href="join">Sign up</a><br>
	<a href="find">Forgot Id / password</a> 
</form>

</body>
</html>
