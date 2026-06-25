<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>销售统计 - 咩嘢熊仔后台</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {display:flex;min-height:100vh;background:#f5ede4;}
        .sidebar {width:220px;background:#5C4836;color:#fff;padding:20px 0;height:100vh;position:sticky;top:0;}
        .logo {text-align:center;padding:0 20px 30px;border-bottom:1px solid #7D664F;}
        .logo h2 {font-size:20px;}
        .nav {padding:20px 10px;}
        .nav a {display:block;padding:12px 18px;color:#E9D9C2;text-decoration:none;border-radius:8px;margin-bottom:4px;transition:0.2s;}
        .nav a:hover,.nav a.active {background:#7D664F;color:#fff;}
        .main {flex:1;padding:30px;overflow-y:auto;}
        .header {display:flex;justify-content:space-between;align-items:center;margin-bottom:25px;}
        .header h3 {color:#5C4836;}
        .content {background:#fff;border-radius:12px;padding:25px;border:1px solid #E9D9C2;}
        
        /* 统计卡片 */
        .stats-grid {display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:25px;}
        .stat-card {background:#FFF9EF;padding:20px;border-radius:12px;text-align:center;border:1px solid #E9D9C2;transition:0.2s;}
        .stat-card:hover {border-color:#C9B48E;transform:translateY(-2px);}
        .stat-card .icon {font-size:32px;margin-bottom:10px;}
        .stat-card .num {font-size:28px;font-weight:bold;color:#5C4836;}
        .stat-card .label {font-size:14px;color:#a8937b;margin-top:4px;}
        .stat-card.highlight {background:#5C4836;color:#fff;}
        .stat-card.highlight .num,.stat-card.highlight .label,.stat-card.highlight .icon {color:#fff;}
        
        /* 图表区域 */
        .charts-section {display:grid;grid-template-columns:repeat(2,1fr);gap:20px;margin-bottom:25px;}
        .chart-box {background:#fff;border-radius:12px;padding:20px;border:1px solid #E9D9C2;}
        .chart-title {color:#5C4836;font-size:16px;margin-bottom:15px;padding-bottom:10px;border-bottom:1px solid #E9D9C2;}
        
        /* 状态分布条形图 */
        .status-bars {display:flex;flex-direction:column;gap:12px;}
        .status-bar {display:flex;align-items:center;}
        .status-label {width:80px;font-size:14px;color:#5C4836;}
        .status-bar-fill {flex:1;height:24px;background:#E9D9C2;border-radius:6px;position:relative;overflow:hidden;}
        .status-bar-inner {height:100%;border-radius:6px;transition:0.3s;}
        .bar-pending {background:#FFC107;}
        .bar-ready {background:#28a745;}
        .bar-completed {background:#5C4836;}
        .bar-cancelled {background:#dc3545;}
        .status-count {width:60px;text-align:right;font-size:14px;color:#7D664F;}
        
        /* 排行榜 */
        .rank-list {display:flex;flex-direction:column;gap:8px;}
        .rank-item {display:flex;align-items:center;padding:12px;background:#FFF9EF;border-radius:8px;transition:0.2s;}
        .rank-item:hover {background:#F7E9D6;}
        .rank-num {width:30px;height:30px;border-radius:50%;background:#5C4836;color:#fff;text-align:center;line-height:30px;font-size:14px;font-weight:bold;}
        .rank-item:nth-child(1) .rank-num {background:#FFD700;}
        .rank-item:nth-child(2) .rank-num {background:#C0C0C0;}
        .rank-item:nth-child(3) .rank-num {background:#CD7F32;}
        .rank-info {flex:1;margin-left:12px;}
        .rank-name {font-size:14px;color:#5C4836;font-weight:600;}
        .rank-category {font-size:12px;color:#a8937b;}
        .rank-stats {text-align:right;}
        .rank-sales {font-size:14px;color:#5C4836;font-weight:600;}
        .rank-revenue {font-size:12px;color:#a8937b;}
        
        /* 分类销售占比 */
        .category-list {display:flex;flex-direction:column;gap:10px;}
        .category-item {display:flex;align-items:center;gap:10px;}
        .category-name {width:100px;font-size:14px;color:#5C4836;}
        .category-bar {flex:1;height:20px;background:#E9D9C2;border-radius:6px;position:relative;overflow:hidden;}
        .category-fill {height:100%;background:#5C4836;border-radius:6px;}
        .category-percent {width:60px;text-align:right;font-size:14px;color:#7D664F;}
        
        /* 7天趋势简单柱状图 */
        .trend-chart {display:flex;align-items:flex-end;gap:8px;height:200px;padding:20px 10px;}
        .trend-bar {flex:1;display:flex;flex-direction:column;align-items:center;gap:5px;}
        .trend-bar-fill {width:100%;max-width:50px;background:#5C4836;border-radius:6px 6px 0 0;min-height:5px;transition:0.3s;}
        .trend-bar:hover .trend-bar-fill {background:#7D664F;}
        .trend-value {font-size:12px;color:#5C4836;font-weight:600;}
        .trend-date {font-size:11px;color:#a8937b;}
        
        /* 空数据提示 */
        .empty-tip {text-align:center;padding:30px;color:#a8937b;}
        .empty-tip p {font-size:14px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h2>🐻 咩嘢熊仔</h2><small>管理后台</small></div>
    <div class="nav">
<div class="nav">
        <a  href="${pageContext.request.contextPath}/admin/index.jsp">📊 仪表盘</a>
        <a  href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
        <a  href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
        <a  href="${pageContext.request.contextPath}/admin/CategoryListServlet">🏷️ 分类管理</a>
        <a  href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
        <a  href="${pageContext.request.contextPath}/admin/InventoryListServlet">📦 库存管理</a>
        <a  href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet">📋 进货记录</a>
        <a  href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a class="active" href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
    </div>
</div>

<div class="main">
    <div class="header">
        <h3>📈 销售统计</h3>
        <span>管理员：${sessionScope.adminUser.nickname}</span>
    </div>
    
    <!-- 统计卡片 -->
    <div class="stats-grid">
        <div class="stat-card highlight">
            <div class="icon">💰</div>
            <div class="num"><fmt:formatNumber value="${todaySales}" type="currency" currencySymbol="¥"/></div>
            <div class="label">今日销售额</div>
        </div>
        <div class="stat-card">
            <div class="icon">📦</div>
            <div class="num">${todayOrders}</div>
            <div class="label">今日订单数</div>
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
    
    <div class="stats-grid" style="margin-bottom:25px;">
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
    
    <!-- 图表区域 -->
    <div class="charts-section">
        <!-- 销量排行榜 -->
        <div class="chart-box">
            <div class="chart-title">🏆 销量排行榜 TOP 10</div>
            <c:choose>
                <c:when test="${not empty topProducts}">
                    <div class="rank-list">
                        <c:forEach items="${topProducts}" var="item" varStatus="status">
                            <div class="rank-item">
                                <div class="rank-num">${status.index + 1}</div>
                                <div class="rank-info">
                                    <div class="rank-name">${item.name}</div>
                                    <div class="rank-category">${item.category != null ? item.category : '未分类'}</div>
                                </div>
                                <div class="rank-stats">
                                    <div class="rank-sales">销量: ${item.totalSales}</div>
                                    <div class="rank-revenue">收入: <fmt:formatNumber value="${item.totalRevenue}" type="currency" currencySymbol="¥"/></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-tip">
                        <p>暂无销量数据</p>
                        <p style="margin-top:8px;font-size:12px;">等待订单完成后统计</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 订单状态分布 -->
        <div class="chart-box">
            <div class="chart-title">📊 订单状态分布</div>
            <c:choose>
                <c:when test="${not empty statusDistribution}">
                    <div class="status-bars">
                        <c:forEach items="${statusDistribution}" var="item">
                            <div class="status-bar">
                                <div class="status-label">${item.statusText}</div>
                                <div class="status-bar-fill">
                                    <c:set var="percent" value="${(item.count * 100) / (todayOrders > 0 ? todayOrders : 1)}"/>
                                    <div class="status-bar-inner bar-${item.status == 0 ? 'pending' : (item.status == 1 ? 'ready' : (item.status == 2 ? 'completed' : 'cancelled'))}" 
                                         style="width:${percent > 100 ? 100 : percent}%"></div>
                                </div>
                                <div class="status-count">${item.count}单</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-tip"><p>暂无订单数据</p></div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <div class="charts-section">
        <!-- 最近7天销售趋势 -->
        <div class="chart-box">
            <div class="chart-title">📈 最近7天销售趋势</div>
            <c:choose>
                <c:when test="${not empty dailySales}">
                    <div class="trend-chart">
                        <c:set var="maxSales" value="0"/>
                        <c:forEach items="${dailySales}" var="day">
                            <c:if test="${day.sales > maxSales}">
                                <c:set var="maxSales" value="${day.sales}"/>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${dailySales}" var="day">
                            <div class="trend-bar">
                                <c:set var="heightPercent" value="${maxSales > 0 ? (day.sales / maxSales * 150) : 5}"/>
                                <div class="trend-bar-fill" style="height:${heightPercent < 5 ? 5 : heightPercent}px"></div>
                                <div class="trend-value"><fmt:formatNumber value="${day.sales}" pattern="#"/></div>
                                <div class="trend-date">${day.date.toString().substring(5)}</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-tip"><p>暂无7天销售数据</p></div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 分类销售占比 -->
        <div class="chart-box">
            <div class="chart-title">🏷️ 分类销售占比</div>
            <c:choose>
                <c:when test="${not empty categorySales}">
                    <c:set var="totalCategorySales" value="0"/>
                    <c:forEach items="${categorySales}" var="cat">
                        <c:set var="totalCategorySales" value="${totalCategorySales + cat.totalRevenue}"/>
                    </c:forEach>
                    <div class="category-list">
                        <c:forEach items="${categorySales}" var="cat">
                            <div class="category-item">
                                <div class="category-name">${cat.category}</div>
                                <div class="category-bar">
                                    <c:set var="catPercent" value="${totalCategorySales > 0 ? (cat.totalRevenue / totalCategorySales * 100) : 0}"/>
                                    <div class="category-fill" style="width:${catPercent}%"></div>
                                </div>
                                <div class="category-percent"><fmt:formatNumber value="${catPercent}" pattern="#.#"/>%</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-tip"><p>暂无分类销售数据</p></div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>