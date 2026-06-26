package com.example.coffee.impl;

import com.example.coffee.dao.OrderDao;
import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OrderDaoImpl implements OrderDao {

    @Override
    public int insertOrder(Order order) {
        int generatedId = 0;
        String sql = "INSERT INTO `order` (order_no, user_id, total_price, status, create_time, remark) VALUES (?, ?, ?, ?, NOW(), ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, order.getOrderNo());
            pstmt.setInt(2, order.getUserId());
            pstmt.setDouble(3, order.getTotalPrice());
            pstmt.setInt(4, order.getStatus() != null ? order.getStatus() : 0);
            pstmt.setString(5, order.getRemark());
            pstmt.executeUpdate();

            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                generatedId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return generatedId;
    }

    @Override
    public int insertOrderItem(OrderItem item) {
        int rows = 0;
        String sql = "INSERT INTO order_item (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, item.getOrderId());
            pstmt.setInt(2, item.getProductId());
            pstmt.setInt(3, item.getQuantity());
            pstmt.setDouble(4, item.getPrice());
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public Order selectOrderById(int id) {
        Order order = null;
        String sql = "SELECT o.id, o.order_no, o.user_id, o.total_price, o.status, o.create_time, o.pay_time, o.remark, u.username " +
                "FROM `order` o LEFT JOIN user u ON o.user_id = u.id WHERE o.id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setOrderNo(rs.getString("order_no"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setCreateTime(rs.getTimestamp("create_time"));
                order.setPayTime(rs.getTimestamp("pay_time"));
                order.setRemark(rs.getString("remark"));
                order.setUsername(rs.getString("username"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return order;
    }

    @Override
    public List<Order> selectOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT o.id, o.order_no, o.user_id, o.total_price, o.status, o.create_time, o.pay_time, o.remark, u.username " +
                "FROM `order` o LEFT JOIN user u ON o.user_id = u.id WHERE o.user_id = ? ORDER BY o.id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setOrderNo(rs.getString("order_no"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setCreateTime(rs.getTimestamp("create_time"));
                order.setPayTime(rs.getTimestamp("pay_time"));
                order.setRemark(rs.getString("remark"));
                order.setUsername(rs.getString("username"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

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
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setOrderNo(rs.getString("order_no"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalPrice(rs.getDouble("total_price"));
                order.setStatus(rs.getInt("status"));
                order.setCreateTime(rs.getTimestamp("create_time"));
                order.setPayTime(rs.getTimestamp("pay_time"));
                order.setRemark(rs.getString("remark"));
                order.setUsername(rs.getString("username"));
                list.add(order);
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
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return count;
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
    public int payOrder(int orderId) {
        int rows = 0;
        String sql = "UPDATE `order` SET status=1, pay_time=NOW() WHERE id=? AND status=0";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderId);
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
                "FROM order_item oi LEFT JOIN product p ON oi.product_id = p.id WHERE oi.order_id = ?";
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

    // =========================================================
    // ===== 新增：仪表盘统计方法 =====
    // =========================================================

    @Override
    public Double selectTodaySales() {
        Double sales = 0.0;
        String sql = "SELECT COALESCE(SUM(total_price), 0) FROM `order` WHERE DATE(create_time) = CURDATE() AND status IN (1, 2)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                sales = rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return sales;
    }

    @Override
    public int selectTodayOrderCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM `order` WHERE DATE(create_time) = CURDATE()";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return count;
    }

    @Override
    public int selectPendingOrderCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM `order` WHERE status IN (0, 1)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return count;
    }
    // =========================================================
// ===== 统计分析方法实现 =====
// =========================================================

    @Override
    public List<Map<String, Object>> selectTopSellingProducts(int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.id, p.name, SUM(oi.quantity) AS total_quantity, SUM(oi.quantity * oi.price) AS total_sales " +
                "FROM order_item oi " +
                "INNER JOIN product p ON oi.product_id = p.id " +
                "INNER JOIN `order` o ON oi.order_id = o.id " +
                "WHERE o.status IN (1, 2) " + // 已支付订单（待取餐、已完成）
                "GROUP BY p.id, p.name " +
                "ORDER BY total_quantity DESC " +
                "LIMIT ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, limit);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new java.util.HashMap<>();
                row.put("id", rs.getInt("id"));
                row.put("name", rs.getString("name"));
                row.put("totalQuantity", rs.getInt("total_quantity"));
                row.put("totalSales", rs.getDouble("total_sales"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Map<String, Object>> selectOrderStatusDistribution() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT status, COUNT(*) AS count FROM `order` GROUP BY status ORDER BY status";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new java.util.HashMap<>();
                row.put("status", rs.getInt("status"));
                row.put("count", rs.getInt("count"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Map<String, Object>> selectDailySalesLast7Days() {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT DATE(create_time) AS sale_date, COALESCE(SUM(total_price), 0) AS daily_total " +
                "FROM `order` " +
                "WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) " +
                "AND status IN (1, 2) " + // 已支付
                "GROUP BY DATE(create_time) " +
                "ORDER BY sale_date ASC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new java.util.HashMap<>();
                row.put("saleDate", rs.getDate("sale_date"));
                row.put("dailyTotal", rs.getDouble("daily_total"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Map<String, Object>> selectCategorySalesDistribution() {
        List<Map<String, Object>> list = new ArrayList<>();
        // 注意：product 表需要有 category 字段，或者关联 category 表
        // 这里假设 product 表有 category 字段（字符串）
        String sql = "SELECT p.category, SUM(oi.quantity * oi.price) AS category_sales " +
                "FROM order_item oi " +
                "INNER JOIN product p ON oi.product_id = p.id " +
                "INNER JOIN `order` o ON oi.order_id = o.id " +
                "WHERE o.status IN (1, 2) " +
                "GROUP BY p.category " +
                "ORDER BY category_sales DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new java.util.HashMap<>();
                row.put("category", rs.getString("category"));
                row.put("categorySales", rs.getDouble("category_sales"));
                list.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

}