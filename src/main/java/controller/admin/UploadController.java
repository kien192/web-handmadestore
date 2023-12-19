package controller.admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collection;

@WebServlet(name = "UploadController", value = "/upload")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, //1kb
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class UploadController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/jsp; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");

        Collection<Part> parts = req.getParts();

        String realPath = req.getServletContext().getRealPath("/images");
        if (!Files.exists(Path.of(realPath))) {
            Files.createDirectories(Path.of(realPath));
        }
        System.out.println(parts.size());
        for (Part part : parts) {
            if (part.getName().equals("images") && part.getSize() > 0) {
                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                System.out.println(":::: " + fileName);
                part.write(Paths.get(realPath, fileName).toString());
                resp.getWriter().println("<img src='" + req.getContextPath() + "/images/" + fileName + "'>");
            }
        }

//        String imagePath = "/images/" + fileName;
//        resp.getWriter().println("<img src=" + req.getContextPath() + imagePath + " alt='Uploaded Image'>");
    }
}
