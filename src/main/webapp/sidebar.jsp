<div class="sidebar">
    <h3 style="text-align:center; font-size:1.1em; font-weight:500; margin-bottom:20px;">Pahana Edu</h3>
    <div class="menu">
        <a href="home.jsp">Home</a>
        <a href="manageCustomers">Customer Management</a>
        <a href="manageItems">Manage Item Information</a>
        <a href="calculateBill">Calculate and Print Bill</a>
        <a href="help.jsp">Help Section</a>
        <a href="logout">Exit System</a>
    </div>
</div>
<style>
.sidebar {
    width: 240px;
    background: #007bff;
    color: #fff;
    padding: 20px 0 0 0;
    min-height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
}
.sidebar .menu {
    display: flex;
    flex-direction: column;
    gap: 10px;
}
.sidebar .menu a {
    color: #007bff;
    background: #fff;
    text-decoration: none;
    padding: 8px 16px;
    border-radius: 4px;
    font-size: 1em;
    margin: 0 20px;
    text-align: center;
}
.sidebar .menu a:hover {
    background: #0056b3;
    color: #fff;
}
</style>