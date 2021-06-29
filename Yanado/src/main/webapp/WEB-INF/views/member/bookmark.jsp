<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>bookmark</title>
<link href="${pageContext.request.contextPath}/resources/css/uploadVideo.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/member_main.css?ver-1" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/member_base.css" rel="stylesheet" type="text/css">

</head>
    <body >
    <%@ include file="/WEB-INF/views/sidebar.jsp" %>
    
        <main class="bookmark_main"  style="width: 80%; height: 100%; margin-left: 10%; margin-top: 5%;">
    

            <!-- bookmark content  -->
            <div class="s-content content">
                <main class="row s-styles">
                    
                    <!-- styles -->
                    <section id="styles" class="column large-full">
                        <section class="column large-full entry format-standard">
    
                            <div class="content__page-header">
                                <h1 class="display-1" style="margin-left: -10%;">
                                Book Mark
                                </h1>
                            </div> 

                            <h2 style="margin-bottom: 20px;">${member.name}님이 기록해 놓은 Book mark list입니다. </h2>
                             
        					<h5>
                            YANADO의 Contents를 감상하는 중 기억하고 싶은 문장이 있다면 Book mark로 저장해 주세요. 저장한 Book mark는 이곳에서 언제든지 다시 볼 수 있습니다.
                               <hr style="margin-left: 0.3%;">
                           </h5>
                          
                        
                        <div class="row section-intro add-bottom">
    
  
                        <div class="row" id="bookMarksArea">
							 
                            <c:forEach items="${allBookmarks }" var="allBookmarks">
                            <div class="column large-6 tab-full" id="eachBookMarks">

                                <a  href="${pageContext.request.contextPath}/video/play?trackId=${allBookmarks.uniqueNo }&bookmarkTime=${allBookmarks.subTimestamp}">
                                <aside class="pull-quote">
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
                                </aside>
                            </a>
                            </div>
    </c:forEach>
                           
                    </section> <!-- end styles -->
    
                </main>
    
            </div> <!-- end s-content -->
    
    
            <!-- footer
            ================================================== -->
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
    
        </div> <!-- end s-wrap -->
        </main>
    </body>
</html>
