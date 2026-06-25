package com.example.coffee.impl;

import com.example.coffee.dao.OrderDao;
import com.example.coffee.impl.OrderDaoImpl;
import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.service.OrderService;
import com.example.coffee.util.PageBean;

import java.util.List;

public class OrderServiceImpl implements OrderService {
    private OrderDao orderDao = new OrderDaoImpl();

    @Override
    public PageBean<Order> listOrders(Integer status, int currentPage, int pageSize) {
        int start = (currentPage - 1) * pageSize;
        List<Order> list = orderDao.selectOrderList(status, start, pageSize);
        int totalCount = orderDao.selectOrderCount(status);
        return new PageBean<>(currentPage, pageSize, totalCount, list);
    }

    @Override
    public Order getOrderDetail(int orderId) {
        Order order = orderDao.selectOrderById(orderId);
        if (order != null) {
            List<OrderItem> items = orderDao.selectOrderItemsByOrderId(orderId);
            order.setItems(items);
        }
        return order;
    }

    @Override
    public int updateOrderStatus(int orderId, int status) {
        return orderDao.updateOrderStatus(orderId, status);
    }

    @Override
    public int createOrder(Order order, List<OrderItem> items) {
        int orderId = orderDao.insertOrder(order);
        if (orderId > 0 && items != null) {
            for (OrderItem item : items) {
                item.setOrderId(orderId);
                orderDao.insertOrderItem(item);
            }
        }
        return orderId;
    }

    @Override
    public List<Order> listUserOrders(int userId) {
        return orderDao.selectOrdersByUserId(userId);
    }

    @Override
    public int payOrder(int orderId) {
        return orderDao.payOrder(orderId);
    }
}