package controller.admin;

import model.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AdminConfirm", value = "/confirm")
public class ConfirmAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        String selectedCategory = req.getParameter("selectedCategory");
        String confirm_delete_product_id = req.getParameter("confirm_delete_product_id");

        //Đang xử lý xóa 1 sán phẩm
        if (confirm_delete_product_id != null) {
            String confirm = req.getParameter("confirm");
            //Nếu ok -> xóa product, isShowChildFrame = hide
            if (confirm != null && confirm.equals("ok")) {
                ProductService.getInstance().deleteProduct(confirm_delete_product_id);
                req.setAttribute("isShowChildFrame", "hide");
            }
            //Nếu cancel -> isShowChildFrame = hide
            else {
                req.setAttribute("isShowChildFrame", "hide");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/product?func=product_management&category_id=" + selectedCategory);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/product?func=product_management&category_id=all");
        }
    }
}
