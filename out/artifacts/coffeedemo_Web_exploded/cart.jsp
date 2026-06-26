<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.coffee.entity.CartItem" %>
<%@ page import="java.util.List" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double total = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
    }
    request.setAttribute("cartTotal", total);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>购物车 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:130px;}
        .page-title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .cart-item {background:#fff;margin:10px 15px;border-radius:14px;padding:12px;display:flex;gap:12px;align-items:center;}
        .item-icon {width:60px;height:60px;background:#F7E9D6;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:30px;flex-shrink:0;}
        .item-info {flex:1;}
        .item-name {font-weight:bold;margin-bottom:4px;}
        .item-price {color:#C9B48E;}
        .num-box {display:flex;gap:8px;align-items:center;}
        .num-btn {width:28px;height:28px;border-radius:50%;border:1px solid #C9B48E;background:#fff;cursor:pointer;font-size:15px;line-height:26px;text-align:center;}
        .count {min-width:24px;text-align:center;font-weight:bold;}
        .del-btn {color:#ff6b6b;font-size:13px;cursor:pointer;margin-left:8px;}
        .settle-bar {position:fixed;bottom:60px;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .total-text {font-size:15px;}
        .total-price {font-size:18px;color:#C9B48E;font-weight:bold;}
        .submit-btn {padding:10px 24px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;font-size:15px;}
        .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
        .nav-item {flex:1;text-align:center;font-size:14px;cursor:pointer;}
        .nav-item.active {color:#C9B48E;}
        .empty-cart {text-align:center;margin-top:80px;color:#947c64;}
        .empty-cart a {color:#C9B48E;text-decoration:none;}
    </style>
</head>
<body>
<div class="page-title">我的购物车</div>

<c:choose>
    <c:when test="${empty cart || cartTotal == 0}">
        <div class="empty-cart">
            <p style="font-size:50px;">🛒</p>
            <p style="margin-top:15px;">购物车还是空的，去点单看看吧～</p>
            <p style="margin-top:15px;"><a href="coffeeList.jsp">去点单 ></a></p>
        </div>
    </c:when>
    <c:otherwise>
        <c:forEach items="${cart}" var="item" varStatus="vs">
            <div class="cart-item">
                <div class="item-icon">${item.icon}</div>
                <div class="item-info">
                    <div class="item-name">${item.name}</div>
                    <div class="item-price">¥<fmt:formatNumber value="${item.price}" pattern="#"/></div>
                </div>
                <div class="num-box">
                    <button class="num-btn" onclick="location.href='CartUpdateServlet?index=${vs.index}&op=dec'">-</button>
                    <span class="count">${item.quantity}</span>
                    <button class="num-btn" onclick="location.href='CartUpdateServlet?index=${vs.index}&op=inc'">+</button>
                    <span class="del-btn" onclick="if(confirm('确定删除该商品？'))location.href='CartUpdateServlet?index=${vs.index}&op=del'">删除</span>
                </div>
            </div>
        </c:forEach>

        <div class="settle-bar">
            <div class="total-text">合计：<span class="total-price">¥<fmt:formatNumber value="${cartTotal}" pattern="#"/></span></div>
            <button class="submit-btn" onclick="goPay()">结算</button>
        </div>
    </c:otherwise>
</c:choose>

<div class="footer-nav">
    <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
    <div class="nav-item" onclick="location.href='coffeeList.jsp'">点单</div>
    <div class="nav-item active" onclick="location.href='cart.jsp'">购物车</div>
    <div class="nav-item" onclick="location.href='myOrder.jsp'">订单</div>
    <div class="nav-item" onclick="location.href='personal.jsp'">我的</div>
</div>

<script>
    let loginUser = ${sessionScope.loginUser != null ? 1 : 0};
    function goPay(){
        if(loginUser !== 1){
            alert("下单前需要登录账号！");
            location.href = "login.jsp";
            return;
        }
        // 提交订单到服务器
        location.href = "${pageContext.request.contextPath}/OrderSubmitServlet?mode=cart";
    }
</script>
</body>
</html>
