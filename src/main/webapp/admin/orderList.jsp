<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>订单管理 - 咩嘢熊仔后台</title>
  <style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
    body {display:flex;min-height:100vh;background:#f5ede4;}
    .sidebar {width:220px;background:#5C4836;color:#fff;padding:20px 0;height:100vh;position:sticky;top:0;}
    .logo {text-align:center;padding:0 20px 30px;border-bottom:1px solid #7D664F;}
    .logo h2 {font-size:20px;}
    .nav {padding:20px 10px;}
    .nav a {display:block;padding:12px 18px;color:#E9D9C2;text-decoration:none;border-radius:8px;margin-bottom:4px;transition:0.2s;}
    .nav a:hover,.nav a.active {background:#7D664F;color:#fff;}
    .main {flex:1;padding:30px;}
    .header {display:flex;justify-content:space-between;margin-bottom:20px;}
    .header h3 {color:#5C4836;}
    .filter-bar {display:flex;gap:10px;margin-bottom:20px;flex-wrap:wrap;}
    .filter-bar a {padding:6px 16px;border-radius:16px;background:#fff;border:1px solid #DBC8A8;text-decoration:none;color:#5C4836;font-size:14px;}
    .filter-bar a.active {background:#5C4836;color:#fff;border-color:#5C4836;}
    table {width:100%;border-collapse:collapse;background:#fff;border-radius:12px;overflow:hidden;}
    th {background:#F7E9D6;padding:12px;text-align:left;color:#5C4836;}
    td {padding:12px;border-bottom:1px solid #E9D9C2;}
    .status-badge {padding:3px 12px;border-radius:12px;font-size:12px;}
    .status-0 {background:#fef3cd;color:#856404;}
    .status-1 {background:#d1ecf1;color:#0c5460;}
    .status-2 {background:#d4edda;color:#155724;}
    .status-3 {background:#f8d7da;color:#721c24;}
    .page-box {margin-top:20px;display:flex;justify-content:center;gap:8px;}
    .page-box a {padding:6px 14px;border:1px solid #DBC8A8;border-radius:6px;text-decoration:none;color:#5C4836;}
    .page-box a.active {background:#5C4836;color:#fff;border-color:#5C4836;}
    .page-box a.disabled {color:#ccc;pointer-events:none;}
    .order-detail-link {color:#C9B48E;text-decoration:underline;cursor:pointer;}
  </style>
</head>
<body>
<div class="sidebar">
  <div class="logo"><h2>🐻 咩嘢熊仔</h2><small>管理后台</small></div>
  <div class="nav">
    <a href="${pageContext.request.contextPath}/admin/index.jsp">📊 仪表盘</a>
    <a class="active" href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
    <a href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
    <a href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
    <a href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
    <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
  </div>
</div>
<div class="main">
  <div class="header"><h3>📋 订单管理</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>
  <div class="filter-bar">
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet" class="${empty statusFilter ? 'active' : ''}">全部</a>
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet?status=0" class="${statusFilter == 0 ? 'active' : ''}">待付款</a>
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet?status=1" class="${statusFilter == 1 ? 'active' : ''}">待取餐</a>
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet?status=2" class="${statusFilter == 2 ? 'active' : ''}">已完成</a>
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet?status=3" class="${statusFilter == 3 ? 'active' : ''}">已取消</a>
  </div>
  <table>
    <thead>
    <tr>
      <th>订单号</th>
      <th>用户</th>
      <th>总金额</th>
      <th>状态</th>
      <th>下单时间</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageBean.list}" var="o">
      <tr>
        <td><span class="order-detail-link" onclick="location.href='${pageContext.request.contextPath}/admin/orderDetail.jsp?id=${o.id}'">${o.orderNo}</span></td>
        <td>${o.username}</td>
        <td>¥${o.totalPrice}</td>
        <td><span class="status-badge status-${o.status}">${o.statusText}</span></td>
        <td><fmt:formatDate value="${o.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
        <td>
          <form action="${pageContext.request.contextPath}/admin/OrderUpdateServlet" method="post" style="display:inline;">
            <input type="hidden" name="orderId" value="${o.id}">
            <select name="status" onchange="this.form.submit()" style="padding:4px 8px;border-radius:6px;border:1px solid #DBC8A8;">
              <option value="0" ${o.status == 0 ? 'selected' : ''}>待付款</option>
              <option value="1" ${o.status == 1 ? 'selected' : ''}>待取餐</option>
              <option value="2" ${o.status == 2 ? 'selected' : ''}>已完成</option>
              <option value="3" ${o.status == 3 ? 'selected' : ''}>已取消</option>
            </select>
          </form>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty pageBean.list}">
      <tr><td colspan="6" style="text-align:center;padding:40px;color:#a8937b;">暂无订单</td></tr>
    </c:if>
    </tbody>
  </table>
  <div class="page-box">
    <a class="${pageBean.first ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/OrderListServlet?page=${pageBean.prePage}&status=${statusFilter}">上一页</a>
    <c:forEach begin="1" end="${pageBean.totalPage}" var="i">
      <a class="${i == pageBean.currentPage ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/OrderListServlet?page=${i}&status=${statusFilter}">${i}</a>
    </c:forEach>
    <a class="${pageBean.last ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/OrderListServlet?page=${pageBean.nextPage}&status=${statusFilter}">下一页</a>
  </div>
</div>
</body>
</html>
