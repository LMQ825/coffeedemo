package com.example.coffee.dao;

import com.example.coffee.entity.OrderItem;
import java.util.List;

public interface OrderItemDao {
    void insert(OrderItem item);
    List<OrderItem> findByOrderId(int orderId);
}