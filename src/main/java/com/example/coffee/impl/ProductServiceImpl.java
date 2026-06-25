package com.example.coffee.impl;

import com.example.coffee.dao.ProductDao;
import com.example.coffee.impl.ProductDaoImpl;
import com.example.coffee.entity.Product;
import com.example.coffee.service.ProductService;
import com.example.coffee.util.PageBean;

import java.util.List;

public class ProductServiceImpl implements ProductService {
    private ProductDao productDao = new ProductDaoImpl();

    @Override
    public PageBean<Product> listProducts(String keyword, int currentPage, int pageSize) {
        int start = (currentPage - 1) * pageSize;
        List<Product> list = productDao.selectProductList(keyword, start, pageSize);
        int totalCount = productDao.selectProductCount(keyword);
        return new PageBean<>(currentPage, pageSize, totalCount, list);
    }

    @Override
    public Product getProductById(int id) {
        return productDao.selectProductById(id);
    }

    @Override
    public int addProduct(Product product) {
        return productDao.insertProduct(product);
    }

    @Override
    public int updateProduct(Product product) {
        return productDao.updateProduct(product);
    }

    @Override
    public int deleteProduct(int id) {
        return productDao.deleteProduct(id);
    }

    @Override
    public int upProduct(int id) {
        return productDao.upProduct(id);
    }
    @Override
    public List<Product> getProductsByCategory(String category) {
        return productDao.selectProductsByCategory(category);
    }

    @Override
    public List<Product> getNewProducts() {
        return productDao.selectNewProducts();
    }
}