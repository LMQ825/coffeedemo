package com.example.coffee.dao;

import com.example.coffee.entity.Category;
import java.util.List;

public interface CategoryDao {
    // 查询所有分类（按排序顺序）
    List<Category> selectAllCategories();
    
    // 查询启用的分类
    List<Category> selectActiveCategories();
    
    // 根据ID查询分类
    Category selectCategoryById(int id);
    
    // 添加分类
    int insertCategory(Category category);
    
    // 更新分类
    int updateCategory(Category category);
    
    // 删除分类
    int deleteCategory(int id);
    
    // 更新分类状态
    int updateCategoryStatus(int id, int status);
    
    // 查询分类总数
    int selectCategoryCount();
}