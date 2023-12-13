package controller;

import model.bean.Category;
import model.bean.Product;
import model.bean.User;
import model.dao.ProductDAO;
import model.service.CategoryService;
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
public class AdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User admin = (User) req.getSession().getAttribute("auth");
        System.out.println("admin available: " + admin);
        if (admin != null && RoleService.getInstance().checkRole(admin).equals("admin")) {
            String func = req.getParameter("func");
            String framePath = "views/Admin/admin.jsp";
            if (func != null) {
                switch (func) {
                    case "dashboard":
                        framePath = "/views/Admin/dashboard.jsp";
                        break;
                    case "product_management":
                        List<Product> products = ProductDAO.getAll();
                        List<Category> categories = CategoryService.getInstance().getALl();
                        req.setAttribute("products", products);
                        req.setAttribute("categories", categories);
                        framePath = "/views/Admin/product_management.jsp";
                        break;
                    case "order_management":
                        framePath = "/views/Admin/order_management.jsp";
                        break;
                    case "customer_management":
                        String user_id = req.getParameter("user_id");
                        if (user_id != null) {
                            //lock or unlock
                            User u = UserService.getInstance().getUserById(user_id);
                            if (u.getStatus().trim().startsWith("Bình Thường")) {
                                UserService.getInstance().lockUser(user_id);
                            } else if (u.getStatus().trim().equalsIgnoreCase("Bị Khóa")) {
                                UserService.getInstance().unlockUser(user_id);
                            }
                        }
                        framePath = "/views/Admin/customer_management.jsp";
                        List<User> users = UserService.getInstance().getAllUsers();
                        req.setAttribute("users", users);
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
        } else {
            resp.sendRedirect("login");
        }
    }
//    private void add_product(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//
//    }
}
