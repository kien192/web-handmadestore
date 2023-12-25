package controller.admin;

import model.bean.Category;
import model.bean.Product;
import model.service.CategoryService;
import model.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddProductForAdmin", value = "/admin/product")
public class ProductAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String categoty_id = req.getParameter("category_id");
//                       Ngừng bán sản phẩm
        String switch_product_isSale = req.getParameter("switch_product_isSale");
        if (switch_product_isSale != null) {
            ProductService.getInstance().switchIsSale(switch_product_isSale);
        }
//                      func_2: để hiện thị childFrame: thêm sp, qlkm, confirm
        String func_2 = req.getParameter("func_2");
        System.out.println("func2: " + func_2);
        if (func_2 != null) {
            req.setAttribute("isShowChildFrame", "show");
            String childFramePath = "";
            String childFrameTitle = "";
//                        Thêm sản phẩm
            if (func_2.equals("showAddProductFrame")) {
                childFramePath = "views/Admin/add_product.jsp";
                childFrameTitle = "Thêm sản phẩm mới";
            }
//                        Quản lý khuyến mãi
            else if (func_2.equals("showDiscountManagementFrame")) {
                childFramePath = "views/Admin/discount_management.jsp";
                childFrameTitle = "Quản lý khuyến mãi giảm giá";
            }
//                        Sửa sảm phẩm
//                        Tất cả những cái cần confirm
            if (func_2.equals("showConfirmBox")) {
                childFramePath = "views/Admin/confirm_box.jsp";
                childFrameTitle = "Xác nhận";
                //Xóa 1 sản phẩm
                String delete_product_id = req.getParameter("delete_product_id");
                System.out.println("deteleP: " + delete_product_id);
                if (delete_product_id != null) {
                    //Chuyển sang confirm
                    req.setAttribute("title", "Xác nhận xóa sản phẩm");
                    req.setAttribute("message", "Để tránh mất dữ liệu liên quan, chúng tôi khuyên bạn nên thiết lập ngưng bán sản phẩm này thay vì xóa!");
                    req.setAttribute("ok_link", "confirm?selectedCategory=" + categoty_id + "&confirm_delete_product_id=" + delete_product_id + "&confirm=ok");
                    req.setAttribute("cancel_link", "confirm?selectedCategory=" + categoty_id + "&confirm_delete_product_id=" + delete_product_id + "&confirm=cancel");
                    req.getRequestDispatcher("/views/Admin/confirm_box.jsp").forward(req, resp);
                }
            } else {
                req.setAttribute("childFramePath", childFramePath);
                req.setAttribute("childFrameTitle", childFrameTitle);
                req.setAttribute("selectedCategory", categoty_id);
                req.getRequestDispatcher("/views/Admin/product_management.jsp").forward(req, resp);
            }
        }
//                        Hiển thị sản phẩm - Lọc Sản phẩm
        product_management_filter(req, resp);
    }

    private void product_management_filter(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products;
        List<Category> categories = CategoryService.getInstance().getALl();
        req.setAttribute("categories", categories);
        String categoty_id = req.getParameter("category_id");

        String nameFilter = req.getParameter("nameFilter");
        if (nameFilter != null && !nameFilter.equals("")) {
            if (nameFilter.charAt(0) == '#') {
                products = new ArrayList<>();
                products.add(ProductService.instance.getProductById(nameFilter.substring(1, nameFilter.length())));
            } else
                products = ProductService.instance.getProductByAsName(nameFilter);
            req.setAttribute("nameFilter", nameFilter);
        } else {
            if (categoty_id == null || categoty_id.equals("all")) {
                products = ProductService.getInstance().getAll();
                categoty_id = "all";
            } else {
                switch (categoty_id) {
                    case "isSaleTrue":
                        products = ProductService.getInstance().getTrueIsSaleProduct();
                        break;
                    case "isSaleFalse":
                        products = ProductService.getInstance().getFalseIsSaleProduct();
                        break;
                    case "hasDiscountTrue":
                        products = ProductService.getInstance().getTrueHasDiscountProduct();
                        break;
                    case "hasDiscountFalse":
                        products = ProductService.getInstance().getFalseHasDiscountProduct();
                        break;
                    case "nullQuantity":
                        products = ProductService.getInstance().getNullQuantityProduct();
                        break;
                    default:
                        categoty_id = "all";
                        products = ProductService.getInstance().getProductsByCategoryId(categoty_id);
                        break;
                }
            }
        }

        req.setAttribute("isShowChildFrame", "hide");
        req.setAttribute("selectedCategory", categoty_id);
        req.setAttribute("products", products);
        req.getRequestDispatcher("/views/Admin/product_management.jsp").

                forward(req, resp);
    }
}
