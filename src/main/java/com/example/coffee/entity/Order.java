package com.example.coffee.entity;

import java.util.Date;
import java.util.List;

public class Order {
    private Integer id;
    private String orderNo;
    private Integer userId;
    private Double totalPrice;
    private Integer status;  // 0待付款 1待取餐 2已完成 3已取消
    private Date createTime;
    private Date payTime;
    private String remark;

    // 关联字段（用于页面展示，非数据库字段）
    private String username;  // 下单用户名称

    // 关联的订单明细（用于详情展示）
    private List<OrderItem> items;

    public Order() {}

    // ---- getter / setter ----
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getOrderNo() { return orderNo; }
    public void setOrderNo(String orderNo) { this.orderNo = orderNo; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(Double totalPrice) { this.totalPrice = totalPrice; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    public Date getPayTime() { return payTime; }
    public void setPayTime(Date payTime) { this.payTime = payTime; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }

    // 状态转文字（方便JSP显示）
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