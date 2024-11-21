<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>YOUR NAME Grocery Order Processing</title>
</head>

<h1>Your Order Summary</h1>
<body>

<% 

String custId = request.getParameter("customerId");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

final String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
final String uid = "sa";
final String pw = "304#sa#pw";

NumberFormat currFormat = NumberFormat.getCurrencyInstance();

String firstN = "";
String lastN = "";
boolean hasValidCustomerId = custId != null && !custId.equals("");

try(Connection con = DriverManager.getConnection(url, uid, pw);
Statement stmt = con.createStatement();)
{

    String getCustomerName = "SELECT firstName, lastName FROM customer WHERE customerId = ?";
    PreparedStatement getCustName = con.prepareStatement(getCustomerName);
    getCustName.setString(1, custId);
    ResultSet rst = getCustName.executeQuery();
    rst.next();
    firstN += rst.getString(1);
    lastN += rst.getString(2);
    
    con.close();
}catch(SQLException ex){
    out.println("<h2>Invalid Customer Id!</h2>");
    productList = new HashMap<String, ArrayList<Object>>();
}

if (productList == null)
{	out.println("<H2>Your shopping cart is empty!</H2>");
	productList = new HashMap<String, ArrayList<Object>>();
}else if(!hasValidCustomerId){
    out.println("<H2>Your User Id is Invalid!</H2>");
	productList = new HashMap<String, ArrayList<Object>>();
}else{
    try(Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)
    {

        String sql = "INSERT INTO OrderSummary (customerId, totalAmount) VALUES (?, 0)";
        PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        pstmt.setString(1, custId);
        pstmt.executeUpdate();			
        ResultSet keys = pstmt.getGeneratedKeys();
        keys.next();
        int orderId = keys.getInt(1);

        String productsSql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt2 = con.prepareStatement(productsSql);

        double total = 0;
        double orderTotal = 0;

        out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
        out.println("<th>Price</th><th>Subtotal</th></tr>");

        Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
        while (iterator.hasNext())
        { 
            Map.Entry<String, ArrayList<Object>> entry = iterator.next();
            ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
            String productId = (String) product.get(0);
            String price = (String) product.get(2);
            double pr = Double.parseDouble(price);
            int qty = ( (Integer)product.get(3)).intValue();

            pstmt2.setInt(1, orderId);
            pstmt2.setString(2, productId);
            pstmt2.setInt(3, qty);
            pstmt2.setDouble(4, pr);
            pstmt2.executeUpdate();  

            total = qty * pr;
            orderTotal += total;

            String getProductName = "SELECT productName FROM product WHERE productId = ?";
            PreparedStatement getName = con.prepareStatement(getProductName);
            getName.setString(1, productId);
            ResultSet rst = getName.executeQuery();
            
            rst.next();
            String pName = rst.getString(1);

            out.print("<tr><td>"+productId+"</td>");
            out.print("<td>"+pName+"</td>");
            out.print("<td align=\"center\">"+qty+"</td>");
            out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		    out.print("<td align=\"right\">"+currFormat.format(total)+"</td></tr>");

            total = 0;
        }

        String updateOrderSummary = "UPDATE OrderSummary SET totalAmount = ? WHERE customerId = ?";
        PreparedStatement updateOrderSum = con.prepareStatement(updateOrderSummary);
        updateOrderSum.setDouble(1, orderTotal);
        updateOrderSum.setString(2, custId);
        updateOrderSum.executeUpdate();

        out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(orderTotal)+"</td></tr>");
	    out.println("</table>");

        out.println("<tr><th>Shipping to Customer: </th></tr>");
        out.println("<th>" + custId + "</th>");
        out.println("<th> Name: </th>");
        out.println("<th>" + firstN + "</th>");
        out.println("<th>" + lastN + "</th>");

        out.println("<h2>Order Complete. Will be shipped soon...</h2>");

        con.close();
    }catch(SQLException ex){
        out.println("<h5>INFORMATION ON ERROR: </h5>");
        out.println(ex);
    }
}

session.removeAttribute("productList");

%>

<h3><a href="listprod.jsp">Go Back to Products</a></h3>
<h3><a href="shop.html">Back to Main Menu</a></h3>

</BODY>
</HTML>