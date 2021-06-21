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
		<input type="radio" name="selectedSubtitle" id="KorRadio" value="Kor" ><label for="KorRadio">한</label>
		<input type="radio" name="selectedSubtitle" id="EngRadio" value="Eng"  ><label for="EngRadio">영</label>
		<input type="radio" name="selectedSubtitle" id="MixRadio" value="Mix"  ><label for="MixRadio">한/영</label>
		<input type="radio" name="selectedSubtitle" id="NonRadio" value="Non"  ><label for="NonRadio">자막 없음</label>
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
			<div id="engSubArea" class="transcript" style="display: none; color: white; font-size: 25px; font-weight: 900;  height: 60px; bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center"></div>
			<div id="korSubAreaR" class="transcript" style="display: none; border: 1px solid; color: black; height: 50px; font-size: 15px; left: 70%; width: 30%; top:1%; height: 98%; position: absolute; z-index: 9998; overflow-y: scroll; text-align: left"></div>
			<div id="korSubArea" class="transcript" style="display: none; color: white; font-size: 25px; font-weight: 900;  height: 60px; bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center"></div>
			<div id="mixSubAreaR" class="transcript" style="display: none; border: 1px solid; color: black; height: 50px; font-size: 15px; left: 70%; width: 30%; top:1%; height: 98%; position: absolute; z-index: 9998; overflow-y: scroll; text-align: left"></div>
			<div id="mixSubArea" class="transcript" style="display: none; color: white; font-size: 25px; font-weight: 900;  height: 60px; bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center"></div>
		</div>
		
		
	</form>
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
	var currentSubtitle = "${defaultSubtitle }";
	var isRightSubtitle = false;
	var mScrollHeight;
	var rScrollHeight;
	
	
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
	    document.getElementById('videoArea').currentTime="${record.recentPo}";				// 기존에 있던 재생 구간으로 이동한다.
	    
	    videoWrapper.each(function() {
	        video = $(this).find('video');    /* 비디오 재생 */
	        
	        var videoProperty = document.getElementById("videoArea");						// 비디오, 자막 위치 정보를 가져온다.
	        engSubArea = document.getElementById("engSubArea");
	        engSubAreaR = document.getElementById("engSubAreaR");
	        korSubArea = document.getElementById("korSubArea");
	        korSubAreaR = document.getElementById("korSubAreaR");
	        mixSubArea = document.getElementById("mixSubArea");
	        mixSubAreaR = document.getElementById("mixSubAreaR");
	        
	        changeSub();		// 저장된 자막 종류로 시작.
	        
	        
	        document.getElementById("trackTagEng").track.mode="hidden";							// 테그들을 안보이게 다 숨긴다.
	        document.getElementById("trackTagKor").track.mode="hidden";
	        document.getElementById("trackTagMix").track.mode="hidden";
	        
	        video.find('track[id="trackTagMix"]').on("load", function(evt) {					// 트랙 테그가 로딩완료되면 실행.
	        	subtitleEng = document.getElementById("trackTagEng").track;						// 각종 테그의 정보를 가져온다.
	            subtitleKor = document.getElementById("trackTagKor").track;	
	            subtitleMix = document.getElementById("trackTagMix").track;
	            
	            
	            
	            var engSubHtml = '';				// 동적으로 자막과 이미지를 생성하기 위해 변수를 만들어준다.
	            var korSubHtml = '';
	            var mixSubHtml = '';
	            var engSubHtmlR = '';
	            var korSubHtmlR = '';
	            var mixSubHtmlR = '';
	            
	        	for (var i=0; i<subtitleEng.cues.length; i++){				// 자막 길이만큼 반복실행하면서 자막과 이미지를 만든다.
	        		var imgHtml = '<img id="bookmarkEngImg_'+subtitleEng.cues[i].startTime+'" src = "../resources/image/before_bookmark.png" style="cursor: pointer;  width: 20px; height: 20px;"  onclick="bookmarks('+i+')" ></img>';
	        		var parHtml = '<p role="button" id="subTitle_eng'+subtitleEng.cues[i].startTime+'" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleEng.cues[i].startTime+
	        		'" data-end-time="'+subtitleEng.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleEng.cues[i].startTime+')">' + subtitleEng.cues[i].text + '</p>';
	        		var parHtmlR = '<p role="button" id="subTitle_R_eng'+subtitleEng.cues[i].startTime+'" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleEng.cues[i].startTime+
	        		'" data-end-time="'+subtitleEng.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleEng.cues[i].startTime+')">' + subtitleEng.cues[i].text + '</p>';
	        		engSubHtml += parHtml;
	        		engSubHtmlR = engSubHtmlR + imgHtml + parHtmlR;	// 오른쪽 자막 구간에는 북마크 이미지까지 더해준다.
	        	}
	        	engSubArea.innerHTML = engSubHtml;					// 동적으로 만든 자막들을 해당 위치에 넣는다.
	        	engSubAreaR.innerHTML = engSubHtmlR;
	        	
				for (var i=0; i<subtitleKor.cues.length; i++){
					var imgHtml = '<img id="bookmarkKorImg_'+subtitleKor.cues[i].startTime+'" src = "../resources/image/before_bookmark.png" style="cursor: pointer;  width: 20px; height: 20px;"  onclick="bookmarks('+i+')" ></img>';
	        		var parHtml = '<p role="button" id="subTitle_kor'+subtitleKor.cues[i].startTime+'" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleKor.cues[i].startTime+
	        		'" data-end-time="'+subtitleKor.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleKor.cues[i].startTime+')">' + subtitleKor.cues[i].text + '</p>';
	        		var parHtmlR = '<p role="button" id="subTitle_R_kor'+subtitleKor.cues[i].startTime+'" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleKor.cues[i].startTime+
	        		'" data-end-time="'+subtitleKor.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleKor.cues[i].startTime+')">' + subtitleKor.cues[i].text + '</p>';
	        		korSubHtml += parHtml;
	        		korSubHtmlR = korSubHtmlR + imgHtml + parHtmlR;
	        	}
	        	korSubArea.innerHTML = korSubHtml;
	        	korSubAreaR.innerHTML = korSubHtmlR;
	        	
				for (var i=0; i<subtitleMix.cues.length; i++){
					var imgHtml = '<img id="bookmarkMixImg_'+subtitleMix.cues[i].startTime+'" src = "../resources/image/before_bookmark.png" style="cursor: pointer;  width: 20px; height: 20px;"  onclick="bookmarks('+i+')" ></img>';
	        		var parHtml = '<p role="button" id="subTitle_mix'+subtitleEng.cues[i].startTime+'" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleMix.cues[i].startTime+
	        		'" data-end-time="'+subtitleMix.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleMix.cues[i].startTime+')">' + subtitleMix.cues[i].text + '</p>';
	        		var parHtmlR = '<p role="button" id="subTitle_R_mix'+subtitleEng.cues[i].startTime+'" tabindex="0" class="cuePoint" name="cuePoint_'+i+'" data-id="'+i+'" data-start-time="'+subtitleEng.cues[i].startTime+
	        		'" data-end-time="'+subtitleEng.cues[i].endTime+'" style="margin: 100px" onclick="subtitleClkEvnt('+subtitleEng.cues[i].startTime+')">' + subtitleEng.cues[i].text + '</p>';
	        		mixSubHtml += parHtml;
	        		mixSubHtmlR = mixSubHtmlR + imgHtml + parHtmlR;
	        	}
	        	mixSubArea.innerHTML = mixSubHtml;
	        	mixSubAreaR.innerHTML = mixSubHtmlR;
	           
	        	
	        	for (var i=0;i<bookmarkArray.length;i++){						// 북마크가 있는경우 그 위치에 북마크 이미지를 변화시켜준다.
			        document.getElementById("bookmarkEngImg_"+bookmarkArray[i]).src= afterBookImg;
			        document.getElementById("bookmarkKorImg_"+bookmarkArray[i]).src= afterBookImg;
			        document.getElementById("bookmarkMixImg_"+bookmarkArray[i]).src= afterBookImg;
			    } 
	        	
	        	
	        	// 자막이 변하는 이벤트. 자막이 변하면서 해당 자막의 offsetTop을 가져와서 scroll 위치를 그쪽으로 옮겨준다.
	        	subtitleEng.oncuechange = function () {	
	        		console.log(video.currentTime);
	        		if(typeof subtitleKor.activeCues[0] !== "undefined"){
	        			currentCue = subtitleKor.activeCues[0].startTime;
		            	var pTag = document.getElementById('subTitle_'+currentSubtitle+currentCue).offsetTop;
		            	var pTagR = document.getElementById('subTitle_R_'+currentSubtitle+currentCue).offsetTop;
		            	document.getElementById(currentSubtitle + "SubArea").scrollTop = pTag;
		            	document.getElementById(currentSubtitle + "SubAreaR").scrollTop = pTagR - 
		            	document.getElementById(currentSubtitle + "SubAreaR").offsetHeight/2;
	        		}else{
	        			document.getElementById(currentSubtitle + "SubArea").scrollTop +=
	        			document.getElementById(currentSubtitle + "SubAreaR").offsetHeight;
	        		}
	            	
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
	    	console.log(record);
	    	var uniqueNo = "${newVid.uniqueNo}";
	    	window.location.href="${pageContext.request.contextPath}/video/backToMain?trackId="+uniqueNo+"&record="+record;
	    })
	});
	
	// 북마크 클릭했을 때 해당 북마크를 없애거나 북마크를 지정하는 함수.
	function bookmarks(index) {
		var isChangeBookMark = true;						// 북마크가 변했는지 확인한다. 기존에 있던 북마크는 북마크를 삭제시키기 위해 확인한다.
		var newStartTime = subtitleEng.cues[index].startTime;	// 선택된 북마크 시간.
		var newSubtitle = subtitleEng.cues[index].text;			// 선택된 북마크 자막.
		
		for (var i=0;i<bookmarkArray.length;i++){				// 기존에 북마크에 있는지 확인한다.
	   		if(bookmarkArray[i] == newStartTime){				// 기존에 북마크가 있으면 삭제 코드를 실행한다.
	   			var xhttp = new XMLHttpRequest();
		   		 xhttp.open("GET", "${pageContext.request.contextPath}/video/deleteBookmark?trackId="+uniqueNo+"&startTime="+newStartTime, true);
		   			xhttp.onreadystatechange = function() {
		   				if(xhttp.readyState == 4 && xhttp.status == 200){		// 정상상태일때 한번만 실행시키게 해준다.
		   					if (xhttp.responseText){							// 응답이 왔으면 실행한다. 이 두개의 if가 없으면 여러번 실행된다.
		   						document.getElementById("bookmarkEngImg_"+newStartTime).src = beforeBookImg;		// 삭제됐으면 북마크 이미지를 변화시켜준다.
		   		            	document.getElementById("bookmarkKorImg_"+newStartTime).src = beforeBookImg;
		   		            	document.getElementById("bookmarkMixImg_"+newStartTime).src = beforeBookImg;
		   		            	bookmarkArray.splice(i,1);						// 삭제 시킨 북마크 정보를 JavaScript에서 가지고 있는 북마크 정보에서 없애준다.
		   					}
		   				}
		   			};
		   		xhttp.send();
	   			isChangeBookMark = false;	// false시켜줘서 북마크 넣는 코드를 실행시키지 않는다.
	   			break;	
	   		}
	     } 
		if(isChangeBookMark){				// 처음 눌린 북마크면 북마크를 넣어주는 코드를 실행한다.
			var xhttp = new XMLHttpRequest();
			 xhttp.open("GET", "${pageContext.request.contextPath}/video/setBookmark?trackId="+uniqueNo+
					 "&startTime="+newStartTime+"&subtitle="+newSubtitle, true);
				xhttp.onreadystatechange = function() {
					if(xhttp.readyState == 4 && xhttp.status == 200){		// 정상상태일때 한번만 실행시키게 해준다.
						if (xhttp.responseText){							// 응답이 왔으면 실행한다. 이 두개의 if가 없으면 여러번 실행된다.
							document.getElementById("bookmarkEngImg_"+newStartTime).src = afterBookImg;		// 북마크를 성공적으로 넣었으면 북마크 이미지를 변화시켜준다.
			            	document.getElementById("bookmarkKorImg_"+newStartTime).src = afterBookImg;
			            	document.getElementById("bookmarkMixImg_"+newStartTime).src = afterBookImg;
			            	bookmarkArray.push(newStartTime);										// 입력한 북마크 정보를 JavaScript에서 다루는 북마크 정보에 넣어준다.
						}
					}
				};
			xhttp.send();
		}
	}
	
	
	
	
	// div를 스크롤 했을 경우.
	document.getElementById("korSubAreaR").addEventListener('scroll',function(){
		rScrollHeight=document.getElementById("korSubAreaR").scrollTop;
	});
	document.getElementById("korSubArea").addEventListener('scroll',function(){
		mScrollHeight=document.getElementById("korSubArea").scrollTop;
	})
	document.getElementById("engSubAreaR").addEventListener('scroll',function(){
		rScrollHeight=document.getElementById("engSubAreaR").scrollTop;
	});
	document.getElementById("engSubArea").addEventListener('scroll',function(){
		mScrollHeight=document.getElementById("engSubArea").scrollTop;
	})
	document.getElementById("mixSubAreaR").addEventListener('scroll',function(){
		rScrollHeight=document.getElementById("mixSubAreaR").scrollTop;
	});
	document.getElementById("mixSubArea").addEventListener('scroll',function(){
		mScrollHeight=document.getElementById("mixSubArea").scrollTop;
	})
	
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
	
	// 자막 선택 라디오 버튼을 누르면 자막이 진행되는 코드.
	document.getElementById("KorRadio").addEventListener('click',function(event){
		currentSubtitle='kor';
		changeSub();
		document.getElementById("korSubArea").scrollTop = mScrollHeight;
		document.getElementById("korSubAreaR").scrollTop = rScrollHeight;
	});
	document.getElementById("EngRadio").addEventListener('click',function(event){
		currentSubtitle='eng';
		changeSub();
		document.getElementById("engSubArea").scrollTop = mScrollHeight;
		document.getElementById("engSubAreaR").scrollTop = rScrollHeight;
	});
	document.getElementById("MixRadio").addEventListener('click',function(event){
		currentSubtitle='mix';
		changeSub();
		document.getElementById("mixSubArea").scrollTop = mScrollHeight;
		document.getElementById("mixSubAreaR").scrollTop = rScrollHeight;
	});
	document.getElementById("NonRadio").addEventListener('click',function(event){
		currentSubtitle='non';
		changeSub();
	});
	
	// 오른쪽 자막 스크립트를 보이거나 보이지 않거나 하는 버튼.
	document.getElementById("RScript").addEventListener('click',function(){
		isRightSubtitle = (isRightSubtitle)?false:true;
		changeSub();
	});
	
	// 자막을 선택했을때 해당 자막의 div를 표시해주는 함수. 처음 초기 자막 설정에도 사용.
	function changeSub(){
			korSubArea.style.display=(currentSubtitle == 'kor')?'block':'none';
			korSubAreaR.style.display=(currentSubtitle == 'kor' && isRightSubtitle)?'block':'none';
			engSubArea.style.display=(currentSubtitle == 'eng')?'block':'none';
			engSubAreaR.style.display=(currentSubtitle == 'eng' && isRightSubtitle)?'block':'none';
			mixSubArea.style.display=(currentSubtitle == 'mix')?'block':'none';
			mixSubAreaR.style.display=(currentSubtitle == 'mix' && isRightSubtitle)?'block':'none';
			// 변경된 자막을 맴버 정보에 default 값으로 변경해 준다.
			var xhttp = new XMLHttpRequest();
			 xhttp.open("GET", "${pageContext.request.contextPath}/video/setDefaultCaption?caption="+currentSubtitle, true);
				xhttp.onreadystatechange = function() {
					if(xhttp.readyState == 4 && xhttp.status == 200){		// 정상상태일때 한번만 실행시키게 해준다.
						if (xhttp.responseText){							// 응답이 왔으면 실행한다. 이 두개의 if가 없으면 여러번 실행된다.
						}
					}
				};
			xhttp.send();
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









