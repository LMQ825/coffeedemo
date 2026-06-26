package com.example.coffee.impl;

import com.example.coffee.dao.CategoryDao;
import com.example.coffee.entity.Category;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {

    @Override
    public List<Category> selectAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT id, name, description, sort_order, status FROM category ORDER BY sort_order ASC, id ASC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setSortOrder(rs.getInt("sort_order"));
                c.setStatus(rs.getInt("status"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Category> selectActiveCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT id, name, description, sort_order, status FROM category WHERE status = 1 ORDER BY sort_order ASC, id ASC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setSortOrder(rs.getInt("sort_order"));
                c.setStatus(rs.getInt("status"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public Category selectCategoryById(int id) {
        Category c = null;
        String sql = "SELECT id, name, description, sort_order, status FROM category WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                c = new Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                c.setDescription(rs.getString("description"));
                c.setSortOrder(rs.getInt("sort_order"));
                c.setStatus(rs.getInt("status"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return c;
    }


    @Override
    public int insertCategory(Category category) {
        int result = 0;
        String sql = "INSERT INTO category(name, description, sort_order, status) VALUES(?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, category.getSortOrder() != null ? category.getSortOrder() : 0);
            pstmt.setInt(4, category.getStatus() != null ? category.getStatus() : 1);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return result;
    }

    @Override
    public int updateCategory(Category category) {
        int result = 0;
        String sql = "UPDATE category SET name=?, description=?, sort_order=?, status=? WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category.getName());
            pstmt.setString(2, category.getDescription());
            pstmt.setInt(3, category.getSortOrder());
            pstmt.setInt(4, category.getStatus());
            pstmt.setInt(5, category.getId());
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return result;
    }

    @Override
    public int deleteCategory(int id) {
        int result = 0;
        String sql = "DELETE FROM category WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return result;
    }

    @Override
    public int updateCategoryStatus(int id, int status) {
        int result = 0;
        String sql = "UPDATE category SET status=? WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, status);
            pstmt.setInt(2, id);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return result;
    }

    @Override
    public int selectCategoryCount() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM category";
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
}