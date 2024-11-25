<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>Grocery Store - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<img src="/getImage.action?imageId=${1_a.jpg}"/>

<%

String id = request.getParameter("id");
int prodID = Integer.parseInt(id);

try
{	
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

final String url = "jdbc:sqlserver://cosc304_sqlserver:1433;DatabaseName=orders;TrustServerCertificate=True";
final String uid = "sa";
final String pw = "304#sa#pw";

try (Connection con = DriverManager.getConnection(url, uid, pw);
	Statement stmt = con.createStatement();)
{
    String sql = "SELECT productName, productPrice FROM product WHERE productId = ?";
    PreparedStatement pstmt = con.prepareStatement(sql);
    pstmt.setInt(1, prodID);
    ResultSet rst = pstmt.executeQuery();
    rst.next();
    out.println("<table><tr><th><h3>" + rst.getString(1) + "</h3></th></tr>");

    // TODO: If there is a productImageURL, display using IMG tag

    try (Connection con2 = DriverManager.getConnection(url, uid, pw);
    Statement stmt2 = con2.createStatement();)
    {
        String sqlCheckIMG = "SELECT productImageURL FROM product WHERE productId = ?";
        PreparedStatement pstmt2 = con2.prepareStatement(sqlCheckIMG);
        pstmt2.setInt(1, prodID);
        ResultSet rst2 = pstmt2.executeQuery();
        
        rst2.next();
        out.println("<tr><th><img src=\"" + rst2.getString(1) + "\"></th></tr>");

        
    }catch(SQLException ex){
        out.println("Missing imageURL: " + ex);
    }

    // TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
                
    // TODO: Add links to Add to Cart and Continue Shopping

    out.println("<tr><td><h3><a href=\"addcart.jsp?id=" + id + "&name=" + rst.getString(1) + "&price=" + rst.getDouble(2) + "\">Add to Cart</a></h3></td></tr>");
    out.println("<tr><td><h3><a href=\"listorder.jsp\">Continue Shopping</a></h3></td></tr>");
    out.println("</table>");

}catch(SQLException ex){
    out.println(ex);
}    
    


%>

</body>
</html>

