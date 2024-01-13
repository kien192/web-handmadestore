package model.dao;

import model.bean.Discount;
import model.bean.Order;
import model.bean.OrderDetail;
import model.db.JDBIConnector;
import model.service.OrderService;
import model.service.UserService;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class OrderDAO {
    public static List<Order> getAllOrder() {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` order by orderDate desc")
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

    public static long waitConfirmOrdersNumber() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select count(id) from `order` where status='Chờ xác nhận'")
                        .mapTo(Long.class).one());
    }

    public static long deliveringOrdersNumber() {
        return JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select count(id) from `order` where status='Đang giao'")
                        .mapTo(Long.class).one());
    }

    public static List<Order> getWaitConfirmOrders() {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where status='Chờ xác nhận' order by orderDate desc")
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<Order> getDeliveringOrders() {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where status='Đang giao' order by orderDate desc")
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<Order> getCanceledOrders() {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where status='Đã hủy' order by orderDate desc")
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<Order> getSucccessfulOrders() {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where status='Thành công' order by orderDate desc")
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<Order> getOrderByCustomerId(String customerId) {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where userId=?")
                        .bind(0, customerId)
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<Order> getOrderByCustomerNamePart(String customerNamePart) {
        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where userId IN(" +
                                "select id from user where name like ?)")
                        .bind(0, "%" + customerNamePart + "%")
                        .mapToBean(Order.class)
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static void cancelOrder(String orderId) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE `order` SET status = 'Đã hủy' WHERE id=?")
                        .bind(0, orderId)
                        .execute()
        );
    }

    public static void confirmOrder(String orderId) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE `order` SET status = 'Đang giao' WHERE id=?")
                        .bind(0, orderId)
                        .execute()
        );
    }

    public static double getRevenueForMonth(int month, int year) {
        String sql = "SELECT SUM(totalPrice) FROM `order` WHERE MONTH(orderDate) = ? AND YEAR(orderDate) = ? AND status='Thành công'";
        Double re = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, month)
                        .bind(1, year)
                        .mapTo(Double.class).one());
        return re != null ? re : 0;
    }

    public static double getMonthRevenueMax(int year) {
        String sql = "SELECT MAX(totalPrice) FROM (SELECT SUM(totalPrice) AS totalPrice FROM `order` WHERE YEAR(orderDate) = ? AND status='Thành công' GROUP BY MONTH(orderDate)) AS monthlyRevenue";
        Double re = JDBIConnector.me().withHandle(handle ->
                handle.createQuery(sql)
                        .bind(0, year)
                        .mapTo(Double.class).one());
        return re != null ? re : 0;
    }


    public static void main(String[] args) {
//        System.out.println(OrderService.getInstance().getOrderByCustomerId(44 + ""));
//        System.out.println(UserService.getInstance().getUserById((44 + "")));
//        System.out.println(waitConfirmOrdersNumber());
    }
}
