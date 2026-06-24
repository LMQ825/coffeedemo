package com.example.coffee.dao;

import com.example.coffee.entity.Admin;

public interface AdminDao {
    // 管理员登录查询
    Admin selectAdminByUsernameAndPwd(String username, String password);
}
