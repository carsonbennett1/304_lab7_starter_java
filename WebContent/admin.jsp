<%@ page import="java.text.NumberFormat" %>
<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

<h2>Administrator Sales Report by Day</h2>

<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp"%>

<%
String user = (String)session.getAttribute("authenticatedUser");

try{
    getConnection();

    NumberFormat currFormat = NumberFormat.getCurrencyInstance();

    Statement stmt = con.createStatement();

    String sql = "SELECT CONVERT (DATE, orderDate), SUM(totalAmount) FROM ordersummary GROUP BY CONVERT (DATE, orderDate)";
    ResultSet rst = stmt.executeQuery(sql);
    out.println("<table><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    while(rst.next()){
        if(rst.getDate(1) != null){
            out.println("<tr><td>" + rst.getDate(1) + "</td><td align=\"center\">" + currFormat.format(rst.getBigDecimal(2)) + "</td></tr>");
        }
    }


}catch(SQLException ex){
    out.println(ex);
}finally{
    closeConnection();
}

%>

</body>
</html>

