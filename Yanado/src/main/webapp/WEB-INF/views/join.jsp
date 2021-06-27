<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Join</title>
	<link href="${pageContext.request.contextPath}/resources/css/join.css" rel="stylesheet" type="text/css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<a href="/yanado/">
<img src="${pageContext.request.contextPath}/resources/ci/ya.png">
</a>	
<div class="joinArea">	
	<h1>회원가입 </h1>  
	<br>
	<form action="join" method="post">
		<div id="message"></div>
		<label for="id" >ID : </label>
		<input type="text" id = "id" name="id">
		<input type="button" id="idCheck" name="idCheck" value="ID check"><br>       
	    <label for="name" >Name : </label>		
		<input type="text" id = "name" name="name"><br>
		
		<label for="pw" >Password : </label>
		<input type="password" id = "pw" name = "pw"><br>
		
		<label for="checkPw" >Check PW : </label>	
		<input type="password" id = "checkPw" name = "checkPw"><br>
		<div id="checkPwMsg"></div>
		
		<label for="email" >E-mail : </label>		
		<input type="text" id = "email" name = "email"> <br>
		
		<label for="phoneNum" >Tel. : </label>	
		<input type="text" id = "tel" name = "tel">
		<input type="button" id="phoneCheck" name="phoneCheck" value="Send"><br>
		<div id="phoneMessage"></div>
		
		<label for="checkNum" >Check Tel. : </label>
		<input type="text" id = "checkNum" name = "checkNum">
		<input type="button" id="numberCheck" name="numberCheck" value="Verify"><br>
		<div id="checkMessage"></div> <br>
		
		<input type="submit" value="JOIN" id="finalBtn" name="finalBtn" disabled="disabled">
	</form>
	
</div>	
	<script>
	$(document).ready(function(){
		var isPossible = parseInt("0");
		var isId = parseInt("0");
		var isPhone = parseInt("0");
		var isPw = parseInt("0");
		var isNumberChk = parseInt("0");
		
		function checkInput(){
			console.log(isPossible);
			if(isPossible>=10){
				console.log("running");
				const target = document.getElementById("finalBtn");
				target.disabled = false;
			}
		}
		
		var checkNumber = "";
		$("#idCheck").on('click', function(){
			var id = document.getElementById("id").value;
			$.ajax({
				type : "GET",
				url : "checkId",
				data : {"id" : id},
				success : function(returnDate){
					console.log(returnDate);
					if(returnDate.length == 0 ){
						$("#message").html("You can use this ID.");
						if(isId==0){
							isPossible = isPossible + 1;
						}
						isId = isId+1;
					}else{
						$("#message").html("ID is using");
						$("#id").val('');
					}
				},
				error:function(){
					console.log("fail");
				}
			})
			checkInput();
		})
		
		
		$("#phoneCheck").on('click', function(){
			var phoneNum = document.getElementById("tel").value;
			$.ajax({
				type : "GET",
				url : "checkPhone",
				data : {"phoneNum" : phoneNum},
				success : function(returnData){
					checkNumber=returnData;
					$("#phoneMessage").html("Text has been sended.");
					if(isPhone == 0){
						isPossible = isPossible + 3;
					}
					isPhone = isPhone+1;
				},
				error:function(){
					console.log("fail");
				}
			})
			checkInput();
		})
		
		$("#numberCheck").on('click', function(){
			var writtenNum = document.getElementById("checkNum").value;
			if(writtenNum == checkNumber){
				$("#checkMessage").html("Right Number!");
				if(isNumberChk==0){
					isPossible = isPossible + 5;
				}
				isNumberChk = isNumberChk + 1;
			}else{
				$("#checkMessage").html("Wrong Number!");
				$("#checkNum").val('');
			}
			checkInput();
		})
		
		$("#checkPw").keyup(function(){
			var pw = document.getElementById("pw").value;
			var checkPw = document.getElementById("checkPw").value;
			if (pw == checkPw){
				$("#checkPwMsg").html("Correct Password!");
				if(isPw == 0){
					isPossible = isPossible + 10;
				}
				isPw = isPw + 1;
			}
			checkInput();
		})
	})
	
	</script>
</body>
</html>
