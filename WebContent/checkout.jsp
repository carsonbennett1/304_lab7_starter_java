<!DOCTYPE html>
<html>
<head>
<title>Super Save CheckOut Line</title>
</head>
<body>

<h1>Enter Your Customer Details to Complete the Transaction:</h1>

<form method="get" action="order.jsp">
<h3>Customer Id</h3>
<input type="text" name="customerId" size="50" style="margin-bottom: 10px;"><br>
<h3>Payment Type (Debit, Credit, Prepaid Card)</h3>
<input type="text" name="paymentType" size="50" style="margin-bottom: 10px;"><br>
<h3>Payment Number (Ex: 0123 4567 8910 0000)</h3>
<input type="number" name="paymentNumber" size="25" style="margin-bottom: 10px;"><br>

<input type="submit" value="Submit"><input type="reset" value="Reset">
</form>

</body>
</html>

