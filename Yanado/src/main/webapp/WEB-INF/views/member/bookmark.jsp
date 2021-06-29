<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>bookmark</title>
<link href="${pageContext.request.contextPath}/resources/css/uploadVideo.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/bookmark.css?ver-1" rel="stylesheet" type="text/css">


</head>
<body >

    <main class="bookmark_main">


        <!-- bookmark content  -->
        <div class="book_mark_content">
       
                
                    <section class="bookmark_header">

                            <h1>
                            Book Mark
                            </h1>
                     

                        <h2 style="margin-bottom: 20px;">${member.name}님이 기록해 놓은 Book mark list입니다. </h2>
                         
                        <h5>
                        YANADO의 Contents를 감상하는 중 기억하고 싶은 문장이 있다면 Book mark로 저장해 주세요. <br>
                        저장한 Book mark는 이곳에서 언제든지 다시 볼 수 있습니다.
                        
                       </h5>
                       <hr style="margin-left: 0.3%;">
                    </section>


                    <div class="bookmark_card_box" id="bookMarksArea">
                         
                        <c:forEach items="${allBookmarks }" var="allBookmarks">
                        <div class="bookmark_card" id="eachBookMarks">

                            <a  href="${pageContext.request.contextPath}/video/play?trackId=${allBookmarks.uniqueNo }&bookmarkTime=${allBookmarks.subTimestamp}">
                   
                                <blockquote>
                                    <h2> ${allBookmarks.title} </h2>
                                <p>
                                    <c:if test="${allBookmarks.season ne 00 }">
                                        <span>시즌 : </span>${allBookmarks.season}<br>
                                        <span>에피소드 : </span>${allBookmarks.episode}<br>
                                        </c:if>
                                        <span>${allBookmarks.subtitle}</span><br>
                                </p>
                                </blockquote>
                          
                        </a>
                        </div>
                        </c:forEach>
                       


          

        </div> <!-- end s-content -->


        <!-- footer
        ================================================== -->
        <footer>
            <div class="row">
            
                        <span>© Copyright YANADO_Bit 195</span> 
            
            </div>
        </footer>

    </div> <!-- end s-wrap -->
    </main>
</body>
</html>
