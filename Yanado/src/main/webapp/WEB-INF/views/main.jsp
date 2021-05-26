<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Main</title>
	
	<style type="text/css">
	#header{
		text-align: center;
	}
	</style>
</head>

<body>


<div id="header" style="border: 1px solid" >
	<jsp:include page="header.jsp" flush="false">
		<jsp:param name="param1" value=""/>
	</jsp:include>
</div>


<P>  The time on the server is. </P>



</body>
</html>
