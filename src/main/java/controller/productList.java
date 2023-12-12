package controller;

import model.bean.Product;
import model.service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "product", value = "/product")
public class productList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("html/text; charset= UTF-8");
        //tất cả sản phẩm
        List<Product> products = ProductService.getInstance().sixProduct(0);
        System.out.println("-----: "+ products.size());
        System.out.println("-----: "+ products.size());
        req.setAttribute("allProduct",products);
        try {
            req.getRequestDispatcher("/views/ProductList/productList.jsp").forward(req,resp);
        } catch (ServletException e) {
            throw new RuntimeException(e);
        }    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     doGet(req,resp);
    }
}
