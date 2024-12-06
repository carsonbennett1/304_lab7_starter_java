
<!DOCTYPE html>
<html>
<head>
<title>Super Save Administrator Page</title>
<%-- Stylesheet section coded with the assistance of Copilot AI https://m365.cloud.microsoft/chat?auth=2 --%>
<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border: 1px solid #ddd;
    }
    th {
        background-color: #f2f2f2;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #f1f1f1;
    }
</style>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>

<%
// Print out total order amount by day
String sql = "select year(orderDate), month(orderDate), day(orderDate), SUM(totalAmount) FROM OrderSummary GROUP BY year(orderDate), month(orderDate), day(orderDate)";

// Print out all Customers
String displayCust = "SELECT firstName, lastName, email, phonenum, userid, customerId FROM Customer";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

try 
{	
	out.println("<h2>Administrator Sales Report by Day</h2>");
	
	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	ResultSet rst = con.createStatement().executeQuery(sql);		
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>Order Date</th><th>Total Order Amount</th>");	

	while (rst.next())
	{
		out.println("<tr><td>"+rst.getString(1)+"-"+rst.getString(2)+"-"+rst.getString(3)+"</td><td>"+currFormat.format(rst.getDouble(4))+"</td></tr>");
	}
	out.println("</table>");

}
catch (SQLException ex) 
{ 	out.println(ex); 
}
finally
{	
	closeConnection();	
}

try{
	out.println("<h2>List of All Customers</h2>");

	getConnection();
	Statement stmt = con.createStatement(); 
	stmt.execute("USE orders");

	ResultSet rst = con.createStatement().executeQuery(displayCust);
	out.println("<table class=\"table\" border=\"1\">");
	out.println("<tr><th>First Name</th><th>Last Name</th><th>Email</th><th>Phone Number</th><th>User ID</th><th>Customer ID</th>");	
	
	while(rst.next()){
		out.println("<tr><td>"+rst.getString(1)+"</td>");
		out.println("<td>"+rst.getString(2)+"</td>");
		out.println("<td>"+rst.getString(3)+"</td>");
		out.println("<td>"+rst.getString(4)+"</td>");
		out.println("<td>"+rst.getString(5)+"</td>");
		out.println("<td>"+rst.getString(6)+"</td></tr>");
	}
	out.println("</table>");

	out.println("<h2>Sales Report by Day Bar Graph</h2>");

	// Bar graph created, and printed out, with the assistance of Copilot AI
	out.println("<img src=\"img/daily_purchases.png\" alt=\"Daily Purchases Bar Chart\" />");

}catch (SQLException ex) { 	
	out.println(ex); 
}
finally {	
	closeConnection();	
}
%>

</body>
</html>
