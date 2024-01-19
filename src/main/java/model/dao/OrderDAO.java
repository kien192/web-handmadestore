package model.dao;

import model.bean.*;
import model.db.JDBIConnector;

import javax.xml.crypto.Data;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class OrderDAO {
    public static List<Order> getAllOrder() {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order`")
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static Order getOrderById(String orderId) {
        Optional<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where id=:orderId")
                        .bind("orderId", orderId)
                        .mapToBean(Order.class)
                        .stream().findFirst()
        );
        return orders.isEmpty() ? null : orders.get();
    }

    public static List<OrderDetail> getOrderDetailsByOrderId(String orderId) {
        List<OrderDetail> orderDetails = JDBIConnector.me().withHandle(detail_handle ->
                detail_handle.createQuery("select * from order_details where orderId=:orderId")
                        .bind("orderId", orderId)
                        .mapToBean(OrderDetail.class).stream().collect(Collectors.toList())
        );
        return orderDetails;
    }

    /**
     * Sử dụng cho việc checkout
     */
    //lấy ngày hiện tại
//    java.time.LocalDate curDate = java.time.LocalDate.now();
//    String date = curDate.toString();
//    public void addOrder(User user , Cart cart) {
//        Timestamp dateOrder = new Timestamp(System.currentTimeMillis());
//    try {
//        String sql = "INSERT INTO [order] (totalPrice, orderDate, userId) values (?,?,?)";
//        JDBIConnector.me().useHandle(handle -> {
//                handle.createUpdate(sql).bind(0, cart.getTotalPrice())
//                        .bind(1, dateOrder)
//                        .bind(2, user.getId())
//                        .execute(); }
//        );

        //Lấy id vừa được theem vào order
//        int orderId =  JDBIConnector.me().withHandle(handle ->
//                handle.createQuery("Select id from [order] order by id desc limit 1")
//                        .mapTo(Integer.class)
//                        .findOne()
//                        .orElseThrow()
//        );
//
//        //Thực hiện insert vào bảng orderDetails cho từng sản phẩm trong giỏ hàng.
//        String sql1 = "INSERT INTO [order_details] (orderId, productId, quantity) values (?,?,?)";
//        for(Item item : cart.getItems()) {
//            JDBIConnector.me().useHandle(
//                    handle -> {
//                        handle.createUpdate(sql1)
//                                .bind(0,orderId )
//                                .bind(1, item.getProduct().getId())
//                                .bind(2, item.getQuantity())
//                                .execute();
//                    }
//            );
//        }
//
//    }
//
//    catch (Exception e) {
//        e.printStackTrace();
//    }
// }


    public static void main(String[] args) {
        java.time.LocalDate curDate = java.time.LocalDate.now();
        String date = curDate.toString();
        System.out.println(date);
//        System.out.println(getOrderDetailsByOrderId(2 + ""));
    }
}
