package com.example.coffee.impl;

import com.example.coffee.dao.InventoryDao;
import com.example.coffee.entity.Inventory;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * 库存DAO实现类
 */
public class InventoryDaoImpl implements InventoryDao {

    @Override
    public List<Inventory> selectInventoryList(String keyword, String category, int start, int pageSize) {
        List<Inventory> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM inventory WHERE 1=1");
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (name LIKE ? OR supplier LIKE ?)");
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
        }
        sql.append(" ORDER BY update_time DESC LIMIT ?, ?");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            int idx = 1;
            if (keyword != null && !keyword.isEmpty()) {
                String like = "%" + keyword + "%";
                pstmt.setString(idx++, like);
                pstmt.setString(idx++, like);
            }
            if (category != null && !category.isEmpty()) {
                pstmt.setString(idx++, category);
            }
            pstmt.setInt(idx++, start);
            pstmt.setInt(idx, pageSize);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public int selectInventoryCount(String keyword, String category) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM inventory WHERE 1=1");
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (name LIKE ? OR supplier LIKE ?)");
        }
        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
        }

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql.toString());
            int idx = 1;
            if (keyword != null && !keyword.isEmpty()) {
                String like = "%" + keyword + "%";
                pstmt.setString(idx++, like);
                pstmt.setString(idx++, like);
            }
            if (category != null && !category.isEmpty()) {
                pstmt.setString(idx++, category);
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
    public Inventory selectInventoryById(int id) {
        Inventory inv = null;
        String sql = "SELECT * FROM inventory WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                inv = mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return inv;
    }

    @Override
    public int insertInventory(Inventory inventory) {
        String sql = "INSERT INTO inventory (name, category, quantity, unit, min_quantity, supplier, description) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, inventory.getName());
            pstmt.setString(2, inventory.getCategory());
            pstmt.setDouble(3, inventory.getQuantity());
            pstmt.setString(4, inventory.getUnit());
            pstmt.setDouble(5, inventory.getMinQuantity());
            pstmt.setString(6, inventory.getSupplier());
            pstmt.setString(7, inventory.getDescription());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return result;
    }

    @Override
    public int updateInventory(Inventory inventory) {
        String sql = "UPDATE inventory SET name=?, category=?, quantity=?, unit=?, min_quantity=?, supplier=?, description=? WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, inventory.getName());
            pstmt.setString(2, inventory.getCategory());
            pstmt.setDouble(3, inventory.getQuantity());
            pstmt.setString(4, inventory.getUnit());
            pstmt.setDouble(5, inventory.getMinQuantity());
            pstmt.setString(6, inventory.getSupplier());
            pstmt.setString(7, inventory.getDescription());
            pstmt.setInt(8, inventory.getId());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return result;
    }

    @Override
    public int deleteInventory(int id) {
        String sql = "DELETE FROM inventory WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return result;
    }

    @Override
    public List<Inventory> selectAllInventory() {
        List<Inventory> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory ORDER BY category, name";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Inventory> selectLowStockItems() {
        List<Inventory> list = new ArrayList<>();
        String sql = "SELECT * FROM inventory WHERE quantity <= min_quantity ORDER BY (quantity / min_quantity) ASC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public int updateQuantity(int id, double quantity) {
        String sql = "UPDATE inventory SET quantity = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, quantity);
            pstmt.setInt(2, id);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return result;
    }

    /** 将ResultSet行映射为Inventory对象 */
    private Inventory mapRow(ResultSet rs) throws Exception {
        Inventory inv = new Inventory();
        inv.setId(rs.getInt("id"));
        inv.setName(rs.getString("name"));
        inv.setCategory(rs.getString("category"));
        inv.setQuantity(rs.getDouble("quantity"));
        inv.setUnit(rs.getString("unit"));
        inv.setMinQuantity(rs.getDouble("min_quantity"));
        inv.setSupplier(rs.getString("supplier"));
        inv.setDescription(rs.getString("description"));
        inv.setCreateTime(rs.getString("create_time"));
        inv.setUpdateTime(rs.getString("update_time"));
        return inv;
    }
}
