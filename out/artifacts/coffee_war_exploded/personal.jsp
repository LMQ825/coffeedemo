<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.coffee.entity.User" %>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    request.setAttribute("loginUser", loginUser);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
  <title>个人中心</title>
  <style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
    body {background:#FFF0DC;color:#5C4836;padding-bottom:70px;}
    /* 用户头部 */
    .user-header {background:#fff;padding:30px 20px;text-align:center;margin:0 15px;border-radius:14px;margin-top:10px;}
    .user-avatar {font-size:80px;margin-bottom:10px;}
    .user-name {font-size:22px;font-weight:bold;}
    /* 功能列表 双栏网格 */
    .func-wrap {padding:15px;display:grid;grid-template-columns:repeat(2,1fr);gap:12px;}
    .func-item {background:#fff;border-radius:14px;padding:20px 15px;display:flex;flex-direction:column;align-items:center;gap:8px;border:1px solid #E9D9C2;cursor:pointer;}
    .func-icon {font-size:32px;}
    .func-text {font-size:15px;}
    /* 底部导航 无图标 */
    .footer-nav {position:fixed;bottom:0;left:0;width:100%;background:#fff;display:flex;padding:8px 0;border-top:1px solid #E9D9C2;}
    .nav-item {flex:1;text-align:center;font-size:14px;}
    .nav-item.active {color:#C9B48E;}
  </style>
</head>
<body>
<!-- 用户头部 -->
<div class="user-header">
  <div class="user-avatar">🐻</div>
  <div class="user-name">${loginUser.username}</div>
</div>

<!-- 双栏功能菜单 -->
<div class="func-wrap">
  <div class="func-item" onclick="location.href='myCoupon.jsp'">
    <span class="func-icon">🎫</span>
    <span class="func-text">我的优惠券</span>
  </div>
  <div class="func-item">
    <span class="func-icon">💰</span>
    <span class="func-text">储值中心</span>
  </div>
  <div class="func-item">
    <span class="func-icon">📞</span>
    <span class="func-text">修改手机号</span>
  </div>
  <div class="func-item">
    <span class="func-icon">❓</span>
    <span class="func-text">帮助中心</span>
  </div>
  <div class="func-item" onclick="location.href='UserLogoutServlet'">
    <span class="func-icon">🚪</span>
    <span class="func-text">退出登录</span>
  </div>
</div>

<!-- 底部导航 -->
<div class="footer-nav">
  <div class="nav-item" onclick="location.href='index.jsp'">首页</div>
  <div class="nav-item" onclick="location.href='index.jsp'">点单</div>
  <div class="nav-item active" onclick="location.href='personal.jsp'">我的</div>
</div>
</body>
</html>