
<!DOCTYPE html>
<html>
<head>
<title>Super Save Administrator Page</title>
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
	out.println("<h3>Administrator Sales Report by Day</h3>");
	
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
	out.println("<h3>List of All Customers</h3>");

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

	out.println("<h3>Sales Report by Day Bar Graph</h3>");

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
