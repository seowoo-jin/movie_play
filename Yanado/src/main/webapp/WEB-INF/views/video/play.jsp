<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="shortcut icon" href="#">

	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>


<style type="text/css">
.transcript{
	-ms-overflow-style: none;  /* IE and Edge */
 	 scrollbar-width: none;  /* Firefox */
}

</style>
</head>
<body>

	<input type="checkbox" value="자막선택" id="selectSubtitle" onclick="selectSubtitleFcn()">
	<div id="subtitleBox" style="display: none">
		<input type="radio" name="selectedSubtitle" id="KorRadio" value="Kor" onclick="changeSub('kor')"><label for="KorRadio">한</label>
		<input type="radio" name="selectedSubtitle" id="EngRadio" value="Eng" onclick="changeSub('eng')" ><label for="EngRadio">영</label>
		<input type="radio" name="selectedSubtitle" id="MixRadio" value="Mix" onclick="changeSub('mix')" ><label for="MixRadio">한/영</label>
	</div>
	
	<button id="RScript" name="RScript" value="script">Script</button>
	
	<input type="button" value="back" id="videoBack"><br>
	<form id="play" action="/video/play" method="get">
		<div class="video-wrapper" style="border: 1px solid; position: relative;">
			<video id="videoArea" crossorigin="anonymous" controls  width=70% >
				<source id="uniqueNo2" src="${newVid.link }" type="video/mp4"> 
				<track id="trackTagEng"  src="${newVid.subEng } " kind="captions" >
				<track id="trackTagKor"  src="${newVid.subKor } " kind="captions" >
				<track id="trackTagMix"  src="${newVid.subMix } " kind="captions" >
			</video>
			<p hidden="hidden"> </p>
			<div id="engSubAreaR" class="transcript" style="display: none; border: 1px solid; color: black; height: 50px; font-size: 15px; left: 70%; width: 30%; top:1%; height: 98%; position: absolute; z-index: 9998; overflow-y: scroll; text-align: left"></div>
			<div id="engSubArea" class="transcript" style="display: none; color: lime; font-size: 25px; font-weight: 900;  height: 50px; bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center"></div>
			<div id="korSubAreaR" class="transcript" style="display: none; border: 1px solid; color: black; height: 50px; font-size: 15px; left: 70%; width: 30%; top:1%; height: 98%; position: absolute; z-index: 9998; overflow-y: scroll; text-align: left"></div>
			<div id="korSubArea" class="transcript" style="display: none; color: lime; font-size: 25px; font-weight: 900;  height: 50px; bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center"></div>
			<div id="mixSubAreaR" class="transcript" style="display: none; border: 1px solid; color: black; height: 50px; font-size: 15px; left: 70%; width: 30%; top:1%; height: 98%; position: absolute; z-index: 9998; overflow-y: scroll; text-align: left"></div>
			<div id="mixSubArea" class="transcript" style="display: none; color: lime; font-size: 25px; font-weight: 900;  height: 50px; bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center"></div>
		</div>
		
		
	</form>
	<input type="hidden" id="defaultSubtitle" data-defaultSubtitle="${defaultSubtitle }">
	<c:forEach items="${bookmarks}" var="bookmarks">
		<input type="hidden" class="bookmarks" data-timestamp = "${bookmarks.subTimestamp }">
	</c:forEach>
	
</body>


<script type="text/javascript" defer="defer" >
		/* 북마크 */
	var video;				// 비디오 정보 
	var uniqueNo = "${newVid.uniqueNo}"; // 현제 비디오 정보.
	var subtitleEng;		// 영어 자막 
	var subtitleKor;		// 한글 자막 
	var subtitleMix;		// 한영 자막 
	var engSubArea;			// 영어자막을 보여주는 div
	var engSubAreaR;		// 영어자막을 보여주는 div 오른쪽에 표시됨 
	var korSubArea;			// 한글자막을 보여주는 div		
	var korSubAreaR;		// 한글자막을 보여주는 div 오른쪽에 표시됨 
	var mixSubArea;			// 한영자막을 보여주는 div
	var mixSubAreaR;		// 한영자막을 보여주는 div 오른쪽에 표시됨 
	var beforeBookImg =  "../resources/image/before_bookmark.png";
	var afterBookImg =  "../resources/image/after_bookmark.png";
	var currentCue;			// 현재 진행되고 있는 장면의 자막 
	var existBookmarks = document.getElementsByClassName("bookmarks");  		// 기존에 가지고 있었던 북마크.
	var bookmarkArray = [];
	for(var i=0;i<existBookmarks.length;i++){
		bookmarkArray.push(existBookmarks[i].dataset.timestamp);
	}
	
	
	/* 좌우키 클릭 이벤트 */
	window.addEventListener("keydown", function(e){
		if(e.keyCode == 37){
			// left
			console.log(cues.length);
			for(var j=0;j<cues.length; j++){
				if (video[0].currentTime > cues[j].startTime && video[0].currentTime <= cues[j].endTime){
					video[0].currentTime = cues[j-1].startTime; 
				}else if( video[0].currentTime > cues[j].endTime && video[0].currentTime <= cues[j+1].startTime){
					video[0].currentTime = cues[j].startTime; 
				}
			} 
		}else if(e.keyCode == 39){
			// right
			for(var j=0;j<cues.length; j++){
				if (video[0].currentTime > cues[j].startTime && video[0].currentTime <= cues[j].endTime){
					video[0].currentTime = cues[j+1].startTime; 
				}else if( video[0].currentTime > cues[j].endTime && video[0].currentTime <= cues[j+1].startTime){
					video[0].currentTime = cues[j+1].startTime; 
				}
			} 
		} 
	})
	
	
	$(function() {
	    var videoWrapper = $('.video-wrapper');
	    
	    // 마지막 시청기록 부터 시작.
	    document.getElementById('videoArea').currentTime="${record.recentPo}";
	    
	    videoWrapper.each(function() {
	        video = $(this).find('video');    /* 비디오 재생 */
	        
	        var videoProperty = document.getElementById("videoArea");
	        engSubArea = document.getElementById("engSubArea");
	        engSubAreaR = document.getElementById("engSubAreaR");
	        korSubArea = document.getElementById("korSubArea");
	        korSubAreaR = document.getElementById("korSubAreaR");
	        mixSubArea = document.getElementById("mixSubArea");
	        mixSubAreaR = document.getElementById("mixSubAreaR");
	        
	        changeSub(document.getElementById("defaultSubtitle").dataset.defaultsubtitle);		// 저장된 자막 종류로 변
	        
	        
	        document.getElementById("trackTagEng").track.mode="hidden";
	        document.getElementById("trackTagKor").track.mode="hidden";
	        document.getElementById("trackTagMix").track.mode="hidden";
	        
	        video.find('track[id="trackTagMix"]').on("load", function(evt) {
	        	subtitleEng = document.getElementById("trackTagEng").track;
	            subtitleKor = document.getElementById("trackTagKor").track;
	            subtitleMix = document.getElementById("trackTagMix").track;
	            
	            subtitleEng.oncuechange = function () {
	            	currentCue = subtitleKor.activeCues[0];
	            }
	            
	            var engSubHtml = '';
	            var korSubHtml = '';
	            var mixSubHtml = '';
	            var engSubHtmlR = '';
	            var korSubHtmlR = '';
	            var mixSubHtmlR = '';
	            
	        	for (var i=0; i<subtitleEng.cues.length; i++){
	        		var imgHtml = '<img id="bookmarkEngImg_'+subtitleEng.cues[i].startTime+'" src = "../resources/image/before_bookmark.png" style="cursor: pointer;  width: 20px; height: 20px;"  onclick="bookmarks('+i+')" ></img>';
	        		var parHtml = '<p role="button" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleEng.cues[i].startTime+
	        		'" data-end-time="'+subtitleEng.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleEng.cues[i].startTime+')">' + subtitleEng.cues[i].text + '</p>';
	        		engSubHtml += parHtml;
	        		engSubHtmlR = engSubHtmlR + imgHtml + parHtml;
	        	}
	        	engSubArea.innerHTML = engSubHtml;
	        	engSubAreaR.innerHTML = engSubHtmlR;
	        	
				for (var i=0; i<subtitleKor.cues.length; i++){
					var imgHtml = '<img id="bookmarkKorImg_'+subtitleKor.cues[i].startTime+'" src = "../resources/image/before_bookmark.png" style="cursor: pointer;  width: 20px; height: 20px;"  onclick="bookmarks('+i+')" ></img>';
	        		var parHtml = '<p role="button" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleKor.cues[i].startTime+
	        		'" data-end-time="'+subtitleKor.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleKor.cues[i].startTime+')">' + subtitleKor.cues[i].text + '</p>';
	        		korSubHtml += parHtml;
	        		korSubHtmlR = korSubHtmlR + imgHtml + parHtml;
	        	}
	        	korSubArea.innerHTML = korSubHtml;
	        	korSubAreaR.innerHTML = korSubHtmlR;
	        	
				for (var i=0; i<subtitleMix.cues.length; i++){
					var imgHtml = '<img id="bookmarkMixImg_'+subtitleMix.cues[i].startTime+'" src = "../resources/image/before_bookmark.png" style="cursor: pointer;  width: 20px; height: 20px;"  onclick="bookmarks('+i+')" ></img>';
	        		var parHtml = '<p role="button" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleMix.cues[i].startTime+
	        		'" data-end-time="'+subtitleMix.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleMix.cues[i].startTime+')">' + subtitleMix.cues[i].text + '</p>';
	        		mixSubHtml += parHtml;
	        		mixSubHtmlR = mixSubHtmlR + imgHtml + parHtml;
	        	}
	        	mixSubArea.innerHTML = mixSubHtml;
	        	mixSubAreaR.innerHTML = mixSubHtmlR;
	           
	        	
	        	for (var i=0;i<bookmarkArray.length;i++){
			        document.getElementById("bookmarkEngImg_"+bookmarkArray[i]).src= afterBookImg;
			        document.getElementById("bookmarkKorImg_"+bookmarkArray[i]).src= afterBookImg;
			        document.getElementById("bookmarkMixImg_"+bookmarkArray[i]).src= afterBookImg;
			    } 
	        	
	        	
	        	
	        	////////////////////////////
	            var isScrolling = 0;
	            var beforeSelectedCue = 0;    /* 이전에 선택된 자막 id */
	            function myFunction(event){
	            	if (event == 0){
		            	for( var i=0; i<cues.length; i++){
		            		/* 현재 시간이 자막의 시작시간과 끝 시간 사이에 있으면 해당 자막을 표시한다. */
		                	if (videoProperty.currentTime >= cues[i].startTime && videoProperty.currentTime <= cues[i].endTime){
		                		/* 자막이 이전과 변했는지 변하지 않았는지 확인한다. 자박이 변화 했으면 다음 자막으로 스크롤 한다. */
		                		if (beforeSelectedCue != cues[i].id){
		                			$('p[data-id='+beforeSelectedCue+']').css({'font-weight':'normal' , 'color' : '#ececed'});
		                			beforeSelectedCue = cues[i].id;
		                			/* p tag의 offsetTop 프로퍼티를 받아와서 스크롤을 그쪽으로 바로 보내도록 하는 코 */
		                			$('.tranScript').animate({scrollTop : $('p[data-id='+cues[i].id+']').prop('offsetTop')},0);
		                			/* $tranScript.html(transcriptHtml); */
		                			$('p[data-id='+cues[i].id+']').css({'font-weight':'bold' , 'color' : 'white'});
		                		}
		                	}
		            	}
	            	}
	            }
	      	});
	    });
	    
	   // 뒤로가기 버튼 눌렀을때 현재 시청기록 저장.
	    document.getElementById("videoBack").addEventListener('click',function(){
	    	var record = document.getElementById('videoArea').currentTime;
	    	var uniqueNo = "${newVid.uniqueNo}";
	    	window.location.href="${pageContext.request.contextPath}/video/backToMain?trackId="+uniqueNo+"&record="+record;
	    })
	});
	
	// 북마크 클릭했을 때 해당 북마크를 없애거나 북마크를 지정하는 함수.
	function bookmarks(index) {
		var isChangeBookMark = true;
		var newStartTime = subtitleEng.cues[index].startTime;
		var newSubtitle = subtitleEng.cues[index].text;
		
		for (var i=0;i<bookmarkArray.length;i++){
	   		if(bookmarkArray[i] == newStartTime){
	   			var xhttp = new XMLHttpRequest();
		   		 xhttp.open("GET", "${pageContext.request.contextPath}/video/deleteBookmark?trackId="+uniqueNo+"&startTime="+newStartTime, true);
		   			xhttp.onreadystatechange = function() {
		   				if(xhttp.readyState == 4 && xhttp.status == 200){		// 정상상태일때 한번만 실행시키게 해준다.
		   					if (xhttp.responseText){							// 응답이 왔으면 실행한다. 이 두개의 if가 없으면 여러번 실행된다.
		   						document.getElementById("bookmarkEngImg_"+newStartTime).src = beforeBookImg;
		   		            	document.getElementById("bookmarkKorImg_"+newStartTime).src = beforeBookImg;
		   		            	document.getElementById("bookmarkMixImg_"+newStartTime).src = beforeBookImg;
		   		            	bookmarkArray.splice(i,1);
		   					}
		   				}
		   			};
		   		xhttp.send();
	   			isChangeBookMark = false;
	   			break;	
	   		}
	     } 
		if(isChangeBookMark){
			var xhttp = new XMLHttpRequest();
			 xhttp.open("GET", "${pageContext.request.contextPath}/video/setBookmark?trackId="+uniqueNo+
					 "&startTime="+newStartTime+"&subtitle="+newSubtitle, true);
				xhttp.onreadystatechange = function() {
					if(xhttp.readyState == 4 && xhttp.status == 200){		// 정상상태일때 한번만 실행시키게 해준다.
						if (xhttp.responseText){							// 응답이 왔으면 실행한다. 이 두개의 if가 없으면 여러번 실행된다.
							document.getElementById("bookmarkEngImg_"+newStartTime).src = afterBookImg;
			            	document.getElementById("bookmarkKorImg_"+newStartTime).src = afterBookImg;
			            	document.getElementById("bookmarkMixImg_"+newStartTime).src = afterBookImg;
			            	bookmarkArray.push(newStartTime);
						}
					}
				};
			xhttp.send();
		}
	}
	
	
	document.getElementById("RScript").addEventListener('click',function(){
		alert("aaa");
	});
	
	// 자막을 클랙했을 때 해당 자막으로 영상이 이동하는 함수.
	function subtitleClkEvnt(startTime) {
	    video[0].currentTime=startTime;
	    /* 자막클릭했을경우 몇번쨰 자막인지 나타내는  */
	    
	    /* myFunction(0); */
	};
	
	// 자막을 선택하기 위해 체크박스를 선택하면 자막을 선택할수 있는 div가 표시되는 함수.
	function selectSubtitleFcn(){
		var subtitleBox = document.getElementById("subtitleBox");
		if(document.getElementById("selectSubtitle").checked){
			subtitleBox.style.display = "block";
		}else{
			subtitleBox.style.display = "none";
		}
	};
	
	// 자막을 선택했을때 해당 자막의 div를 표시해주는 함수. 처음 초기 자막 설정에도 사용.
	function changeSub(selectedSub){
		if(selectedSub == 'kor'){
			korSubArea.style.display="block";
			korSubAreaR.style.display="block";
			engSubArea.style.display="none";
			engSubAreaR.style.display="none";
			mixSubArea.style.display="none";
			mixSubAreaR.style.display="none";
		}else if(selectedSub == 'eng'){
			korSubArea.style.display="none";
			korSubAreaR.style.display="none";
			engSubArea.style.display="block";
			engSubAreaR.style.display="block";
			mixSubArea.style.display="none";
			mixSubAreaR.style.display="none";
		}else if(selectedSub == 'mix'){
			korSubArea.style.display="none";
			korSubAreaR.style.display="none";
			engSubArea.style.display="none";
			engSubAreaR.style.display="none";
			mixSubArea.style.display="block";
			mixSubAreaR.style.display="block";
		}
	};
	
	
	
	/* 
	
	   // 뒤로가기 버튼 눌렀을때 현재 시청기록 저장.
	    document.getElementById("videoBack").addEventListener('click',function(){
	    	var record = document.getElementById('videoArea').currentTime;
	    	var uniqueNo = "${newVid.uniqueNo}";
	    	window.location.href="${pageContext.request.contextPath}/video/backToMain?trackId="+uniqueNo+"&record="+record;
	    })
	 */
	
	


</script>
</html>









