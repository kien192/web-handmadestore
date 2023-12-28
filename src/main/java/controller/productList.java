package controller;

import model.bean.Product;
import model.dao.ProductDAO;
import model.service.ProductService;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/product"})
public class productList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("html/text; charset= UTF-8");
        List<Product> productList = null;/**/
        String filter = req.getParameter("filter");
        String category = req.getParameter("category");
        if (filter != null && category != null) {
            if (filter.equals("ascPrice")) {
                productList = switch (category) {
                    case "categoryC01" -> ProductDAO.sortProductByCategoryAZ("C01");
                    case "categoryC02" -> ProductDAO.sortProductByCategoryAZ("C02");
                    case "categoryC03" -> ProductDAO.sortProductByCategoryAZ("C03");
                    case "categoryC04" -> ProductDAO.sortProductByCategoryAZ("C04");
                    case "categoryC05" -> ProductDAO.sortProductByCategoryAZ("C05");
                    default -> ProductService.getInstance().sortProductsAZ();
                };
            } else if (filter.equals("descPrice")) {
                productList = switch (category) {
                    case "categoryC01" -> ProductDAO.sortProductByCategoryZA("C01");
                    case "categoryC02" -> ProductDAO.sortProductByCategoryZA("C02");
                    case "categoryC03" -> ProductDAO.sortProductByCategoryZA("C03");
                    case "categoryC04" -> ProductDAO.sortProductByCategoryZA("C04");
                    case "categoryC05" -> ProductDAO.sortProductByCategoryZA("C05");
                    default -> ProductService.getInstance().sortProductsZA();
                };
            }
        }else if(filter == null && category != null){
            productList = switch (category) {
                case "categoryC01" -> ProductService.getInstance().productByCategoryC01();
                case "categoryC02" -> ProductService.getInstance().productByCategoryC02();
                case "categoryC03" -> ProductService.getInstance().productByCategoryC03();
                case "categoryC04" -> ProductService.getInstance().productByCategoryC04();
                case "categoryC05" -> ProductService.getInstance().productByCategoryC05();
                default -> ProductService.getInstance().allProduct();
            };
        }else if(filter != null && category == null) {
            if (filter.equals("ascPrice")) {
                productList = ProductService.getInstance().sortProductsAZ();
            } else if (filter.equals("descPrice")) {
                productList = ProductService.getInstance().sortProductsZA();
            }
        }else{
            productList = ProductService.getInstance().allProduct();
        }

        req.setAttribute("filter", filter);
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
}
