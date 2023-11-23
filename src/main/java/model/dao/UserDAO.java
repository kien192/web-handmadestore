package model.dao;

import model.bean.User;
import model.db.JDBIConnector;

import java.sql.ResultSet;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class UserDAO {
    public static User getUserByEmail(final String email) {
        Optional<User> user = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from user where email= ?").bind(0, email).mapToBean(User.class).stream().findFirst()
        );
        return user.isEmpty() ? null : user.get();
    }

    public static void main(String[] args) {
        List<User> users = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from user").mapToBean(User.class).collect(Collectors.toList())
        );
        System.out.println(users);
    }
}
