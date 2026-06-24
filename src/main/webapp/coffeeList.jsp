<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>点单 - 咩嘢熊仔咖啡</title>
  <style>
    * {margin: 0;padding: 0;box-sizing: border-box;font-family: "微软雅黑";}
    body {background: #FFF0DC;color: #5C4836;padding-bottom: 70px;}
    /* 顶部搜索栏 */
    .search-bar {padding:15px;background:#fff;display:flex;gap:10px;align-items:center;}
    .search-input {flex:1;padding:10px 14px;border:1px solid #E0CDB4;border-radius:20px;outline:none;background:#FFF9EF;}
    /* 饮品卡片容器 改为4列 */
    .coffee-container {padding:0 15px;display:grid;grid-template-columns:repeat(4,1fr);gap:12px;}
    .coffee-card {background:#fff;border-radius:14px;overflow:hidden;border:1px solid #E9D9C2;}
    .coffee-img {height:130px;background:#F7E9D6;display:flex;align-items:center;justify-content:center;font-size:50px;}
    .coffee-info {padding:10px;}
    .coffee-name {font-weight:bold;font-size:15px;margin-bottom:4px;}
    .coffee-price {color:#C9B48E;font-weight:bold;}
    .add-cart-btn {width:100%;margin-top:8px;padding:6px 0;background:#C9B48E;color:#fff;border:none;border-radius:12px;cursor:pointer;}
    /* 底部导航 移除图标样式 */
    .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
    .nav-item {flex:1;text-align:center;font-size:14px;}
    .nav-item.active {color:#C9B48E;}
  </style>
</head>
<body>
<!-- 搜索框 -->
<div class="search-bar">
  <input class="search-input" placeholder="搜索拿铁、美式、蛋糕...">
  <span>🔍</span>
</div>

<!-- 已删除分类标签区域 -->

<!-- 饮品列表 四列布局 -->
<div class="coffee-container">
  <div class="coffee-card">
    <div class="coffee-img">☕</div>
    <div class="coffee-info">
      <div class="coffee-name">经典拿铁</div>
      <div class="coffee-price">¥22</div>
      <button class="add-cart-btn" onclick="location.href='cartAddServlet?coffeeId=1'">加入购物车</button>
    </div>
  </div>
  <div class="coffee-card">
    <div class="coffee-img">🥤</div>
    <div class="coffee-info">
      <div class="coffee-name">焦糖玛奇朵</div>
      <div class="coffee-price">¥24</div>
      <button class="add-cart-btn" onclick="location.href='cartAddServlet?coffeeId=2'">加入购物车</button>
    </div>
  </div>
  <div class="coffee-card">
    <div class="coffee-img">🍰</div>
    <div class="coffee-info">
      <div class="coffee-name">提拉米苏</div>
      <div class="coffee-price">¥18</div>
      <button class="add-cart-btn" onclick="location.href='cartAddServlet?coffeeId=3'">加入购物车</button>
    </div>
  </div>
  <div class="coffee-card">
    <div class="coffee-img">🫧</div>
    <div class="coffee-info">
      <div class="coffee-name">荔枝气泡美式</div>
      <div class="coffee-price">¥26</div>
      <button class="add-cart-btn" onclick="location.href='cartAddServlet?coffeeId=4'">加入购物车</button>
    </div>
  </div>
</div>

<!-- 底部导航 移除图标span -->
<div class="footer-nav">
  <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
  <div class="nav-item active" onclick="location.href='coffeeList.jsp'">点单</div>
  <div class="nav-item" onclick="location.href='myOrder.jsp'">订单</div>
  <div class="nav-item" onclick="location.href='personal.jsp'">我的</div>
</div>
</body>
</html>