<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Display Account Details</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; }
        .container { width: 700px; margin: 40px auto; padding: 30px; background: #fff; border-radius: 8px; box-shadow: 0 0 10px #ccc; }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #007bff; color: #fff; }
    </style>
</head>
<body>
<div class="container">
    <h2>Customer Account Details</h2>
    <table>
        <tr>
            <th>Account No</th>
            <th>Name</th>
            <th>Address</th>
            <th>Telephone</th>
            <th>Units Consumed</th>
        </tr>
        <% List<Customer> customers = (List<Customer>) request.getAttribute("customers");
           if (customers != null) {
               for (Customer customer : customers) { %>
        <tr>
            <td><%= customer.getAccountNo() %></td>
            <td><%= customer.getName() %></td>
            <td><%= customer.getAddress() %></td>
            <td><%= customer.getTelephone() %></td>
            <td><%= customer.getUnitsConsumed() %></td>
        </tr>
        <%     }
           } %>
    </table>
</div>
</body>
</html>
