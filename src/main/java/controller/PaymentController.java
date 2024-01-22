package controller;

import model.bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("html/text; charset= UTF-8");
        String consigneeName = req.getParameter("fullName");
        String consigneePhoneNumber = req.getParameter("phoneNumber");
        String address = req.getParameter("address");
        String note = req.getParameter("note");
        //chwua làm xong ham


    }
}
