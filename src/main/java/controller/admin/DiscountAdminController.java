package controller.admin;

import model.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "DiscountController", value = "/admin/discount")
public class DiscountAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        String discountId = req.getParameter("submit_1_discountId");
        if (discountId != null) {
            String[] discountProductsId = req.getParameterValues(discountId);
            if (discountProductsId != null) {
                List<String> Plist = Arrays.asList(discountProductsId);
                // Xử lý các giá trị của checkbox
                ProductService.getInstance().setDiscountForProductList(discountId, Plist);
            } else {
//            Khong có product nao duoc chon
                ProductService.getInstance().setDiscountForProductList(discountId, null);
            }
        }
        req.getRequestDispatcher("/views/Admin/discount_management.jsp").forward(req, resp);
    }
}
