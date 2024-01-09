package model.service;

import model.bean.Discount;
import model.bean.Order;
import model.bean.OrderDetail;
import model.dao.DiscountDAO;
import model.dao.OrderDAO;

import java.util.List;

public class OrderService {
    private static OrderService instance;

    public static OrderService getInstance() {
        if (instance == null) instance = new OrderService();
        return instance;
    }

    public List<Order> getAllOrder() {
        return OrderDAO.getAllOrder();
    }

    public Order getOrderById(String orderId) {
        return OrderDAO.getOrderById(orderId);
    }

    public List<OrderDetail> getOrderDetailsByOrderId(String orderId) {
        return OrderDAO.getOrderDetailsByOrderId(orderId);
    }

}
