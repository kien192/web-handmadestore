package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminController", value = "/admin")
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String func = req.getParameter("func");
        String framePath = "views/Admin/admin.jsp";

        if (func != null) {
            switch (func) {
                case "dashboard":
                    framePath = "/views/Admin/dashboard.jsp";
                    break;
                case "product_management":
                    framePath = "/views/Admin/product_management.jsp";
                    break;
                case "order_management":
                    framePath = "/views/Admin/order_management.jsp";
                    break;
                case "customer_management":
                    framePath = "/views/Admin/customer_management.jsp";
                    break;
                case "settings":
                    framePath = "/views/Admin/settings.jsp";
                    break;
                default:
                    // Handle the default case, e.g., redirect to a default page
                    framePath = "/views/Admin/dashboard.jsp";
                    break;
            }

            req.setAttribute("framePath", framePath);
        }
        req.getRequestDispatcher(framePath).forward(req, resp);
    }

    private void add_product(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
}
