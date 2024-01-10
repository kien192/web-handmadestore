package controller.admin;

import model.service.CategoryService;
import model.service.DiscountService;
import model.service.ProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.AccessDeniedException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AddProductAdminController", value = "/addproduct")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class AddProductAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        String productName = req.getParameter("productName");
        String quantity = req.getParameter("quantity");
        String costPrice = req.getParameter("costPrice");
        String sellingPrice = req.getParameter("sellingPrice");

        String radio_choiceCategory = req.getParameter("choiceCategory");

        String discount = req.getParameter("discount");
        String description = req.getParameter("description");

        String availableCategory = req.getParameter("availableCategory");//category id
        String newCategory = req.getParameter("newCategory");

//      Kiểm tra đủ tt? Chưa -> forward kèm attribute để khỏi nhập lại, đủ rồi thì write + insert
//      Yêu cầu: xử lý file name = product Id +'stt';
        if (!(productName.equals("") || quantity.equals("") || costPrice.equals("") || sellingPrice.equals("") || description.equals("") ||
                (radio_choiceCategory == null || radio_choiceCategory.equals("")))) {
            if (radio_choiceCategory != null) {
                String categoryId = null;
                System.out.println(availableCategory + " - " + newCategory);
                if (radio_choiceCategory.equals("choiceAvailableCategory")) {
                    //Danh mục có sẵn
                    categoryId = availableCategory;
                } else if (radio_choiceCategory.equals("choiceNewCategory")) {
                    //create new category in table
                    categoryId = CategoryService.getInstance().createNewCategory(newCategory) + "";
                }
                if (categoryId != null) {
                    try {
                        //write
                        List<String> paths = writeProductImagesFromClient(productName, req, resp);
                        //insert
                        try {
                            if (!discount.equals("")) {
                                ProductService.getInstance().insertNewProduct(productName, description, Double.parseDouble(costPrice), Double.parseDouble(sellingPrice), Integer.parseInt(quantity),
                                        Integer.parseInt(categoryId),Integer.parseInt(discount), paths);
                            } else {
                                // không áp dụng discount
                                ProductService.getInstance().insertNewProduct(productName, description, Double.parseDouble(costPrice), Double.parseDouble(sellingPrice), Integer.parseInt(quantity),
                                        Integer.parseInt(categoryId), paths);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            req.setAttribute("productName", productName);
                            req.setAttribute("quantity", quantity);
                            req.setAttribute("costPrice", costPrice);
                            req.setAttribute("sellingPrice", sellingPrice);
                            req.setAttribute("radio_choiceCategory", radio_choiceCategory);
                            req.setAttribute("discount", discount);
                            req.setAttribute("description", description);
                            req.setAttribute("availableCategory", availableCategory);
                            req.setAttribute("newCategory", newCategory);

                            req.setAttribute("result", "Dữ liệu không chính xác!Vui lòng thử lại");
                            req.getRequestDispatcher("/views/Admin/add_product.jsp").forward(req, resp);
                        }
                        //forward
                        req.setAttribute("result", "Thêm sản phẩm mới thành công! Bạn có thể thêm sản phẩm tiếp theo.");
                        req.getRequestDispatcher("/views/Admin/add_product.jsp").forward(req, resp);
                    } catch (IOException e) {
                        req.setAttribute("productName", productName);
                        req.setAttribute("quantity", quantity);
                        req.setAttribute("costPrice", costPrice);
                        req.setAttribute("sellingPrice", sellingPrice);
                        req.setAttribute("radio_choiceCategory", radio_choiceCategory);
                        req.setAttribute("discount", discount);
                        req.setAttribute("description", description);
                        req.setAttribute("availableCategory", availableCategory);
                        req.setAttribute("newCategory", newCategory);

                        req.setAttribute("result", "Vui lòng tải ảnh cho sản phẩm!");
                        req.getRequestDispatcher("/views/Admin/add_product.jsp").forward(req, resp);
                    }
                }
            }
        } else {
            req.setAttribute("productName", productName);
            req.setAttribute("quantity", quantity);
            req.setAttribute("costPrice", costPrice);
            req.setAttribute("sellingPrice", sellingPrice);
            req.setAttribute("radio_choiceCategory", radio_choiceCategory);
            req.setAttribute("discount", discount);
            req.setAttribute("description", description);
            req.setAttribute("availableCategory", availableCategory);
            req.setAttribute("newCategory", newCategory);

            System.out.println("Thieu thong tin!!!");
            req.setAttribute("result", "Điền đủ thông tin để thêm sản phẩm mới! Vui lòng thử lại");
            req.getRequestDispatcher("/views/Admin/add_product.jsp").forward(req, resp);
        }
    }

    //reference: ChatGPT - vì muốn lưu xuống  file multiple xuống local thui ... nên... write được thì ok :)))
    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }

    public List<String> writeProductImagesFromClient(String productName, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> uploadedFiles = new ArrayList<>();

        String relativePath = "images/products"; // Đường dẫn tới thư mục images trong ứng dụng
        String absolutePath = getServletContext().getRealPath(relativePath);

        // Tạo thư mục nếu chưa tồn tại
        Files.createDirectories(Path.of(absolutePath));
        int count = 0;
        for (Part part : req.getParts()) {
            String fileName = getSubmittedFileName(part);
            if (!(fileName.endsWith("unknown"))) {
                count++;
                String newFileName = count + "_" + productName + getFileExtension(fileName);
                String filePath = Path.of(absolutePath, newFileName).toString();
                part.write(filePath);

                uploadedFiles.add("images/products/" + newFileName);
            }
        }
        return uploadedFiles;
    }

    private void deleteProductImage() {
        String fileNameToDelete = "your_file_name.jpg"; // Tên tệp tin cần xóa
        String relativePath = "images"; // Đường dẫn tới thư mục images trong ứng dụng
        String absolutePath = getServletContext().getRealPath(relativePath);

        Path filePath = Path.of(absolutePath, fileNameToDelete);

        try {
            // Kiểm tra xem tệp tin tồn tại trước khi xóa
            if (Files.exists(filePath)) {
                Files.delete(filePath);
//                resp.getWriter().println("File deleted successfully.");
            } else {
//                resp.getWriter().println("File not found.");
            }
        } catch (IOException e) {
            e.printStackTrace(); // Xử lý các ngoại lệ IO nếu có
//            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Phương thức để lấy phần mở rộng của file
    private static String getFileExtension(String fileName) {
        String extension = "";
        int lastDotIndex = fileName.lastIndexOf('.');
        if (lastDotIndex > 0 && lastDotIndex < fileName.length() - 1) {
            extension = fileName.substring(lastDotIndex);
        }
        return extension;
    }
}
