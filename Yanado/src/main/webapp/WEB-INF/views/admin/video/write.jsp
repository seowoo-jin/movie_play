<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/uploadVideo.css" rel="stylesheet" type="text/css">
	<title>Write</title>
</head>
<body style="text-align: center; margin: 200px auto;">

<h1>
	${empty videoInfo ? "Video Write": "Video Edit" }
</h1>


<form action="${pageContext.request.contextPath}/admin/videoUpload" method="get">

	<label for="title">Title :</label><input type="text" id="title" name="title" value="${videoInfo.title }" ${empty videoInfo ? '' : 'disabled' } placeholder="Title">
	<select id="selectTitle" name="selectTitle" onchange="selectedTitle()" ${empty videoInfo ? '' : 'disabled' }>
		<option value=0>Select title</option>
		<c:forEach items="${movieTitle }" var="movieTitle">
			<option value="${movieTitle.titleSeq }">${movieTitle.title }</option>
		</c:forEach>
	</select>
	<input type='checkbox' id="titleManual" name="titleManual" onClick="newTitleAval()" ${empty videoInfo ? '' : 'disabled' }>영상 제목을 직접 입력
	<br>
	<input type='hidden' id="titleSeq" name="titleSeq">
	
	<label style="width:185px;"></label>
	<label for="season" style="width:60px;">Season :</label><input type="text" id="season" name="season" value="${empty videoInfo.season ? 00 : videoInfo.season }" ${empty videoInfo ? '' : 'disabled' }>
	<label style="width:35px;"></label>
	<label for="episode" style="width:90px;">Episode :</label><input type="text" id="episode" name="episode" value="${empty videoInfo.episode ? 00 : videoInfo.episode }" ${empty videoInfo ? '' : 'disabled' }>
	<br>
	
	<label for="link">File :</label><input type="text" id="link" name="link" readonly="readonly" value="${videoInfo.link }" ${empty videoInfo ? '' : 'disabled' }>
	<input type="button" id="linkFile" value="Choose File" onClick="FilePath('link');return false;" ${empty videoInfo ? '' : 'disabled' }> 
	<br>
	
	
	<label for="tag">Tag :</label><input type="text" id="tag" name="tag" value="${savedTagName }">
	<select id="selectTag" name="selectTag" onchange="selectedTag()">
		<option value=0>Select tag</option>
		<c:forEach items="${tagName }" var="tag">
			<option value="${tag.tagNameSeq }">${tag.tagName }</option>
		</c:forEach>
		<option value=99999>Type new tag</option>
	</select>
	<br>
	
	<c:if test="${empty videoInfo }">
		<label for="myPoster">Poster : </label><input type="text" id="poster" name="poster" readonly="readonly">
		<input type="button" id="posterFile" value="Choose File" onClick="FilePath('poster');return false;">
		<br>
		<label for="teaser">Teaser : </label><input type="text" id="teaserLink" name="teaserLink" readonly="readonly">
		<input type="button" id="teaserLinkFile" value="Choose File" onClick="FilePath('teaserLink');return false;">
		<br>
	</c:if>
	
	
	
	<label for="people">People :</label><input type="text" id="people" name="people" value="${videoInfo.people }"><br>
	<label for="synop">Synop :</label><textarea id="synop" name="synop" >${videoInfo.synop }</textarea><br>
	
	<label for="subEng">English Subtitle File :</label><input type="text" id="subEng" name="subEng" readonly="readonly" value="${videoInfo.subEng }" ${empty videoInfo ? '' : 'disabled' }>
	<input type="button" id="subEngFile" onchange="FilePath('subEng')" value="Choose File" onClick="FilePath('subEng');return false;" ${empty videoInfo ? '' : 'disabled' }>
	<br>
	
	<label for="subKor">Korean Subtitle File :</label><input type="text" id="subKor" name="subKor" readonly="readonly"value="${videoInfo.subKor }" ${empty videoInfo ? '' : 'disabled' }>
	<input type="button" id="subKorFile" onchange="FilePath('subKor')" value="Choose File" onClick="FilePath('subKor');return false;" ${empty videoInfo ? '' : 'disabled' }>
	<br>
	
	<label for="subMix">Mix Subtitle File :</label><input type="text" id="subMix" name="subMix" readonly="readonly" value="${videoInfo.subMix }" ${empty videoInfo ? '' : 'disabled' }>
	<input type="button" id="subMixFile" onchange="FilePath('subMix')" value="Choose File" onClick="FilePath('subMix');return false;" ${empty videoInfo ? '' : 'disabled' }>
	<br>
	
	<c:if test="${empty videoInfo.uniqueNo }">
		<input type="submit" class="submit" id= "submit" value="Upload a file" id="submit">
	</c:if>
	<c:if test="${!empty videoInfo.uniqueNo }">
		<input type="hidden" id="uniqueNo" name="uniqueNo" value="${videoInfo.uniqueNo }">
		<input type="submit" id= "modify1" value="Modify" formaction="videoModify">
	</c:if>
	
	
</form>


<script > 
	
</script>



</body>
</html>