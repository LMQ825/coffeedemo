package com.example.coffee.impl;

import com.example.coffee.dao.OrderDao;
import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @Override
    public int insertOrder(Order order) {
        int id = 0;
        String sql = "INSERT INTO `order`(order_no, user_id, total_price, status, remark, create_time) VALUES(?,?,?,?,?,NOW())";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, order.getOrderNo());
            pstmt.setInt(2, order.getUserId());
            pstmt.setDouble(3, order.getTotalPrice());
            pstmt.setInt(4, order.getStatus() == null ? 0 : order.getStatus());
            pstmt.setString(5, order.getRemark());
            pstmt.executeUpdate();
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
                order.setId(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return id;
    }

    @Override
    public int insertOrderItem(OrderItem item) {
        int rows = 0;
        String sql = "INSERT INTO order_item(order_id, product_id, quantity, price) VALUES(?,?,?,?)";
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
    public List<Order> selectOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT id, order_no, user_id, total_price, status, create_time, pay_time, remark " +
                "FROM `order` WHERE user_id=? ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
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
    public int payOrder(int orderId) {
        int rows = 0;
        String sql = "UPDATE `order` SET status=1, pay_time=NOW() WHERE id=?";
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
    
    // ========== 统计方法实现 ==========
    
    @Override
    public Double selectTodaySales() {
        Double sales = 0.0;
        String sql = "SELECT SUM(total_price) FROM `order` WHERE DATE(create_time) = CURDATE() AND status >= 1";
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
    public Double selectSalesByDateRange(java.util.Date startDate, java.util.Date endDate) {
        Double sales = 0.0;
        String sql = "SELECT SUM(total_price) FROM `order` WHERE create_time >= ? AND create_time <= ? AND status >= 1";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setTimestamp(1, new java.sql.Timestamp(startDate.getTime()));
            pstmt.setTimestamp(2, new java.sql.Timestamp(endDate.getTime()));
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
    public int selectPendingOrderCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM `order` WHERE status = 1"; // 待取餐状态
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
    public List<Map<String, Object>> selectTopSellingProducts(int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT p.name, p.category, SUM(oi.quantity) as total_sales, SUM(oi.quantity * oi.price) as total_revenue " +
                     "FROM order_item oi " +
                     "JOIN product p ON oi.product_id = p.id " +
                     "JOIN `order` o ON oi.order_id = o.id " +
                     "WHERE o.status >= 1 " +
                     "GROUP BY oi.product_id " +
                     "ORDER BY total_sales DESC " +
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
                Map<String, Object> map = new HashMap<>();
                map.put("name", rs.getString("name"));
                map.put("category", rs.getString("category"));
                map.put("totalSales", rs.getInt("total_sales"));
                map.put("totalRevenue", rs.getDouble("total_revenue"));
                list.add(map);
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
        String sql = "SELECT status, COUNT(*) as count FROM `order` GROUP BY status ORDER BY status";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                int status = rs.getInt("status");
                map.put("status", status);
                map.put("statusText", getStatusText(status));
                map.put("count", rs.getInt("count"));
                list.add(map);
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
        String sql = "SELECT DATE(create_time) as date, SUM(total_price) as sales, COUNT(*) as orders " +
                     "FROM `order` WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL 6 DAY) AND status >= 1 " +
                     "GROUP BY DATE(create_time) ORDER BY date ASC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("date", rs.getDate("date"));
                map.put("sales", rs.getDouble("sales"));
                map.put("orders", rs.getInt("orders"));
                list.add(map);
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
        String sql = "SELECT p.category, SUM(oi.quantity) as total_sales, SUM(oi.quantity * oi.price) as total_revenue " +
                     "FROM order_item oi " +
                     "JOIN product p ON oi.product_id = p.id " +
                     "JOIN `order` o ON oi.order_id = o.id " +
                     "WHERE o.status >= 1 AND p.category IS NOT NULL " +
                     "GROUP BY p.category " +
                     "ORDER BY total_revenue DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> map = new HashMap<>();
                map.put("category", rs.getString("category"));
                map.put("totalSales", rs.getInt("total_sales"));
                map.put("totalRevenue", rs.getDouble("total_revenue"));
                list.add(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }
    
    private String getStatusText(int status) {
        switch (status) {
            case 0: return "待付款";
            case 1: return "待取餐";
            case 2: return "已完成";
            case 3: return "已取消";
            default: return "未知";
        }
    }
}