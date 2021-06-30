<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Payment</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/button.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/membership.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet" type="text/css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css" rel="stylesheet" type="text/css">

</head>

<body style="background-color: #2f2e2f;">


	<div id="header"> <!-- style="border: 1px solid -->
		<jsp:include page="header.jsp" flush="false">
			<jsp:param name="param1" value="" />
		</jsp:include>
	</div>

<!-- 멤버십 결제 선택 시작-->

<p>YANADO는 전면 회원제로 운영합니다!</p>
<h1>멤버십 선택</h1>
<h2>선택한 멤버십으로 서비스를 누릴 수 있습니다!&hellip;</h2>
<section>
<div>
  <input type="radio" id="control_01" name="select" value="100">
  <label for="control_01">
    <h2>한 달 멤버십 9,900원</h2>
    <p>아직 망설여지신다구요? 한 달 멤버십 서비스를 이용해 보시고 결정하세요!</p>
  </label>
</div>
<div>
  <input type="radio" id="control_02" name="select" value="200">
  <label for="control_02">
    <h2>두 달 멤버십 17,900원</h2>
    <p>YANADO가 마음에 드신가요? 두 달 멤버십으로 저렴하게 이용하세요!</p>
  </label>
</div>
<!-- <div>
  <input type="radio" id="control_03" name="select" value="3">
  <label for="control_03">
    <h2>Daaamn</h2>
    <p>Now we're talking. It's gettin' a bit hairy out there in game land.</p>
  </label>
</div>
<div>
  <input type="radio" id="control_04" name="select" value="4" disabled>
  <label for="control_04">
    <h2>Mental</h2>
    <p>Prepare for glory! This is going to be one hell of a no-holds-barred ride.</p>
  </label>
</div> -->
<div>
  <input type="radio" id="control_05" name="select" value="300" checked>
  <label for="control_05">
    <h2>세 달 멤버십 23,900원</h2>
    <p>와우! 벌써 YANADO VIP 회원이시네요. 세 달 멤버십으로 가장 저렴하게 최고의 서비스를 누려보세요!</p>
  </label>
</div>
</section>
<br>
<br>
<br>
<section>
<div class="buttonCenter">
<input type="button" class="btnLoginL" onclick="getSelectedBtn()" value="다음">
</div>
</section>

<!-- 멤버십 결제 선택 끝-->





	<!-- <p>Free for 30days</p>
	<input type="button" value="1$ per 1month" id="payBtn1" name="payBtn1">
	<input type="button" value="1$ per 1month" id="payBtn2" name="payBtn2">
	<input type="button" value="1$ per 1month" id="payBtn3" name="payBtn3">
 -->



	<script>
		function charge(mount){
			var IMP = window.IMP; // 생략가능
			IMP.init('imp89010233');
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			IMP.request_pay({
				pg : 'inicis', 
				pay_method : 'card',
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '주문명:결제테스트',
				
				amount : mount,
				//가격
				buyer_email : 'iamport@siot.do',
				buyer_name : '구매자이름',
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456',
				
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = "" + rsp.paid_amount + "won, Success payment!" ;
					window.location.href = "${pageContext.request.contextPath}/successPay";
				} else {
					var msg = 'fail to pay.';
					msg += 'error : ' + rsp.error_msg;
				}
				alert(msg);
			});
		}
	
		
		/* 멤버십 선택 후 다음버튼 클릭 이벤트 */
	  function getSelectedBtn() {
		   const selectList = document.getElementsByName('select'); 
		  
		   selectList.forEach((selected) =>  {
			   if(selected.checked) {
				   charge(selected.value);
			   }
		  })  
	  }
	  
		
		
	/* 	$("#payBtn1").click(function() {
			charge(100);
		});
		$("#payBtn2").click(function() {
			charge(200);
		});
		$("#payBtn3").click(function() {
			charge(300);
		}); */
	</script>
</body>
</html>