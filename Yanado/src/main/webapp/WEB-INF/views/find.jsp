<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Find</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<h1>
	Find 
</h1>

<table>
	<tr>
		<th> Find ID</th>
		<th> Find PW</th>
	</tr>
	<tr>
		<td>
			<label>E-mail : </label> <input type="text" id="emailForId" name="emailForId"><br>
			<input type = "button" id="searchID" name="searchID" value = "Send to Email">
		</td>
		
		<td>
			<label>ID : </label> <input type="text" id="id" name="id"><br>
			<label>E-mail : </label> <input type="text" id="emailForPw" name="emailForPw"><br>
			<input type = "button" id="searchPW" name="searchPW" value = "Send to Email">
		</td>
	</tr>
</table>

<div id="findMessage"></div>

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
