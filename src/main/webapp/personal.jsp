<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>个人中心</title>
  <style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
    body {background:#FFF0DC;color:#5C4836;padding-bottom:70px;}
    /* 用户头部 */
    .user-header {background:#fff;padding:30px 20px;text-align:center;}
    .user-avatar {font-size:80px;margin-bottom:10px;}
    .user-name {font-size:22px;font-weight:bold;}
    /* 功能列表 */
    .func-list {margin:15px;}
    .func-item {background:#fff;border-radius:14px;padding:16px 20px;display:flex;justify-content:space-between;align-items:center;margin-bottom:10px;}
    .func-left {display:flex;gap:12px;align-items:center;}
    .func-icon {font-size:24px;}
    /* 底部导航 */
    .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
    .nav-item {flex:1;text-align:center;font-size:12px;}
    .nav-icon {font-size:22px;margin-bottom:4px;display:block;}
    .nav-item.active {color:#C9B48E;}
  </style>
</head>
<body>
<!-- 用户头部 -->
<div class="user-header">
  <div class="user-avatar">🐻</div>
  <div class="user-name">小熊顾客</div>
</div>

<!-- 功能菜单 -->
<div class="func-list">
  <div class="func-item" onclick="location.href='myCoupon.jsp'">
    <div class="func-left">
      <span class="func-icon">🎫</span>
      <span>我的优惠券</span>
    </div>
    <span>></span>
  </div>
  <div class="func-item">
    <div class="func-left">
      <span class="func-icon">💰</span>
      <span>储值中心</span>
    </div>
    <span>></span>
  </div>
  <div class="func-item">
    <div class="func-left">
      <span class="func-icon">📞</span>
      <span>修改手机号</span>
    </div>
    <span>></span>
  </div>
  <div class="func-item">
    <div class="func-left">
      <span class="func-icon">❓</span>
      <span>帮助中心</span>
    </div>
    <span>></span>
  </div>
  <div class="func-item" onclick="location.href='login.jsp'">
    <div class="func-left">
      <span class="func-icon">🚪</span>
      <span>退出登录</span>
    </div>
    <span>></span>
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
  <div class="nav-item" onclick="location.href='myOrder.jsp'">
    <span class="nav-icon">📋</span>订单
  </div>
  <div class="nav-item active" onclick="location.href='personal.jsp'">
    <span class="nav-icon">👤</span>我的
  </div>
</div>
</body>
</html>