package model.service;

import model.bean.Category;
import model.dao.CategoryDAO;

import java.util.List;

public class CategoryService {
    private static CategoryService instance;

    public static CategoryService getInstance() {
        if (instance == null) instance = new CategoryService();
        return instance;
    }
    public List<Category> getALl() {


        return CategoryDAO.getAll() ;
    }


    public static void main(String[] args) {
        List<Category> list = getInstance().getALl();
        for(Category sub : list) {
            System.out.println(sub.toString());
        }


    }
    }