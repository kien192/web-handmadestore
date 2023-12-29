package model.service;

import model.bean.Product;
import model.dao.ProductDAO;

import java.util.ArrayList;
import java.util.List;

public class ProductService {
    public static ProductService instance;
    public static ProductService getInstance(){
        if(instance == null) instance = new ProductService();
        return instance;
    }
    public List<Product> sixProduct(int offset){

        return  ProductDAO.listSixProduct(offset);
    }
    public List<Product> getAllProduct() {
        return ProductDAO.getAll();
    }
    public Product getProductById(int productID) {
        return ProductDAO.getProduct(productID);
    }
    public static void main(String[] args) {
        List<Product> products = ProductService.getInstance().sixProduct(0);
        List<Product> productsa = ProductService.getInstance().getAllProduct();
        Product a = ProductService.getInstance().getProductById(10);
        System.out.println(a);
    }
}
