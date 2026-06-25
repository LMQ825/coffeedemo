<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
  String idStr = request.getParameter("id");
  if (idStr != null && !idStr.isEmpty()) {
    com.example.coffee.service.OrderService service = new com.example.coffee.service.impl.OrderServiceImpl();
    com.example.coffee.entity.Order order = service.getOrderDetail(Integer.parseInt(idStr));
    request.setAttribute("order", order);
  }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>订单详情</title>
  <style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
    body {display:flex;min-height:100vh;background:#f5ede4;}
    .sidebar {width:220px;background:#5C4836;color:#fff;padding:20px 0;height:100vh;position:sticky;top:0;}
    .logo {text-align:center;padding:0 20px 30px;border-bottom:1px solid #7D664F;}
    .logo h2 {font-size:20px;}
    .nav {padding:20px 10px;}
    .nav a {display:block;padding:12px 18px;color:#E9D9C2;text-decoration:none;border-radius:8px;margin-bottom:4px;}
    .nav a:hover {background:#7D664F;color:#fff;}
    .main {flex:1;padding:30px;}
    .header {display:flex;justify-content:space-between;margin-bottom:20px;}
    .header h3 {color:#5C4836;}
    .detail-box {background:#fff;border-radius:12px;padding:25px;border:1px solid #E9D9C2;max-width:700px;}
    .detail-row {display:flex;padding:8px 0;border-bottom:1px solid #f0f0f0;}
    .detail-row .label {width:120px;color:#7D664F;}
    .detail-row .value {flex:1;}
    .item-list {margin-top:15px;}
    .item-list th {background:#F7E9D6;padding:8px;text-align:left;}
    .item-list td {padding:8px;border-bottom:1px solid #eee;}
    .back-btn {display:inline-block;margin-top:20px;padding:8px 24px;background:#5C4836;color:#fff;border-radius:8px;text-decoration:none;}
  </style>
</head>
<body>
<div class="sidebar">
  <div class="logo"><h2>🐻 咩嘢熊仔</h2><small>管理后台</small></div>
  <div class="nav">
    <a href="${pageContext.request.contextPath}/admin/index.jsp">📊 仪表盘</a>
    <a href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
    <a href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
    <a href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
    <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出</a>
  </div>
</div>
<div class="main">
  <div class="header"><h3>📄 订单详情</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>
  <div class="detail-box">
    <c:if test="${empty order}">
      <p style="color:#d9534f;">订单不存在</p>
      <a class="back-btn" href="${pageContext.request.contextPath}/admin/OrderListServlet">返回列表</a>
    </c:if>
    <c:if test="${not empty order}">
      <div class="detail-row"><span class="label">订单号</span><span class="value">${order.orderNo}</span></div>
      <div class="detail-row"><span class="label">用户</span><span class="value">${order.username}</span></div>
      <div class="detail-row"><span class="label">总金额</span><span class="value">¥${order.totalPrice}</span></div>
      <div class="detail-row"><span class="label">状态</span><span class="value">${order.statusText}</span></div>
      <div class="detail-row"><span class="label">下单时间</span><span class="value"><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></span></div>
      <div class="detail-row"><span class="label">备注</span><span class="value">${order.remark}</span></div>

      <h4 style="margin-top:20px;color:#5C4836;">商品明细</h4>
      <table class="item-list" style="width:100%;border-collapse:collapse;">
        <thead><tr><th>商品</th><th>单价</th><th>数量</th><th>小计</th></tr></thead>
        <tbody>
        <c:forEach items="${order.items}" var="item">
          <tr>
            <td>${item.productName}</td>
            <td>¥${item.price}</td>
            <td>${item.quantity}</td>
            <td>¥${item.subtotal}</td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
      <a class="back-btn" href="${pageContext.request.contextPath}/admin/OrderListServlet">返回列表</a>
    </c:if>
  </div>
</div>
</body>
//1
</html>