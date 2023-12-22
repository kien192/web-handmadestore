package controller;

import model.bean.Product;
import model.dao.ImageDAO;
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
        List<Product> productList = ProductService.getInstance().allProduct();/**/
        String filter = req.getParameter("filter");
        if (filter != null) {
            if (filter.equals("ascPrice")) {
                productList = ProductService.getInstance().sortProductsAZ();
            } else if (filter.equals("descPrice")) {
                productList = ProductService.getInstance().sortProductsZA();
            }
        }
        int itemPerPage = 16; // số lượng sp trên mỗi trang
        //lấy số trang hiện tại từ tham số yêu cầu
        int currentPage = 1;
        String paraParam = req.getParameter("page");
        if (paraParam != null && !paraParam.isEmpty()) {
            currentPage = Integer.parseInt(paraParam);
        }
        //Tính số sản phẩm bắt đầu và kết thúc
        int startIndex = (currentPage - 1) * itemPerPage;
        int endIndex = Math.min(startIndex + itemPerPage, productList.size());
        //lấy danh sách sản phẩm cho trang hiện tại
        List<Product> currentPageItems = productList.subList(startIndex, endIndex);

        req.setAttribute("currentPage", currentPage);
        req.setAttribute("totalPage", (int) Math.ceil((double) productList.size() / itemPerPage));
        req.setAttribute("productInPage", currentPageItems);
        String path = "./views/ProductList/productList.jsp";
        req.getRequestDispatcher(path).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
