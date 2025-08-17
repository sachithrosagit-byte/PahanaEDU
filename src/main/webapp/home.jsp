<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="dao.CustomerDAO,dao.ItemDAO,dao.BillDAO,model.Customer,model.Item,model.Bill" %>
<%@ page import="java.util.List,java.util.ArrayList" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    CustomerDAO customerDAO = new CustomerDAO();
    ItemDAO itemDAO = new ItemDAO();
    BillDAO billDAO = new BillDAO();
    int totalCustomers = customerDAO.getAllCustomers().size();
    int totalItems = itemDAO.getAllItems().size();
    List<Bill> bills = billDAO.getAllBills(); // Updated to fetch all bills
    int totalBills = bills.size();
    double totalRevenue = 0;
    for (Bill bill : bills) {
        totalRevenue += bill.getAmount();
    }
%>
<html>
<head>
    <title>Home - Pahana Edu Online Billing System</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f4f4; margin: 0; }
        .main-layout { display: flex; min-height: 100vh; }
        .content-area { margin-left: 240px; flex: 1; padding: 40px; }
        h2 { text-align: center; }
        .welcome { text-align: center; margin-bottom: 20px; }
        .kpi-container { display: flex; justify-content: center; gap: 40px; margin-bottom: 30px; }
        .kpi-box { background: #fff; border-radius: 8px; border: 1px solid #ccc; padding: 24px 32px; text-align: center; min-width: 160px; }
        .kpi-title { font-size: 1.1em; color: #888; margin-bottom: 8px; }
        .kpi-value { font-size: 2em; font-weight: bold; color: #2a7ae2; }
    </style>
</head>
<body>
<div class="main-layout">
    <jsp:include page="sidebar.jsp" />
    <div class="content-area">
        <h2>Welcome to Pahana Edu Online Billing System</h2>
        <div class="welcome">
            Hello, <b><%= user.getUsername() %></b>!
        </div>
        <div class="kpi-container">
            <div class="kpi-box">
                <div class="kpi-title">Total Customers</div>
                <div class="kpi-value"><%= totalCustomers %></div>
            </div>
            <div class="kpi-box">
                <div class="kpi-title">Total Items</div>
                <div class="kpi-value"><%= totalItems %></div>
            </div>
            <div class="kpi-box">
                <div class="kpi-title">Total Bills</div>
                <div class="kpi-value"><%= totalBills %></div>
            </div>
            <div class="kpi-box">
                <div class="kpi-title">Total Revenue</div>
                <div class="kpi-value">Rs. <%= String.format("%.2f", totalRevenue) %></div>
            </div>
        </div>
        <!-- Main content for home page -->
    </div>
</div>
</body>
</html>