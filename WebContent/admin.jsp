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
    Statement stmt = con.createStatement();

    String sql = "SELECT CONVERT (DATE,orderDate), SUM(totalAmount) FROM ordersummary GROUP BY CONVERT (DATE,orderDate) ORDER BY CONVERT (DATE,orderDate) ASC";
    ResultSet rst = stmt.executeQuery(sql);
    out.println("<table><tr><th>Order Date</th><th>Total Order Amount</th></tr>");
    while(rst.next()){
        if(rst.getDate(1) != null){
            out.println("<tr><td>" + rst.getDate(1) + "</td><td>" + rst.getInt(2) + "</td></tr>");
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

