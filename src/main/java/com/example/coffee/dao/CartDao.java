package com.example.coffee.dao;

import com.example.coffee.entity.CartItem;
import java.util.List;

public interface CartDao {
    int saveCartItem(int userId, int productId, int quantity, String spec, String remark);
    int updateCartItemQuantity(int userId, int productId, int quantity);
    int deleteCartItem(int userId, int productId);
    int clearUserCart(int userId);
    List<CartItem> selectUserCart(int userId);
}