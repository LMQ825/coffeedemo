package com.example.coffee.dao;

import com.example.coffee.entity.User;
import java.util.List;

public interface UserDao {
    // 原有方法保留
    User selectUserByNameAndPwd(String username, String password);
    User selectUserByUsername(String username);
    int insertUser(User user);

    // 后台管理新增
    List<User> selectUserList(String keyword, int start, int pageSize);
    int selectUserCount(String keyword);
    int updateUserStatus(int userId, int status);  // 禁用/启用
}