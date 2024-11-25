<!DOCTYPE html>
<html>
<head>
<title>Administrator Page</title>
</head>
<body>

// TODO: Include files auth.jsp and jdbc.jsp
<%@include file="auth.jsp"%>
<%@include file="jdbc.jsp"%>

<%

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

    // TODO: Write SQL query that prints out total order amount by day
    String sql = "";




}catch (SQLException ex){
    out.println(ex);
}finally{
    closeConnection();
}

%>

</body>
</html>

