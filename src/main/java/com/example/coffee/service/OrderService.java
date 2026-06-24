package com.example.coffee.service;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.util.PageBean;

import java.util.List;

public interface OrderService {
    PageBean<Order> listOrders(Integer status, int currentPage, int pageSize);
    Order getOrderDetail(int orderId);
    int updateOrderStatus(int orderId, int status);
}