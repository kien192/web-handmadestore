package model.dao;

import model.bean.Product;
import model.db.JDBIConnector;
import java.util.Collections;
import java.util.List;
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
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where categoryId = :id")
                        .bind("id",categoryID)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }




    public static void main(String[] args) {
        List<Product> all = ProductDAO.listSixProduct(0);
        System.out.println(all.toString());
    }
}
