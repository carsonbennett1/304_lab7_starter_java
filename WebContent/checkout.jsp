<!DOCTYPE html>
<html>
<head>
<title>Super Save CheckOut Line</title>
</head>
<body>

<%@ include file="header.jsp" %>

<h1>Enter Your Customer Details to Complete the Transaction:</h1>

<!-- Styling and Line Breaks Coded With the Assistance of Copilot AI-->
 
<form method="get" action="order.jsp">
<h3>Customer Id</h3>
<input type="text" name="customerId" size="50" style="margin-bottom: 10px;"><br>
<h3>Payment Type (Debit, Credit, Prepaid)</h3>
<input type="text" name="paymentType" size="50" style="margin-bottom: 10px;"><br>
<h3>Payment Number (NO SPACES) [Ex: 0123456789100000]</h3>
<input type="text" name="paymentNumber" size="35" style="margin-bottom: 10px;"><br>

<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>

