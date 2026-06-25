<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>饮品管理 - 咩嘢熊仔后台</title>
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
    .toolbar {display:flex;gap:12px;margin-bottom:20px;align-items:center;}
    .toolbar form {display:flex;gap:8px;}
    .toolbar input {padding:8px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;}
    .toolbar button {padding:8px 18px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;}
    .btn-add {padding:8px 18px;background:#C9B48E;color:#fff;border:none;border-radius:8px;cursor:pointer;text-decoration:none;font-size:14px;}
    table {width:100%;border-collapse:collapse;background:#fff;border-radius:12px;overflow:hidden;}
    th {background:#F7E9D6;padding:12px;text-align:left;color:#5C4836;}
    td {padding:10px 12px;border-bottom:1px solid #E9D9C2;}
    .product-img {width:50px;height:50px;border-radius:8px;object-fit:cover;background:#F7E9D6;display:flex;align-items:center;justify-content:center;font-size:24px;}
    .status-badge {padding:3px 12px;border-radius:12px;font-size:12px;}
    .status-on {background:#d4edda;color:#155724;}
    .status-off {background:#f8d7da;color:#721c24;}
    .action-btn {padding:4px 10px;border-radius:6px;text-decoration:none;font-size:12px;color:#fff;border:none;cursor:pointer;margin-right:4px;}
    .btn-edit {background:#5C4836;}
    .btn-delete {background:#d9534f;}
    .btn-up {background:#28a745;}
    .page-box {margin-top:20px;display:flex;justify-content:center;gap:8px;}
    .page-box a {padding:6px 14px;border:1px solid #DBC8A8;border-radius:6px;text-decoration:none;color:#5C4836;}
    .page-box a.active {background:#5C4836;color:#fff;border-color:#5C4836;}
    .page-box a.disabled {color:#ccc;pointer-events:none;}
  </style>
</head>
<body>
<div class="sidebar">
  <div class="logo"><h2>🐻 咩嘢熊仔</h2><small>管理后台</small></div>
  <div class="nav">
    <a href="${pageContext.request.contextPath}/admin/index.jsp">📊 仪表盘</a>
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
    <a class="active" href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
    <a href="${pageContext.request.contextPath}/admin/CategoryListServlet">🏷️ 分类管理</a>
	    <a href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
	    <a href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
	    <a href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
    <a href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
    <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
  </div>
</div>
<div class="main">
  <div class="header"><h3>☕ 饮品管理</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>
  <div class="toolbar">
    <form action="${pageContext.request.contextPath}/admin/ProductListServlet" method="get">
      <input type="text" name="keyword" placeholder="搜索饮品名称" value="${keyword}">
      <button type="submit">搜索</button>
    </form>
    <a class="btn-add" href="${pageContext.request.contextPath}/admin/productAdd.jsp">➕ 新增饮品</a>
  </div>
  <table>
    <thead>
    <tr><th>ID</th><th>图片</th><th>饮品名称</th><th>价格</th><th>分类</th><th>状态</th><th>操作</th></tr>
    </thead>
    <tbody>
    <c:forEach items="${pageBean.list}" var="p">
      <tr>
        <td>${p.id}</td>
        <td>
          <c:choose>
            <c:when test="${not empty p.imageUrl}">
              <img class="product-img" src="${pageContext.request.contextPath}/${p.imageUrl}" alt="${p.name}">
            </c:when>
            <c:otherwise>
              <div class="product-img">☕</div>
            </c:otherwise>
          </c:choose>
        </td>
        <td>${p.name}</td>
        <td>¥${p.price}</td>
        <td>${p.category}</td>
        <td>
          <span class="status-badge ${p.status == 1 ? 'status-on' : 'status-off'}">
            ${p.status == 1 ? '上架' : '下架'}
          </span>
        </td>
        <td>
          <a class="action-btn btn-edit" href="${pageContext.request.contextPath}/admin/productEdit.jsp?id=${p.id}">编辑</a>
          <c:if test="${p.status == 0}">
            <a class="action-btn btn-up" href="${pageContext.request.contextPath}/admin/ProductUpServlet?id=${p.id}">上架</a>
          </c:if>
          <a class="action-btn btn-delete" href="${pageContext.request.contextPath}/admin/ProductDeleteServlet?id=${p.id}" onclick="return confirm('确定删除该饮品吗？')">删除</a>
        </td>
        <th>新品</th>
        <!-- 在 td 中 -->
        <td>${p.isNew == 1 ? '✅' : ''}</td>
      </tr>
    </c:forEach>
    <c:if test="${empty pageBean.list}">
      <tr><td colspan="7" style="text-align:center;padding:40px;color:#a8937b;">暂无饮品</td></tr>
    </c:if>
    </tbody>
  </table>
  <div class="page-box">
    <a class="${pageBean.first ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/ProductListServlet?page=${pageBean.prePage}&keyword=${keyword}">上一页</a>
    <c:forEach begin="1" end="${pageBean.totalPage}" var="i">
      <a class="${i == pageBean.currentPage ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/ProductListServlet?page=${i}&keyword=${keyword}">${i}</a>
    </c:forEach>
    <a class="${pageBean.last ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/ProductListServlet?page=${pageBean.nextPage}&keyword=${keyword}">下一页</a>
  </div>
</div>
</body>
</html>
