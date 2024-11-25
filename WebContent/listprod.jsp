<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery</title>
</head>
<body>

<h1>Search for the products you want to buy:</h1>

<form method="get" action="listprod.jsp">
<input type="text" name="productName" size="50">
<input type="submit" value="Submit"><input type="reset" value="Reset"> (Leave blank for all products)
</form>

<% 
String name = request.getParameter("productName");
		
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

	String sql = "SELECT productId, productName, productPrice FROM product";
	boolean hasProductName = name != null && !name.equals("");
	PreparedStatement pstmt = null;
	ResultSet rst = null;

	if(!hasProductName)
	{
		pstmt = con.prepareStatement(sql);
		rst = pstmt.executeQuery();
	}
	else if(hasProductName)
	{
		name = "%"+name+"%";
		sql += " WHERE productName LIKE ? ";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, name);
		rst = pstmt.executeQuery();
	}

	out.println("<table><tr><th>Product Id</th><th colspan=\"2\" align=\"center\">Product Name</th><th colspan=\"4\" align=\"right\">Price</th></tr>");

	if(rst.next())
	{
		do
		{
			out.println("<tr><td><a href=\"addcart.jsp?id=" + rst.getString(1) + "&name=" + rst.getString(2) + "&price=" + rst.getDouble(3) + "\">Add to Cart</a></td>");
			out.println("<td>" + rst.getString(1) + "</td>");
			out.println("<td><a href=\"product.jsp?id=" + rst.getString(1) + "\">" + rst.getString(2) + "</a></td>");
			out.println("<td>" + currFormat.format(rst.getDouble(3)) + "</td></tr>");
		}while(rst.next());
	}

	out.println("</table>");
	con.close();

}catch(SQLException ex){
	out.println(ex);
}

%>

</body>
</html>