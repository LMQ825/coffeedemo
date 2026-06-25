package com.example.coffee.impl;

import com.example.coffee.dao.InventoryRecordDao;
import com.example.coffee.entity.InventoryRecord;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * 进货记录DAO实现类
 */
public class InventoryRecordDaoImpl implements InventoryRecordDao {

    @Override
    public List<InventoryRecord> selectRecordList(String keyword, String startDate, String endDate, int start, int pageSize) {
        List<InventoryRecord> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT r.*, i.name AS inventory_name FROM inventory_record r " +
            "LEFT JOIN inventory i ON r.inventory_id = i.id WHERE 1=1"
        );
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (i.name LIKE ? OR r.supplier LIKE ? OR r.operator LIKE ?)");
        }
        if (startDate != null && !startDate.isEmpty()) {
            sql.append(" AND r.create_time >= ?");
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append(" AND r.create_time <= ?");
        }
        sql.append(" ORDER BY r.create_time DESC LIMIT ?, ?");

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
                pstmt.setString(idx++, like);
            }
            if (startDate != null && !startDate.isEmpty()) {
                pstmt.setString(idx++, startDate + " 00:00:00");
            }
            if (endDate != null && !endDate.isEmpty()) {
                pstmt.setString(idx++, endDate + " 23:59:59");
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
    public int selectRecordCount(String keyword, String startDate, String endDate) {
        int count = 0;
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM inventory_record r " +
            "LEFT JOIN inventory i ON r.inventory_id = i.id WHERE 1=1"
        );
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (i.name LIKE ? OR r.supplier LIKE ? OR r.operator LIKE ?)");
        }
        if (startDate != null && !startDate.isEmpty()) {
            sql.append(" AND r.create_time >= ?");
        }
        if (endDate != null && !endDate.isEmpty()) {
            sql.append(" AND r.create_time <= ?");
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
                pstmt.setString(idx++, like);
            }
            if (startDate != null && !startDate.isEmpty()) {
                pstmt.setString(idx++, startDate + " 00:00:00");
            }
            if (endDate != null && !endDate.isEmpty()) {
                pstmt.setString(idx++, endDate + " 23:59:59");
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
    public InventoryRecord selectRecordById(int id) {
        InventoryRecord record = null;
        String sql = "SELECT r.*, i.name AS inventory_name FROM inventory_record r " +
                     "LEFT JOIN inventory i ON r.inventory_id = i.id WHERE r.id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                record = mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return record;
    }

    @Override
    public int insertRecord(InventoryRecord record) {
        String sql = "INSERT INTO inventory_record (inventory_id, quantity, unit, supplier, unit_price, total_price, operator, remark) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, record.getInventoryId());
            pstmt.setDouble(2, record.getQuantity());
            pstmt.setString(3, record.getUnit());
            pstmt.setString(4, record.getSupplier());
            pstmt.setDouble(5, record.getUnitPrice());
            pstmt.setDouble(6, record.getTotalPrice());
            pstmt.setString(7, record.getOperator());
            pstmt.setString(8, record.getRemark());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
        return result;
    }

    @Override
    public int deleteRecord(int id) {
        String sql = "DELETE FROM inventory_record WHERE id = ?";
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
    public List<InventoryRecord> selectRecordsByInventoryId(int inventoryId) {
        List<InventoryRecord> list = new ArrayList<>();
        String sql = "SELECT r.*, i.name AS inventory_name FROM inventory_record r " +
                     "LEFT JOIN inventory i ON r.inventory_id = i.id WHERE r.inventory_id = ? ORDER BY r.create_time DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, inventoryId);
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

    /** 将ResultSet行映射为InventoryRecord对象 */
    private InventoryRecord mapRow(ResultSet rs) throws Exception {
        InventoryRecord r = new InventoryRecord();
        r.setId(rs.getInt("id"));
        r.setInventoryId(rs.getInt("inventory_id"));
        r.setQuantity(rs.getDouble("quantity"));
        r.setUnit(rs.getString("unit"));
        r.setSupplier(rs.getString("supplier"));
        r.setUnitPrice(rs.getDouble("unit_price"));
        r.setTotalPrice(rs.getDouble("total_price"));
        r.setOperator(rs.getString("operator"));
        r.setRemark(rs.getString("remark"));
        r.setCreateTime(rs.getString("create_time"));
        r.setInventoryName(rs.getString("inventory_name"));
        return r;
    }
}
