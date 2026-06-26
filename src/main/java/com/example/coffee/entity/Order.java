package com.example.coffee.entity;

import java.util.Date;
import java.util.List;

public class Order {
    private Integer id;
    private String orderNo;
    private int userId;
    private double totalPrice;
    private Integer status;          // 0-待付款, 1-待取餐, 2-已完成, 3-已取消
    private String remark;
    private Date createTime;
    private Date payTime;

    // 订单关联的用户名（用于后台列表展示）
    private String username;

    // 订单商品明细列表（关键！）
    private List<OrderItem> items;

    public Order() {}

    // ====== Getter / Setter ======
    public Integer getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }

    public Integer getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public Integer getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }

    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public Date getPayTime() { return payTime; }
    public void setPayTime(Date payTime) { this.payTime = payTime; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    // 明细列表
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    // 状态文本
    public String getStatusText() {
        switch (status) {
            case 0: return "待付款";
            case 1: return "待取餐";
            case 2: return "已完成";
            case 3: return "已取消";
            default: return "未知";
        }
    }
}