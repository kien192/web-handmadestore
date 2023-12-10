package model.dao;

import model.bean.User;
import model.db.JDBIConnector;

import java.sql.*;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class UserDAO {
    public static User getUserByEmail(final String email) {
        Optional<User> user = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from user where email= :e")
                        .bind("e", email)
                        .mapToBean(User.class)
                        .stream()
                        .findFirst()
        );
        return user.isEmpty() ? null : user.get();
    }

    public static User getUserById(final String id) {
        Optional<User> user = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from user where id= :id")
                        .bind("id", id)
                        .mapToBean(User.class)
                        .stream()
                        .findFirst()
        );
        return user.isEmpty() ? null : user.get();
    }

    public static void setPasswordByEmail(final String email, String newPassword) {
        JDBIConnector.me().useHandle(handle -> {
            handle.createUpdate("update user set password = ? where email = ?")
                    .bind(0, newPassword).bind(1, email).execute();
        });
    }


    public static void insertUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User object is null");
        }

        String userPass = user.getPassword();
        String userName = user.getName();
        String userEmail = user.getEmail();
        String userTelephone = user.getPhoneNumber();

        if (userPass == null || userName == null || userEmail == null || userTelephone == null) {
            throw new IllegalArgumentException("User data is incomplete");
        }

        try {
            JDBIConnector.me().useHandle(handle ->
                    handle.createUpdate("INSERT INTO user (password, name, email, phoneNumber) VALUES(:password, :name, :email, :telephone)")
                            .bind("password", userPass)

                            .bind("name", userName)
                            .bind("email", userEmail)
                            .bind("telephone", userTelephone)
                            .execute()


            );

        } catch (Exception e) {
            // Xử lý exception tại đây, có thể log hoặc throw lại exception tùy vào yêu cầu của ứng dụng
            e.printStackTrace();
            throw new RuntimeException("Failed to insert user into the database", e);
        }
    }

    public static List<User> getAllUsers() {
        List<User> users = JDBIConnector.me().withHandle(handle ->
                handle.createQuery("select * from user").mapToBean(User.class).stream().collect(Collectors.toList()));
        return users;
    }

    public static void lockUser(String user_id) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE user SET status = 'Bị Khóa' WHERE id=?")
                        .bind(0, user_id)
                        .execute()
        );
    }

    public static void unlockUser(String user_id) {
        JDBIConnector.me().useHandle(handle ->
                handle.createUpdate("UPDATE user SET status = 'Bình Thường' WHERE id=?")
                        .bind(0, user_id)
                        .execute()
        );
    }

    public static void main(String[] args) {
//        List<User> users = JDBIConnector.me().withHandle(handle ->
//                handle.createQuery("select * from user").mapToBean(User.class).collect(Collectors.toList())
//        );
//        System.out.println(users);
//        User u = UserDAO.getUserByEmail("nghia@gmail.com");
//        System.out.println(getAllUsers());
        lockUser("u10");
        System.out.println(getAllUsers());
    }
}
