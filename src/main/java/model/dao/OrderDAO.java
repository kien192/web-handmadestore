package model.dao;

import model.bean.Discount;
import model.bean.Order;
import model.bean.OrderDetail;
import model.db.JDBIConnector;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class OrderDAO {
    public static List<Order> getAll() {
        List<OrderDetail> orderDetails = getAllOrderDetails();

        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order`")
                        .map((rs, ctx) -> {
                            Order order = new Order();
                            order.setId(rs.getInt("id"));
                            order.setTotalPrice(rs.getDouble("totalPrice"));
                            order.setOrderDate(rs.getTimestamp("orderDate"));
                            order.setStatus(rs.getString("status"));
                            order.setAddress(rs.getString("address"));
                            order.setShippingFee(rs.getDouble("shippingFee"));
                            order.setUserId(rs.getInt("userId"));
                            order.setOrderedProducts(orderDetails);
                            return order;
                        })
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<Order> getOrderById(String orderId) {
        List<OrderDetail> orderDetails = getOrderDetailsByOrderId(orderId);

        List<Order> orders = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from `order` where id=:orderId")
                        .bind("orderId", orderId)
                        .map((rs, ctx) -> {
                            Order order = new Order();
                            order.setId(rs.getInt("id"));
                            order.setTotalPrice(rs.getDouble("totalPrice"));
                            order.setOrderDate(rs.getTimestamp("orderDate"));
                            order.setStatus(rs.getString("status"));
                            order.setAddress(rs.getString("address"));
                            order.setShippingFee(rs.getDouble("shippingFee"));
                            order.setUserId(rs.getInt("userId"));
                            order.setOrderedProducts(orderDetails);
                            return order;
                        })
                        .stream().collect(Collectors.toList())
        );
        return orders;
    }

    public static List<OrderDetail> getAllOrderDetails() {
        List<OrderDetail> orderDetails = JDBIConnector.me().withHandle(detail_handle ->
                detail_handle.createQuery("select * from order_details")
                        .mapToBean(OrderDetail.class).stream().collect(Collectors.toList())
        );
        return orderDetails;
    }

    public static List<OrderDetail> getOrderDetailsByOrderId(String id) {
        List<OrderDetail> orderDetails = JDBIConnector.me().withHandle(detail_handle ->
                detail_handle.createQuery("select * from order_details where orderId=:id")
                        .bind("id", id)
                        .mapToBean(OrderDetail.class).stream().collect(Collectors.toList())
        );
        return orderDetails;
    }

    public static void main(String[] args) {
        System.out.println(getOrderDetailsByOrderId("1"));
        System.out.println(getOrderById("1"));
    }
}
