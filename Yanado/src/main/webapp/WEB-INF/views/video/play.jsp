<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html style="margin: 0;">
<head>
<title>Home</title>
<link rel="shortcut icon" href="#">

	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/play.css" rel="stylesheet" type="text/css">

<style type="text/css">





</style>
</head>
<body style="margin: 0;  background-color: #2f2e2f; overflow: hidden;">
	
	<input type="checkbox" id="selectSubtitle" onclick="selectSubtitleFcn()" >
	<label for="selectSubtitle" class="chooseSubtitle">
		<img id="selectImg" src="${pageContext.request.contextPath}/resources/image/chooseSubtitle.png">
	</label>
	<div id="subtitleBox" name="subtitleBox">
		<input type="radio" class="selectedSubtitle" name="selectedSubtitle" id="KorRadio" value="Kor" ><label for="KorRadio" >한</label>
		<input type="radio" class="selectedSubtitle" name="selectedSubtitle" id="EngRadio" value="Eng"  ><label for="EngRadio">영</label>
		<input type="radio" class="selectedSubtitle" name="selectedSubtitle" id="MixRadio" value="Mix"  ><label for="MixRadio">한/영</label>
		<input type="radio" class="selectedSubtitle" name="selectedSubtitle" id="NonRadio" value="Non"  ><label for="NonRadio">자막 없음</label>
	</div>
	
	<img src="${pageContext.request.contextPath}/resources/image/script.png" id="RScript" name="RScript" >
	<img src="${pageContext.request.contextPath}/resources/image/fullscreen.png" id="fullscreen" >
	<form id="play" action="/video/play" method="get">
		<div class="video-wrapper" >
			<video id="videoArea" crossorigin="anonymous" controls >
				<source id="uniqueNo2" src="${newVid.link }" type="video/mp4"> 
				<track id="trackTagEng"  src="${newVid.subEng } " kind="captions" >
				<track id="trackTagKor"  src="${newVid.subKor } " kind="captions" >
				<track id="trackTagMix"  src="${newVid.subMix } " kind="captions" >
				
			</video>
			<div id="engSubAreaR" class="transcriptR" ></div>
			<div id="korSubAreaR" class="transcriptR" ></div>
			<div id="mixSubAreaR" class="transcriptR" ></div>
			
			<div id="subAreas" class="transcripts" >
				<div id="engSubArea" class="transcript" ></div>
				<div id="mixSubArea" class="transcript" ></div>
				<div id="korSubArea" class="transcript" ></div>
			</div>
		</div>
		
		
	</form>
	<c:forEach items="${bookmarks}" var="bookmarks">
		<input type="hidden" class="bookmarks" data-timestamp = "${bookmarks.subTimestamp }">
	</c:forEach>
	<input type="hidden" id="recordTime" value="${record }">
	<input type="hidden" id="currentSubtitle" value="${defaultSubtitle }">
	<input type="hidden" id="uniqueNo" value="${newVid.uniqueNo}">
	
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/play.js" defer="defer" ></script>
</html>









