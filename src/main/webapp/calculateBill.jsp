<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Customer" %>
<%@ page import="model.Bill" %>
<%@ page import="model.Item" %>
<%@ page import="dao.ItemDAO" %>
<html>
<head>
    <title>Calculate and Print Bill</title>
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
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        select, input[type="number"] { width: 100%; padding: 8px; box-sizing: border-box; }
        .message { color: green; text-align: center; margin-bottom: 10px; }
        .error { color: red; text-align: center; margin-bottom: 10px; }
        .bill-details { background: #f9f9f9; padding: 15px; border-radius: 6px; margin-top: 20px; }
        button { width: 100%; padding: 10px; background: #007bff; color: #fff; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #0056b3; }
        .print-btn { background: #28a745; margin-top: 10px; }
        .print-btn:hover { background: #218838; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #f2f2f2; }
    </style>
    <script>
        function printBill() {
            var billContent = document.querySelector('.bill-details').innerHTML;
            var printWindow = window.open('', '', 'height=600,width=800');
            printWindow.document.write('<html><head><title>Print Bill</title>');
            printWindow.document.write('<style>body{font-family:Arial,sans-serif;} table{width:100%;border-collapse:collapse;} th,td{border:1px solid #ccc;padding:8px;text-align:left;} th{background:#f2f2f2;} .bill-details{background:#f9f9f9;padding:15px;border-radius:6px;}</style>');
            printWindow.document.write('</head><body>');
            printWindow.document.write('<div class="bill-details">' + billContent + '</div>');
            printWindow.document.write('</body></html>');
            printWindow.document.close();
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        }
    </script>
</head>
<body>
<div class="main-layout">
    <jsp:include page="sidebar.jsp" />
    <div class="content-area">
        <h2>Calculate and Print Bill</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <form method="post" action="calculateBill">
            <div class="form-group">
                <label for="accountNo">Select Customer:</label>
                <select id="accountNo" name="accountNo" required>
                    <option value="">-- Select --</option>
                    <% List<Customer> customers = (List<Customer>) request.getAttribute("customers");
                       if (customers != null) {
                           for (Customer customer : customers) { %>
                    <option value="<%= customer.getAccountNo() %>"><%= customer.getAccountNo() %> - <%= customer.getName() %></option>
                    <%     }
                       } %>
                </select>
            </div>
            <div class="form-group">
                <label>Items:</label>
                <table style="width:100%; border-collapse:collapse;">
                    <tr>
                        <th style="border:1px solid #ccc; padding:8px;">Item Name</th>
                        <th style="border:1px solid #ccc; padding:8px;">Price</th>
                        <th style="border:1px solid #ccc; padding:8px;">Quantity</th>
                    </tr>
                    <% 
                        ItemDAO itemDAO = new ItemDAO();
                        List<Item> items = itemDAO.getAllItems();
                        for (Item item : items) { %>
                    <tr>
                        <td style="border:1px solid #ccc; padding:8px;"><%= item.getName() %></td>
                        <td style="border:1px solid #ccc; padding:8px;">Rs. <%= String.format("%.2f", item.getPrice()) %></td>
                        <td style="border:1px solid #ccc; padding:8px;">
                            <input type="number" name="quantity_<%= item.getItemId() %>" min="0" value="0" />
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>" />
                        </td>
                    </tr>
                    <% } %>
                </table>
            </div>
            <button type="submit">Calculate Bill</button>
        </form>
        <% if (request.getAttribute("bill") != null && request.getAttribute("customer") != null) {
            Bill bill = (Bill) request.getAttribute("bill");
            Customer customer = (Customer) request.getAttribute("customer");
        %>
            <div class="bill-details">
                <h3>Bill Details</h3>
                <p><b>Account No:</b> <%= customer.getAccountNo() %></p>
                <p><b>Name:</b> <%= customer.getName() %></p>
                <p><b>Date:</b> <%= bill.getBillDate() %></p>
                <table style="width:100%; border-collapse:collapse; margin-top:10px;">
                    <tr>
                        <th style="border:1px solid #ccc; padding:8px;">Item Name</th>
                        <th style="border:1px solid #ccc; padding:8px;">Price</th>
                        <th style="border:1px solid #ccc; padding:8px;">Quantity</th>
                        <th style="border:1px solid #ccc; padding:8px;">Total</th>
                    </tr>
                    <% if (bill.getBillItems() != null) {
                        for (model.BillItem billItem : bill.getBillItems()) {
                            model.Item item = billItem.getItem();
                    %>
                    <tr>
                        <td style="border:1px solid #ccc; padding:8px;"><%= item.getName() %></td>
                        <td style="border:1px solid #ccc; padding:8px;">Rs. <%= String.format("%.2f", item.getPrice()) %></td>
                        <td style="border:1px solid #ccc; padding:8px;"><%= billItem.getQuantity() %></td>
                        <td style="border:1px solid #ccc; padding:8px;">Rs. <%= String.format("%.2f", billItem.getQuantity() * item.getPrice()) %></td>
                    </tr>
                    <%     }
                       } %>
                </table>
                <p style="margin-top:10px;"><b>Total Amount:</b> Rs. <%= String.format("%.2f", bill.getAmount()) %></p>
                <button class="print-btn" onclick="printBill()">Print Bill</button>
            </div>
        <% } %>
        <h3>Bill List</h3>
        <table>
            <tr>
                <th>Bill ID</th>
                <th>Account No</th>
                <th>Date</th>
                <th>Total Amount</th>
            </tr>
            <% 
                List<Bill> billList = (List<Bill>) request.getAttribute("billList");
                if (billList != null) {
                    for (Bill billItem : billList) { %>
            <tr>
                <td><%= billItem.getBillId() %></td>
                <td><%= billItem.getAccountNo() %></td>
                <td><%= billItem.getBillDate() %></td>
                <td>Rs. <%= String.format("%.2f", billItem.getAmount()) %></td>
            </tr>
            <%     }
                } %>
        </table>
    </div>
</div>
</body>
</html>