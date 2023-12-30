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






    public String createNewCategory(String newCategoryName) {
        return CategoryDAO.insertCategory(newCategoryName);
    }
}

