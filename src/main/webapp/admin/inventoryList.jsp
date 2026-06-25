<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>库存管理 - 咩嘢熊仔后台</title>
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
    .header {display:flex;justify-content:space-between;margin-bottom:20px;align-items:center;}
    .header h3 {color:#5C4836;}
    .toolbar {display:flex;gap:12px;margin-bottom:20px;align-items:center;flex-wrap:wrap;}
    .toolbar form {display:flex;gap:8px;align-items:center;}
    .toolbar input, .toolbar select {padding:8px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:14px;}
    .toolbar button {padding:8px 18px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:14px;}
    .btn-add {padding:8px 18px;background:#C9B48E;color:#fff;border:none;border-radius:8px;cursor:pointer;text-decoration:none;font-size:14px;display:inline-block;}
    .btn-record {padding:8px 18px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;text-decoration:none;font-size:14px;display:inline-block;}
    table {width:100%;border-collapse:collapse;background:#fff;border-radius:12px;overflow:hidden;}
    th {background:#F7E9D6;padding:12px;text-align:left;color:#5C4836;font-size:14px;}
    td {padding:10px 12px;border-bottom:1px solid #E9D9C2;font-size:14px;}
    tr:hover {background:#FFF9EF;}
    .status-badge {padding:3px 12px;border-radius:12px;font-size:12px;font-weight:bold;}
    .status-normal {background:#d4edda;color:#155724;}
    .status-warning {background:#fff3cd;color:#856404;}
    .status-danger {background:#f8d7da;color:#721c24;}
    .action-btn {padding:4px 10px;border-radius:6px;text-decoration:none;font-size:12px;color:#fff;border:none;cursor:pointer;margin-right:4px;display:inline-block;}
    .btn-edit {background:#5C4836;}
    .btn-delete {background:#d9534f;}
    .page-box {margin-top:20px;display:flex;justify-content:center;gap:8px;}
    .page-box a {padding:6px 14px;border:1px solid #DBC8A8;border-radius:6px;text-decoration:none;color:#5C4836;}
    .page-box a.active {background:#5C4836;color:#fff;border-color:#5C4836;}
    .page-box a.disabled {color:#ccc;pointer-events:none;}
    /* 预警横幅 */
    .alert-banner {background:#fff3cd;border:1px solid #ffc107;border-radius:12px;padding:15px 20px;margin-bottom:20px;display:flex;align-items:center;gap:12px;}
    .alert-banner .alert-icon {font-size:24px;}
    .alert-banner .alert-text {flex:1;color:#856404;font-size:14px;}
    .alert-banner .alert-text strong {color:#664d03;}
    .alert-banner .alert-items {margin-top:8px;font-size:13px;}
    .alert-banner .alert-items span {display:inline-block;background:#ffc107;color:#664d03;padding:2px 8px;border-radius:10px;margin:2px 4px 2px 0;font-size:12px;}
    /* 成功提示 */
    .success-msg {background:#d4edda;border:1px solid #c3e6cb;border-radius:12px;padding:12px 20px;margin-bottom:20px;color:#155724;font-size:14px;}
    /* 库存进度条 */
    .stock-bar {width:100px;height:8px;background:#e9ecef;border-radius:4px;overflow:hidden;display:inline-block;vertical-align:middle;margin-left:6px;}
    .stock-bar-fill {height:100%;border-radius:4px;transition:width 0.3s;}
    .stock-bar-fill.normal {background:#28a745;}
    .stock-bar-fill.warning {background:#ffc107;}
    .stock-bar-fill.danger {background:#dc3545;}
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
        <a class="active" href="${pageContext.request.contextPath}/admin/InventoryListServlet">📦 库存管理</a>
        <a  href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet">📋 进货记录</a>
        <a  href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a  href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
    </div>
</div>
<div class="main">
  <div class="header">
    <h3>📦 库存管理</h3>
    <span>管理员：${sessionScope.adminUser.nickname}</span>
  </div>

  <%-- 成功提示 --%>
  <c:if test="${param.msg == 'add_success'}">
    <div class="success-msg">✅ 新增库存成功！</div>
  </c:if>
  <c:if test="${param.msg == 'update_success'}">
    <div class="success-msg">✅ 更新库存成功！</div>
  </c:if>
  <c:if test="${param.msg == 'delete_success'}">
    <div class="success-msg">✅ 删除库存成功！</div>
  </c:if>

  <%-- 库存预警横幅 --%>
  <c:if test="${lowStockCount > 0}">
    <div class="alert-banner">
      <div class="alert-icon">⚠️</div>
      <div class="alert-text">
        <strong>库存预警：有 ${lowStockCount} 种原料库存不足！</strong>
        <div class="alert-items">
          <c:forEach items="${lowStockItems}" var="item">
            <span>${item.name}（剩余 ${item.quantity} ${item.unit}，阈值 ${item.minQuantity}）</span>
          </c:forEach>
        </div>
      </div>
    </div>
  </c:if>

  <%-- 工具栏 --%>
  <div class="toolbar">
    <form action="${pageContext.request.contextPath}/admin/InventoryListServlet" method="get">
      <input type="text" name="keyword" placeholder="搜索原料名称/供应商" value="${keyword}">
      <select name="category">
        <option value="">全部分类</option>
        <c:forEach items="${categories}" var="cat">
          <option value="${cat}" ${cat == category ? 'selected' : ''}>${cat}</option>
        </c:forEach>
      </select>
      <button type="submit">搜索</button>
    </form>
    <a class="btn-add" href="${pageContext.request.contextPath}/admin/InventoryAddServlet">➕ 新增原料</a>
    <a class="btn-record" href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet">📋 进货记录</a>
  </div>

  <%-- 库存列表表格 --%>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>原料名称</th>
      <th>分类</th>
      <th>当前库存</th>
      <th>预警阈值</th>
      <th>库存状态</th>
      <th>供应商</th>
      <th>备注</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageBean.list}" var="inv">
      <tr>
        <td>${inv.id}</td>
        <td><strong>${inv.name}</strong></td>
        <td>${inv.category}</td>
        <td>
          ${inv.quantity} ${inv.unit}
          <div class="stock-bar">
            <c:set var="pct" value="${inv.quantity / inv.minQuantity * 50}" />
            <c:choose>
              <c:when test="${pct > 100}"><c:set var="pct" value="100" /></c:when>
            </c:choose>
            <div class="stock-bar-fill ${inv.stockStatus == 0 ? 'normal' : (inv.stockStatus == 1 ? 'warning' : 'danger')}"
                 style="width:${pct}%"></div>
          </div>
        </td>
        <td>${inv.minQuantity} ${inv.unit}</td>
        <td>
          <span class="status-badge ${inv.stockStatus == 0 ? 'status-normal' : (inv.stockStatus == 1 ? 'status-warning' : 'status-danger')}">
            ${inv.stockStatusText}
          </span>
        </td>
        <td>${inv.supplier}</td>
        <td>${inv.description}</td>
        <td>
          <a class="action-btn btn-edit" href="${pageContext.request.contextPath}/admin/InventoryUpdateServlet?id=${inv.id}">编辑</a>
          <a class="action-btn btn-delete" href="${pageContext.request.contextPath}/admin/InventoryDeleteServlet?id=${inv.id}" onclick="return confirm('确定删除该原料吗？关联的进货记录也会被删除！')">删除</a>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty pageBean.list}">
      <tr><td colspan="9" style="text-align:center;color:#a8937b;padding:30px;">暂无库存数据，请添加原料</td></tr>
    </c:if>
    </tbody>
  </table>

  <%-- 分页 --%>
  <c:if test="${pageBean.totalPage > 1}">
    <div class="page-box">
      <a class="${pageBean.first ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/InventoryListServlet?page=${pageBean.prePage}&keyword=${keyword}&category=${category}">上一页</a>
      <c:forEach begin="1" end="${pageBean.totalPage}" var="i">
        <a class="${pageBean.currentPage == i ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/InventoryListServlet?page=${i}&keyword=${keyword}&category=${category}">${i}</a>
      </c:forEach>
      <a class="${pageBean.last ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/InventoryListServlet?page=${pageBean.nextPage}&keyword=${keyword}&category=${category}">下一页</a>
    </div>
  </c:if>
</div>
</body>
</html>
