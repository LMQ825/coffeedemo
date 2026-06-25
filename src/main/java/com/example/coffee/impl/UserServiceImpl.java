package com.example.coffee.impl;


import com.example.coffee.dao.UserDao;
import com.example.coffee.impl.UserDaoImpl;
import com.example.coffee.entity.User;
import com.example.coffee.service.UserService;
import com.example.coffee.util.PageBean;

import java.util.List;

public class UserServiceImpl implements UserService {
    // 注入DAO
    private UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        // 调用dao查询账号密码匹配用户
        return userDao.selectUserByNameAndPwd(username,password);
    }
    @Override
    public PageBean<User> listUsers(String keyword, int currentPage, int pageSize) {
        int start = (currentPage - 1) * pageSize;
        List<User> list = userDao.selectUserList(keyword, start, pageSize);
        int totalCount = userDao.selectUserCount(keyword);
        return new PageBean<>(currentPage, pageSize, totalCount, list);
    }

    @Override
    public int updateUserStatus(int userId, int status) {
        return userDao.updateUserStatus(userId, status);
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