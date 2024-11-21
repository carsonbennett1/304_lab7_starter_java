<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order List</title>
</head>
<body>

<h1>Order List</h1>

<%

try
{	
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

final String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
final String uid = "sa";
final String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)
{

	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	String sql = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);

	ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, orderSummary.customerId, firstName, lastname, totalAmount FROM OrderSummary JOIN Customer ON orderSummary.customerId = customer.customerId ORDER BY orderId");
	
	while(rst.next())
	{
		String orderID = rst.getString(1);

		out.println("<table><tr><th>Order ID</th><th>Order Date</th><th>Customer ID</th><th>Name</th><th colspan=\"2\">Total Amount</th></tr>");

		out.println("<tr><td align=\"center\">"+rst.getString(1)+"</td>");
		out.println("<td>"+rst.getString(2)+"</td>");
		out.println("<td align=\"center\">"+rst.getString(3)+"</td>");
		out.println("<td>"+rst.getString(4)+"</td>");
		out.println("<td>"+rst.getString(5)+"</td>");
		out.println("<td>"+currFormat.format(rst.getDouble(6))+"</td></tr>");

		pstmt.setString(1, orderID);
		ResultSet rstProduct = pstmt.executeQuery();

		if(rstProduct.next())
		{
			out.println("<table><tr><th>Product ID</th><th>Quantity</th><th>Price</th></tr>");
			
			do
			{
				out.println("<tr><td align=\"center\">"+rstProduct.getString(1)+"</td>");
				out.println("<td align=\"center\">"+rstProduct.getInt(2)+"</td>");
				out.println("<td>"+currFormat.format(rstProduct.getDouble(3))+"</td></tr>");

			}while(rstProduct.next());

			out.println("</table>");
			rstProduct.close();
		}

	}
	out.println("</table>");
	con.close();
	
}
catch(SQLException ex)
{
	out.println(ex);
}

%>

</body>
</html>

