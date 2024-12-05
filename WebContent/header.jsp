<div style="display: flex; align-items: center; justify-content: center;">
    <H1 style="margin: 0;">
        <font face="cursive" color="#3399FF">
            <a href="index.jsp">Super Save Grocery Store</a>
        </font>
    </H1>
    <!-- Header changed with the assistance of Copilot AI -->
    <%
        String userName = (String) session.getAttribute("authenticatedUser");
        if (userName != null) {
    %>
        <span style="margin-left: 75px; margin-top: 10px;">User: <%= userName %></span>
        <a href="customer.jsp" style="margin-left: 75px; margin-top: 10px;">My Account</a>
        <a href="logout.jsp" style="margin-left: 77px; margin-top: 10px;">Logout</a>
    <%
        } else {
    %>
        <a href="login.jsp" style="margin-left: 77px; margin-top: 10px;">Login</a>
    <%
        }
    %>
</div>
<hr>
