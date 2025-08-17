<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Edit Customer Information</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { width: 450px; margin: 60px auto; padding: 30px; background: #fff; border-radius: 8px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="number"] { width: 100%; padding: 8px; box-sizing: border-box; }
        .message { color: green; text-align: center; margin-bottom: 10px; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
        button { width: 100%; padding: 10px; background: #007bff; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>Edit Customer Information</h2>
    <form method="post" action="editCustomer">
        <input type="hidden" name="action" value="search">
        <div class="form-group">
            <label for="accountNo">Account Number:</label>
            <input type="number" id="accountNo" name="accountNo" min="1" required>
        </div>
        <button type="submit">Search</button>
    </form>
    <br>
    <% if (request.getAttribute("customer") != null) {
        Customer customer = (Customer) request.getAttribute("customer"); %>
        <form method="post" action="editCustomer">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="accountNo" value="<%= customer.getAccountNo() %>">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= customer.getName() %>" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="<%= customer.getAddress() %>" required>
            </div>
            <div class="form-group">
                <label for="telephone">Telephone:</label>
                <input type="text" id="telephone" name="telephone" value="<%= customer.getTelephone() %>" required>
            </div>
            <div class="form-group">
                <label for="unitsConsumed">Units Consumed:</label>
                <input type="number" id="unitsConsumed" name="unitsConsumed" min="0" value="<%= customer.getUnitsConsumed() %>" required>
            </div>
            <button type="submit">Update Customer</button>
        </form>
    <% } %>
    <% if (request.getAttribute("message") != null) { %>
        <div class="message"><%= request.getAttribute("message") %></div>
    <% } %>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>
</div>
</body>
</html>
