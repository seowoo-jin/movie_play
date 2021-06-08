<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Edit</title>
	<script type="text/javascript">



		
	</script>
</head>
<body>
<h1>
	내 정보 수정
	
</h1>
	<form action="edit" method="post">
		<div class="modifyMemInfo" >
			<label for="id" >ID : ${member.id }</label><br>					
		  	<label for="name" >Name : </label>
		  <input type="text" id = "name" name="name" value="${member.name }"><br>
		
		  <label for="pw" >Password : </label>			
		  <input type="text" id = "pw" name = "pw"><br>
		
		  <label for="checkPw" >Check PW : </label>		
		  <input type="text" id = "checkPw" name = "checkPw" onchange="checkPassword()"><br>
		  <div id="checkPwMsg"></div>
		
	  	  <label for="email" >E-mail : </label>			
		  <input type="text" id = "email" name = "email" value="${member.email }"> <br>
		
		  <label for="phoneNum" >Tel. : </label>			
		  <input type="text" id = "tel" name = "tel" value="${member.tel }">
		  <input type="button" id="phoneCheck" name="phoneCheck" value="Send Number" onclick="chekPhone()"><br>
		  <div id="phoneMessage"></div>
		
		  <label for="checkNum" >Check Tel. : </label>	<input type="text" id = "checkNum" name = "checkNum">
		  <input type="button" id="numberCheck" name="numberCheck" value="check Number" onclick="compareNum()"><br>
		  <div id="checkMessage"></div>
		  
		  <input type="hidden" id="id" name="id" value="${member.id }">
		  <input type="hidden" id="isPay" name="isPay" value="${member.isPay }">
		  <input type="hidden" id="defaultCap" name="defaultCap" value="${member.defaultCap }">
		  
		  <input type="submit" value="Edit" id="finalBtn" name="finalBtn" disabled="disabled">
		  <input type="submit" value="탈퇴" id="deleteBtn" name="deleteBtn" disabled="disabled" formaction="delete">
		</div>
	  
	
	  
	</form>

</body>
</html>
