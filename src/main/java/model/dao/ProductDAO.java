package model.dao;

import model.bean.Product;
import model.bean.User;
import model.db.JDBIConnector;
import model.service.ImageService;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class ProductDAO {
    public static List<Product> getAll() {
        List<Product> product = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product")
                        .mapToBean(Product.class).stream().collect(Collectors.toList())
        );
        return product;
    }

    public static Product getProductById(final String id) {
        Optional<Product> product = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where id= :id")
                        .bind("id", id)
                        .mapToBean(Product.class)
                        .stream()
                        .findFirst()
        );
        return product.isEmpty() ? null : product.get();
    }

    public static void deleteProduct(String product_id) {
        //delete products image
//        ImageService.deleteProductImage(product_id);
        //delete order has products
//        JDBIConnector.me().useHandle(handle ->
//                handle.createUpdate("UPDATE order_details SET productId = null WHERE productId=?")
//                        .bind(0, product_id)
//                        .execute()
//        );
//        JDBIConnector.me().useHandle(handle ->
//                handle.createUpdate("DELETE FROM product WHERE id=?")
//                        .bind(0, product_id)
//                        .execute()
//        );
        System.out.println("deleted Product!!!");
    }

    public static void switchIsSale(String product_id) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE product SET isSale = CASE WHEN isSale = 0 THEN 1 ELSE 0 END WHERE id=?")
                        .bind(0, product_id)
                        .execute()
        );
    }


    public static List<Product> listSixProduct(int offset) {
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

    public static List<Product> findByCategory(String categoryID) {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where categoryId = :id")
                        .bind("id", categoryID)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static List<Product> getTrueIsSaleProduct() {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where isSale = 1")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static List<Product> getFalseIsSaleProduct() {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where isSale = 0")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static List<Product> getTrueHasDiscountProduct() {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where discountId IS NOT NULL")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static List<Product> getFalseHasDiscountProduct() {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where discountId IS NULL")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static List<Product> getNullQuantityProduct() {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where quantity = 0")
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static List<Product> getProductByDiscountId(String discountId) {
        List<Product> products = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from product where discountId = :id")
                        .bind("id", discountId)
                        .mapToBean(Product.class)
                        .stream()
                        .toList());
        return products;
    }

    public static void removeDiscount(String product_id) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE product SET discountId = 'null' WHERE id=?")
                        .bind(0, product_id)
                        .execute()
        );
    }

    public static void setDiscountForProductList(String discountId, List<String> product_id_list) {
        if (product_id_list != null && !product_id_list.isEmpty()) {
            StringBuilder ids = new StringBuilder();
            for (int i = 0; i < product_id_list.size(); i++) {
                String id = product_id_list.get(i);
                ids.append("'" + id + "'");
                if (i != product_id_list.size() - 1)
                    ids.append(",");
            }
            System.out.println("thay đổi 1 số");
            JDBIConnector.me().useHandle(handle ->
                    handle.createUpdate(
                                    "UPDATE product " +
                                            "SET discountId = null WHERE id NOT IN (" + ids + ") AND discountId = :id "
                            )
                            .bind("id", discountId)
                            .execute()
            );

            JDBIConnector.me().useHandle(handle ->
                    handle.createUpdate(
                                    "UPDATE product " +
                                            "SET discountId = :id WHERE id IN (" + ids + ")"
                            )
                            .bind("id", discountId)
                            .execute()
            );
//            JDBIConnector.me().useHandle(handle ->
//                    handle.createUpdate(
//                                    "UPDATE product " +
//                                            "SET discountId = " +
//                                            "CASE " +
//                                            "WHEN id NOT IN (" + ids + ") AND discountId = :id THEN 'null' " +
//                                            "WHEN id IN (" + ids + ") THEN :id " +
//                                            "END"
//                            )
//                            .bind("id", discountId)
//                            .execute()
//            );
        } else {
            System.out.println("bỏ tất cả");
            JDBIConnector.me().useHandle(handle ->
                    handle.createUpdate(
                                    "UPDATE product " +
                                            "SET discountId = null WHERE discountId= :id"
                            )
                            .bind("id", discountId)
                            .execute()
            );
        }

    }

    public static void setNullDiscountForProductList(String discountId) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate(
                                "UPDATE product " +
                                        "SET discountId = null WHERE discountId=?"
                        ).bind(0, discountId)
                        .execute()
        );
    }

    public static void main(String[] args) {
        List<Product> all = ProductDAO.listSixProduct(0);
        System.out.println(all.toString());
    }
}
