<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Your Shopping Cart</title>
<!-- Code for .add-link and class="add-link" genederated by
 ChatGPT: https://chatgpt.com/share/67537775-0908-8005-b644-bc27ddc6dc26 
 -->
<style>
.add-link {
    text-decoration: none; /* Optional: Removes the underline */
    color: blue; /* Optional: Sets the link color */
}
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<%

// Clear shopping cart coded with the assistance of Copilot AI
// Check if the clear cart button was clicked
String clearCart = request.getParameter("clearCart");
if ("true".equals(clearCart)) {
    session.setAttribute("productList", null);
    out.println("<H1>Your shopping cart has been cleared!</H1>");
}

// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (productList == null)
{	out.println("<H3>Your shopping cart is empty!</H3>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	out.println("<h1>Your Shopping Cart</h1>");
	out.print("<table><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th>");
	out.println("<th>Price</th><th>Subtotal</th></tr>");

	double total =0;
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		
		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		out.print("<td align=\"center\">"+product.get(3)+"</td>");
		Object price = product.get(2);
		Object itemqty = product.get(3);
		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		

		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td></tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");
	out.println("</table>");

	// **** Code for .add-link and class="add-link" genederated by
 	// ChatGPT: https://chatgpt.com/share/67537775-0908-8005-b644-bc27ddc6dc26 ****
 	

	out.println("<h3><a href=\"checkout.jsp\" class="add-link">Check Out</a></h3>");
}
%>

<!-- Code for .add-link and class="add-link" genederated by
 ChatGPT: https://chatgpt.com/share/67537775-0908-8005-b644-bc27ddc6dc26 
 -->

<h3><a href="listprod.jsp" class="add-link">Return to Shopping Section</a></h3>

<!-- Clear cart button coded by Copilot AI-->

<form action="showcart.jsp" method="post">
    <input type="hidden" name="clearCart" value="true">
    <input type="submit" value="Clear Cart">
</form>
</body>
</html> 

