package model.service;

import model.bean.User;
import model.dao.UserDAO;

import java.util.ArrayList;
import java.util.List;

public class UserService {
    private static UserService instance;

    public static UserService getInstance() {
        if (instance == null) instance = new UserService();
        return instance;
    }

    public User checkLogin(String email, String password) {
        User userByEmail = UserDAO.getUserByEmail(email);

        if (userByEmail != null && userByEmail.getEmail().equals(email)
                && userByEmail.getPassword().equals(password))
            return userByEmail;
        else return null;
    }

    public List<User> getAllUsers() {
        List<User> users = UserDAO.getAllUsers();
        return users;
    }

    public User getUserById(String id) {
        return UserDAO.getUserById(id);
    }

    public void lockUser(String id) {
        UserDAO.lockUser(id);
    }

    public void unlockUser(String id) {
        UserDAO.unlockUser(id);
    }

}
