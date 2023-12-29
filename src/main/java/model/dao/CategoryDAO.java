package model.dao;

import model.bean.Category;
import model.db.JDBIConnector;

import java.util.List;
import java.util.stream.Collectors;

public class CategoryDAO {
    public static List<Category> getAll() {
        List<Category> categories = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from category")
                        .mapToBean(Category.class).stream().collect(Collectors.toList())
        );
        return categories;
    }

    public static void main(String[] args) {
        List<Category> c = getAll();
        for(Category sub : c) {
            System.out.println(sub.toString());
        }
    }
}
