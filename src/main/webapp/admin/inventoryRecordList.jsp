<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>进货记录 - 咩嘢熊仔后台</title>
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
    .toolbar form {display:flex;gap:8px;align-items:center;flex-wrap:wrap;}
    .toolbar input {padding:8px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:14px;}
    .toolbar button {padding:8px 18px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:14px;}
    .btn-add {padding:8px 18px;background:#C9B48E;color:#fff;border:none;border-radius:8px;cursor:pointer;text-decoration:none;font-size:14px;display:inline-block;}
    .btn-back {padding:8px 18px;background:#E9D9C2;color:#5C4836;border:none;border-radius:8px;cursor:pointer;text-decoration:none;font-size:14px;display:inline-block;}
    table {width:100%;border-collapse:collapse;background:#fff;border-radius:12px;overflow:hidden;}
    th {background:#F7E9D6;padding:12px;text-align:left;color:#5C4836;font-size:14px;}
    td {padding:10px 12px;border-bottom:1px solid #E9D9C2;font-size:14px;}
    tr:hover {background:#FFF9EF;}
    .price {color:#5C4836;font-weight:bold;}
    .action-btn {padding:4px 10px;border-radius:6px;text-decoration:none;font-size:12px;color:#fff;border:none;cursor:pointer;margin-right:4px;display:inline-block;}
    .btn-delete {background:#d9534f;}
    .page-box {margin-top:20px;display:flex;justify-content:center;gap:8px;}
    .page-box a {padding:6px 14px;border:1px solid #DBC8A8;border-radius:6px;text-decoration:none;color:#5C4836;}
    .page-box a.active {background:#5C4836;color:#fff;border-color:#5C4836;}
    .page-box a.disabled {color:#ccc;pointer-events:none;}
    .success-msg {background:#d4edda;border:1px solid #c3e6cb;border-radius:12px;padding:12px 20px;margin-bottom:20px;color:#155724;font-size:14px;}
    .summary-bar {display:flex;gap:20px;margin-bottom:20px;}
    .summary-card {background:#fff;border-radius:12px;padding:16px 24px;border:1px solid #E9D9C2;text-align:center;}
    .summary-card .num {font-size:24px;font-weight:bold;color:#5C4836;}
    .summary-card .label {font-size:13px;color:#a8937b;margin-top:4px;}
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
        <a class="active" href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet">📋 进货记录</a>
        <a  href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a  href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
    </div>
</div>
<div class="main">
  <div class="header">
    <h3>📋 进货记录</h3>
    <a class="btn-back" href="${pageContext.request.contextPath}/admin/InventoryListServlet">← 返回库存</a>
  </div>

  <c:if test="${param.msg == 'add_success'}">
    <div class="success-msg">✅ 进货记录新增成功，库存已更新！</div>
  </c:if>

  <%-- 工具栏 --%>
  <div class="toolbar">
    <form action="${pageContext.request.contextPath}/admin/InventoryRecordListServlet" method="get">
      <input type="text" name="keyword" placeholder="搜索原料/供应商/操作人" value="${keyword}">
      <input type="date" name="startDate" value="${startDate}">
      <span style="color:#a8937b;">至</span>
      <input type="date" name="endDate" value="${endDate}">
      <button type="submit">搜索</button>
    </form>
    <a class="btn-add" href="${pageContext.request.contextPath}/admin/InventoryRecordAddServlet">➕ 新增进货</a>
  </div>

  <%-- 进货记录表格 --%>
  <table>
    <thead>
    <tr>
      <th>ID</th>
      <th>进货时间</th>
      <th>原料名称</th>
      <th>进货数量</th>
      <th>供应商</th>
      <th>单价(元)</th>
      <th>总价(元)</th>
      <th>操作人</th>
      <th>备注</th>
      <th>操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${pageBean.list}" var="r">
      <tr>
        <td>${r.id}</td>
        <td>${r.createTime}</td>
        <td><strong>${r.inventoryName}</strong></td>
        <td>${r.quantity} ${r.unit}</td>
        <td>${r.supplier}</td>
        <td class="price">¥${r.unitPrice}</td>
        <td class="price">¥${r.totalPrice}</td>
        <td>${r.operator}</td>
        <td>${r.remark}</td>
        <td>
          <a class="action-btn btn-delete" href="${pageContext.request.contextPath}/admin/InventoryRecordDeleteServlet?id=${r.id}" onclick="return confirm('确定删除该进货记录吗？')">删除</a>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty pageBean.list}">
      <tr><td colspan="10" style="text-align:center;color:#a8937b;padding:30px;">暂无进货记录</td></tr>
    </c:if>
    </tbody>
  </table>

  <%-- 分页 --%>
  <c:if test="${pageBean.totalPage > 1}">
    <div class="page-box">
      <a class="${pageBean.first ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet?page=${pageBean.prePage}&keyword=${keyword}&startDate=${startDate}&endDate=${endDate}">上一页</a>
      <c:forEach begin="1" end="${pageBean.totalPage}" var="i">
        <a class="${pageBean.currentPage == i ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet?page=${i}&keyword=${keyword}&startDate=${startDate}&endDate=${endDate}">${i}</a>
      </c:forEach>
      <a class="${pageBean.last ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet?page=${pageBean.nextPage}&keyword=${keyword}&startDate=${startDate}&endDate=${endDate}">下一页</a>
    </div>
  </c:if>
</div>
</body>
</html>
