package com.example.coffee.service;

import com.example.coffee.entity.Admin;

public interface AdminService {
    Admin login(String username, String password);
}