package model.service;

import model.db.JDBIConnector;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Optional;

public class ImageService {
    public static String getLogoImagePath() {
        Optional<String> path = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select path from image where id = 'logo'")
                        .mapTo(String.class)  // Sử dụng mapTo thay vì mapToBean vì bạn đang truy vấn một cột duy nhất
                        .findFirst()
        );
        return path.orElse("");  // Sử dụng orElse để trả về giá trị mặc định nếu Optional rỗng
    }

    public static String getBackgroundImagePath() {
        Optional<String> path = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select path from image where id = 'bg'")
                        .mapTo(String.class)  // Sử dụng mapTo thay vì mapToBean vì bạn đang truy vấn một cột duy nhất
                        .findFirst()
        );
        return path.orElse("");  // Sử dụng orElse để trả về giá trị mặc định nếu Optional rỗng
    }

    public static boolean isExternalPath(String path) {
        try {
            URL url = new URL(path);
            // Kiểm tra xem đường dẫn có sử dụng giao thức HTTP hoặc HTTPS không
            return "http".equals(url.getProtocol()) || "https".equals(url.getProtocol());
        } catch (MalformedURLException e) {
            // Nếu có lỗi khi tạo URL, có thể coi đường dẫn không phải là từ bên ngoài
            return false;
        }
    }

    public static void main(String[] args) {
        System.out.println(getLogoImagePath());
        System.out.println(getBackgroundImagePath());
    }
}
