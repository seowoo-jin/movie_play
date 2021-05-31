<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Write</title>
</head>
<body>
<h1>
	Write	
</h1>


<form action="${pageContext.request.contextPath}/admin/videoUpload" method="get">

	<label for="title">Name : </label><input type="text" id="title" name="title"><br>
	<label for="link">File : </label>
	<input type="text" id="link" name="link">
	<input type="button" id="linkFile" value="Files" onClick="FilePath('link');return false;"> 
	<br>
	
	<label for="myPoster">Poster : </label>
	<input type="text" id="posterLink" name="posterLink">
	<input type="button" id="posterLinkFile" value="Files" onClick="FilePath('posterLink');return false;">
	<br>
	
	<label for="people">People : </label><input type="text" id="people" name="people"><br>
	<label for="synop">Synop : </label><textarea id="synop" name="synop"></textarea><br>
	
	<label for="subEng">English Subtitle File :</label><input type="text" id="subEng" name="subEng">
	<input type="button" id="subEngFile" onchange="FilePath('subEng')" value="Files" onClick="FilePath('subEng');return false;">
	<br>
	
	<label for="subKor">Korean Subtitle File :</label><input type="text" id="subKor" name="subKor">
	<input type="button" id="subKorFile" onchange="FilePath('subKor')" value="Files" onClick="FilePath('subKor');return false;">
	<br>
	
	<label for="subMix">Mix Subtitle File :</label><input type="text" id="subMix" name="subMix">
	<input type="button" id="subMixFile" onchange="FilePath('subMix')" value="Files" onClick="FilePath('subMix');return false;">
	<br>
	
	<input type="text" value="${pageContext.request.contextPath}">
	<input type="submit" value="Upload">
	
</form>


<script > 
	
</script>



</body>
</html>
