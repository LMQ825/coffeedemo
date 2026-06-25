<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>咩嘢熊仔 · 管理后台</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {display:flex;min-height:100vh;background:#f5ede4;}
        .sidebar {width:220px;background:#5C4836;color:#fff;padding:20px 0;height:100vh;position:sticky;top:0;}
        .logo {text-align:center;padding:0 20px 30px;border-bottom:1px solid #7D664F;}
        .logo h2 {font-size:20px;letter-spacing:2px;}
        .logo small {font-size:12px;color:#C9B48E;}
        .nav {padding:20px 10px;}
        .nav a {display:block;padding:12px 18px;color:#E9D9C2;text-decoration:none;border-radius:8px;margin-bottom:4px;transition:0.2s;}
        .nav a:hover,.nav a.active {background:#7D664F;color:#fff;}
        .main {flex:1;padding:30px;}
        .main .header {display:flex;justify-content:space-between;align-items:center;margin-bottom:25px;}
        .main .header h3 {color:#5C4836;}
        .main .header .admin-info {font-size:14px;color:#7D664F;}
        .content {background:#fff;border-radius:12px;padding:25px;border:1px solid #E9D9C2;}
        .stats {display:grid;grid-template-columns:repeat(4,1fr);gap:15px;margin-bottom:25px;}
        .stat-card {background:#FFF9EF;padding:20px;border-radius:12px;text-align:center;border:1px solid #E9D9C2;transition:0.2s;}
        .stat-card:hover {transform:translateY(-3px);border-color:#C9B48E;}
        .stat-card .icon {font-size:32px;margin-bottom:8px;}
        .stat-card .num {font-size:28px;font-weight:bold;color:#5C4836;}
        .stat-card .label {font-size:14px;color:#a8937b;margin-top:4px;}
        .stat-card.highlight {background:#5C4836;color:#fff;}
        .stat-card.highlight .num,.stat-card.highlight .label,.stat-card.highlight .icon {color:#fff;}
        
        .quick-links {display:grid;grid-template-columns:repeat(3,1fr);gap:15px;margin-top:20px;}
        .quick-link {display:flex;align-items:center;padding:15px;background:#FFF9EF;border-radius:8px;border:1px solid #E9D9C2;transition:0.2s;text-decoration:none;color:#5C4836;}
        .quick-link:hover {background:#F7E9D6;border-color:#C9B48E;}
        .quick-link .icon {font-size:24px;margin-right:12px;}
        .quick-link .text {font-size:14px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo">
        <h2>🐻 咩嘢熊仔</h2>
        <small>管理后台</small>
    </div>
    <div class="nav">
        <a class="active" href="${pageContext.request.contextPath}/admin/DashboardServlet">📊 仪表盘</a>
        <a href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
        <a href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
        <a href="${pageContext.request.contextPath}/admin/CategoryListServlet">🏷️ 分类管理</a>
        <a href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
    <a href="${pageContext.request.contextPath}/admin/InventoryListServlet">📦 库存管理</a>
    <a href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet">📋 进货记录</a>
        <a href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
</div>
<div class="main">
    <div class="header">
        <h3>📊 数据概览</h3>
        <span class="admin-info">管理员：${sessionScope.adminUser.nickname} (${sessionScope.adminUser.username})</span>
    </div>
    <div class="content">
        <div class="stats">
            <div class="stat-card highlight">
                <div class="icon">💰</div>
                <div class="num"><fmt:formatNumber value="${todaySales}" type="currency" currencySymbol="¥"/></div>
                <div class="label">今日销售额</div>
            </div>
            <div class="stat-card">
                <div class="icon">📦</div>
                <div class="num">${todayOrders}</div>
                <div class="label">今日订单</div>
            </div>
            <div class="stat-card">
                <div class="icon">⏳</div>
                <div class="num">${pendingOrders}</div>
                <div class="label">待处理订单</div>
            </div>
            <div class="stat-card">
                <div class="icon">☕</div>
                <div class="num">${totalProducts}</div>
                <div class="label">饮品总数</div>
            </div>
        </div>
        
        <div class="stats" style="grid-template-columns:repeat(2,1fr);">
            <div class="stat-card">
                <div class="icon">👤</div>
                <div class="num">${totalUsers}</div>
                <div class="label">注册用户</div>
            </div>
            <div class="stat-card">
                <div class="icon">🏷️</div>
                <div class="num">${totalCategories}</div>
                <div class="label">分类总数</div>
            </div>
        </div>
        
        <p style="color:#a8937b;font-size:14px;margin-top:20px;">💡 欢迎回来，后台管理功能已准备就绪。</p>
        <p style="color:#a8937b;font-size:14px;margin-top:8px;">点击左侧菜单或下方快捷入口开始管理。</p>
        
        <div class="quick-links">
            <a class="quick-link" href="${pageContext.request.contextPath}/admin/OrderListServlet">
                <span class="icon">📋</span>
                <span class="text">查看订单</span>
            </a>
            <a class="quick-link" href="${pageContext.request.contextPath}/admin/ProductListServlet">
                <span class="icon">☕</span>
                <span class="text">管理饮品</span>
            </a>
            <a class="quick-link" href="${pageContext.request.contextPath}/admin/StatisticsServlet">
                <span class="icon">📈</span>
                <span class="text">销售统计</span>
            </a>
        </div>
    </div>
</div>
</body>
</html>