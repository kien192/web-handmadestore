package model.bean;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Order implements Serializable {
    private int id;
    private double totalPrice;
    private Timestamp orderDate;
    private String status;
    private String address;
    private double shippingFee;
    private int userId;
    private Map<Integer, Integer> orderedProducts;

    public Order() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Map<Integer, Integer> getOrderedProducts() {
        return orderedProducts;
    }

    public void setOrderedProducts(Map<Integer, Integer> orderedProducts) {
        this.orderedProducts = orderedProducts;
    }

    public void setOrderedProducts(List<OrderDetail> orderDetailsAll) {
        this.orderedProducts = new HashMap<>();
        for (int i = 0; i < orderDetailsAll.size(); i++) {
            OrderDetail od = orderDetailsAll.get(i);
            if (od.getOrderId() == this.getId()) {
                this.orderedProducts.put(od.getProductId(), od.getQuantity());
                orderDetailsAll.remove(i);
                i--;
            }
        }
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", totalPrice=" + totalPrice +
                ", orderDate=" + orderDate +
                ", status='" + status + '\'' +
                ", address='" + address + '\'' +
                ", shippingFee=" + shippingFee +
                ", userId=" + userId +
                ", orderedProducts=" + orderedProducts +
                "}\n";
    }
}
