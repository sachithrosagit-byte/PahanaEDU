package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/manageCustomers")
public class ManageCustomersServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO dao = new CustomerDAO();

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
            Customer customer = new Customer(0, name, address, telephone, unitsConsumed);
            boolean success = dao.addCustomer(customer);
            if (success) {
                request.setAttribute("message", "Customer added successfully!");
            } else {
                request.setAttribute("error", "Failed to add customer.");
            }
        } else if ("update".equals(action)) {
            int accountNo = Integer.parseInt(request.getParameter("accountNo"));
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String telephone = request.getParameter("telephone");
            int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));
            Customer customer = new Customer(accountNo, name, address, telephone, unitsConsumed);
            boolean success = dao.updateCustomer(customer);
            if (success) {
                request.setAttribute("message", "Customer updated successfully!");
            } else {
                request.setAttribute("error", "Failed to update customer.");
            }
        } else if ("delete".equals(action)) {
            int accountNo = Integer.parseInt(request.getParameter("accountNo"));
            boolean success = dao.deleteCustomer(accountNo);
            if (success) {
                request.setAttribute("message", "Customer deleted successfully!");
            } else {
                request.setAttribute("error", "Failed to delete customer.");
            }
        }
        List<Customer> customers = dao.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerDAO dao = new CustomerDAO();
        List<Customer> customers = dao.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
    }
}
