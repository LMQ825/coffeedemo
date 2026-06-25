package com.example.coffee.impl;
import com.example.coffee.dao.UserDao;
import com.example.coffee.entity.User;
import com.example.coffee.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    @Override
    public User selectUserByNameAndPwd(String username, String password) {
        User user = null;
        String sql = "select id,username,password,phone,address from user where username=? and password=?";
        // 获取连接
        conn = DBUtil.getConnection();
        // 增加判空，避免空指针
        if(conn == null){
            System.out.println("数据库连接失败！检查账号密码/MySQL服务/驱动包");
            return null;
        }
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return user;
    }

    @Override
    public User selectUserByUsername(String username) {
        User user = null;
        String sql = "select id,username,password,phone,address from user where username=?";
        conn = DBUtil.getConnection();
        if(conn == null){
            System.out.println("数据库连接失败！");
            return null;
        }
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return user;
    }

    @Override
    public int insertUser(User user) {
        int rows = 0;
        String sql = "insert user(username,password,phone,address) values(?,?,?,?)";
        conn = DBUtil.getConnection();
        if(conn == null){
            System.out.println("数据库连接失败！");
            return 0;
        }
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getPassword());
            pstmt.setString(3, user.getPhone());
            pstmt.setString(4, user.getAddress());
            rows = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return rows;
    }
    @Override
    public List<User> selectUserList(String keyword, int start, int pageSize) {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id, username, password, phone, address, status FROM user WHERE username LIKE ? OR phone LIKE ? ORDER BY id DESC LIMIT ?, ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String like = "%" + (keyword == null ? "" : keyword) + "%";
            pstmt.setString(1, like);
            pstmt.setString(2, like);
            pstmt.setInt(3, start);
            pstmt.setInt(4, pageSize);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setStatus(rs.getInt("status"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public int selectUserCount(String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM user WHERE username LIKE ? OR phone LIKE ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String like = "%" + (keyword == null ? "" : keyword) + "%";
            pstmt.setString(1, like);
            pstmt.setString(2, like);
            rs = pstmt.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return count;
    }

    @Override
    public int updateUserStatus(int userId, int status) {
        int rows = 0;
        String sql = "UPDATE user SET status=? WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, status);
            pstmt.setInt(2, userId);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }
}