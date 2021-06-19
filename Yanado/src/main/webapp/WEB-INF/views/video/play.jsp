<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
<title>Home</title>
<link rel="shortcut icon" href="#">

	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script type="text/javascript"  >
/* 북마크 */
var $video;
var cues;






function bookMarkFcn(event) {
	var cues = $video[0].textTracks[0].cues; 
	var startTime = cues[event].startTime;
	var subTitle = cues[event].text;
	
	var id = $("#id").val();
	var uniqueNo = $("#uniqueNo").val();
	
	$.ajax({
			url : '/video/bookmark.do',
			type : 'get',
			data : {
				"subTimestamp" : startTime,
				"id" : id,
				"uniqueNo" : uniqueNo,
				"subtitle": subTitle
			},
			success : function(data) {
				alert("성공")
			},
			error : function() {
				alert("실패");
			}
		})
};


/* 좌우키 클릭 이벤트 */
window.addEventListener("keydown", function(e){
	if(e.keyCode == 37){
		// left
		console.log(cues.length);
		for(var j=0;j<cues.length; j++){
			if ($video[0].currentTime > cues[j].startTime && $video[0].currentTime <= cues[j].endTime){
				$video[0].currentTime = cues[j-1].startTime; 
			}else if( $video[0].currentTime > cues[j].endTime && $video[0].currentTime <= cues[j+1].startTime){
				$video[0].currentTime = cues[j].startTime; 
			}
		} 
	}else if(e.keyCode == 39){
		// right
		for(var j=0;j<cues.length; j++){
			if ($video[0].currentTime > cues[j].startTime && $video[0].currentTime <= cues[j].endTime){
				$video[0].currentTime = cues[j+1].startTime; 
			}else if( $video[0].currentTime > cues[j].endTime && $video[0].currentTime <= cues[j+1].startTime){
				$video[0].currentTime = cues[j+1].startTime; 
			}
		} 
	} 
})

	function trackOnLoad(){
		alert("dddd");
		var video = document.getElementById("videoArea");
		
		video.textTracks[0].mode="hidden";
		video.textTracks[1].mode="hidden";
		video.textTracks[2].mode="hidden";
		console.log(video.textTracks[0].cues);
		console.log(video.textTracks[1].cues);
		console.log(video.textTracks[2].cues);
	}


$(function() {
    var $videoWrapper = $('.video-wrapper');
    $videoWrapper.each(function() {
        $video = $(this).find('video');    /* 비디오 재생 */
       
        var $transcript = $(this).find('.transcript');	/*  자막이 들어갈 div 위치 */
        var vid = document.getElementById("videoArea");
        $video.find('track[kind="chapters"]').on("load", function(evt) {
        	
            var $video  = $(this).closest('video');
            var transcriptHtml = '';  /* 전체 자막 텍스트를 넣을 곳*/
            cues = $video[0].textTracks[0].cues; 
        	for (var i=0; i<cues.length; i++) {
        		transcriptHtml += '<a onClick="bookMarkFcn('+i+'); return false;"><img  src="../resources/image/before_bookmark.png"   style=" width: 20px;position: absolute; left: 10px" ></a>';
        		
                transcriptHtml += '<p role="button" tabindex="0" class="cuepoint" name="cuepoint'+cues[i].id+'" data-id="'+cues[i].id+'" data-start-time="'+cues[i].startTime+'" data-end-time="'+cues[i].endTime+'" style="margin-left: 100px">' + cues[i].text + '</p>';
            }
            $transcript.html(transcriptHtml);
            
            var $cuepoints = $transcript.find('.cuepoint');
            /* 자막 클릭 이벤트 */
            $cuepoints.click(function() {
                var $cuepoint = $(this);
                var $videoWrapper = $cuepoint.closest('.video-wrapper');
                var $transcript = $cuepoint.closest('.transcript');     /* 현재 누른 자막  */
                $video = $videoWrapper.find('video');				
                var $cuepoints = $transcript.find('.cuepoint');			/* 현재 누른 자막의 포인트 */
                $video[0].currentTime = $cuepoint.data('startTime');	/* 비디오가 현재 누른 자막의 시작 점으로 이동 */
                $cuepoints.each(function() {
                    $(this).removeClass('active');					
                });
                $cuepoint.addClass('active');
                /* 자막클릭했을경우 몇번쨰 자막인지 나타내는  */
                var clickedValue = $(this).data("id");
                myFunction(0);
            });
            
            
            var isScrolling = 0;
            /* 스크롤 할 경우 나타나는 이벤트 */
            $( ".transcript" ).scroll(function() {
            	/* 스크롤 할 경우 나타나는 이벤트 */
            	isScrolling = 1;
  				/* 스크롤을 멈췄을때 1초 뒤에 isScrolling	를 0 으로 바꿔서 기존 자막대로 가도록 한다. */          	
            	clearTimeout($.data(this, 'scrollTimer'));
            	$.data(this, 'scrollTimer', setTimeout(function() {
            		isScrolling = 0;
            	}, 1000)); 
            	
          	});
            /* 동영상 재생구간을 다른 곳으로 이동했을 때 */
           vid.onseeking = function(){
        	   myFunction(0);
           };
            /* 현재 비디오 재생 시간위치를 실시간으로 업데이트 한다. */
            vid.ontimeupdate = function(){myFunction(isScrolling)}; /* isScrolling을 넣어줘서 스크롤 중에는 실행 안되도록 한다. */
            
            var tempVal = 0;    /* 이전에 선택된 자막 id */
            function myFunction(event){
            	if (event == 0){
	            	for( var i=0; i<cues.length; i++){
	            		/* 현재 시간이 자막의 시작시간과 끝 시간 사이에 있으면 해당 자막을 표시한다. */
	                	if (vid.currentTime >= cues[i].startTime && vid.currentTime <= cues[i].endTime){
	                		/* 자막이 이전과 변했는지 변하지 않았는지 확인한다. 자박이 변화 했으면 다음 자막으로 스크롤 한다. */
	                		if (tempVal != cues[i].id){
	                			$('p[data-id='+tempVal+']').css({'font-weight':'normal' , 'color' : '#ececed'});
	                			tempVal = cues[i].id;
	                			/* p tag의 offsetTop 프로퍼티를 받아와서 스크롤을 그쪽으로 바로 보내도록 하는 코 */
	                			$('.transcript').animate({scrollTop : $('p[data-id='+cues[i].id+']').prop('offsetTop')},0);
	                			/* $transcript.html(transcriptHtml); */
	                			$('p[data-id='+cues[i].id+']').css({'font-weight':'bold' , 'color' : 'white'});
	                		}
	                	}
	            	}
            	}
            }
            var tempHeight = $('.transcript').height();
            
            
      	});
        
    });
    
    
    
    
});



/* 

   // 뒤로가기 버튼 눌렀을때 현재 시청기록 저장.
    document.getElementById("videoBack").addEventListener('click',function(){
    	var record = document.getElementById('videoArea').currentTime;
    	var uniqueNo = "${newVid.uniqueNo}";
    	window.location.href="${pageContext.request.contextPath}/video/backToMain?trackId="+uniqueNo+"&record="+record;
    })
 */



</script>

<style type="text/css">
* { 
  box-sizing: border-box;
  font-family: Avenir, Helvetica, sans-serif;
}


.cuePoint {
    cursor: pointer;
    font-weight: normal;
    color: #9c9c9c;
    &:hover, &.active {
        color: #000;
    }
}
.tranScript::-webkit-scrollbar {
    display: none;
     -ms-overflow-style: none;  /* IE and Edge */
 	 scrollbar-width: none;  /* Firefox */
}
</style>
</head>
<body>

<%-- <input type="button" value="back" id="videoBack"><br>
<div class="video-wrapper" style="z-index:9997;  border: 1px solid; position: relative;" >
     
	<video id="videoArea" crossorigin="anonymous" controls  autoplay="autoplay">
        <source src="${newVid.link }">
        <track id="chaptersTrack01" class="chaptersTrack" src="${newVid.subKor } " kind="chapters" default>
    </video>
   
    <div id="subTitleArea" class="tranScript" style="color: lime; font-size: 25px; font-weight: 900;  height: 50px;
    bottom: 13%; left: 10%; width: 50%;  position: absolute; z-index:9998;  overflow-y:scroll; text-align: center "></div>
</div>
 --%>


	<input type="button" value="back" id="videoBack"><br>
	<form id="play" action="/video/play" method="get">
		<div class="video-wrapper" style="border: 1px solid; position: relative;">
			<video id="videoArea" crossorigin="anonymous" controls  width=70% >
				<source id="uniqueNo2" src="${newVid.link }" type="video/mp4"> <!-- 클릭할 자막  --> 
				<track id="trackTagEng"  src="${newVid.subEng } " kind="chapters" >
				<track id="trackTagKor"  src="${newVid.subKor } " kind="chapters"  ">
				<track id="trackTagMix"  src="${newVid.subMix } " kind="chapters"   >
			</video>
			<p hidden="hidden"> </p>
			<div id="subTitleArea" class="transcript" style="color: black; font-size: 15px; left: 70%; width: 30%; top:1%; height: 98%; position: absolute; z-index: 9998; overflow-y: scroll; text-align: left"></div>
		</div>
		
		<c:forEach var="bookmark" items="${bookMark }">
			<c:choose>
				<c:when test="${null eq bookmark.subTimestamp}">
					<a href="#">${bookmark.subTimestamp } 
					<img src="/resources/image/before_bookmark.png" id="btn_like" align="left" style="cursor: pointer; width: 20px;">
					</a>
				</c:when>
				<c:otherwise>
					<a href="#"> 
					<img src="/resources/image/afger_bookmark.png" id="btn_like" align="left" style="cursor: pointer;  width: 20px;">
					</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
	</form>
</body>
</html>









