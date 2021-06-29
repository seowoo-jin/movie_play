<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>

<title>Reco</title>
<link href="${pageContext.request.contextPath}/resources/css/qna.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/member_main.css?ver-1" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/member_base.css" rel="stylesheet" type="text/css">
</head>

 <body>

    
<main class="watch_main"  style="width: 80%; height: 100%; margin-left: 10%; margin-top: 10%'">
    
    
            <!-- watch history -->
            <div class="s-content content">
                <main class="row content__page">
                    
                    <article class="column large-full entry format-standard">
                        <!-- 그냥 이미지 -->
                        <div class="media-wrap entry__media">
                            <div class="entry__post-thumb">
                                <img src="../resources/image/ran.jpg" 
                                    sizes="(max-width: 2000px) 100vw, 2000px" alt="">
                            </div>
                        </div>
                        <!-- 페이지 이름, 최근 시청 기록이라고 알려줌 -->
                        <div class="content__page-header entry__header">
                            <h1 class="display-1 entry__title">
                                Recent Watch History
                            </h1>
                            <ul class="entry__header-meta">
                                 <!-- 누구 시청 기록인지 -->
                                <li class="author">By ${member.name}</li>
                            </ul>
                        </div> 
                     
    
                        <div class="entry__content">
    
                            <blockquote>
                                <h4>
                                &nbsp; 회원님께서 최근 시청하신 contents list입니다. <br>
                                &nbsp; 만약 이어서 시청하길 원하신다면, 해당 poster를 클릭하세요.
                                </h4>
                                <cite>&nbsp;&nbsp;From : YANADO Team</cite>
                            </blockquote>
        
                       
    
                        </div> 
                          <!-- end entry__header -->
    
                        
                        <!-- 여기서 부터 시청 기록, 포스터 크기 균일하게 맞출 것 -->
                        <div class="entry__related">
                            <ul class="related">
                                

                            <c:forEach items="${posters }" var="posters" varStatus="status">
                                <li class="related__item">
                                    <a href="http://localhost:8085/yanado/video/play?trackId=${allRecord[status.index].uniqueNo }" class="related__link">
                                        <img src="${posters.poster }" class="posterImg" id="posterClk">
                                    </a>
                                    <h5 class="related__post-title"><b> ${videoInfo[status.index].title } </b> <br>
                                    <c:if test="${videoInfo[status.index].season  ne 0}" >
				                	season : ${videoInfo[status.index].season }
					                episode : ${videoInfo[status.index].episode }
				                    </c:if>
				                    </h5>
                                </li>
                             </c:forEach> 


                                
    
                            </ul>
                        </div> 
                        
                        <!-- end entry related -->
    
                    </article> <!-- end column large-full entry-->
    
    
           
                </main>
    
            </div> 
            
            <!-- end s-content -->
    
    
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
    
   
            </footer>
    
        <!-- end s-wrap -->
</main>
    </body>
</html>