package com.example.coffee.dao;

import com.example.coffee.entity.CartItem;
import java.util.List;

/**
 * 购物车DAO接口 - 支持购物车数据持久化
 */
public interface CartDao {
    /**
     * 保存购物车商品到数据库
     */
    int saveCartItem(int userId, int productId, int quantity);
    
    /**
     * 更新购物车商品数量
     */
    int updateCartItemQuantity(int userId, int productId, int quantity);
    
    /**
     * 删除购物车商品
     */
    int deleteCartItem(int userId, int productId);
    
    /**
     * 清空用户购物车
     */
    int clearUserCart(int userId);
    
    /**
     * 查询用户的购物车商品列表
     */
    List<CartItem> selectUserCart(int userId);
}
