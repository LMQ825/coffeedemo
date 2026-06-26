package com.example.coffee.impl;

import com.example.coffee.entity.OrderItem;
import java.util.List;

public interface OrderItemDaoImpl {
    void insert(OrderItem item);
    List<OrderItem> findByOrderId(int orderId);
}