<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>

<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/poster.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/board.css" rel="stylesheet" type="text/css">
   
<!-- Sidebar menu css -->
<link href="${pageContext.request.contextPath}/resources/css/sidebar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/member_main.css?ver=1" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/member_base.css?ver=1" rel="stylesheet" type="text/css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<title>MyPage</title>
</head>

<body >

<%@ include file="/WEB-INF/views/header.jsp" %>


<main class="yanado_main" >
       
    
            <!-- my page start  -->
            <div class="s-content content">
                <main class="row content__page">
                    
                    <section class="column large-full entry format-standard">
                        <!-- 그냥 디자인 요소임_사진  -->
                        <div class="media-wrap">
                            <div>
                                <img src="../resources/image/mypage.jpg.jpg"  sizes="(max-width: 2000px) 100vw, 2000px" alt="">
                            </div>
                        </div>
    
                        <div class="content__page-header">
                            <h1 class="display-1" style="margin-bottom: 10px;">
                                <!-- 세션에 저장된 회원 이름, 또는 아이디 불러오기  -->
                                 ${member}
                            Hello, ${member.name}님 !
                            </h1>
                               <p>
                        YANDO와 함께 보다 유익한 일상을 보내고 계신가요 ? 
                        <!-- 세션에 저장된 회원 이름, 또는 아이디 불러오기  -->
                        <br>${member.name}님의 최근 접속 일자는 ${member.lastLoginDate}입니다.
                        </p>
                        </div> 
                        <!-- end content__page-header -->
                     

                        <!-- 시청기록 a tag -->
                        <a href="reco" ><input  name="button" id="submit" class="btn btn--primary btn-wide btn--large full-width" value="Watch History" type="submit"></a>
                        <!-- 북마크 a tag -->
                        <a href="bookmark"><input name="button" id="submit" class="btn btn--primary btn-wide btn--large full-width" value="book mark" type="submit"></a>
                         <!-- Q&A a tag -->
                        <a href="qna/board""><input name="button" id="submit" class="btn btn--primary btn-wide btn--large full-width" value="Q&A" type="submit"></a>
                        <!-- 내 Q&A 보기 -->
                        <a href="bookmark"> <input name="button" id="submit" class="btn btn--primary btn-wide btn--large full-width" value="My Q&A" type="submit"></a>
                        <!-- 내 정보 보기 -->
                        <a href="modify"> <input name="button" id="submit" class="btn btn--primary btn-wide btn--large full-width" value="My information" type="submit"></a>
        
    
    
                    </section>
    
                </main>
    
            </div> 
            
            <!-- my page end -->
    
    
            <!-- footer start -->
            <footer class="s-footer footer">
                <div class="row">
                    <div class="column large-full footer__content">
                        <div class="footer__copyright">
                            <span>© Copyright YANADO_Bit 195</span> 
                        </div>
                    </div>
                </div>
    
                <div class="go-top">
                    <a class="smoothscroll" title="Back to Top" href="#top"></a>
                </div>
            </footer>

             <!-- footer end -->
    
        </div> 
        <!-- s-wrap end -->
</main>

 <script type="text/javascript">
      /* Sidebar menu hide & show  */
      function dis() {
         if ($('#submenu').css('display') == 'none') {
            $('#submenu').show();
         } else {
            $('#submenu').hide();
         }
      }

      /* ajax를 javascript로 나타낸 것 */
      function loadDoc(event) { // 오른쪽 div에 띄울 jsp를 비동기형식으로 가져온다. 
         console.log(event);
         var xhttp = new XMLHttpRequest();
         xhttp.onreadystatechange = function() {
            if (xhttp.readyState == 4 && xhttp.status == 200) {
               if (xhttp.responseText) {
                  document.getElementById("article").innerHTML = this.responseText;
               }
            }
         };
         xhttp.open("GET", "${pageContext.request.contextPath}/member/"
               + event, true);
         xhttp.send();
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

         console.log(panel);

      }

      /* 
         개인 정보 수정 구간.      
       */
      // 개인정보 수정에서 핸드폰 인증
      var checkNumber; // 임시로 생성된 6자리의 숫자 
      function chekPhone() { // 핸드폰 인증 함수 
         var phoneNum = document.getElementById("tel").value; // 적어놓은 전화번호를 가져온다.
         var xhttp = new XMLHttpRequest(); // ajax 
         xhttp.onreadystatechange = function() {
            if (xhttp.readyState == 4 && xhttp.status == 200) {
               if (xhttp.responseText) {
                  checkNumber = this.responseText; // 컨트롤러에서 임시로 생성된 6자리 숫자를 가져온다.
                  console.log(checkNumber);
               }
            }
         };
         xhttp.open("GET",
               "${pageContext.request.contextPath}/checkPhone?phoneNum="
                     + phoneNum, true); // 폰번호를 GET 으로 보내준다.
         xhttp.send();
      }

      // 핸드폰 인
      var isCheckPhone = parseInt("0");
      var isCheckPw = parseInt("0");
      function compareNum() { // 인증번호를 인증해서 확인한다.
         var checkNum = document.getElementById("checkNum").value; // 입력된 인증번호를 가져온다.
         var comment = "인증번호를 확인해 주세요."; // 반환될 코멘트를 적어준다.
         if (checkNum == checkNumber) {
            comment = "문자 확인 성공!"; // 인증에 성공하면 반환될 코멘트를 적는다.
            isCheckPhone = parseInt("1");
         }
         document.getElementById("checkMessage").innerHTML = comment; // 적은 코멘트를 반환해 준다.
         editPossibility();
      }

      // 비밀번호 인증.
      function checkPassword() {
         var checkPw = document.getElementById("checkPw").value; // 비밀번호 확인 란에 적은 비밀번호 가져오기.
         var checkedPw = document.getElementById("pw").value; // 처음 작성한 비밀번호 가져오기.
         var comment = "비밀번호를 확인해 주세요.";
         if (checkPw == checkedPw) {
            comment = "비밀번호가 일치합니다." // 비밀번호가 맞으면 코멘트 변경.
            isCheckPw = parseInt("3"); // 비밀번호가 확인됐다는 신호를 준다.
         }
         document.getElementById("checkPwMsg").innerHTML = comment; // 코멘트를 반환한다.
         editPossibility(); // 비밀번호와 핸드본 인증이 모두 확인됐는지 확인한다.
      }

      function editPossibility() { // 비밀번호와 핸드폰 번호가 모두 인증되었는지 확인해 모두 인증되었으면 edit버튼을 활성화 한다.
         var comment;
         var possibleEdit = isCheckPhone + isCheckPw; // 핸드폰 인증과 비밀번호 인증 했는지 변수를 가져와 더한다.
         if (possibleEdit >= 4) { // 둘다 인증되었으면 그 값이 4이므로 버튼을 활성화 시킨다.
            const editBtn = document.getElementById("finalBtn");
            editBtn.disabled = false;
            const deleteBtn = document.getElementById("deleteBtn");
            deleteBtn.disabled = false;
         } else if (possibleEdit == 3) { // 값이 3이면 핸드폰 인증이 되지 않았다.
            comment = "핸드폰 인증을 해주세요.";
         } else if (possibleEdit == 1) { // 값이 1이면 비밀번호 인증이 되지 않았다.
            comment = "비밀번호를 확인해 주세요.";
         }
      }
   </script>
    </body>
</html>