

var scrollingIndex = 0;
document.getElementById("posterChangeRight").addEventListener('click',function(){
	scrollingIndex += 1;
	scrollingIndex = rightSlide("posterArea","posterIndex_",scrollingIndex);
});
document.getElementById("posterChangeLeft").addEventListener('click',function(){
	scrollingIndex -= 1;
	scrollingIndex = leftSlide("posterArea","posterIndex_",scrollingIndex);
});

var recoScrollingIndex = 0;
document.getElementById("recoPosterChangeRight").addEventListener('click',function(){
	recoScrollingIndex += 1;
	recoScrollingIndex = rightSlide("recoPosterArea","recoPosterIndex_",recoScrollingIndex);
});
document.getElementById("recoPosterChangeLeft").addEventListener('click',function(){
	recoScrollingIndex -= 1;
	recoScrollingIndex = leftSlide("recoPosterArea","recoPosterIndex_",recoScrollingIndex);
});


function rightSlide(Area, IndexArea,index){
	index = (index > document.getElementById(Area).childElementCount-6)?0:index;
	console.log(index);
	document.getElementById(Area).scrollLeft = document.getElementById(IndexArea+String(index)).offsetLeft - 70;
	return index;
}

function leftSlide(Area, IndexArea,index){
	index = (index<0)?document.getElementById(Area).childElementCount-6:index;
	document.getElementById(Area).scrollLeft = document.getElementById(IndexArea+String(index)).offsetLeft - 70;
	return index;
}



var beforeDiv;
/* 포스터를 선택했을 때 해당 포스터(시즌)이 가지고 있는 에피소드를 가지고 오는 함수. */
function getEpsoideFcn(event){	
	if(beforeDiv){
		var temp = document.getElementById(beforeDiv);
		document.getElementById(beforeDiv).removeChild(temp.firstChild);
	}
	var tempSession = event;					// 이벤트에 선택된 타이틀과 시즌이 들어온다.
	if (tempSession.length<7){					// 시즌이 한자리인경우 시즌앞에 0을 붙혀준다.
		var season = tempSession[5];
		tempSession = tempSession.substring(0,5) + '0' + tempSession.substring(5+1);
		season = tempSession + season;
	}
	episodeFromCont(season,event);		// 7자리를 맞춘 뒤 컨트롤러와 연결된 Ajax로 보내준다.
}

var episode;  /* episode를 가지고 있는 변수. */
function episodeFromCont(titleSeason,event){     // Ajax로 컨트롤러에 보내 에피소드를 가져오는 함수.
	var xhttp = new XMLHttpRequest();
	xhttp.open("POST", "getEpisode?titleSeason="+titleSeason, true);
	xhttp.onreadystatechange = function() {
		if(xhttp.readyState == 4 && xhttp.status == 200){		// 정상상태일때 한번만 실행시키게 해준다.
			if (xhttp.responseText){							// 응답이 왔으면 실행한다. 이 두개의 if가 없으면 여러번 실행된다.
				console.log("response" + this.responseText);
				var temp = this.responseText;
				temp = temp.replaceAll('<List><item>','');					// String로 불러오기 때문에 ",[,]를 없애주고 ,로 나눠서 array로 만든다.
				temp = temp.replaceAll('</item><item>',',');
				temp = temp.replaceAll('</item></List>','');
				episode = temp.split(',');
				console.log(episode);
				makeSelection(episode,event,titleSeason);					// 만들어진 에피소드 array를 보내 select 함수를 만든다.
			}
		}
	};
	xhttp.send();
}

function makeSelection(episode,event,titleSeason){				// 에피소드를 받아서 셀렉트(드롭박스)를 만드는 함수.
    if (episode==0){
    	// 에피소드가 없는 영화인 경우에는 바로 재생 버튼이 보일수 있도록 한다.
		var button = document.createElement("input");
		button.type = "button";
		button.value = "Play"; // Really? You want the default value to be the type string?
		button.name = "Play"; // And the name too?
		button.className="playBtn";
		button.style.width="100%";
		button.style.height="60px";
		button.addEventListener('click', function() {
			openVideo(titleSeason+episode);
        }, false);
		document.getElementById(event).appendChild(button);
		
    }else{
    	var select = document.createElement("select");			// select 엘리먼트를 만든다.
    	select.name="episodeSelection";							// select 이름을 넣는다.
		select.id="episodeSelection";							// select 아이디를 넣는다.
		select.className="selectEp";							// 클래스 이름을 정해준다.
		select.style.width="100%";
		select.addEventListener('change', function () { 
			openVideo(this.value + this.options[this.selectedIndex].text)	// this.value는 지금 선택된 에피스드를 가져온다.;; this.selectedIndex로 선택된 인덱스위치의 options 텍스트를 구한다.
		}, false);
		
		var firstOption = document.createElement("option");
		firstOption.value="none";
		firstOption.text="에피소트 선택";
		select.appendChild(firstOption);				
		for(var j=0; j<episode.length; j++){						// 받아온 에피소드 수 만큼 반복해주면서 option을 생성한다.
			var option = document.createElement("option");
			option.value = titleSeason;								// option 값을 넣어준다.
			option.text = episode[j];								// 표시될 옵션 텍스트를 넣어준다.
			select.appendChild(option);							// 만들어진 옵션을 셀렉트 밑에 넣어준다.
		}
		document.getElementById(event).appendChild(select);
    }
	beforeDiv=event;
} 

function openVideo(videoNo){					// 이 함수에서 비디오 플레이 화면으로 넘어간다.
	window.location.href="video/play?trackId="+videoNo;
	/* windowObjectReference = window.open("${pageContext.request.contextPath}/video/play?trackId="+videoNo, 
			"_blank"); */
}
	