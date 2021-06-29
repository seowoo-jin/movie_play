<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Edit</title>
<link href="${pageContext.request.contextPath}/resources/css/movieBoard.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/bookmark.css?ver-1" rel="stylesheet" type="text/css">

</head>
<body>
  
    <main class="main">
  	
            <!-- my information content  -->
            <div class="content">
            <section class="header" >
  

   
            <img src="../resources/image/mypage.jpg.jpg"    sizes="(max-width: 2000px) 100vw, 2000px" alt="">
                      <h1> My Information Mofify </h1>
        </section> 

               <div class="infor_box" id="respond">
                
                 <h2>${member.id}님 안녕하세요.</h2>
                
                  <form name="contactForm" id="contactForm" method="post" action="" autocomplete="off">
                                  
                
                                        <div class="init">
                                            <input type="text" id = "name" name="name" value="${member.name }" placeholder="Name" class="full-width" >
                                        </div>
                
                                        <div class="init">
                                            <input type="password" id = "pw" name = "pw" class="full-width" placeholder="Password" >
                                        </div>
    
                                        <div class="init">
                                            <input type="password" id = "checkPw" name = "checkPw" placeholder="Check Password" class="full-width"  onchange="checkPassword()"><br>
                                            <span id="checkPwMsg" style="margin-top: 10px; font-size: 18px; "> </span>
                                        </div>

                                        <div class="init">
                                            <input type="text" id = "email" name = "email" value="${member.email }" class="full-width"  placeholder="Email"> 
                                        </div>
   
                                        <div class="init2">
                                            <input type="text" id = "tel" name = "tel" value="${member.tel }" class="full-width" placeholder="tel">
                                            <button  type="button" id="phoneCheck" name="phoneCheck" value="Send Number" onclick="chekPhone()" >
	    
                                        </div>
                                        <span class="inint_span" id="phoneMessage" ></span>
                                        
                                        <div class="init2">
                                            <input type="text" id = "checkNum" name = "checkNum" value="${member.tel }" class="full-width" placeholder="tel">
                                            <button type="button"  id="numberCheck" name="numberCheck" value="check Number" onclick="compareNum()" >
                                          
                                        </div>
                                        <span class="inint_span" id="checkMessage"  ></span>
                                        <div class="init" hidden>
                                        <input type="hidden" id="id" name="id" value="${member.id }">
		                                 <input type="hidden" id="isPay" name="isPay" value="${member.isPay }">
		                                 <input type="hidden" id="defaultCap" name="defaultCap" value="${member.defaultCap }">
                                        </div>
                                
                                        <input class="edit_btn" type="submit"  value="Edit" id="finalBtn" name="finalBtn" disabled="disabled">
                                   
                                    </form> <!-- end form -->
                                   
                                
                                <input type="button" class="delete_btn" value="탈퇴" id="deleteBtn" name="deleteBtn" disabled="disabled" formaction="delete">
                          
                              </div>
                          
                
                        </div> 
                
                   
    
            </div> 
    </section>
</main>
</div>
             <!-- footer
        ================================================== -->
        <footer>
            <div class="row">
            
                        <span>© Copyright YANADO_Bit 195</span> 
            
            </div>
        </footer>

    </div> <!-- end s-wrap -->
    
</body>
</html>
