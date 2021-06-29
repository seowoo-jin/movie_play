<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<html>
<head>

<title>Reco</title>
<link href="${pageContext.request.contextPath}/resources/css/qna.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath}/resources/css/bookmark.css?ver-1"
	rel="stylesheet" type="text/css">
</head>


<body>

    
  
        <main class="main">
        
            <div class="content">
        
                <!-- watch history -->
                <section class="header">
                    
                        <img src="../resources/image/ran.jpg"  
                            sizes="(max-width: 2000px) 100vw, 2000px" alt="">
             
                    <h1>
                        Recent Watch History
                        </h1>
                        <p>By ${member.name}</p>
        
                       
        
                          
        
                                <blockquote class="poster_block">
                                    <h2>
                                     회원님께서 최근 시청하신 contents list입니다. <br>
                                     만약 이어서 시청하길 원하신다면, 해당 poster를 클릭하세요.
                                    </h2>
                                    <cite>From : YANADO Team</cite>
                                </blockquote>

        
                        </section>
                     
                              <!-- end entry__header -->
        
                            
                            <!-- 여기서 부터 시청 기록, 포스터 크기 균일하게 맞출 것 -->
                            
                            <div class="poster_box">
                                <ul class="poster_card">
                                    
    
                                <c:forEach items="${posters }" var="posters" varStatus="status">
                                    <div class="poster_text">
                                        <a href="http://localhost:8085/yanado/video/play?trackId=${allRecord[status.index].uniqueNo }" class="related__link">
                                            <img src="${posters.poster }" class="posterImg" id="posterClk">
                                        </a>
                                        <h5><b> ${videoInfo[status.index].title } </b> <br>
                                        <c:if test="${videoInfo[status.index].season  ne 0}" >
                                        season : ${videoInfo[status.index].season }
                                        episode : ${videoInfo[status.index].episode }
                                        </c:if>
                                        </h5>
                                    </div>
                                 </c:forEach> 
                                </ul>
                            </div> 
                            
                            <!-- end entry related -->
        
                    
        
                        
               
        </main>
        
       
                
                <!-- end s-content -->
        
              <!-- footer
                ================================================== -->
                <footer>
                    <div class="row">
                    
                                <span>© Copyright YANADO_Bit 195</span> 
                    
                    </div>
                </footer>
        
            </div> <!-- end s-wrap -->
        </div>
        </body>
        </html>