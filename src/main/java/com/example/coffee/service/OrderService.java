package com.example.coffee.service;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.util.PageBean;

import java.util.List;

public interface OrderService {
    PageBean<Order> listOrders(Integer status, int currentPage, int pageSize);
    Order getOrderDetail(int orderId);
    int updateOrderStatus(int orderId, int status);
    // 创建订单（主表+明细），返回订单主键 id
    int createOrder(Order order, List<OrderItem> items);
    // 查询某用户的全部订单
    List<Order> listUserOrders(int userId);
    // 支付订单
    int payOrder(int orderId);
    // 根据订单ID查询订单(不加载明细)
    Order getOrderById(int orderId);
    // 查询订单明细
    List<OrderItem> getOrderItems(int orderId);
}