package com.example.coffee.dao;

import com.example.coffee.entity.Product;
import com.example.coffee.util.PageBean;

import java.util.List;

public interface ProductDao {
    // 分页+搜索查询
    List<Product> selectProductList(String keyword, int start, int pageSize);
    // 查询总数
    int selectProductCount(String keyword);
    // 根据ID查询
    Product selectProductById(int id);
    // 新增
    int insertProduct(Product product);
    // 修改
    int updateProduct(Product product);
    // 删除（软删除，改status=0）
    int deleteProduct(int id);
    // 上架（status=1）
    int upProduct(int id);
}