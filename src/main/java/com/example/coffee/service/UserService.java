package com.example.coffee.service;

import com.example.coffee.entity.User;
import com.example.coffee.util.PageBean;

public interface UserService {
    // 原有
    User login(String username, String password);
    int register(User user);
    User findUserByName(String username);

    // 新增后台
    PageBean<User> listUsers(String keyword, int currentPage, int pageSize);
    int updateUserStatus(int userId, int status);
}