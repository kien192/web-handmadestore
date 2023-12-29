package model.dao;

import model.bean.Image;
import model.bean.Product;
import model.db.JDBIConnector;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

public class ProductDAO {
    public static List<Product> getAll(){
        List<Product> product = JDBIConnector.me().withHandle(handle ->
            handle.createQuery("select * from product")
                    .mapToBean(Product.class).stream().collect(Collectors.toList())
        );
        return product;
    }



    public static List<Product> listSixProduct(int offset){
        try {
            List<Product> products = JDBIConnector.me().withHandle(handle ->
                    handle.createQuery("select * from product limit 6 offset :offset")
                            .bind("offset", offset)
                            .mapToBean(Product.class)
                            .stream().toList());

            return products;
        } catch (Exception e) {
            // Xử lý exception, ví dụ: log hoặc throw lại một exception khác.
            e.printStackTrace();
            return Collections.emptyList(); // hoặc return null tùy vào trường hợp
        }
    }
    public static  List<Product> findByCategory(String categoryID){
        List<Product> products = JDBIConnector.me().withHandle(
                handle -> handle.createQuery("select * from product where categoryId = :id")
                        .bind("id",categoryID)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    //Lấy sản phẩm dựa vào id product
    public static Product getProduct(int productID) {
        Product p = JDBIConnector.me().withHandle(
                handle ->  handle.createQuery("SELECT * from product where id = :productID")
                        .bind("productID", productID)
                            .mapToBean(Product.class).findFirst().orElse(null)
                 );
        return p;
    }

    public static List<Image> getImagesForProduct(int productId) {
        List<Image> imageList = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * from image where productId = :productId ")
                        .bind("productId", productId)
                        .mapToBean(Image.class)
                        .stream().toList());

                        return  imageList;
    }

    public static void insertNewProduct(String name, String description, double costPrice, double sellingPrice, int quantity, String categoryId, List<String> imagesPath) {
        JDBIConnector.me().useHandle(handle -> {
            // Insert into product table with auto-increment ID
            int productId = handle.createUpdate("INSERT INTO product(name, description, costPrice, sellingPrice, quantity, categoryId) VALUES (:name, :description, :costPrice, :sellingPrice, :quantity, :categoryId)")
                    .bind("name", name)
                    .bind("description", description)
                    .bind("costPrice", costPrice)
                    .bind("sellingPrice", sellingPrice)
                    .bind("quantity", quantity)
                    .bind("categoryId", categoryId)
                    .executeAndReturnGeneratedKeys("id")
                    .mapTo(Integer.class)
                    .one();

            for (String imagePath : imagesPath) {
                // Insert into image table with auto-increment ID
                int imageId = handle.createUpdate("INSERT INTO image(name, path, product) VALUES (:name, :path, :productId)")
                        .bind("name", name + " " + imagePath)
                        .bind("path", imagePath)
                        .bind("productId", productId)
                        .executeAndReturnGeneratedKeys("id")
                        .mapTo(Integer.class)
                        .one();
            }
        });
    }





        public static void main(String[] args) {
            System.out.println("lololo");
        Product p = getProduct(11);
        List<Product> all = ProductDAO.listSixProduct(0);
        List<Image> im = ProductDAO.getImagesForProduct(10);
        if(im == null) System.out.println("Ko co gi");
        for(Image i : im) {
            System.out.println(i.toString());
        }
    }
}
