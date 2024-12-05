<!DOCTYPE html>
<html>
<head>
    <title>Super Save Account Creation</title>
</head>
<body>

<h2>Create Account</h2>
<%@ include file="jdbc.jsp" %>

<!-- Form coded by Copilot AI-->
<form action="createAccount.jsp" method="post">
    <label for="firstName">First Name:</label>
    <input type="text" id="firstName" name="firstName" required><br><br>
    
    <label for="lastName">Last Name:</label>
    <input type="text" id="lastName" name="lastName" required><br><br>
    
    <label for="email">Email (use '-' for spaces):</label>
    <input type="email" id="email" name="email" required><br><br>
    
    <label for="phonenum">Phone Number:</label>
    <input type="text" id="phonenum" name="phonenum" required><br><br>
    
    <label for="address">Address:</label>
    <input type="text" id="address" name="address" required><br><br>
    
    <label for="city">City:</label>
    <input type="text" id="city" name="city" required><br><br>
    
    <label for="state">State/Province (Ex AB):</label>
    <input type="text" id="state" name="state" required><br><br>
    
    <label for="postalCode">Postal Code/Zip Code:</label>
    <input type="text" id="postalCode" name="postalCode" required><br><br>
    
    <label for="country">Country:</label>
    <input type="text" id="country" name="country" required><br><br>
    
    <label for="userid">User ID:</label>
    <input type="text" id="userid" name="userid" required><br><br>
    
    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>
    
    <input type="submit" value="Create Account">
</form>

<%
    // getParameter, SQL, and prepareStatement coded by Copilot AI
    
    if (request.getMethod().equalsIgnoreCase("post")) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phonenum = request.getParameter("phonenum");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String postalCode = request.getParameter("postalCode");
        String country = request.getParameter("country");
        String userid = request.getParameter("userid");
        String password = request.getParameter("password");

        String sql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            getConnection();
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, firstName);
            pstmt.setString(2, lastName);
            pstmt.setString(3, email);
            pstmt.setString(4, phonenum);
            pstmt.setString(5, address);
            pstmt.setString(6, city);
            pstmt.setString(7, state);
            pstmt.setString(8, postalCode);
            pstmt.setString(9, country);
            pstmt.setString(10, userid);
            pstmt.setString(11, password);
            int rows = pstmt.executeUpdate();

        } catch (SQLException ex) {
            out.println("<p>Error: " + ex.getMessage() + "</p>");
        } finally {
            closeConnection();
        }
    }
%>

<h3><a href="index.jsp">Return Home</a></h3>

</body>
</html>