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

    try{

        getConnection();
	    Statement stmt = con.createStatement();

        String sql = "SELECT productId, productName, productPrice FROM product";
        ResultSet rst = stmt.executeQuery(sql); 

        while(rst.next()){
            out.println("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity Remaining</th></tr>");
            out.println("<tr><td>" + rst.getString(1) + "</td><td>" + rst.getString(2) + "</td><td>" + rst.getString(3) + "</td></tr>");
        }

        out.println("</table>");

    }
    catch (SQLException ex) {
        out.println(ex);
    }
    finally
    {
        closeConnection();
    }


%>

</body>
</html>