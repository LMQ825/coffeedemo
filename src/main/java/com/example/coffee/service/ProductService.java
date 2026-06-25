package com.example.coffee.service;

import com.example.coffee.entity.Product;
import com.example.coffee.util.PageBean;

public interface ProductService {
    PageBean<Product> listProducts(String keyword, int currentPage, int pageSize);
    Product getProductById(int id);
    int addProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(int id);
    int upProduct(int id);
}