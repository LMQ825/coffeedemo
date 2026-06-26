<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.coffee.entity.Order" %>
<%@ page import="com.example.coffee.entity.User" %>
<%@ page import="com.example.coffee.impl.OrderServiceImpl" %>
<%@ page import="java.util.List" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser != null) {
        List<Order> orders = new OrderServiceImpl().listUserOrders(loginUser.getId());
        request.setAttribute("orders", orders);
    }
    String msg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>我的订单 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:70px;}
        .page-title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .pay-success {background:#4CAF50;color:#fff;text-align:center;padding:10px;font-size:14px;}
        .order-container {padding:0 15px;}
        .order-card {background:#fff;border-radius:14px;padding:15px;border:1px solid #E9D9C2;margin-bottom:12px;}
        .order-top {display:flex;justify-content:space-between;margin-bottom:10px;}
        .order-no {font-size:13px;color:#947c64;}
        .order-status {font-weight:bold;font-size:14px;}
        .status-0 {color:#ff9800;}
        .status-1 {color:#4CAF50;}
        .status-2 {color:#947c64;}
        .status-3 {color:#ff6b6b;}
        .order-items {font-size:14px;line-height:1.6;color:#5C4836;background:#FFF9EF;border-radius:8px;padding:10px;margin:8px 0;}
        .item-line {display:flex;justify-content:space-between;padding:3px 0;}
        .item-name-qty {flex:1;}
        .item-price {color:#C9B48E;font-weight:bold;}
        .order-remark {font-size:13px;color:#947c64;margin-top:6px;padding:4px 8px;background:#FDF6EB;border-radius:6px;}
        .order-bottom {display:flex;justify-content:space-between;margin-top:12px;padding-top:10px;border-top:1px solid #E9D9C2;align-items:center;}
        .order-total {font-weight:bold;color:#C9B48E;font-size:16px;}
        .pay-btn {border:none;padding:6px 16px;border-radius:14px;font-size:13px;cursor:pointer;background:#C9B48E;color:#fff;}
        .detail-btn {border:1px solid #C9B48E;padding:6px 16px;border-radius:14px;font-size:13px;cursor:pointer;background:#fff;color:#5C4836;}
        .order-time {font-size:12px;color:#a8937b;margin-top:4px;}
        .empty-tip {text-align:center;margin-top:80px;color:#947c64;}
        .empty-tip a {color:#C9B48E;}
        .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
        .nav-item {flex:1;text-align:center;font-size:14px;cursor:pointer;}
        .nav-item.active {color:#C9B48E;}
    </style>
</head>
<body>
<div class="page-title">我的订单</div>

<% if ("paySuccess".equals(msg)) { %>
<div class="pay-success">✅ 支付成功！订单已提交，请等待取餐</div>
<% } %>

<c:choose>
    <c:when test="${empty orders}">
        <div class="empty-tip">
            <p style="font-size:40px;">📋</p>
            <p style="margin-top:10px;">暂无订单记录</p>
            <p style="margin-top:10px;"><a href="index.jsp">去点单 ></a></p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="order-container">
            <c:forEach items="${orders}" var="order">
                <div class="order-card">
                    <div class="order-top">
                        <span class="order-no">订单号：${order.orderNo}</span>
                        <span class="order-status status-${order.status}">${order.statusText}</span>
                    </div>

                    <div class="order-items">
                        <c:forEach items="${order.items}" var="item">
                            <div class="item-line">
                                <span class="item-name-qty">${item.productName} ×${item.quantity}</span>
                                <span class="item-price">¥<fmt:formatNumber value="${item.price * item.quantity}" pattern="#"/></span>
                            </div>
                        </c:forEach>
                        <c:if test="${not empty order.remark}">
                            <div class="order-remark">📌 ${order.remark}</div>
                        </c:if>
                    </div>

                    <div class="order-time">
                        下单时间：<fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                        <c:if test="${not empty order.payTime}">　|　支付时间：<fmt:formatDate value="${order.payTime}" pattern="yyyy-MM-dd HH:mm"/></c:if>
                    </div>
                    <div class="order-bottom">
                        <span class="order-total">¥<fmt:formatNumber value="${order.totalPrice}" pattern="#"/></span>
                        <div>
                            <c:if test="${order.status == 0}">
                                <button class="pay-btn" onclick="location.href='payment.jsp?orderId=${order.id}'">去支付</button>
                            </c:if>
                            <button class="detail-btn" onclick="location.href='orderDetail.jsp?orderId=${order.id}'">查看详情</button>
                            <c:if test="${order.status == 2}">
                                <button class="pay-btn" onclick="location.href='index.jsp'" style="background:#4CAF50;margin-left:5px;">再买一单</button>
                                <button class="detail-btn" onclick="alert('评价功能开发中')" style="margin-left:5px;">去评价</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<div class="footer-nav">
    <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
    <div class="nav-item" onclick="location.href='coffeeList.jsp'">点单</div>
    <div class="nav-item active" onclick="location.href='myOrder.jsp'">订单</div>
    <div class="nav-item" onclick="location.href='personal.jsp'">我的</div>
</div>

<script>
    let loginUser = ${sessionScope.loginUser != null ? 1 : 0};
    window.onload = function(){
        if(loginUser !== 1){
            alert("请先登录账号！");
            location.href = "login.jsp";
        }
    }
</script>
</body>
</html>