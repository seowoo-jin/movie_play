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

	<label for="title">Title : </label><input type="text" id="title" name="title" value="${videoInfo.title }">
	<select id="selectTitle" name="selectTitle" onchange="selectedTitle()">
		<option value=0>제목 선택</option>
		<c:forEach items="${movieTitle }" var="movieTitle">
			<option value="${movieTitle.titleSeq }">${movieTitle.title }</option>
		</c:forEach>
	</select>
	<input type='checkbox' id="titleManual" name="titleManual" onClick="newTitleAval()" >영상 제목을 직접 입력
	<input type='hidden' id="titleSeq" name="titleSeq">
	<c:if test="${!empty videoInfo }">
		<input type="hidden" id="uniqueNo" name="uniqueNo" value="${videoInfo.uniqueNo }">
	</c:if>
	<br>
	
	<label for="season">season : </label><input type="text" id="season" name="season" value="${empty videoInfo.season ? 00 : videoInfo.season }">
	<label for="episode">episode : </label><input type="text" id="episode" name="episode" value="${empty videoInfo.episode ? 00 : videoInfo.episode }">
	<br>
	
	<label for="link">File : </label>
	<input type="text" id="link" name="link" readonly="readonly" value="${videoInfo.link }">
	<input type="button" id="linkFile" value="Files" onClick="FilePath('link');return false;"> 
	<br>
	
	
	<label for="tag">Tag : </label><input type="text" id="tag" name="tag">
	<select id="selectTag" name="selectTag" onchange="selectedTag()">
		<option value=0>테그 입력</option>
		<c:forEach items="${tagName }" var="tag">
			<option value="${tag.tagNameSeq }">${tag.tagName }</option>
		</c:forEach>
		<option value=99999>직접 입력</option>
	</select>
	<br>
	
	<c:if test="${empty videoInfo }">
		<label for="myPoster">Poster : </label>
		<input type="text" id="poster" name="poster" >
		<input type="button" id="posterFile" value="Files" onClick="FilePath('poster');return false;">
		<br>
		<label for="teaser">Teaser : </label>
		<input type="text" id="teaserLink" name="teaserLink">
		<input type="button" id="teaserLinkFile" value="Files" onClick="FilePath('teaserLink');return false;">
		<br>
	</c:if>
	
	
	
	<label for="people">People : </label><input type="text" id="people" name="people" value="${videoInfo.people }"><br>
	<label for="synop">Synop : </label><textarea id="synop" name="synop"></textarea><br>
	
	<label for="subEng">English Subtitle File :</label><input type="text" id="subEng" name="subEng" readonly="readonly" value="${videoInfo.subEng }">
	<input type="button" id="subEngFile" onchange="FilePath('subEng')" value="Files" onClick="FilePath('subEng');return false;">
	<br>
	
	<label for="subKor">Korean Subtitle File :</label><input type="text" id="subKor" name="subKor" readonly="readonly"value="${videoInfo.subKor }">
	<input type="button" id="subKorFile" onchange="FilePath('subKor')" value="Files" onClick="FilePath('subKor');return false;">
	<br>
	
	<label for="subMix">Mix Subtitle File :</label><input type="text" id="subMix" name="subMix" readonly="readonly" value="${videoInfo.subMix }">
	<input type="button" id="subMixFile" onchange="FilePath('subMix')" value="Files" onClick="FilePath('subMix');return false;">
	<br>
	
	<c:if test="${empty videoInfo.uniqueNo }">
		<input type="submit" value="Upload">
	</c:if>
	<c:if test="${!empty videoInfo.uniqueNo }">
		<input type="submit" value="Modify" formaction="videoModify">
	</c:if>
	
	
</form>


<script > 
	
</script>



</body>
</html>
