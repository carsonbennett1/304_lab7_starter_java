<!DOCTYPE html>
<html>
<head>
<title>Warehouse</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

<%
    out.println("<h2>Warehouse Storage Information Page</h2>");


%>


</body>
</html>