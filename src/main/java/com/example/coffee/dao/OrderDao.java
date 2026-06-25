package com.example.coffee.dao;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;

import java.util.Date;
import java.util.List;
import java.util.Map;

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
    // 新增订单主表，返回自增主键 id
    int insertOrder(Order order);
    // 新增订单明细
    int insertOrderItem(OrderItem item);
    // 根据用户ID查询其订单（按时间倒序）
    List<Order> selectOrdersByUserId(int userId);
    // 订单支付：状态置为待取餐(1)并记录支付时间
    int payOrder(int orderId);
    
    // ========== 统计相关方法 ==========
    // 查询今日销售额
    Double selectTodaySales();
    // 查询今日订单数
    int selectTodayOrderCount();
    // 查询某时间段内的销售额
    Double selectSalesByDateRange(Date startDate, Date endDate);
    // 查询待处理订单数
    int selectPendingOrderCount();
    // 查询销量排行榜（返回商品名称和销量）
    List<Map<String, Object>> selectTopSellingProducts(int limit);
    // 查询订单状态分布（返回状态和数量）
    List<Map<String, Object>> selectOrderStatusDistribution();
    // 查询最近7天每日销售额
    List<Map<String, Object>> selectDailySalesLast7Days();
    // 查询分类销售占比
    List<Map<String, Object>> selectCategorySalesDistribution();
}