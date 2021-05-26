<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Join</title>
</head>
<body>
	<h1>Join</h1> 
	
	
	<br>
	<form action="join" method="post">
	<label for="id" >ID : </label>					<input type="text" id = "id" name="id">
	<input type="button" value="ID check"><br>       
	<label for="name" >Name : </label>				<input type="text" id = "name" name="name"><br>
	<label for="pw" >Password : </label>			<input type="text" id = "pw" name = "pw"><br>
	<label for="checkpw" >Check PW : </label>		<input type="text" id = "checkpw" name = "checkpw"><br>
	<label for="email" >E-mail : </label>			<input type="text" id = "email" name = "email"> <br>
	<label for="tel" >Tel. : </label>				<input type="text" id = "tel" name = "tel">
	<input type="button" value="Tel check"><br>
	<label for="checktel" >Check Tel. : </label>	<input type="text" id = "checktel" name = "checktel"><br>
	
	<input type="submit" value="join">
	</form>
</body>
</html>
