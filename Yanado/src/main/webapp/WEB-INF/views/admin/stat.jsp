<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<html>
<head>
<title>Stat</title>
<link href="${pageContext.request.contextPath}/resources/css/movieBoard.css" rel="stylesheet" type="text/css">
</head>
<body>
   <h1>DATA</h1>
	
   <div style=" height: 450px; overflow-x: hidden; overflow-y: hidden; ">
      <div style="float:left; position: relative; top: 0; width: 50%; height: inherit; margin: auto; font-size: 35pt; ">
	      <div style="position: absolute; top: 35%; margin: auto; text-align: center; width: 100%; max-width: 100%; height: inherit;">
	      	총 맴버 수 : ${memberWithoutOut } 명 <br>
	         탈퇴한 맴버 수 : ${totalMemberNumber - memberWithoutOut} 명 
	      </div>
         
      </div> 
      <div style="position: relative; width: 400px; height: inherit; margin: auto; display: inline-block;">
         <p style="font-size: 30pt;">많이 시청하는 태그 순 </p>
         <c:forEach items="${tagInformation }" var="tagInfo" varStatus="status">
	         <div style="margin: 0 0 0 0; font-size: 20pt;">
	            <p style="margin: 0;">${status.index +1 }&nbsp;위 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  ${tagInfo.tagName }</p>
            </div>
         </c:forEach>
      </div>
   </div>
   <div style="position: relative; left: 50px; width: 90%; font-size: 15pt;">
      <c:forEach items="${years }" var="years" >
         <input type="checkbox" name="selectYear" value="${years }"> ${years }
      </c:forEach>
   </div>
   <div style="margin: 20px 0px 20px 0px; text-align: center;">
	   <button id="sendYear" class="movieBoardBtn" onClick="sendYear()">선택 연도 자료 보기</button>
	   <button id="generatePDF" class="movieBoardBtn" onClick="reportGenerate()">레포트 생성</button> 
   </div>

   
   
   <div id="resultTables" style="display: none; position: relative;  margin: auto; ">
      <h3 style="font-Size: 30pt;">로그인 맴버 수</h3>
      
      <table style="margin: auto; align-self: center; text-align:center;  border-spacing: 2px;  border-collapse: separate; width: 80%; color: #dbdbdb; font-size: 20pt;">
         <tr>
            <td>연도</td>
            <td>1월</td>
            <td>2월</td>
            <td>3월</td>
            <td>4월</td>
            <td>5월</td>
            <td>6월</td>
            <td>7월</td>
            <td>8월</td>
            <td>9월</td>
            <td>10월</td>
            <td>11월</td>
            <td>12월</td>
         </tr>
         <c:forEach items="${memberLoginInfo }" var="item" varStatus="statusKey">
            <tr>
               <td>${item.key }</td>
               <c:forEach items="${item.value }" var="memberNum" varStatus="statusValue">
                  <td>${memberNum }</td>
               </c:forEach>
            </tr>
         </c:forEach>
      </table >

      <h3 style="font-Size: 30pt;">가입자 수</h3>
      <table style="margin: auto; align-self: center; text-align:center;  border-spacing: 2px;  border-collapse: separate; width: 80%; color: #dbdbdb; font-size: 20pt;">
         <tr>
            <td>연도</td>
            <td>1월</td>
            <td>2월</td>
            <td>3월</td>
            <td>4월</td>
            <td>5월</td>
            <td>6월</td>
            <td>7월</td>
            <td>8월</td>
            <td>9월</td>
            <td>10월</td>
            <td>11월</td>
            <td>12월</td>
         </tr>
         <c:forEach items="${memberJoinInfo }" var="memberJoinInfo" varStatus="statusKey">
            <tr>
               <td>${memberJoinInfo.key }</td>
               <c:forEach items="${memberJoinInfo.value }" var="memberJoinNum" varStatus="statusValue">
                  <td>${memberJoinNum }</td>
               </c:forEach>
            </tr>
         </c:forEach>
      </table>

      <h3 style="font-Size: 30pt;">탈퇴한 맴버 수</h3>
      <table style="margin: auto; align-self: center; text-align:center;  border-spacing: 2px;  border-collapse: separate; width: 80%; color: #dbdbdb; font-size: 20pt;">
         <tr>
            <td>연도</td>
            <td>1월</td>
            <td>2월</td>
            <td>3월</td>
            <td>4월</td>
            <td>5월</td>
            <td>6월</td>
            <td>7월</td>
            <td>8월</td>
            <td>9월</td>
            <td>10월</td>
            <td>11월</td>
            <td>12월</td>
         </tr>
         <c:forEach items="${memberOutInfo }" var="memberOutInfo" varStatus="statusKey">
            <tr>
               <td>${memberOutInfo.key }</td>
               <c:forEach items="${memberOutInfo.value }" var="memberOutNum" varStatus="statusValue">
                  <td>${memberOutNum }</td>
               </c:forEach>
            </tr>
         </c:forEach>
      </table>
   </div>
</body>
</html>