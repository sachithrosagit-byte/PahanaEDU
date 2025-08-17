<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Customer Management</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; }
        .main-layout { display: flex; min-height: 100vh; }
        .sidebar { width: 220px; background: #007bff; color: #fff; padding: 30px 0; min-height: 100vh; position: fixed; left: 0; top: 0; }
        .sidebar h3 { text-align: center; margin-bottom: 30px; }
        .menu { display: flex; flex-direction: column; gap: 10px; }
        .menu a { background: #fff; color: #007bff; margin: 0 20px; padding: 10px; border-radius: 4px; text-align: center; text-decoration: none; }
        .menu a:hover { background: #0056b3; color: #fff; }
        .content-area { margin-left: 240px; flex: 1; padding: 40px; }
        h2 { text-align: center; }
        .welcome { text-align: center; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #007bff; color: #fff; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="number"] { width: 100%; padding: 8px; box-sizing: border-box; }
        .message { color: green; text-align: center; margin-bottom: 10px; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
        button, .action-btn { padding: 8px 16px; background: #007bff; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        button:hover, .action-btn:hover { background: #0056b3; }
        .action-btn { margin-right: 5px; }
    </style>
</head>
<body>
<div class="main-layout">
    <jsp:include page="sidebar.jsp" />
    <div class="content-area">
        <h2>Customer Management</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <h3>Add New Customer</h3>
        <form method="post" action="manageCustomers">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
            </div>
            <div class="form-group">
                <label for="telephone">Telephone:</label>
                <input type="text" id="telephone" name="telephone" required>
            </div>
            <button type="submit">Add Customer</button>
        </form>
        <h3>Customer List</h3>
        <table>
            <tr>
                <th>Account No</th>
                <th>Name</th>
                <th>Address</th>
                <th>Telephone</th>
                <th>Actions</th>
            </tr>
            <% List<Customer> customers = (List<Customer>) request.getAttribute("customers");
               if (customers != null) {
                   for (Customer customer : customers) { %>
            <tr>
                <form method="post" action="manageCustomers">
                    <td><%= customer.getAccountNo() %><input type="hidden" name="accountNo" value="<%= customer.getAccountNo() %>"></td>
                    <td><input type="text" name="name" value="<%= customer.getName() %>" required></td>
                    <td><input type="text" name="address" value="<%= customer.getAddress() %>" required></td>
                    <td><input type="text" name="telephone" value="<%= customer.getTelephone() %>" required></td>
                    <td>
                        <input type="hidden" name="action" value="update">
                        <button type="submit" class="action-btn">Update</button>
                </form>
                <form method="post" action="manageCustomers" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="accountNo" value="<%= customer.getAccountNo() %>">
                    <button type="submit" class="action-btn" onclick="return confirm('Are you sure you want to delete this customer?');">Delete</button>
                </form>
                    </td>
            </tr>
            <%     }
               } %>
        </table>
    </div>
</div>
</body>
</html>