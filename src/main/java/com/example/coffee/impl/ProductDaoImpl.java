package com.example.coffee.impl;



import com.example.coffee.dao.ProductDao;
import com.example.coffee.entity.Product;
import com.example.coffee.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDaoImpl implements ProductDao {

    @Override
    public List<Product> selectProductList(String keyword, int start, int pageSize) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, price, category, description, image_url, status,is_new FROM product WHERE name LIKE ? OR category LIKE ? ORDER BY id DESC LIMIT ?, ?";
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
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStatus(rs.getInt("status"));
                p.setIsNew(rs.getInt("is_new"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public int selectProductCount(String keyword) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM product WHERE name LIKE ? OR category LIKE ?";
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
    public List<Product> selectProductsByCategory(String category) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, price, category, description, image_url, status, is_new FROM product WHERE status=1 AND category=? ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, category);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStatus(rs.getInt("status"));
                p.setIsNew(rs.getInt("is_new"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Product> selectNewProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, price, category, description, image_url, status, is_new FROM product WHERE status=1 AND is_new=1 ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStatus(rs.getInt("status"));
                p.setIsNew(rs.getInt("is_new"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT id, name, price, category, description, image_url, status, is_new FROM product WHERE status=1 AND (name LIKE ? OR category LIKE ? OR description LIKE ?) ORDER BY id DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            String like = "%" + (keyword == null ? "" : keyword) + "%";
            pstmt.setString(1, like);
            pstmt.setString(2, like);
            pstmt.setString(3, like);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStatus(rs.getInt("status"));
                p.setIsNew(rs.getInt("is_new"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return list;
    }

    @Override
    public Product selectProductById(int id) {
        Product p = null;
        String sql = "SELECT id, name, price, category, description, image_url, status ,is_new FROM product WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setPrice(rs.getDouble("price"));
                p.setCategory(rs.getString("category"));
                p.setDescription(rs.getString("description"));
                p.setImageUrl(rs.getString("image_url"));
                p.setStatus(rs.getInt("status"));
                p.setIsNew(rs.getInt("is_new"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, rs);
        }
        return p;
    }

    @Override
    public int insertProduct(Product product) {
        int rows = 0;
        String sql = "INSERT INTO product(name, price, category, description, image_url, status, is_new) VALUES(?,?,?,?,?,?,?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, product.getName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getCategory());
            pstmt.setString(4, product.getDescription());
            pstmt.setString(5, product.getImageUrl());
            pstmt.setInt(6, product.getStatus() != null ? product.getStatus() : 1);
            pstmt.setInt(7, product.getIsNew() != null ? product.getIsNew() : 0);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public int updateProduct(Product product) {
        int rows = 0;
        String sql = "UPDATE product SET name=?, price=?, category=?, description=?, image_url=?, status=?, is_new=? WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, product.getName());
            pstmt.setDouble(2, product.getPrice());
            pstmt.setString(3, product.getCategory());
            pstmt.setString(4, product.getDescription());
            pstmt.setString(5, product.getImageUrl());
            pstmt.setInt(6, product.getStatus());
            pstmt.setInt(7, product.getIsNew() != null ? product.getIsNew() : 0);
            pstmt.setInt(8, product.getId());
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public int deleteProduct(int id) {
        int rows = 0;
        String sql = "UPDATE product SET status=0 WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }

    @Override
    public int upProduct(int id) {
        int rows = 0;
        String sql = "UPDATE product SET status=1 WHERE id=?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rows = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt);
        }
        return rows;
    }
}