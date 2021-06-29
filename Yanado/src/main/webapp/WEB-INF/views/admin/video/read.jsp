<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Video Information</title>
	<link href="${pageContext.request.contextPath}/resources/css/uploadVideo.css" rel="stylesheet" type="text/css">
	
<style>
textarea{
	height:50px;
}
</style>	
</head>
<body>
<h1>
	Video Information	
</h1>

<form action="singleVideoDelete" method="get">

	<label>Title :</label> <textarea>${videoInfo.title }</textarea><br>
	<input type="hidden" id="uniqueNo" name="uniqueNo" value="${videoInfo.uniqueNo }">
	<label>season :</label><textarea>${videoInfo.season }</textarea><br>
	<label>episode :</label><textarea>${videoInfo.episode }</textarea><br>
	<label>File :</label><textarea>${videoInfo.link }</textarea><br>
	<label>Tag :</label><textarea>${tag }</textarea><br>
	
	<label for="people">People :</label><textarea>${videoInfo.people }</textarea><br>
	<label for="synop">Synop :</label><textarea style="height:70px;">${videoInfo.synop }</textarea><br>
	<label for="subEng">English Subtitle File :</label><textarea>${videoInfo.subEng }</textarea><br>
	<label for="subKor">Korean Subtitle File :</label><textarea>${videoInfo.subKor }</textarea><br>
	<label for="subMix">Mix Subtitle File :</label><textarea>${videoInfo.subMix }</textarea><br>
	
	<input type="submit" id="delete" value="Delete">
	<button id="modify" id="modify" name="modify" onclick="loadDoc('videoModifyForm?uniqueNo=${videoInfo.uniqueNo}');return false;">Modify</button>	
</form>
</body>
</html>