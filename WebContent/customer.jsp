<!DOCTYPE html>
<html>
<head>
<title>Customer Page</title>
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	out.println("<h2>Customer Info Section</h2>");
	out.println("<h3>User: "+ userName + " Customer Profile</h3>");

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

try {

	getConnection();
	String sql = "SELECT * FROM customer WHERE userid = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, userName);
	ResultSet rst = pstmt.executeQuery();

	rst.next();

	out.println("<table><tr><td>Id</th><td align=\"right\" colspan=\"4\">" + rst.getInt(1) + "</td></tr>");
	out.println("<tr><th align=\"left\">First Name</th><td align=\"right\" colspan=\"4\">" + rst.getString(2) + "</td></tr>");
	out.println("<table><tr><th>Last Name</th><td align=\"right\" colspan=\"4\">" + rst.getString(3) + "</td></tr>");
	out.println("<tr><th align=\"left\">Email</th><td align=\"right\" colspan=\"4\">" + rst.getString(4) + "</td></tr>");
	out.println("<table><tr><th align=\"left\">Phone</th><td align=\"right\" colspan=\"4\">" + rst.getString(5) + "</td></tr>");
	out.println("<tr><th align=\"left\">Address</th><td align=\"right\" colspan=\"4\">" + rst.getString(6) + "</td></tr>");
	out.println("<table><tr><th align=\"left\">City</th><td align=\"right\" colspan=\"4\">" + rst.getString(7) + "</td></tr>");
	out.println("<tr><th align=\"left\">State/Province</th><td align=\"right\" colspan=\"4\">" + rst.getString(8) + "</td></tr>");
	out.println("<table><tr><th align=\"left\">Postal Code</th><td align=\"right\" colspan=\"4\">" + rst.getString(9) + "</td></tr>");
	out.println("<tr><th align=\"left\">Country</th><td align=\"right\" colspan=\"4\">" + rst.getString(10) + "</td></tr>");
	out.println("<table><tr><th align=\"left\">User Id</th><td align=\"right\" colspan=\"4\">" + rst.getString(11) + "</td></tr>");
	out.println("</table>");


}catch (SQLException ex){
	out.println(ex);
}finally{
	closeConnection();
}

%>

</body>
</html>

