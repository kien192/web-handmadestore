package model.dao;

import model.bean.Product;
import model.db.JDBIConnector;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class ProductDAO {
    //Tất cả các sản phẩm
    public static List<Product> getAll(){
        List<Product> product = JDBIConnector.me().withHandle(handle ->
            handle.createQuery("select * from product")
                    .mapToBean(Product.class).stream().collect(Collectors.toList())
        );
        return product;
    }
//   Tìm kiếm sản phẩm theo danh mục
    public static  List<Product> findByCategory(String categoryID){
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where categoryId = :id")
                        .bind("id",categoryID)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }
//    Sắp xếp theo giá tăng dần toàn bộ
    public static List<Product> sortProductAZ(){
        List<Product> productAZ = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM product ORDER BY product.sellingPrice ASC")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return productAZ;
    }
    //    Sắp xếp theo giá giảm dần toàn bộ
    public static List<Product> sortProductZA(){
        List<Product> productZA = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM product ORDER BY product.sellingPrice DESC")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return productZA;
    }
    //    Sắp xếp theo giá tăng dần theo category
    public static List<Product> sortProductByCategoryAZ(String Categoryid){
        List<Product> productAZ = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM product WHERE categoryId = :id ORDER BY product.sellingPrice ASC")
                        .bind("id",Categoryid)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return productAZ;
    }
    //    Sắp xếp theo giá giảm dần theo category
    public static List<Product> sortProductByCategoryZA(String Categoryid){
        List<Product> productZA = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("SELECT * FROM product WHERE categoryId = :id ORDER BY product.sellingPrice DESC")
                        .bind("id",Categoryid)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return productZA;
    }

    public static void main(String[] args) {
        System.out.println(sortProductByCategoryZA("C02").toString());
    }

}
