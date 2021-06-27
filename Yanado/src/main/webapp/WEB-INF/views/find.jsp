<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Find</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link href="${pageContext.request.contextPath}/resources/css/find.css" rel="stylesheet" type="text/css">	
</head>
<body>
<a href="/yanado/">
<img src="${pageContext.request.contextPath}/resources/ci/ya.png">
</a>
<div id="findMessage"></div> <br>

<div class="findID" >
	<h2> Forgot ID ? </h2> <br><br>
			<label>E-mail : </label> <input type="text" id="emailForId" name="emailForId" placeholder="name@example.com"><br>
			<input type = "button" class="btnEmailSend" id="searchID" name="searchID" value = "Email Me">	
</div>

<div class="findPW">
	<h2> Forgot Password ?</h2><br>
			<label>ID : </label> <input type="text" id="id" name="id" placeholder="Your ID"><br>
			<label>E-mail : </label> <input type="text" id="emailForPw" name="emailForPw" placeholder="name@example.com"><br>
			<input type = "button" class="btnEmailSend" id="searchPW" name="searchPW" value = "Email Me">	
</div>


<script type="text/javascript">
	$(document).ready(function(){
		/* ID Searching */
		$("#searchID").on('click',function(){
			var temp = document.getElementById("emailForId").value;
			console.log(temp);
			$.ajax({
				type: "GET",
				url : "findId",
				data : {"email" : temp},
				success : function(returnDate){
					$("#findMessage").html(returnDate);
				},
				error:function(){
					console.log("fail");
				}
			})
		})
		
		/* PW Searching */
		$("#searchPW").on('click',function(){
			var id = document.getElementById("id").value;
			var email = document.getElementById("emailForPw").value;
			$.ajax({
				type: "GET",
				url : "findPw",
				data : {
					"email" : email,
					"id" : id		
				},
				success : function(returnDate){
					$("#findMessage").html(returnDate);
				},
				error:function(){
					console.log("fail");
				}
			})
		})
	})
	
	
	
	
	
	
	

</script>

</body>
</html>
