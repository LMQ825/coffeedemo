package com.example.coffee.service;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.util.PageBean;

import java.util.List;

public interface OrderService {
    int createOrder(Order order, List<OrderItem> items);
    List<Order> listUserOrders(int userId);
    Order getOrderById(int orderId);
    List<OrderItem> getOrderItems(int orderId);
    boolean updateOrderStatus(int orderId, int status);
    boolean payOrder(int orderId);

    // 后台分页查询所有订单（可根据状态过滤）
    PageBean<Order> listOrders(Integer status, int currentPage, int pageSize);

    // 如果需要简单列表（不分页），可以加一个
    List<Order> listAllOrders(Integer status);
}