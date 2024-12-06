<!DOCTYPE html>
<html>
<head>
    <title>Super Save Account Creation</title>
    <script>
        function validateForm() {
            var email = document.getElementById("email").value;
            var phonenum = document.getElementById("phonenum").value;
            var postalCode = document.getElementById("postalCode").value;
            var password = document.getElementById("password").value;
            var state_province = document.getElementById("state").value;
            var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            var phonePattern = /^\d{10}$/;
            var postalCodePattern = /^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$/; // Canadian postal code pattern
            var state_province_pattern = /^[A-Z]{2}$/;

            if (!emailPattern.test(email)) {
                alert("Please enter a valid email address. \nEx: someone@something.com");
                return false;
            }
            if (!phonePattern.test(phonenum)) {
                alert("Please enter a valid 10-digit phone number.\nNO spaces OR dashes\nEx: 7013331355");
                return false;
            }
            if(!state_province_pattern.test(state_province)){
                alert("Please enter a two charcter state/province.\nEx: AB, MB, MT, NY");
                return false;
            }
            if (!postalCodePattern.test(postalCode)) {
                alert("Please enter a valid postal code. \nEx: A1A 1A1");
                return false;
            }
            if (password.length < 8) {
                alert("Password must be at least 8 characters long.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

<h2>Create Account</h2>
<%@ include file="jdbc.jsp" %>
<h4>* = Mandatory Entry Field</h4>

<form action="createAccount.jsp" method="post" onsubmit="return validateForm()">
    <label for="firstName">First Name: *</label>
    <input type="text" id="firstName" name="firstName" required><br><br>
    
    <label for="lastName">Last Name: *</label>
    <input type="text" id="lastName" name="lastName" required><br><br>
    
    <label for="email">Email: *</label>
    <input type="email" id="email" name="email" required><br><br>
    
    <label for="phonenum">Phone Number: *</label>
    <input type="text" id="phonenum" name="phonenum" required><br><br>
    
    <label for="address">Address: *</label>
    <input type="text" id="address" name="address" required><br><br>
    
    <label for="city">City: *</label>
    <input type="text" id="city" name="city" required><br><br>
    
    <label for="state">State/Province: *</label>
    <input type="text" id="state" name="state" required><br><br>
    
    <label for="postalCode">Postal Code/Zip Code: *</label>
    <input type="text" id="postalCode" name="postalCode" required><br><br>
    
    <label for="country">Country: *</label>
    <input type="text" id="country" name="country" required><br><br>
    
    <label for="userid">User ID: *</label>
    <input type="text" id="userid" name="userid" required><br><br>
    
    <label for="password">Password: *</label>
    <input type="password" id="password" name="password" required><br><br>
    
    <input type="submit" value="Create Account">
</form>

<%
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

        // Server-side validation
        if (!email.matches("^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            out.println("<p>Error: Invalid email format.</p>");
        } else if (!phonenum.matches("^\\d{10}$")) {
            out.println("<p>Error: Invalid phone number format. Please enter a 10-digit phone number.</p>");
        } else if (!postalCode.matches("^[A-Za-z]\\d[A-Za-z][ -]?\\d[A-Za-z]\\d$")) {
            out.println("<p>Error: Invalid postal code format.</p>");
        } else if (password.length() < 8) {
            out.println("<p>Error: Password must be at least 8 characters long.</p>");
        } else {
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
                out.println("<p>Account created successfully!</p>");
            } catch (SQLException ex) {
                out.println("<p>Error: " + ex.getMessage() + "</p>");
            } finally {
                closeConnection();
            }
        }
    }
%>

<h3><a href="index.jsp">Return Home</a></h3>

</body>
</html>