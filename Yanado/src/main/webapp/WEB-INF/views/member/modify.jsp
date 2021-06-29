<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Edit</title>
<link href="${pageContext.request.contextPath}/resources/css/movieBoard.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/resources/css/member_main.css?ver-1" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath}/resources/css/member_base.css" rel="stylesheet" type="text/css">
</head>
    <body class="ss-bg-white">
    

    
        <div id="top" class="s-wrap site-wrapper">
    
    
  	
            <!-- my information content  -->
            <section class="modify" style="width: 80%; margin-left: 10%; margin-top: 5% ">
            <div class="s-content content">
           

                    <article class="column large-full entry format-video">
    
                     
    
                        <div class="content__page-header entry__header">
                            <h1 class="display-1 entry__title">
                            My Information Mofify
                            </h1>
                        </div> <!-- end entry__header -->
    
                        <div class="entry__content">
    
                
    
                            <p>
                            <img src="../resources/image/mypage.jpg.jpg"  
                                         sizes="(max-width: 2000px) 100vw, 2000px" alt="">
                            </p>
    
                          
    
                        </div> 

                            <div id="respond">
                
                                <h3 class="h2">${member.id}님 안녕하세요.</h3></span>
                
                                <form name="contactForm" id="contactForm" method="post" action="" autocomplete="off">
                                    <fieldset>
                
                                        <div class="form-field">
                                            <input type="text" id = "name" name="name" value="${member.name }" placeholder="Name" class="full-width" >
                                        </div>
                
                                        <div class="form-field">
                                            <input type="password" id = "pw" name = "pw" class="full-width" placeholder="Password" >
                                        </div>
    
                                        <div class="form-field">
                                            <input type="password" id = "checkPw" name = "checkPw" placeholder="Check Password" class="full-width"  onchange="checkPassword()"><br>
                                            <div id="checkPwMsg" style="margin-top: 10px; font-size: 18px; "> </div>
                                        </div>

                                        <div class="form-field">
                                            <input type="text" id = "email" name = "email" value="${member.email }" class="full-width"  placeholder="Email"> 
                                        </div>
   
                                        <div class="form-field">
                                            <input type="text" id = "tel" name = "tel" value="${member.tel }" class="full-width" placeholder="tel">
                                            <input type="button" class="movieBoardBtn" id="phoneCheck" name="phoneCheck" value="Send Number" onclick="chekPhone()" style="float: right; margin-top: -110px; width: 200px; height: 40px;"><br>
	                                    	  <div id="phoneMessage" style=" font-size: 18px; " >하하ㄴㅁㄹㄴㅁㄹ</div>
                                        </div>

                                        <div class="form-field">
                                            <input type="text" id = "checkNum" name = "checkNum" value="${member.tel }" class="full-width" placeholder="tel">
                                            <input type="button" class="movieBoardBtn" id="numberCheck" name="numberCheck" value="check Number" onclick="compareNum()" style="float: right; margin-top: -145px; width: 200px; height: 40px;">
                                            <div id="checkMessage" style="margin-top: 10px;margin-bottom:50px;   font-size: 18px; " >하하ㄴㄻ</div>
                                        </div>
                                     
                                        <div class="form-field">
                                        <input type="hidden" id="id" name="id" value="${member.id }">
		                                 <input type="hidden" id="isPay" name="isPay" value="${member.isPay }">
		                                 <input type="hidden" id="defaultCap" name="defaultCap" value="${member.defaultCap }">
                                        </div>
                                
                                        <input class="btn btn--primary btn-wide btn--large full-width" type="submit"  value="Edit" id="finalBtn" name="finalBtn" disabled="disabled">
                                    </form> <!-- end form -->
                                   
                                
                                <input type="submit" class="btn btn--primary btn-wide btn--large full-width" value="탈퇴" id="deleteBtn" name="deleteBtn" disabled="disabled" formaction="delete">
                            </fieldset>
                              </div>
                          
                
                        </div> 
                
                    </div> 
                </main>
    
            </div> 
    </section>
    
            <!-- footer
            ================================================== -->
            <footer class="s-footer footer" style="margin-left: -5%;">
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
                         

    </body>
</html>
