<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Shipment Processing</title>
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
// TODO: Get order id
String ordId = request.getParameter("orderId");
 
try{

	// TODO: Check if valid order id in database
	getConnection();

	String sql = "SELECT * FROM OrderProduct WHERE orderId = ?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, ordId);


}catch(SQLException ex){
	out.println(ex);
}

try{

	// TODO: Start a transaction (turn-off auto-commit)
	// TODO: Retrieve all items in order with given id
	
	getConnection();


}catch(SQLException ex){
	out.println(ex);
}

	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
