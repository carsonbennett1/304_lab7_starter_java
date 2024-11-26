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
	con.setAutocommit();

	boolean shipmentFailed = false;

	String sql = "SELECT orderProduct.orderId, orderProduct.productId, orderProduct.quantity, productInventory.quantity FROM orderProduct JOIN productInventory ON orderProduct.productId = productInventory.productId WHERE orderProduct.orderId = ? AND productInventory.warehouseId = 1";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setString(1, ordId);
	ResultSet rst = pstmt.executeQuery();

	int oid = 0;

	out.println("<table>");
	while(rst.next()){
		oid = rst.getInt(1);
		int orderQuantity = rst.getInt(3);
		int warehouseQuantity = rst.getInt(4);
		int remaining = warehouseQuantity - orderQuantity;

		out.println("<tr><th>Ordered Product</th><td>" + rst.getString(1) + "</td><th>Qty</th><td>" + orderQuantity + "</td><th>Previous Inventory</th><td>" + warehouseQuantity + "</td><th>New Inventory</th><td>" + remaining + "</td></tr>");

		if(remaining < 0){
			shipmentFailed = true;
		}

	}

	out.println("</table>");
	if(!shipmentFailed){
		out.println("<h2>Shipment Successfully Processed!</h2>");
		con.commit();
	}else{
		out.println("<h2>Shipment Failed. Insufficient Inventory for Product Id " + oid + "</h2>");
		con.rollback();
	}


}catch(SQLException ex){
	out.println(ex);
	con.rollback();
}


%>                       				

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>
