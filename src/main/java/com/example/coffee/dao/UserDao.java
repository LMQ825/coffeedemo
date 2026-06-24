package com.example.coffee.dao;


import com.example.coffee.entity.User;

public interface UserDao {
    // 根据用户名+密码查询用户（登录用）
    User selectUserByNameAndPwd(String username, String password);

    // 根据用户名查询用户（注册查重）
    User selectUserByUsername(String username);

    // 新增用户（注册）
    int insertUser(User user);
}