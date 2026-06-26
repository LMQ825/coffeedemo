<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  String type = request.getParameter("type");
  if(type == null) type = "";
%>
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
    .add-cart-btn {flex:1;padding:6px 0;background:#C9B48E;color:#fff;border:none;border-radius:12px;cursor:pointer;font-size:13px;}
    .btn-row {display:flex;gap:6px;margin-top:8px;}
    .buy-now-btn {flex:1;padding:6px 0;background:#fff;color:#C9B48E;border:1px solid #C9B48E;border-radius:12px;cursor:pointer;font-size:13px;}
    /* 底部导航 移除图标样式 */
    .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
    .nav-item {flex:1;text-align:center;font-size:14px;}
    .nav-item.active {color:#C9B48E;}
    /* Toast提示 */
    .toast {position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);background:rgba(0,0,0,0.75);color:#fff;padding:14px 28px;border-radius:10px;font-size:15px;z-index:9999;opacity:0;transition:opacity 0.3s;pointer-events:none;}
    .toast.show {opacity:1;}
    /* 购物车角标 */
    .cart-badge {position:fixed;top:12px;right:15px;background:#C9B48E;color:#fff;width:26px;height:26px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:bold;z-index:100;cursor:pointer;}
  </style>
</head>
<body>
<!-- 搜索框 -->
<div class="search-bar">
  <input class="search-input" placeholder="搜索拿铁、美式、蛋糕...">
  <span>🔍</span>
</div>

<!-- 购物车角标 -->
<div class="cart-badge" onclick="location.href='cart.jsp'" id="cartBadge">0</div>

<!-- 饮品列表 四列布局 -->
<div class="coffee-container">
  <%-- 全部 --%>
  <% if(type.equals("") || type.equals("意式咖啡")){ %>
  <div class="coffee-card">
    <div class="coffee-img"></div>
    <div class="coffee-info">
      <div class="coffee-name">经典拿铁</div>
      <div class="coffee-price">¥22</div>
      <div class="btn-row">
        <button class="buy-now-btn" onclick="location.href='checkout.jsp?cid=1'">直接购买</button>
        <button class="add-cart-btn" onclick="addToCart(1)">加购</button>
      </div>
    </div>
  </div>
  <div class="coffee-card">
    <div class="coffee-img">🥤</div>
    <div class="coffee-info">
      <div class="coffee-name">焦糖玛奇朵</div>
      <div class="coffee-price">¥24</div>
      <div class="btn-row">
        <button class="buy-now-btn" onclick="location.href='checkout.jsp?cid=2'">直接购买</button>
        <button class="add-cart-btn" onclick="addToCart(2)">加购</button>
      </div>
    </div>
  </div>
  <% } %>

  <% if(type.equals("") || type.equals("甜品小食")){ %>
  <div class="coffee-card">
    <div class="coffee-img">🍰</div>
    <div class="coffee-info">
      <div class="coffee-name">提拉米苏</div>
      <div class="coffee-price">¥18</div>
      <div class="btn-row">
        <button class="buy-now-btn" onclick="location.href='checkout.jsp?cid=3'">直接购买</button>
        <button class="add-cart-btn" onclick="addToCart(3)">加购</button>
      </div>
    </div>
  </div>
  <% } %>

  <% if(type.equals("") || type.equals("特调饮品")){ %>
  <div class="coffee-card">
    <div class="coffee-img"></div>
    <div class="coffee-info">
      <div class="coffee-name">荔枝气泡美式</div>
      <div class="coffee-price">¥26</div>
      <div class="btn-row">
        <button class="buy-now-btn" onclick="location.href='checkout.jsp?cid=4'">直接购买</button>
        <button class="add-cart-btn" onclick="addToCart(4)">加购</button>
      </div>
    </div>
  </div>
  <% } %>

  <%-- 冷萃/特色美式后续扩充商品直接加对应判断即可 --%>
</div>

<!-- 底部导航 移除图标span -->
<div class="footer-nav">
  <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
  <div class="nav-item active" onclick="location.href='coffeeList.jsp'">点单</div>
  <div class="nav-item" onclick="location.href='cart.jsp'">购物车</div>
  <div class="nav-item" onclick="location.href='myOrder.jsp'">订单</div>
  <div class="nav-item" onclick="location.href='personal.jsp'">我的</div>
</div>

<!-- Toast提示 -->
<div class="toast" id="toast"></div>

<script>
  // 加购函数 - AJAX调用，不跳转
  function addToCart(coffeeId) {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'CartAddServlet?coffeeId=' + coffeeId, true);
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xhr.onload = function() {
      if (xhr.status === 200) {
        try {
          var result = JSON.parse(xhr.responseText);
          if (result.success) {
            showToast('已加入购物车 🛒');
            // 更新购物车角标
            if (result.cartSize) {
              document.getElementById('cartBadge').textContent = result.cartSize;
            }
          }
        } catch(e) {
          showToast('加购成功 🛒');
        }
      } else {
        showToast('加购失败，请重试');
      }
    };
    xhr.onerror = function() {
      showToast('网络错误，请重试');
    };
    xhr.send();
  }

  // Toast提示函数
  function showToast(msg) {
    var toast = document.getElementById('toast');
    toast.textContent = msg;
    toast.classList.add('show');
    setTimeout(function() {
      toast.classList.remove('show');
    }, 1500);
  }
</script>
</body>
</html>
