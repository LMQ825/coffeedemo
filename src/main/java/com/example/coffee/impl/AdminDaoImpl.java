package com.example.coffee.impl;

import com.example.coffee.dao.AdminDao;
import com.example.coffee.entity.Admin;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDaoImpl implements AdminDao {

    @Override
    public Admin selectAdminByUsernameAndPwd(String username, String password) {
        Admin admin = null;
        String sql = "SELECT id, username, password, nickname, role FROM admin WHERE username=? AND password=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
                admin.setNickname(rs.getString("nickname"));
                admin.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return admin;
    }
}
