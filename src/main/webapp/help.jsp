<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Help - Pahana Edu Online Billing System</title>
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
        ul { margin-top: 20px; }
        li { margin-bottom: 10px; }
    </style>
</head>
<body>
<div class="main-layout">
    <jsp:include page="sidebar.jsp" />
    <div class="content-area">
        <h2>Help &amp; System Usage Guidelines</h2>
        <ul>
            <li><b>Login:</b> Enter your username and password to access the system.</li>
            <li><b>Customer Management:</b> Add, edit, delete, and view customer accounts in one place.</li>
            <li><b>Manage Item Information:</b> Add, update, or delete items used for billing.</li>
            <li><b>Calculate and Print Bill:</b> Select a customer to calculate their bill and print it.</li>
            <li><b>Help Section:</b> View guidelines and instructions for using the system.</li>
            <li><b>Exit System:</b> Use the logout option to securely exit the application.</li>
            <li><b>Dashboard Overview:</b> View key performance indicators such as total customers, items, bills, and revenue on the home page.</li>
        </ul>
        <p>If you need further assistance, please contact the system administrator.</p>
    </div>
</div>
</body>
</html>