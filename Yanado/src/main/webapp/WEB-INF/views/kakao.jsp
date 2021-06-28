<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
  <script
    src="https://code.jquery.com/jquery-3.5.1.min.js"
    integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
    crossorigin="anonymous"></script>
<link href="${path}/resources/css/kakao.css" rel="stylesheet"/> 
</head>
<body>

<section class="login-Form">
        <h5> Social Login</h5>
        <h1> 안녕하세요, ${kakao.nickname } 님!</h1>
        <form action="kakaoCheck" method="post">
            <div class="int-area">
           		 <input class="name" type="text" id="name" name="name" autocomplete="off" required/><br>
                <label for="id"> USER ID : ${kakao.id }</label>
                
            </div>
    
            <div class="int-area">
                <input class="id" type="text" id="id" name="id"  autocomplete="off" required></input><br>
                <label for="id"> USER NAME : ${kakao.name }</label>
            </div>
       
            <div class="int-area">
                <input class="pw" type="text" id="pw" name="pw"  autocomplete="off" required></input><br>
                <label for="pw"> CONNECTION DATE : ${kakao.pw }</label>
            </div>
        
            <div class="btn-area"> 
                <button id="btn" type="submit">계속 이용하기</button>
            </div>
            
        </form>
        <div class="caption">
            <a href="/main"> RETURN </a>
        </div>
 
    </section>

<script type="text/javascript">

document.getElementById("name").value = '${kakao.name }'
document.getElementById("id").value = '${kakao.id }'
document.getElementById("pw").value = '${kakao.pw }'

</script>

</body>
</html>