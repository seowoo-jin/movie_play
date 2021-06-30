<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>

<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/board.css" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/tui.pagination/latest/tui-pagination.css" />
<script src="https://uicdn.toast.com/tui.pagination/v3.4.0/tui-pagination.js"></script>
<script src="https://uicdn.toast.com/grid/latest/tui-grid.js"></script>
<script src="https://uicdn.toast.com/tui-tree/latest/tui-tree.js"></script>
<link rel="stylesheet" type="text/css" href="https://uicdn.toast.com/tui-tree/latest/tui-tree.css" />
<link href="${pageContext.request.contextPath}/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<title>admin page</title>
</head>


<body>
	<div id="head">
		<jsp:include page="../header.jsp" flush="false">
			<jsp:param name="param1" value="" />
		</jsp:include>
	</div>


<!--sideBar CSS soojung_0625 -->
	<nav class="main-menu">
		<ul>
			<li>
				<a href="javascript:void(0);"onClick="loadDoc('stat');return false;"> 
					<i class="fa fa-bar-chart-o fa-2x"></i> 
					<span class="nav-text">통계 </span>
				</a>
			</li>
			<li class="has-subnav" onclick="dis()">
				<a href="javascript:void(0);" onClick="loadDoc('video/board');return false;"> 
					<i class="fa fa-laptop fa-2x"></i> 
					<span class="nav-text">영화관리 </span>
				</a>
			</li>
			
			<div id="submenu">
				<li class="has-subnav">
					<a href="javascript:void(0);" onClick="loadDoc('video/board');return false;"> 
						<i class="slidedown"></i> 
						<span class="nav-text"> - 영화 게시판 </span>
					</a>
				</li>
				<li class="has-subnav">
					<a href="javascript:void(0);"onClick="loadDoc('video/write');return false;"> 
						<i class="slidedown"> </i> 
						<span class="nav-text"> - 영화등록 </span>
					</a>
				</li>
				<li class="has-subnav">
					<a href="javascript:void(0);" onClick="loadDoc('video/teaser');return false;"> 
						<i class="slidedown"></i> 
						<span class="nav-text"> - 예고편 </span>
					</a>
				</li>
			</div>
				<li class="has-subnav">
					<a href="javascript:void(0);" onClick="loadDoc('member');return false;"> 
						<i class="fa fa-table fa-2x"></i> 
						<span class="nav-text"> 멤버관리</span>
					</a>
				</li>
				<li class="has-subnav">
					<a href="javascript:void(0);" onClick="loadDoc('qna');return false;"> 
						<i class="fa fa-font fa-2x"></i> 
						<span class="nav-text"> Q&A </span>
					</a>
				</li>
		</ul>
	</nav>




	<!-- <div class="container">
      <div class="sidemenu" role="banner">
         <div class="nav-wrap">
            <nav class="main-nav" role="navigation">
               <ul class="unstyled list-hover-slide">
                  <li><a href="javascript:void(0);" onClick="loadDoc('stat');return false;">통계</a></li>
                  <li>
                  <input class="list-hover-slide" type="checkbox" id="check">
                  <label for="check" class="main-nav">영화 관리</label>
                     <ul class="qna-list" id="qna-list">
                        <li><a href="javascript:void(0);" onClick="loadDoc('video/board');return false;"> 영화 관리</a></li>
                        <li><a href="javascript:void(0);" onClick="loadDoc('video/write');return false;"> 영화 등록</a></li>
                        <li><a href="javascript:void(0);" onClick="loadDoc('video/teaser');return false;"> 예고편</a></li>
                     </ul>
                  </li>
                  <li><a href="javascript:void(0);" onClick="loadDoc('member');return false;">맴버관리</a></li>
                  <li><a href="javascript:void(0);" onClick="loadDoc('qna');return false;">Q&A</a></li>
               </ul>
            </nav>
         </div>
      </div> -->
	<!--사이드 메뉴 끝  -->

	<div class="article" id="article" style="background-color: #2f2e2f;">
		<jsp:include page="stat.jsp" flush="false">
			<jsp:param name="param1" value="" />
		</jsp:include>
	</div>
	</div>



	<script>
	window.onload=function(){
		loadDoc('qna');
	}
		/*sidbar  */
		function dis() {
			if ($('#submenu').css('display') == 'none') {
				$('#submenu').show();
			} else {
				$('#submenu').hide();
			}
		}

		/* ajax를 javascript로 나타낸 것 */
		function loadDoc(event) {
			console.log(event);
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					if (xhttp.responseText) {
						if ((event === "video/board" || event === "video/teaser")
								|| event === "member") {
							console.log(event);
							document.getElementById('article').innerHTML = stripAndExecuteScript(
									this.responseText, event);
						} else {
							document.getElementById("article").innerHTML = this.responseText;
						}
					}
				}
			};
			xhttp.open("GET", "${pageContext.request.contextPath}/admin/" + event, true);
			xhttp.send();
		}

		function stripAndExecuteScript(text, event) {
			var filename = event.replaceAll('/', '');
			var scripts = '';
			var cleaned = text.replace(/<script[^>]*>([\s\S]*?)<\/script>/gi,
					function() {
						scripts += arguments[1] + '\n';
						return '';
					});
			if (window.execScript) {
				window.execScript(scripts);
			} else {
				var head = document.getElementsByTagName('head')[0];
				var scriptElement = document.createElement('script');
				scriptElement.setAttribute('src','${pageContext.request.contextPath}/resources/js/' + filename + '.js');
				scriptElement.setAttribute('defer', '');
				scriptElement.innerText = scripts;
				head.appendChild(scriptElement);
				head.removeChild(scriptElement);
			}
			return cleaned;
		};

		/* 파일을 선택하면 비동기 방식으로 filePath 메소드를 실행시켜 선택된 파일의 경로를 가져온다. */
		function FilePath(event) {
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
						document.getElementById(event).value = this.responseText;
				}
			};
			xhttp.open("GET", "${pageContext.request.contextPath}/admin/filePath", true);
			xhttp.send();

		}

		/* 제목을 선택했을때 실행되는 함수  */
		function selectedTitle() {
			var title = document.getElementById("selectTitle"); // 드롭박스에서 선택했을때 드롭박스 정보를 가져온다.
			var text = title.options[title.selectedIndex].text; // 선택된 아이템의 이름을 가져온다. 
			var value = title.options[title.selectedIndex].value; // 선택된 아이템의 고유번호를 가져온다. 

			document.getElementById("title").value = text; // title란에 선택된 이름을 넣는다.
			document.getElementById("titleSeq").value = value; // 히든 란에 고유번호를 넣는다.
		}

		/* 새로운 타이틀을 넣기위해 체크박스를 선택하면 실행된다. */
		function newTitleAval() {
			document.getElementById("title").value = ""; // 타이틀란에 새로 적을 수 있게 빈칸으로 만들어 준다.
			document.getElementById("titleSeq").value = 0; // 고유번호는 0으로 넘겨줘서 새로운 타이틀이라는 것을 알려준다.
		}

		/* 테그를 선택할 때마다 실행시킨다. */
		function selectedTag() {
			var tag = document.getElementById("selectTag"); // 드롭박스 정보를 가져온다.
			var text = tag.options[tag.selectedIndex].text; // 선택된 아이템의 텍스트 정보를 가져온다.
			var value = tag.options[tag.selectedIndex].value; // 선택된 아이템의 값을 가져온다.

			if (value != 99999) { // value가 99999면 새로운 값을 넣어 주는 것이다. 그렇지 않은 경우는 기존의 값을 '&'다음에 적어준다.
				var temp = document.getElementById("tag").value;
				document.getElementById("tag").value = temp + '&' + text;
			}
		}

		// Q&A board 
		function accordion(event) {
			console.log("click");
			var panel = document.getElementById("panel_" + event); //현재 아코디언의 다음노트를 가져온다. panel이 옴 
			if (panel.style.display === "block") { //출력모드가 블럭인지 none인지 체크한다. 
				panel.style.display = "none";
			} else {
				panel.style.display = "block";
			}
		}
		// 답글 달기.
		function reply(qnaSeq) {
			var reply = document.getElementById("replyString_" + qnaSeq).value;
			console.log(reply);
			loadDoc("reply?qnaSeq=" + qnaSeq + "&reply=" + reply); //
		}
		
		function sendYear(){
			var checkValue = document.getElementsByName("selectYear");
			var years = '';
			for(var i=0; i<checkValue.length;i++){
				if(checkValue[i].checked){
					years = years + '*' + checkValue[i].value;
				}
			}
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					if (xhttp.responseText) {
						console.log("success");
						document.getElementById("article").innerHTML = this.responseText;
						document.getElementById("resultTables").style.display= 'block';
					}
				}
			};
			xhttp.open("GET", "${pageContext.request.contextPath}/admin/genearteStat?years="+years, true);
			xhttp.send();
		}
		
		function reportGenerate(){
			var checkValue = document.getElementsByName("selectYear");
			var years = '';
			for(var i=0; i<checkValue.length;i++){
				if(checkValue[i].checked){
					years = years + '*' + checkValue[i].value;
				}
			}
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function() {
				if (xhttp.readyState == 4 && xhttp.status == 200) {
					if (xhttp.responseText) {
						console.log("success");
					}
				}
			};
			xhttp.open("GET", "${pageContext.request.contextPath}/admin/generatePDF?years="+years, true);
			xhttp.send();
		}
		
		
		

	</script>
</body>
</html>