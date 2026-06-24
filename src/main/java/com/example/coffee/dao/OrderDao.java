package com.example.coffee.dao;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;

import java.util.List;

public interface OrderDao {
    // 分页查询订单（关联用户名）
    List<Order> selectOrderList(Integer status, int start, int pageSize);
    // 查询总数
    int selectOrderCount(Integer status);
    // 根据ID查询订单（含明细）
    Order selectOrderById(int id);
    // 更新订单状态
    int updateOrderStatus(int orderId, int status);
    // 根据订单ID查询明细（关联商品名称）
    List<OrderItem> selectOrderItemsByOrderId(int orderId);
}