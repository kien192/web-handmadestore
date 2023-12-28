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
    public List<Product> allProduct(){
        return  ProductDAO.getAll();
    }
    //Sắp xếp từ thấp đến cao
    public List<Product> sortProductsAZ(){
        return ProductDAO.sortProductAZ();
    }
    //sắp xếp từ cao đến thấp
    public List<Product> sortProductsZA(){
        return ProductDAO.sortProductZA();
    }
    //danh sách sản phẩm theo danh mục
    public List<Product> productByCategoryC01() {return  ProductDAO.findByCategory("C01");}
    public List<Product> productByCategoryC02() {return  ProductDAO.findByCategory("C02");}
    public List<Product> productByCategoryC03() {return  ProductDAO.findByCategory("C03");}
    public List<Product> productByCategoryC04() {return  ProductDAO.findByCategory("C04");}
    public List<Product> productByCategoryC05() {return  ProductDAO.findByCategory("C05");}
    public static void main(String[] args) {
    }
}
