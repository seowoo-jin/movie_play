<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<html>
<head>
	<title>Stat</title>
</head>
<body style="background-color: #2f2e2f;">
	<h1>
		데이터
		
	</h1>
	<div style="border: 1px solid; height : 450px; overflow-x: hidden; overflow-y: hidden;display: inline-block;">
		<span style="position: relative; border: 5px solid; top: 0; width: 200px; height: inherit; margin: 0;">
			
				총 맴버 수 : ${memberWithoutOut } 명
				탈퇴한 맴버 수 : ${totalMemberNumber - memberWithoutOut} 명
		</span>
		
		<span style="position: relative; border: 5px solid; top: 0; width: 200px; height: inherit; margin: 0;display: inline-block;">
			많이 시청하는 태그 순
			<c:forEach items="${tagInformation }" var="tagInfo" varStatus="status">
				<p>${status.index +1 } 위 : ${tagInfo.tagName }</p>
			</c:forEach>
		</span>
	</div>
	<div style="position: relative; border: 5px solid; ">
		<c:forEach items="${years }" var="years">
			<input type="checkbox" name="selectYear" value="${years }">${years }
		</c:forEach>
		<button id="sendYear" class="movieBoardBtn" onClick="sendYear()">선택 연도 자료 보기</button>
		<button id="generatePDF" class="movieBoardBtn" onClick="reportGenerate()">레포트 생성</button>
	
	</div>
	<div style="position: relative; border: 5px solid; ">
		<h3>연/월별 로그인한 맴버 수</h3>
		<table>
			<tr>
				<td>연도</td><td>1월</td><td>2월</td><td>3월</td><td>4월</td><td>5월</td><td>6월</td><td>7월</td><td>8월</td>	<td>9월</td>	<td>10월</td><td>11월</td><td>12월</td>			
			</tr>
			<c:forEach items="${memberLoginInfo }" var="item" varStatus="statusKey">
			<tr>
				<td>${item.key } </td>
				<c:forEach items="${item.value }" var="memberNum" varStatus="statusValue">
					<td>${memberNum }</td>		
				</c:forEach>
			</tr>
			</c:forEach>
		</table>
		
		<h3>연/월 별 가입자 수</h3>
		<table>
			<tr>
				<td>연도</td><td>1월</td><td>2월</td><td>3월</td><td>4월</td><td>5월</td><td>6월</td><td>7월</td><td>8월</td>	<td>9월</td>	<td>10월</td><td>11월</td><td>12월</td>			
			</tr>
			<c:forEach items="${memberJoinInfo }" var="memberJoinInfo" varStatus="statusKey">
			<tr>
				<td>${memberJoinInfo.key } </td>
				<c:forEach items="${memberJoinInfo.value }" var="memberJoinNum" varStatus="statusValue">
					<td>${memberJoinNum }</td>		
				</c:forEach>
			</tr>
			</c:forEach>
		</table>
		
		<h3>연/월 별 탈퇴한 맴버 수</h3>
		<table>
			<tr>
				<td>연도</td><td>1월</td><td>2월</td><td>3월</td><td>4월</td><td>5월</td><td>6월</td><td>7월</td><td>8월</td>	<td>9월</td>	<td>10월</td><td>11월</td><td>12월</td>			
			</tr>
			<c:forEach items="${memberOutInfo }" var="memberOutInfo" varStatus="statusKey">
			<tr>
				<td>${memberOutInfo.key } </td>
				<c:forEach items="${memberOutInfo.value }" var="memberOutNum" varStatus="statusValue">
					<td>${memberOutNum }</td>		
				</c:forEach>
			</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>
