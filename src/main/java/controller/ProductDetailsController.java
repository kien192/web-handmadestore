package controller;

import model.bean.Image;
import model.bean.Product;
import model.dao.ProductDAO;
import model.service.ProductService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Product-Detail", value = "/product-detail")
public class ProductDetailsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//Kiểm tra khi tăng số lượng mua > số lượng hàng có sẵn nè
        boolean alert =req.getParameter("invalid-quantity") != null;

        //Lấy id từ sản phẩm được chọn !!
        int id = Integer.parseInt(req.getParameter("id"));

//Lấy sản phẩm từ database với id đã được chọn
        Product product = ProductDAO.getProduct(id);
        List<Image> imageList = ProductDAO.getImagesForProduct(id);

        //Kiểm tra số lượng có sẵn , nếu quantity = soldout => disable lẹ ko cho thêm vào giỏ hàng
        String disable = "";
        int available = product.getQuantity() - product.getSoldout();
        if(available <= 0) {
disable = "disable";

        }
//Thiết lập chế đô active từ menu bar (trang chủ)
    String active = "active";

        req.setAttribute("alert", alert);
        req.setAttribute("disable", disable);
        req.setAttribute("shop_active", active);
        req.setAttribute("productById", product);
        req.setAttribute("proName", product.getName());
        req.setAttribute("proQua", product.getSellingPrice());
        req.setAttribute("proDtails", product.getDescription());
        req.setAttribute("proAvai", product.getQuantity() - product.getSoldout());
        req.setAttribute("listImage",imageList );


        ServletContext context = req.getServletContext();
        String absolutePath = context.getRealPath("/");
        String jspPath = "/views/product-details/view/productdt.jsp";

        String fullPath = absolutePath + jspPath;

        System.out.println("Full path to JSP file: " + fullPath);

        RequestDispatcher rq = req.getRequestDispatcher(jspPath);
        rq.forward(req, resp);
//        RequestDispatcher rq =req.getRequestDispatcher("/views/product-details/view/productdt.jsp");
//        rq.forward(req, resp);

//



    }
}
