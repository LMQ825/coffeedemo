package com.example.coffee.impl;


import com.example.coffee.dao.UserDao;
import com.example.coffee.impl.UserDaoImpl;
import com.example.coffee.entity.User;
import com.example.coffee.service.UserService;

public class UserServiceImpl implements UserService {
    // 注入DAO
    private UserDao userDao = new UserDao();

    @Override
    public User login(String username, String password) {
        // 调用dao查询账号密码匹配用户
        return userDao.selectUserByNameAndPwd(username,password);
    }

    @Override
    public int register(User user) {
        return userDao.insertUser(user);
    }

    @Override
    public User findUserByName(String username) {
        return userDao.selectUserByUsername(username);
    }
}