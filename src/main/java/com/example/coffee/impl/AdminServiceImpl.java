package com.example.coffee.impl;

import com.example.coffee.dao.AdminDao;
import com.example.coffee.impl.AdminDaoImpl;
import com.example.coffee.entity.Admin;
import com.example.coffee.service.AdminService;

public class AdminServiceImpl implements AdminService {
    private AdminDao adminDao = new AdminDaoImpl();

    @Override
    public Admin login(String username, String password) {
        return adminDao.selectAdminByUsernameAndPwd(username, password);
    }
}