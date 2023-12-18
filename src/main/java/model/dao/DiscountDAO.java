package model.dao;

import model.bean.Category;
import model.bean.Discount;
import model.bean.User;
import model.db.JDBIConnector;
import org.h2.expression.function.SysInfoFunction;

import javax.xml.transform.stream.StreamSource;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class DiscountDAO {
    public static List<Discount> getAll() {
        List<Discount> categories = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from discount")
                        .mapToBean(Discount.class).stream().collect(Collectors.toList())
        );
        return categories;
    }

    public static Discount getDiscountById(String id) {
        Optional<Discount> discount = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from discount where id= :id")
                        .bind("id", id)
                        .mapToBean(Discount.class)
                        .stream()
                        .findFirst()
        );
        return discount.isEmpty() ? null : discount.get();
    }
}
