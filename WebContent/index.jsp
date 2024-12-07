<!DOCTYPE html>
<html>
<!--Background Image code link: 
https://stackoverflow.com/questions/35240758/adding-image-as-a-background-in-jsp 
-->

<!-- Fit to screen code provided by ChatGPT: 
 https://chatgpt.com/share/67536416-9900-8005-bf45-932e18d3b512 
 -->

<!-- H1 and H2 style coded by Copilot AI-->

<!-- Code for .add-link and class="add-link" genederated by
 ChatGPT: https://chatgpt.com/share/67537775-0908-8005-b644-bc27ddc6dc26 
 -->
<style>
body {
	background-image: url("img/background.webp");
        background-size: cover;
}
h1, h2 {
            border: 2px solid #000; /* Black border */
            padding: 10px; /* Space inside the border */
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white background */
            text-align: center; /* Center align text */
            margin: 10px auto; /* Center align the box */
            width: fit-content; /* Adjust width to fit content */
        }
.add-link {
    text-decoration: none; /* Optional: Removes the underline */
    color: blue; /* Optional: Sets the link color */
}
</style>
<head>
        <title>Super Save Home</title>
</head>
<body>
<h1 align="center">Welcome to Super Save Grocery!</h1>

<h2 align="center"><a href="listprod.jsp" class="add-link">Go Shopping</a></h2>

<h2 align="center"><a href="showcart.jsp" class="add-link">Show Cart</a></h2>

<h2 align="center"><a href="listorder.jsp" class="add-link">List All Orders</a></h2>

<h2 align="center"><a href="admin.jsp" class="add-link">Administrators</a></h2>

<h2 align="center"><a href="warehouse.jsp" class="add-link">Warehouse Info</a></h2>

<h2 align="center"><a href="createAccount.jsp" class="add-link">Create Account</a></h2>

<h2 align="center"><a href="customer.jsp" class="add-link">Customer Info</a></h2>

<h2 align="center"><a href="login.jsp" class="add-link">Login</a> - <a href="logout.jsp" class="add-link">Log Out</a></h2>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
	if (userName != null)
		out.println("<h2 align=\"center\">Signed in as: "+userName+"</h2>");
%>

</body>
</head>


