package controller.admin;

import model.bean.User;
import model.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerAdminController", value = "/admin/customer")
public class CustomerAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
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
        List<User> users = null;
        String filter = req.getParameter("filter");

        String currentFilter = req.getParameter("currentFilter");
        if (currentFilter != null) filter = currentFilter;

        if (filter != null) {
            if (filter.equals("ascCreatedDate")) {
                currentFilter = filter;
                users = UserService.getInstance().ascCreateDateFilter();
            } else if (filter.equals("descCreatedDate")) {
                currentFilter = filter;
                users = UserService.getInstance().descCreateDateFilter();
            } else if (filter.equals("ascName")) {
                currentFilter = filter;
                users = UserService.getInstance().ascNameFilter();
            } else if (filter.equals("descName")) {
                currentFilter = filter;
                users = UserService.getInstance().descNameFilter();
            } else if (filter.equals("lockUsers")) {
                currentFilter = filter;
                users = UserService.getInstance().getLockUsers();
            } else if (filter.equals("findCustomer")) {
                currentFilter = filter;
                String name = req.getParameter("nameFilter");
                String phone = req.getParameter("phoneFilter");
                String email = req.getParameter("emailFilter");
                System.out.println(name + phone + email);
                if (!name.equals("")) {
                    users = UserService.getInstance().findUsersByName(name);
                } else if (!phone.equals("")) {
                    users = UserService.getInstance().findUserByPhone(phone);
                } else if (!email.equals("")) {
                    users = UserService.getInstance().findUserByEmail(email);
                }
            } else users = UserService.getInstance().getAllUsers();
        } else {
            users = UserService.getInstance().getAllUsers();
        }
        req.setAttribute("currentFilter", currentFilter);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/views/Admin/customer_management.jsp").forward(req, resp);
    }
}
