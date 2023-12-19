package controller.admin;

import model.bean.Category;
import model.bean.Product;
import model.bean.User;
import model.service.CategoryService;
import model.service.ProductService;
import model.service.RoleService;
import model.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminController", value = "/admin")
public class MainAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        User admin = (User) req.getSession().getAttribute("auth");
        boolean isAdmin = ((req.getSession().getAttribute("isAdmin") == null) ? false : ((boolean) req.getSession().getAttribute("isAdmin")));
        if (admin != null && isAdmin) {
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
                    case "support":
                        framePath = "/views/Admin/support.jsp";
                        break;
                    default:
                        framePath = "/views/Admin/dashboard.jsp";
                        break;
                }
                req.setAttribute("framePath", framePath);
            }
            req.getRequestDispatcher(framePath).forward(req, resp);
        } else {
            resp.sendRedirect("login");
        }
    }
}
