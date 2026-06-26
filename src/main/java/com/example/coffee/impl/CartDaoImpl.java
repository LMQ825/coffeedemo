package com.example.coffee.impl;

import com.example.coffee.dao.CartDao;
import com.example.coffee.entity.CartItem;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDaoImpl implements CartDao {

    @Override
    public int saveCartItem(int userId, int productId, int quantity, String spec, String remark) {
        int rows = 0;
        String sql = "INSERT INTO cart (user_id, product_id, quantity, spec, remark) VALUES (?, ?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity), spec = VALUES(spec), remark = VALUES(remark)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            pstmt.setInt(3, quantity);
            pstmt.setString(4, spec == null ? "" : spec);
            pstmt.setString(5, remark == null ? "" : remark);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public int updateCartItemQuantity(int userId, int productId, int quantity) {
        int rows = 0;
        String sql = "UPDATE cart SET quantity=? WHERE user_id=? AND product_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, quantity);
            pstmt.setInt(2, userId);
            pstmt.setInt(3, productId);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public int deleteCartItem(int userId, int productId) {
        int rows = 0;
        String sql = "DELETE FROM cart WHERE user_id=? AND product_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, productId);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public int clearUserCart(int userId) {
        int rows = 0;
        String sql = "DELETE FROM cart WHERE user_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public List<CartItem> selectUserCart(int userId) {
        List<CartItem> list = new ArrayList<>();
        String sql = "SELECT c.product_id, c.quantity, c.spec, c.remark, p.name, p.price " +
                "FROM cart c LEFT JOIN product p ON c.product_id = p.id " +
                "WHERE c.user_id=? ORDER BY c.id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setSpec(rs.getString("spec"));
                item.setRemark(rs.getString("remark"));
                item.setName(rs.getString("name"));
                item.setPrice(rs.getDouble("price"));
                item.setIcon("☕"); // 默认图标，可以从 product 表查询
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }
}