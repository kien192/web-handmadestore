package controller;

import model.bean.Role;
import model.bean.User;
import model.dao.UserDAO;
import model.service.RoleService;
import model.service.UserService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;

@WebServlet("/login")
public class login extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        String email = req.getParameter("email");// nhận input từ ng dùng
        String pw = req.getParameter("password");
        User checkEmail = UserDAO.getUserByEmail(email);
        User user = UserService.getInstance().checkLogin(email, pw);
        if (email == null) {
            req.getRequestDispatcher("./views/Login/view_login/login.jsp").forward(req, resp);
        } else if (checkEmail == null) {
            req.setAttribute("errEmail", "Email không tồn tại!");
            req.getRequestDispatcher("./views/Login/view_login/login.jsp").forward(req, resp);
        }
        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("auth", user);
            String c = RoleService.getInstance().checkRole(user);

            if (c.equals("admin"))
                resp.sendRedirect(req.getContextPath() + "/views/Admin/admin.jsp");
            else
                resp.sendRedirect(req.getContextPath() + "/views/MainPage/view_mainpage/mainpage.jsp");
        } else {
            req.setAttribute("result", "Mật khẩu không chính xác!");
            req.getRequestDispatcher("./views/Login/view_login/login.jsp").forward(req, resp);
        }
    }
}
