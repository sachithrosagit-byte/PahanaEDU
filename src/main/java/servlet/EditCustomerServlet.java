package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editCustomer")
public class EditCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CustomerDAO dao = new CustomerDAO();

        if ("search".equals(action)) {
            int accountNo = Integer.parseInt(request.getParameter("accountNo"));
            Customer customer = dao.getCustomerByAccountNo(accountNo);
            if (customer != null) {
                request.setAttribute("customer", customer);
            } else {
                request.setAttribute("error", "Customer not found.");
            }
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
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
                request.setAttribute("customer", customer);
            } else {
                request.setAttribute("error", "Failed to update customer.");
                request.setAttribute("customer", customer);
            }
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
    }
}
