package controller.admin;

import model.bean.BannerItem;
import model.bean.Tip;
import model.service.BannerService;
import model.service.DiscountService;
import model.service.ProductService;
import model.service.TipService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.InvalidPathException;
import java.nio.file.Path;

@WebServlet(name = "BannerTipAdminController", value = "/admin/bannertip")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class BannerTipAdminController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
        //submit
        String submit_type = req.getParameter("submit_type");
        System.out.println("submit_type:" + submit_type);
        if (submit_type != null) {
            String oldTitle = null;
            String title = null;
            String description = null;
            String video_link = null;
            switch ((submit_type)) {
                case "show_banner":
                    String edit_banner_title = req.getParameter("edit_banner_title");
                    BannerItem currentBannerItem = BannerService.getInstance().getBannerItemByTitle(edit_banner_title);
                    req.setAttribute("currentBannerItem", currentBannerItem);
                    break;
                case "show_tip":
                    String edit_tip_title = req.getParameter("edit_tip_title");
                    Tip currentTip = TipService.getInstance().getTipByTitle(edit_tip_title);
                    req.setAttribute("currentTip", currentTip);
                    break;
                case "edit_tip":
                    oldTitle = req.getParameter("oldTitle");
                    title = req.getParameter("title");
                    description = req.getParameter("description");
                    video_link = req.getParameter("video_link");
                    System.out.println(oldTitle);
                    System.out.println(title);
                    System.out.println(description);
                    System.out.println(video_link);
                    if (!(oldTitle == null || title == null || description == null || video_link == null)) {
                        TipService.updateByTitle(oldTitle, title, description, video_link);
                    }
//                    save
                    break;
                case "edit_banner":
                    oldTitle = req.getParameter("oldTitle");
                    title = req.getParameter("title");
                    description = req.getParameter("description");
                    System.out.println(oldTitle);
                    System.out.println(title);
                    System.out.println(description);
                    if (!(oldTitle == null || title == null || description == null)) {
                        BannerService.updateByTitle(oldTitle, title, description);
                    }
//                    save
                    break;
                case "add_banner":
                    title = req.getParameter("title");
                    description = req.getParameter("description");
                    Part part = req.getPart("image");
                    break;
                case "add_tip":
                    title = req.getParameter("title");
                    description = req.getParameter("description");
                    video_link = req.getParameter("video_link");
                    part = req.getPart("image");
                    break;
                case "delete_banner":
                    //xoa an
                    String delete_banner_title = req.getParameter("delete_banner_title");
                    BannerItem bannerItem = BannerService.getInstance().getBannerItemByTitle(delete_banner_title);
                    //xóa image src
                    deleteImage(bannerItem.getImg_path());
                    BannerService.getInstance().deleteBannerByTitle(delete_banner_title);
                    break;
                case "delete_tip":
                    String delete_tip_title = req.getParameter("delete_tip_title");
                    Tip tip = TipService.getInstance().getTipByTitle(delete_tip_title);
                    //xóa image src
                    deleteImage(tip.getImgPath());
                    TipService.getInstance().deleteTipByTitle(delete_tip_title);
                    break;
            }
        }
        req.getRequestDispatcher("/views/Admin/banners_tips.jsp").forward(req, resp);
    }

    private String getSubmittedFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown";
    }

    private void deleteImage(String imagePath) {
        String relativePath = "images"; // Đường dẫn tới thư mục images trong ứng dụng
        String absolutePath = getServletContext().getRealPath(relativePath);

        try {
            Path filePath = Path.of(absolutePath, imagePath);
            try {
                // Kiểm tra xem tệp tin tồn tại trước khi xóa
                if (Files.exists(filePath)) {
                    Files.delete(filePath);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (
                InvalidPathException e) {

        }
    }
}
