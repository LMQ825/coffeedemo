package com.example.coffee.dao;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import java.util.List;
import java.util.Map;

public interface OrderDao {
    // ---- 订单主表操作 ----
    int insertOrder(Order order);
    Order selectOrderById(int id);
    List<Order> selectOrdersByUserId(int userId);
    List<Order> selectOrderList(Integer status, int start, int pageSize);
    int selectOrderCount(Integer status);
    int updateOrderStatus(int orderId, int status);
    int payOrder(int orderId);

    // ---- 订单明细操作 ----
    int insertOrderItem(OrderItem item);
    List<OrderItem> selectOrderItemsByOrderId(int orderId);

    // ===== 新增：仪表盘统计方法 =====
    /**
     * 查询今日销售额（已支付订单）
     */
    Double selectTodaySales();

    /**
     * 查询今日订单数
     */
    int selectTodayOrderCount();

    /**
     * 查询待处理订单数（待付款 + 待取餐）
     */
    int selectPendingOrderCount();
    // ===== 统计分析方法 =====
    /**
     * 查询销量前 N 的商品（按销量降序）
     */
    List<Map<String, Object>> selectTopSellingProducts(int limit);

    /**
     * 查询订单状态分布（各状态数量）
     */
    List<Map<String, Object>> selectOrderStatusDistribution();

    /**
     * 查询最近7天每日销售额（按日期分组）
     */
    List<Map<String, Object>> selectDailySalesLast7Days();

    /**
     * 查询分类销售占比（按分类汇总销售额）
     */
    List<Map<String, Object>> selectCategorySalesDistribution();
}