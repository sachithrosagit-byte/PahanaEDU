<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Item" %>
<html>
<head>
    <title>Manage Item Information</title>
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
        <h2>Manage Item Information</h2>
        <% if (request.getAttribute("message") != null) { %>
            <div class="message"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>
        <h3>Add New Item</h3>
        <form method="post" action="manageItems">
            <input type="hidden" name="action" value="add">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="price">Price:</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required>
            </div>
            <div class="form-group">
                <label for="description">Description:</label>
                <input type="text" id="description" name="description">
            </div>
            <button type="submit">Add Item</button>
        </form>
        <h3>Item List</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <% List<Item> items = (List<Item>) request.getAttribute("items");
               if (items != null) {
                   for (Item item : items) { %>
            <tr>
                <form method="post" action="manageItems">
                    <td><%= item.getItemId() %><input type="hidden" name="itemId" value="<%= item.getItemId() %>"></td>
                    <td><input type="text" name="name" value="<%= item.getName() %>" required></td>
                    <td><input type="number" name="price" step="0.01" min="0" value="<%= String.format("%.2f", item.getPrice()) %>" required></td>
                    <td><input type="text" name="description" value="<%= item.getDescription() %>"></td>
                    <td>
                        <input type="hidden" name="action" value="update">
                        <button type="submit" class="action-btn">Update</button>
                </form>
                <form method="post" action="manageItems" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                    <button type="submit" class="action-btn" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
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