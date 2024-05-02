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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet(name = "CustomerAdminController", value = "/admin/customer")
public class CustomerAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
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
                String kw = req.getParameter("findCustomer");
                req.setAttribute("kw", kw);
                if (kw.contains("@")) {
                    users = UserService.getInstance().findUserByEmail(kw);
                } else if (isPhoneNumber(kw)) {
                    users = UserService.getInstance().findUserByPhone(kw);
                } else {
                    users = UserService.getInstance().findUsersByName(kw);
                }
            } else users = UserService.getInstance().getAllUsers();
        } else {
            users = UserService.getInstance().getAllUsers();
        }
        req.setAttribute("currentFilter", currentFilter);
        req.setAttribute("users", users);
        req.getRequestDispatcher("/views/Admin/customer_management.jsp").forward(req, resp);
    }

    public static boolean isPhoneNumber(String text) {
        // Định nghĩa mẫu regex cho số điện thoại
        // Các định dạng hợp lệ có thể là: (123) 456-7890 hoặc 1234567890
        String phoneNumberPattern = "^\\(?(\\d{3})\\)?[- ]?(\\d{3})[- ]?(\\d{4})$";

        // Tạo Pattern object
        Pattern pattern = Pattern.compile(phoneNumberPattern);

        // Tạo Matcher object
        Matcher matcher = pattern.matcher(text);

        // Kiểm tra xem chuỗi có khớp với mẫu regex không
        return matcher.matches();
    }
}
