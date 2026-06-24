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
    /* 分类标签 */
    .cate-wrap {display:flex;gap:10px;padding:12px 15px;overflow-x:auto;background:#fff;margin-bottom:10px;}
    .cate-item {white-space:nowrap;padding:6px 16px;border-radius:16px;border:1px solid #C9B48E;font-size:14px;}
    .cate-item.active {background:#C9B48E;color:#fff;border:none;}
    /* 饮品卡片容器 */
    .coffee-container {padding:0 15px;display:grid;grid-template-columns:1fr 1fr;gap:12px;}
    .coffee-card {background:#fff;border-radius:14px;overflow:hidden;border:1px solid #E9D9C2;}
    .coffee-img {height:130px;background:#F7E9D6;display:flex;align-items:center;justify-content:center;font-size:50px;}
    .coffee-info {padding:10px;}
    .coffee-name {font-weight:bold;font-size:15px;margin-bottom:4px;}
    .coffee-price {color:#C9B48E;font-weight:bold;}
    .add-cart-btn {width:100%;margin-top:8px;padding:6px 0;background:#C9B48E;color:#fff;border:none;border-radius:12px;cursor:pointer;}
    /* 底部导航 */
    .footer-nav {position:fixed;bottom:0;left:0;width:100%;max-width:480px;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
    .nav-item {flex:1;text-align:center;font-size:12px;}
    .nav-icon {font-size:22px;margin-bottom:4px;display:block;}
    .nav-item.active {color:#C9B48E;}
  </style>
</head>
<body>
<!-- 搜索框 -->
<div class="search-bar">
  <input class="search-input" placeholder="搜索拿铁、美式、蛋糕...">
  <span>🔍</span>
</div>

<!-- 饮品分类 -->
<div class="cate-wrap">
  <div class="cate-item active">全部饮品</div>
  <div class="cate-item">拿铁系列</div>
  <div class="cate-item">美式黑咖</div>
  <div class="cate-item">气泡特调</div>
  <div class="cate-item">甜品蛋糕</div>
</div>

<!-- 饮品列表 -->
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

<!-- 底部导航 -->
<div class="footer-nav">
  <div class="nav-item" onclick="location.href='index.jsp'">
    <span class="nav-icon">🏠</span>首页
  </div>
  <div class="nav-item active" onclick="location.href='coffeeList.jsp'">
    <span class="nav-icon">🍹</span>点单
  </div>
  <div class="nav-item" onclick="location.href='myOrder.jsp'">
    <span class="nav-icon">📋</span>订单
  </div>
  <div class="nav-item" onclick="location.href='personal.jsp'">
    <span class="nav-icon">👤</span>我的
  </div>
</div>
</body>
</html>
