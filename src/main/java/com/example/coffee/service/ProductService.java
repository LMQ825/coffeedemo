package com.example.coffee.service;

import com.example.coffee.entity.Product;
import com.example.coffee.util.PageBean;

import java.util.List;

public interface ProductService {
    PageBean<Product> listProducts(String keyword, int currentPage, int pageSize);
    Product getProductById(int id);
    int addProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(int id);
    int upProduct(int id);
    // 新增用户端方法
    List<Product> getProductsByCategory(String category);
    List<Product> getNewProducts();
    // 新增:搜索商品
    List<Product> searchProducts(String keyword);
}