<!DOCTYPE html>
<html>
<head>
        <title>Super Save Home</title>
</head>
<body>
<h1 align="center">Welcome to Super Save Grocery</h1>

<h2 align="center"><a href="login.jsp">Login</a></h2>

<h2 align="center"><a href="listprod.jsp">Go Shopping</a></h2>

<h2 align="center"><a href="showcart.jsp">Show Cart</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="warehouse.jsp">Warehouse Info</a></h2>

<h2 align="center"><a href="logout.jsp">Log out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h2 align=\"center\">Signed in as: "+userName+"</h2>");
%>

</body>
</head>


