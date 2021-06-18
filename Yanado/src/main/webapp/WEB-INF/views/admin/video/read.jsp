<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Video Information</title>
</head>
<body>
<h1>
	Video Information	
</h1>

<form action="singleVideoDelete" method="get">

	<label>Title : </label> ${videoInfo.title }<br>
	<input type="hidden" id="uniqueNo" name="uniqueNo" value="${videoInfo.uniqueNo }">
	<label>season : </label>${videoInfo.season }<br>
	<label>episode : </label>${videoInfo.episode }<br>
	<label>File : </label>${videoInfo.link }<br>
	<label>Tag : </label>${tag }<br>
	
	<label for="people">People : </label>${videoInfo.people }<br>
	<label for="synop">Synop : </label>${videoInfo.synop }<br>
	<label for="subEng">English Subtitle File :</label>${videoInfo.subEng }<br>
	<label for="subKor">Korean Subtitle File :</label>${videoInfo.subKor }<br>
	<label for="subMix">Mix Subtitle File :</label>${videoInfo.subMix }<br>
	
	<input type="submit" value="삭제">
</form>

<button id="modify" name="modify" onclick="loadDoc('videoModifyForm?uniqueNo=${videoInfo.uniqueNo}');return false;">수정</button>

<script > 

</script>



</body>
</html>
