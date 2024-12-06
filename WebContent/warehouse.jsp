<!DOCTYPE html>
<html>
<head>
<title>Super Save Warehouse</title>
<%@ include file="header.jsp" %>

<!-- Stylesheet section coded with the assistance of Copilot AI -->
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
<%@ include file="jdbc.jsp" %>

<%
out.println("<h2>Warehouse Storage Information Page</h2>");
String sql = "SELECT P.productName, P.productId, PI.quantity FROM product P, productInventory PI WHERE P.productId = PI.productId";

try{

    getConnection();
	Statement stmt = con.createStatement();
    stmt.execute("USE orders");
    ResultSet rst = stmt.executeQuery(sql);

    // Color styles and Quantity Color changing coded with the assistance of Copilot AI

    out.println("<h3><span style='color: rgb(255, 162, 0);'>Amber Items are Low Quantity</span></h3>");
    out.println("<h3><span style='color: red;'>Red Items Have NO Quantity</span></h3>");
    
    out.println("<table><th align=\"left\">Product Name</th><th>Product Id</th><th>Quantity</th>");


    while(rst.next()){
        int id = rst.getInt(2);
        int quantity = rst.getInt(3);
        String quantityDisplay;
        if (quantity == 0) {
            quantityDisplay = "<span style='color:red;'>" + quantity + "</span>";
        } else if (quantity < 3) {
            quantityDisplay = "<span style='color: rgb(255, 162, 0);'>" + quantity + "</span>";
        } else {
            quantityDisplay = String.valueOf(quantity);
        }
        out.println("<tr><td><a href=\"product.jsp?id="+id+"\">" + rst.getString(1) + "</a></td><td align=\"center\">" + rst.getInt(2) + "</td><td align=\"center\">" + quantityDisplay + "</td></tr>");
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