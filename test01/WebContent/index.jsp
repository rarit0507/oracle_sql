<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
<%
	pageContext.setAttribute("name","키아누리브스");
	//그냥 String name = ""; 하면 안 됨	- EL 때문에
%>
<h1>${name }메인 페이지</h1>
<%@ include file = "menu.jsp" %>

</body>
</html>