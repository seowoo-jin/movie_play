<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<title>Payment</title>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<style type="text/css">
#header {
	text-align: center;
}
</style>
</head>

<body>


	<div id="header" style="border: 1px solid">
		<jsp:include page="header.jsp" flush="false">
			<jsp:param name="param1" value="" />
		</jsp:include>
	</div>

	<p>Free for 30days</p>
	<input type="button" value="1$ per 1month" id="payBtn1" name="payBtn1">
	<input type="button" value="1$ per 1month" id="payBtn2" name="payBtn2">
	<input type="button" value="1$ per 1month" id="payBtn3" name="payBtn3">


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
					window.location.href = "http://localhost:8085/yanado/successPay";
				} else {
					var msg = 'fail to pay.';
					msg += 'error : ' + rsp.error_msg;
				}
				alert(msg);
			});
		}
	
		$("#payBtn1").click(function() {
			charge(100);
		});
		$("#payBtn2").click(function() {
			charge(200);
		});
		$("#payBtn3").click(function() {
			charge(300);
		});
	</script>
</body>
</html>
