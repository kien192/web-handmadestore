package model.service;

import model.bean.User;
import model.dao.UserDAO;

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
}
