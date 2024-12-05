<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>
</head>
<body>

<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<h2>Change Password</h2>

<h4>Enter Customer ID and Old Password to Begin</h4>

<form action="changePassword.jsp" method="post">
    <label for="customerId">Customer ID:</label>
    <input type="text" id="customerId" name="customerId" required><br><br>
    
    <label for="oldPassword">Old Password:</label>
    <input type="password" id="oldPassword" name="oldPassword" required><br><br>
    
    <label for="newPassword">New Password:</label>
    <input type="password" id="newPassword" name="newPassword" required><br><br>
    
    <label for="confirmPassword">Confirm New Password:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>
    
    <input type="submit" value="Change Password">
</form>

<%
    if (request.getMethod().equalsIgnoreCase("post")) {
        String customerId = request.getParameter("customerId");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            out.println("<p>New passwords do not match. Please try again.</p>");
        } else {
            String sqlSelect = "SELECT password FROM customer WHERE customerId = " + customerId;
            String sqlUpdate = "UPDATE customer SET password = '" + newPassword + "' WHERE customerId = " + customerId;

            try {
                getConnection();
                Statement stmt = con.createStatement();
                ResultSet rst = stmt.executeQuery(sqlSelect);

                if (rst.next()) {
                    String storedPassword = rst.getString("password");
                    if (storedPassword.equals(oldPassword)) {
                        int rows = stmt.executeUpdate(sqlUpdate);

                        if (rows > 0) {
                            out.println("<p>Password changed successfully!</p>");
                        } else {
                            out.println("<p>Error changing password. Please try again.</p>");
                        }
                    } else {
                        out.println("<p>Old password is incorrect. Please try again.</p>");
                    }
                } else {
                    out.println("<p>Customer ID not found. Please try again.</p>");
                }
            } catch (SQLException ex) {
                out.println("<p>Error: " + ex.getMessage() + "</p>");
            } finally {
                closeConnection();
            }
        }
    }
%>

</body>
</html>