<!DOCTYPE html>
<html>
<head>
<title>Add New Product</title>
<!-- Add product style sheet (i.e. body, h2, h4, ... .feedback) 
 all coded by ChatGPT:
 https://chatgpt.com/share/67537db4-d7bc-8005-b27e-69c09c306b06 
 -->
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 20px;
        background-color: #f9f9f9;
    }

    h2, h4 {
        text-align: center;
        color: #333;
    }

    h4 {
        font-size: 14px;
        color: #555;
        margin-bottom: 20px;
    }

    form {
        margin: 30px auto;
        width: 60%;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    }

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

    input[type="text"], input[type="number"], textarea {
        width: 95%;
        padding: 8px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    button {
        background-color: #28a745;
        color: white;
        font-size: 16px;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin: 20px 0;
    }

    button:hover {
        background-color: #218838;
    }

    .add-link {
        margin-left: 30px;
        text-decoration: none;
        color: blue;
    }

    .add-link:hover {
        text-decoration: underline;
    }

    .feedback {
        text-align: center;
        margin-top: 20px;
        font-size: 16px;
    }
</style>
<!-- Client Side validation coded by ChatGPT:
 https://chatgpt.com/share/6753826a-19d8-8005-8365-02d51d16741e 
 -->
<script>
    function validateForm() {
        const productName = document.forms[0]["productName"].value;
        const categoryId = document.forms[0]["categoryId"].value;

        const specialCharPattern = /[!@#$%^&*(),.?":{}|<>[\]]/;

        if (specialCharPattern.test(productName)) {
            alert("Product Name should not contain special characters.");
            return false;
        }

        if (categoryId < 1 || categoryId > 8) {
            alert("Category ID must be a number between 1 and 8.");
            return false;
        }

        return true;
    }
</script>

</head>
<body>

<!-- Add new product file coded by ChatGPT
 (i.e. <form> and <% %> sections): 
 https://chatgpt.com/share/67536ab8-21d8-8005-b8e8-af1a88e50402 
 -->

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="header.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.math.BigDecimal" %>


<h2 style="text-align: center;">Add New Product</h2>
<h4 style="text-align: center;">*** NO special charcters in product name (i.e. @, [], {}, ^, </h4>
<h4 style="text-align: center;">Category ID Legend:</h4>
<h4 style="text-align: center;">
    [1 = Beverages, 2 = Condiments, 3 = Dairy Products, 4 = Produce
     5 = Meat/Poultry, 6 = Seafood, 7 = Confections, 8 = Grains/Cereals]
</h4>

<!-- Form method changed to onsubmit="return validateForm()" due to
 ChatGPT feedback: https://chatgpt.com/share/6753826a-19d8-8005-8365-02d51d16741e 
 -->
<form method="post" action="addproduct.jsp" onsubmit="return validateForm()">
    <table>
        <tr><td>Product Name:</td><td><input type="text" name="productName" required></td></tr>
        <tr><td>Product Price:</td><td><input type="number" step="0.01" name="productPrice" required></td></tr>
        <tr><td>Product Description:</td><td><textarea name="productDesc" rows="4" cols="30"></textarea></td></tr>
        <tr><td>Category ID:</td><td><input type="number" name="categoryId" required></td></tr>
        <tr><td colspan="2" align="center"><button type="submit">Add Product</button></td></tr>
    </table>
</form>

<!-- Server side validation coded by ChatGPT:
 https://chatgpt.com/share/6753826a-19d8-8005-8365-02d51d16741e 
 -->
<%
if (request.getMethod().equalsIgnoreCase("POST")) {
    String productName = request.getParameter("productName");
    String productPrice = request.getParameter("productPrice");
    String productDesc = request.getParameter("productDesc");
    String categoryId = request.getParameter("categoryId");

    String specialCharPattern = "[!@#$%^&*(),.?\":{}|<>\\[\\]]";
    if (productName.matches(".*" + specialCharPattern + ".*")) {
        out.println("<h3 style='color:red; text-align:center;'>Error: Product Name should not contain special characters.</h3>");
        return;
    }

    int categoryIdInt;
    try {
        categoryIdInt = Integer.parseInt(categoryId);
        if (categoryIdInt < 1 || categoryIdInt > 8) {
            out.println("<h3 style='color:red; text-align:center;'>Error: Category ID must be between 1 and 8.</h3>");
            return;
        }
    } catch (NumberFormatException e) {
        out.println("<h3 style='color:red; text-align:center;'>Error: Invalid Category ID.</h3>");
        return;
    }

    String insertSQL = "INSERT INTO Product (productName, productPrice, productDesc, categoryId) " +
                       "VALUES (?, ?, ?, ?)";

    try {
        getConnection();
        PreparedStatement pstmt = con.prepareStatement(insertSQL);
        pstmt.setString(1, productName);
        pstmt.setBigDecimal(2, new BigDecimal(productPrice));
        pstmt.setString(3, productDesc);
        pstmt.setInt(4, Integer.parseInt(categoryId));

        int rowsInserted = pstmt.executeUpdate();
        if (rowsInserted > 0) {
            out.println("<h3 style='color:green; text-align:center;'>Product added successfully!</h3>");
        } else {
            out.println("<h3 style='color:red; text-align:center;'>Failed to add product. Please try again.</h3>");
        }
    } catch (SQLException e) {
        out.println("<h3 style='color:red; text-align:center;'>Error: " + e.getMessage() + "</h3>");
    } finally {
        closeConnection();
    }
}
%>

</body>
</html>