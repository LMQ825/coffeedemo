<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>购物车</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:100px;}
        .page-title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .cart-item {background:#fff;margin:10px 15px;border-radius:14px;padding:12px;display:flex;gap:12px;align-items:center;}
        .item-icon {width:60px;height:60px;background:#F7E9D6;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:30px;}
        .item-info {flex:1;}
        .item-name {font-weight:bold;margin-bottom:4px;}
        .item-price {color:#C9B48E;}
        .num-box {display:flex;gap:8px;align-items:center;}
        .num-btn {width:26px;height:26px;border-radius:50%;border:1px solid #C9B48E;background:#fff;cursor:pointer;}
        /* 底部结算栏 */
        .settle-bar {position:fixed;bottom:60px;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .total-text {font-size:15px;}
        .total-price {font-size:18px;color:#C9B48E;font-weight:bold;}
        .submit-btn {padding:10px 24px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;}
        /* 底部导航 */
        .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
        .nav-item {flex:1;text-align:center;font-size:12px;cursor:pointer;}
        .nav-icon {font-size:22px;margin-bottom:4px;display:block;}
        .nav-item.active {color:#C9B48E;}
    </style>
</head>
<body>
<div class="page-title">我的购物车</div>

<!-- 购物车商品 -->
<div class="cart-item">
    <div class="item-icon">☕</div>
    <div class="item-info">
        <div class="item-name">经典拿铁</div>
        <div class="item-price">¥22</div>
    </div>
    <div class="num-box">
        <button class="num-btn">-</button>
        <span>1</span>
        <button class="num-btn">+</button>
    </div>
</div>
<div class="cart-item">
    <div class="item-icon">🍰</div>
    <div class="item-info">
        <div class="item-name">提拉米苏</div>
        <div class="item-price">¥18</div>
    </div>
    <div class="num-box">
        <button class="num-btn">-</button>
        <span>2</span>
        <button class="num-btn">+</button>
    </div>
</div>

<!-- 底部结算栏 -->
<div class="settle-bar">
    <div class="total-text">合计：<span class="total-price">¥58</span></div>
    <button class="submit-btn" onclick="goPay()">去结算</button>
</div>

<!-- 底部导航 -->
<div class="footer-nav">
    <div class="nav-item" onclick="location.href='index.jsp'">
        <span class="nav-icon">🏠</span>首页
    </div>
    <div class="nav-item" onclick="location.href='coffeeList.jsp'">
        <span class="nav-icon">🍹</span>点单
    </div>
    <div class="nav-item" onclick="goOrder()">
        <span class="nav-icon">📋</span>订单
    </div>
    <div class="nav-item active" onclick="goPersonal()">
        <span class="nav-icon">🛒</span>购物车
    </div>
</div>

<script>
    let loginUser = ${sessionScope.loginUser != null ? 1 : 0};
    // 结算下单
    function goPay(){
        if(loginUser === 1){
            location.href = "orderSubmit.jsp";
        }else{
            alert("下单前需要登录账号！");
            location.href = "login.jsp";
        }
    }
    // 我的订单
    function goOrder(){
        if(loginUser === 1){
            location.href = "myOrder.jsp";
        }else{
            alert("请先登录！");
            location.href = "login.jsp";
        }
    }
    // 个人中心
    function goPersonal(){
        if(loginUser === 1){
            location.href = "personal.jsp";
        }else{
            location.href = "login.jsp";
        }
    }
</script>
</body>
</html>