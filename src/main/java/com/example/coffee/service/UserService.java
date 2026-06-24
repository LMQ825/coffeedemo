package com.example.coffee.service;



import com.example.coffee.entity.User;

public interface UserService {
    // 登录：根据用户名密码查询用户
    User login(String username, String password);
    // 注册用户
    int register(User user);
    // 根据用户名查询用户（判断是否重复）
    User findUserByName(String username);
}