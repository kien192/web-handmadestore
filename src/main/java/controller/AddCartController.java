package controller;

import model.bean.Cart;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CartController", value = "/add-cart")
public class AddCartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession sessions = req.getSession();
        Cart cart = (Cart) sessions.getAttribute("cart");
        if(cart == null) {
            cart= new Cart();
        }
        sessions.setAttribute("cart", cart);
//        resp.sendRedirect( req.getContextPath() + "/views/CartPage/cart.jsp");
//    delegated
        doPost(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession sessions = req.getSession();
        Cart cart = (Cart) sessions.getAttribute("cart");
        String action = req.getParameter("actionCart");
        /*
        doPost add san pham
        doGet lay view san pham
        doPut update san pham
        doDelete xoa san pham
        CRUD.
         */

        switch (action) {
            case "get":
                resp.sendRedirect(req.getContextPath() + "/views/CartPage/cart.jsp");
                break;

            case "delete":
                DeleteP(req,resp);
                break;
            case "put":
                doPut(req,resp);
                break;

            case "post":
            int id = Integer.parseInt(req.getParameter("id")); // lay id product

            cart.add(id );
            sessions.setAttribute("cart", cart);
            resp.sendRedirect(req.getContextPath() + "/product");
            break;
            default:

                break;
        }





//        HttpSession session = req.getSession();
//        Cart cart = (Cart) session.getAttribute("cart");
//        if (cart == null) cart = new Cart();
//        int id = Integer.parseInt(req.getParameter("id"));
//        cart.add(id);
//        session.setAttribute("cart", cart);
//        resp.sendRedirect("product");
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession sessions = req.getSession();
        Cart cart = (Cart) sessions.getAttribute("cart");
        int id = Integer.parseInt(req.getParameter("id"));

    }


    protected void DeleteP(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession sessions = req.getSession();
        Cart cart = (Cart) sessions.getAttribute("cart");
        String action = req.getParameter("actionCart");
        int id = Integer.parseInt(req.getParameter("id"));
        cart.remove(id);
        sessions.setAttribute("cart", cart);
        resp.sendRedirect(req.getContextPath() + "/views/CartPage/cart.jsp");

    }
}
