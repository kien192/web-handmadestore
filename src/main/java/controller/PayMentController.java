package controller;

import model.bean.Cart;
import model.bean.Order;
import model.bean.User;
import model.dao.OrderDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet(name= "PaymentController", value = "/payment" )
public class PayMentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    //
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession sessions = req.getSession();
        User user = (User) sessions.getAttribute("auth");
        Cart cart = (Cart) sessions.getAttribute("cart");

        if (user == null) {
            resp.sendRedirect(  "views/Login/view_login/login.jsp");
        } else {
            OrderDAO orderZ = new OrderDAO();

            req.setCharacterEncoding("UTF-8");
            String namePay = req.getParameter("namePay");
            String phonePay = req.getParameter("phonePay");
            String address = req.getParameter("address");


            Order order = new Order();
            order.setConsigneeName(namePay);
            order.setConsigneePhoneNumber(phonePay);
            order.setAddress(address);

//           Xoasa sesion gio hàng
            orderZ.addOrder(order, cart, user);
            req.getRequestDispatcher("req.getContextPath() + \"/views/MainPage/view_mainpage/mainpage.jsp").forward(req,resp);


        }
    }
}