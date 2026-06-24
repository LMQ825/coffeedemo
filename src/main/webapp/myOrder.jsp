<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>我的订单</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:70px;}
        .page-title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .order-card {background:#fff;margin:10px 15px;border-radius:14px;padding:15px;}
        .order-top {display:flex;justify-content:space-between;margin-bottom:10px;}
        .order-status {color:#C9B48E;font-weight:bold;}
        .order-item {display:flex;gap:10px;align-items:center;margin:8px 0;}
        .order-icon {width:40px;height:40px;background:#F7E9D6;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:20px;}
        .order-bottom {display:flex;justify-content:space-between;margin-top:12px;padding-top:10px;border-top:1px solid #E9D9C2;}
        .detail-btn {border:1px solid #C9B48E;padding:4px 12px;border-radius:14px;font-size:13px;cursor:pointer;}
        /* 底部导航 */
        .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
        .nav-item {flex:1;text-align:center;font-size:12px;}
        .nav-icon {font-size:22px;margin-bottom:4px;display:block;}
        .nav-item.active {color:#C9B48E;}
    </style>
</head>
<body>
<div class="page-title">我的订单</div>

<!-- 订单卡片 -->
<div class="order-card">
    <div class="order-top">
        <span>订单号：202606241001</span>
        <span class="order-status">待取餐</span>
    </div>
    <div class="order-item">
        <div class="order-icon">☕</div>
        <span>经典拿铁 ×1</span>
    </div>
    <div class="order-item">
        <div class="order-icon">🍰</div>
        <span>提拉米苏 ×2</span>
    </div>
    <div class="order-bottom">
        <span>实付 ¥53</span>
        <button class="detail-btn" onclick="location.href='orderDetail.jsp'">查看详情</button>
    </div>
</div>

<div class="order-card">
    <div class="order-top">
        <span>订单号：202606231805</span>
        <span class="order-status">已完成</span>
    </div>
    <div class="order-item">
        <div class="order-icon">🫧</div>
        <span>荔枝气泡美式 ×1</span>
    </div>
    <div class="order-bottom">
        <span>实付 ¥26</span>
        <button class="detail-btn">查看详情</button>
    </div>
</div>

<!-- 底部导航 -->
<div class="footer-nav">
    <div class="nav-item" onclick="location.href='index.jsp'">
        <span class="nav-icon">🏠</span>首页
    </div>
    <div class="nav-item" onclick="location.href='coffeeList.jsp'">
        <span class="nav-icon">🍹</span>点单
    </div>
    <div class="nav-item active" onclick="location.href='myOrder.jsp'">
        <span class="nav-icon">📋</span>订单
    </div>
    <div class="nav-item" onclick="location.href='personal.jsp'">
        <span class="nav-icon">👤</span>我的
    </div>
</div>
</body>
</html>