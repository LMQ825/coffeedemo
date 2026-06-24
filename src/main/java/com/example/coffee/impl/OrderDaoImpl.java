package com.example.coffee.impl;

import com.example.coffee.dao.OrderDao;
import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDaoImpl implements OrderDao {

    @Override
    public List<Order> selectOrderList(Integer status, int start, int pageSize) {
        List<Order> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT o.id, o.order_no, o.user_id, o.total_price, o.status, o.create_time, o.pay_time, o.remark, u.username " +
                        "FROM `order` o LEFT JOIN user u ON o.user_id = u.id WHERE 1=1"
        );
        if (status != null) {
            sql.append(" AND o.status = ?");
        }
        sql.append(" ORDER BY o.id DESC LIMIT ?, ?");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            int index = 1;
            if (status != null) {
                pstmt.setInt(index++, status);
            }
            pstmt.setInt(index++, start);
            pstmt.setInt(index, pageSize);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setOrderNo(rs.getString("order_no"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setStatus(rs.getInt("status"));
                o.setCreateTime(rs.getTimestamp("create_time"));
                o.setPayTime(rs.getTimestamp("pay_time"));
                o.setRemark(rs.getString("remark"));
                o.setUsername(rs.getString("username"));
                list.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public int selectOrderCount(Integer status) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM `order` WHERE 1=1");
        if (status != null) {
            sql.append(" AND status = ?");
        }
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            if (status != null) {
                pstmt.setInt(1, status);
            }
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
    public Order selectOrderById(int id) {
        Order o = null;
        String sql = "SELECT o.id, o.order_no, o.user_id, o.total_price, o.status, o.create_time, o.pay_time, o.remark, u.username " +
                "FROM `order` o LEFT JOIN user u ON o.user_id = u.id WHERE o.id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                o = new Order();
                o.setId(rs.getInt("id"));
                o.setOrderNo(rs.getString("order_no"));
                o.setUserId(rs.getInt("user_id"));
                o.setTotalPrice(rs.getDouble("total_price"));
                o.setStatus(rs.getInt("status"));
                o.setCreateTime(rs.getTimestamp("create_time"));
                o.setPayTime(rs.getTimestamp("pay_time"));
                o.setRemark(rs.getString("remark"));
                o.setUsername(rs.getString("username"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return o;
    }

    @Override
    public int updateOrderStatus(int orderId, int status) {
        int rows = 0;
        String sql = "UPDATE `order` SET status=? WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, status);
            pstmt.setInt(2, orderId);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public List<OrderItem> selectOrderItemsByOrderId(int orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT oi.id, oi.order_id, oi.product_id, oi.quantity, oi.price, p.name as product_name " +
                "FROM order_item oi LEFT JOIN product p ON oi.product_id = p.id WHERE oi.order_id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setId(rs.getInt("id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("price"));
                item.setProductName(rs.getString("product_name"));
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