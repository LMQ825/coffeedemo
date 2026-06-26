package com.example.coffee.impl;

import com.example.coffee.dao.OrderDao;
import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.service.OrderService;
import com.example.coffee.util.DBUtil;
import com.example.coffee.util.PageBean;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    private OrderDao orderDao = new OrderDaoImpl();

    public Order getOrderDetail(int orderId) {
        Order order = orderDao.selectOrderById(orderId);
        if (order != null) {
            // 加载订单明细
            List<OrderItem> items = orderDao.selectOrderItemsByOrderId(orderId);
            order.setItems(items);
        }
        return order;
    }
    @Override
    public int createOrder(Order order, List<OrderItem> items) {
        Connection conn = null;
        int orderId = 0;
        try {
            conn = DBUtil.getConnection();
            // 手动开启事务
            conn.setAutoCommit(false);

            // 1. 插入订单
            orderId = orderDao.insertOrder(order);
            if (orderId <= 0) {
                throw new RuntimeException("订单创建失败");
            }

            // 2. 插入订单明细
            if (items != null && !items.isEmpty()) {
                for (OrderItem item : items) {
                    item.setOrderId(orderId);
                    int rows = orderDao.insertOrderItem(item);
                    if (rows <= 0) {
                        throw new RuntimeException("订单明细插入失败");
                    }
                }
            }

            // 提交事务
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            orderId = 0; // 失败返回0
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }
    @Override
    public List<Order> listUserOrders(int userId) {
        List<Order> orders = orderDao.selectOrdersByUserId(userId);
        if (orders != null) {
            for (Order order : orders) {
                List<OrderItem> items = orderDao.selectOrderItemsByOrderId(order.getId());
                order.setItems(items);
            }
        }
        return orders;
    }

    @Override
    public Order getOrderById(int orderId) {
        Order order = orderDao.selectOrderById(orderId);
        if (order != null && order.getItems() == null) {
            List<OrderItem> items = orderDao.selectOrderItemsByOrderId(orderId);
            order.setItems(items);
        }
        return order;
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) {
        return orderDao.selectOrderItemsByOrderId(orderId);
    }

    @Override
    public boolean updateOrderStatus(int orderId, int status) {
        return orderDao.updateOrderStatus(orderId, status) > 0;
    }

    @Override
    public boolean payOrder(int orderId) {
        return orderDao.payOrder(orderId) > 0;
    }

    /**
     * 分页查询订单（后台用）
     */
    @Override
    public PageBean<Order> listOrders(Integer status, int currentPage, int pageSize) {
        // 1. 查询总记录数
        int totalCount = orderDao.selectOrderCount(status);
        // 2. 计算起始位置
        int start = (currentPage - 1) * pageSize;
        // 3. 查询当前页数据
        List<Order> orders = orderDao.selectOrderList(status, start, pageSize);
        // 4. 为每个订单填充商品明细（可选，视需求）
        if (orders != null) {
            for (Order order : orders) {
                List<OrderItem> items = orderDao.selectOrderItemsByOrderId(order.getId());
                order.setItems(items);
            }
        }
        // 5. 构造分页对象
        return new PageBean<>(currentPage, pageSize, totalCount, orders);
    }

    @Override
    public List<Order> listAllOrders(Integer status) {
        // 如果要全部列表，可以调用 selectOrderList 并传入足够大的 size
        int total = orderDao.selectOrderCount(status);
        List<Order> orders = orderDao.selectOrderList(status, 0, total);
        if (orders != null) {
            for (Order order : orders) {
                List<OrderItem> items = orderDao.selectOrderItemsByOrderId(order.getId());
                order.setItems(items);
            }
        }
        return orders;
    }
}