<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.coffee.entity.Order" %>
<%@ page import="com.example.coffee.entity.OrderItem" %>
<%@ page import="com.example.coffee.entity.User" %>
<%@ page import="com.example.coffee.impl.OrderServiceImpl" %>
<%@ page import="java.util.List" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int orderId = 0;
    try {
        orderId = Integer.parseInt(request.getParameter("orderId"));
    } catch (Exception e) {
        response.sendRedirect("myOrder.jsp");
        return;
    }

    Order order = new OrderServiceImpl().getOrderById(orderId);
    if (order == null || order.getUserId() != loginUser.getId()) {
        response.sendRedirect("myOrder.jsp");
        return;
    }

    List<OrderItem> orderItems = new OrderServiceImpl().getOrderItems(orderId);
    request.setAttribute("order", order);
    request.setAttribute("orderItems", orderItems);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>订单详情 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:70px;}
        .page-header {background:#fff;padding:15px;display:flex;align-items:center;gap:10px;border-bottom:1px solid #E9D9C2;}
        .back-btn {font-size:20px;cursor:pointer;}
        .page-title {font-size:18px;font-weight:bold;}
        .section {background:#fff;margin:12px 15px;border-radius:14px;padding:15px;}
        .section-title {font-weight:bold;font-size:16px;margin-bottom:12px;padding-bottom:8px;border-bottom:1px solid #E9D9C2;}
        .order-status-box {text-align:center;padding:20px 0;}
        .status-icon {font-size:48px;margin-bottom:10px;}
        .status-text {font-size:20px;font-weight:bold;color:#C9B48E;}
        .order-info-row {display:flex;justify-content:space-between;padding:10px 0;font-size:14px;}
        .order-info-row:not(:last-child) {border-bottom:1px solid #F0E6D8;}
        .info-label {color:#947c64;}
        .info-value {font-weight:500;}
        .order-item-row {display:flex;gap:12px;padding:12px 0;border-bottom:1px solid #F0E6D8;}
        .order-item-row:last-child {border-bottom:none;}
        .item-icon {width:50px;height:50px;background:#F7E9D6;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:24px;}
        .item-info {flex:1;}
        .item-name {font-weight:bold;margin-bottom:4px;}
        .item-spec {font-size:12px;color:#a8937b;}
        .item-price {color:#C9B48E;font-weight:bold;margin-top:4px;}
        .price-row {display:flex;justify-content:space-between;padding:8px 0;font-size:14px;}
        .price-label {color:#947c64;}
        .price-value {font-weight:500;}
        .price-total {font-size:16px;font-weight:bold;color:#C9B48E;}
        .action-btns {display:flex;gap:10px;margin-top:15px;}
        .action-btn {flex:1;padding:12px;border-radius:12px;border:none;font-size:15px;cursor:pointer;}
        .btn-primary {background:#5C4836;color:#fff;}
        .btn-primary:hover {background:#4a3728;}
        .btn-secondary {background:#fff;color:#5C4836;border:1.5px solid #C9B48E;}
        .btn-secondary:hover {background:#F7E9D6;}
        .btn-success {background:#4CAF50;color:#fff;}
        .btn-success:hover {background:#45a049;}
        .contact-box {background:#FFF9EF;border-radius:10px;padding:12px;margin-top:10px;}
        .contact-row {display:flex;align-items:center;gap:10px;padding:8px 0;}
        .contact-icon {font-size:20px;}
        .contact-text {flex:1;}
        .contact-btn {padding:6px 16px;background:#C9B48E;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:13px;}
        .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
        .nav-item {flex:1;text-align:center;font-size:14px;cursor:pointer;}
        .nav-item.active {color:#C9B48E;}
    </style>
</head>
<body>
<div class="page-header">
    <span class="back-btn" onclick="history.back()">←</span>
    <span class="page-title">订单详情</span>
</div>

<!-- 订单状态 -->
<div class="section">
    <div class="order-status-box">
        <div class="status-icon">
            <c:choose>
                <c:when test="${order.status == 0}">⏳</c:when>
                <c:when test="${order.status == 1}">🚚</c:when>
                <c:when test="${order.status == 2}">✅</c:when>
                <c:when test="${order.status == 3}">❌</c:when>
            </c:choose>
        </div>
        <div class="status-text">${order.statusText}</div>
    </div>
</div>

<!-- 订单信息 -->
<div class="section">
    <div class="section-title">订单信息</div>
    <div class="order-info-row">
        <span class="info-label">订单号</span>
        <span class="info-value">${order.orderNo}</span>
    </div>
    <div class="order-info-row">
        <span class="info-label">下单时间</span>
        <span class="info-value">
            <fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
        </span>
    </div>
    <div class="order-info-row">
        <span class="info-label">收货地址</span>
        <span class="info-value">${order.address}</span>
    </div>
    <div class="order-info-row">
        <span class="info-label">联系电话</span>
        <span class="info-value">${order.phone}</span>
    </div>
    <c:if test="${not empty order.remark}">
        <div class="order-info-row">
            <span class="info-label">备注</span>
            <span class="info-value">${order.remark}</span>
        </div>
    </c:if>
</div>

<!-- 商品列表 -->
<div class="section">
    <div class="section-title">商品清单</div>
    <c:forEach items="${orderItems}" var="item">
        <div class="order-item-row">
            <div class="item-icon">☕</div>
            <div class="item-info">
                <div class="item-name">${item.productName}</div>
                <div class="item-spec">${item.spec}</div>
                <div class="item-price">¥<fmt:formatNumber value="${item.price}" pattern="#"/> × ${item.quantity}</div>
            </div>
        </div>
    </c:forEach>
</div>

<!-- 价格明细 -->
<div class="section">
    <div class="section-title">价格明细</div>
    <div class="price-row">
        <span class="price-label">商品总价</span>
        <span class="price-value">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#"/></span>
    </div>
    <div class="price-row">
        <span class="price-label">红包抵用</span>
        <span class="price-value" style="color:#ff6b6b;">-¥<fmt:formatNumber value="${order.couponDiscount}" pattern="#"/></span>
    </div>
    <div class="price-row" style="border-top:1px solid #E9D9C2;padding-top:12px;margin-top:8px;">
        <span class="price-label" style="font-weight:bold;">实际付款</span>
        <span class="price-total">¥<fmt:formatNumber value="${order.actualPrice}" pattern="#"/></span>
    </div>
    <div style="font-size:12px;color:#a8937b;margin-top:8px;text-align:right;">
        (总价 ¥<fmt:formatNumber value="${order.totalPrice}" pattern="#"/> = 实际付款 ¥<fmt:formatNumber value="${order.actualPrice}" pattern="#"/> + 红包抵用 ¥<fmt:formatNumber value="${order.couponDiscount}" pattern="#"/>)
    </div>
</div>

<!-- 联系商家 -->
<div class="section">
    <div class="section-title">联系商家</div>
    <div class="contact-box">
        <div class="contact-row">
            <span class="contact-icon">📞</span>
            <span class="contact-text">电话联系商家</span>
            <button class="contact-btn" onclick="window.location.href='tel:400-123-4567'">拨打电话</button>
        </div>
        <div class="contact-row">
            <span class="contact-icon">💬</span>
            <span class="contact-text">在线客服</span>
            <button class="contact-btn" onclick="alert('客服功能开发中')">发消息</button>
        </div>
    </div>
</div>

<!-- 操作按钮（根据订单状态动态显示） -->
<div class="section">
    <div class="action-btns">
        <button class="action-btn btn-secondary" onclick="reorder()">🛒 再买一单</button>

        <!-- 待付款：显示去支付 -->
        <c:if test="${order.status == 0}">
            <button class="action-btn btn-primary" onclick="location.href='payment.jsp?orderId=${order.id}'">💳 去支付</button>
        </c:if>

        <!-- 已付款（待取餐/已完成）：显示评价订单 -->
        <c:if test="${order.status == 1 || order.status == 2}">
            <button class="action-btn btn-success" onclick="review()">⭐ 评价订单</button>
        </c:if>
    </div>
</div>

<!-- 底部导航 -->
<div class="footer-nav">
    <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
    <div class="nav-item" onclick="location.href='index.jsp'">点单</div>
    <div class="nav-item" onclick="location.href='myOrder.jsp'">订单</div>
    <div class="nav-item active" onclick="location.href='personal.jsp'">我的</div>
</div>

<script>
    // 再买一单 - 跳转到点单页面
    function reorder() {
        window.location.href = '${pageContext.request.contextPath}/index.jsp';
    }

    // 去评价
    function review() {
        alert('评价功能开发中,感谢您的支持!');
        // TODO: 跳转到评价页面
    }
</script>
</body>
</html>