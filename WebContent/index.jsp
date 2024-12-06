<!DOCTYPE html>
<html>
<!--Background Image code link: https://stackoverflow.com/questions/35240758/adding-image-as-a-background-in-jsp -->
<!-- H1 and H2 style coded by Copilot AI-->
<style>
body {
	background-image: url("img/background.jpg");
}
h1, h2 {
            border: 2px solid #000; /* Black border */
            padding: 10px; /* Space inside the border */
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            text-align: center; /* Center align text */
            margin: 10px auto; /* Center align the box */
            width: fit-content; /* Adjust width to fit content */
        }
</style>
<head>
        <title>Super Save Home</title>
</head>
<body>
<h1 align="center">Welcome to Super Save Grocery!</h1>

<h2 align="center"><a href="listprod.jsp">Go Shopping</a></h2>

<h2 align="center"><a href="showcart.jsp">Show Cart</a></h2>

<h2 align="center"><a href="listorder.jsp">List All Orders</a></h2>

<h2 align="center"><a href="admin.jsp">Administrators</a></h2>

<h2 align="center"><a href="warehouse.jsp">Warehouse Info</a></h2>

<h2 align="center"><a href="createAccount.jsp">Create Account</a></h2>

<h2 align="center"><a href="customer.jsp">Customer Info</a></h2>

<h2 align="center"><a href="login.jsp">Login</a> - <a href="logout.jsp">Log Out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h2 align=\"center\">Signed in as: "+userName+"</h2>");
%>

</body>
</head>


