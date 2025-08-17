package servlet;

import dao.ItemDAO;
import model.Item;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageItems")
public class ItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        ItemDAO dao = new ItemDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            Item item = new Item(0, name, price, description);
            boolean success = dao.addItem(item);
            if (success) {
                request.setAttribute("message", "Item added successfully!");
            } else {
                request.setAttribute("error", "Failed to add item.");
            }
        } else if ("update".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            Item item = new Item(itemId, name, price, description);
            boolean success = dao.updateItem(item);
            if (success) {
                request.setAttribute("message", "Item updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update item.");
            }
        } else if ("delete".equals(action)) {
            int itemId = Integer.parseInt(request.getParameter("itemId"));
            boolean success = dao.deleteItem(itemId);
            if (success) {
                request.setAttribute("message", "Item deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete item.");
            }
        }
        List<Item> items = dao.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("manageItems.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ItemDAO dao = new ItemDAO();
        List<Item> items = dao.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("manageItems.jsp").forward(request, response);
    }
}
