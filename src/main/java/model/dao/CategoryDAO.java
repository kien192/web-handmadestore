package model.dao;

import model.bean.Category;
import model.db.JDBIConnector;

import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

public class CategoryDAO {
    public static List<Category> getAll() {
        List<Category> categories = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from category")
                        .mapToBean(Category.class).stream().collect(Collectors.toList())
        );
        return categories;
    }


    public static String insertCategory(String newCategoryName) {
        AtomicInteger newID = new AtomicInteger();
        JDBIConnector.me().useHandle(handle -> {
                     newID.set(handle.createUpdate("INSERT INTO category (name) VALUES (:name)")
                             .bind("name", newCategoryName)
                             .executeAndReturnGeneratedKeys("id")
                             .mapTo(Integer.class)
                             .one());
                }
        );

        return newID.get()+"";

    }
}
