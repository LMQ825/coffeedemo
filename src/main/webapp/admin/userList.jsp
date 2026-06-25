<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>用户管理 - 咩嘢熊仔后台</title>
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
        .toolbar {display:flex;gap:12px;margin-bottom:20px;}
        .toolbar form {display:flex;gap:8px;}
        .toolbar input {padding:8px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;}
        .toolbar button {padding:8px 18px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;}
        table {width:100%;border-collapse:collapse;background:#fff;border-radius:12px;overflow:hidden;}
        th {background:#F7E9D6;padding:12px;text-align:left;color:#5C4836;}
        td {padding:12px;border-bottom:1px solid #E9D9C2;}
        .status-badge {padding:3px 12px;border-radius:12px;font-size:12px;}
        .status-on {background:#d4edda;color:#155724;}
        .status-off {background:#f8d7da;color:#721c24;}
        .action-btn {padding:4px 12px;border-radius:6px;text-decoration:none;font-size:12px;color:#fff;border:none;cursor:pointer;}
        .btn-disable {background:#d9534f;}
        .btn-enable {background:#28a745;}
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
        <a href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
        <a class="active" href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
        <a href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
</div>
<div class="main">
    <div class="header"><h3>👤 用户管理</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>
    <div class="toolbar">
        <form action="${pageContext.request.contextPath}/admin/UserListServlet" method="get">
            <input type="text" name="keyword" placeholder="搜索用户名/手机号" value="${keyword}">
            <button type="submit">搜索</button>
        </form>
    </div>
    <table>
        <thead>
        <tr><th>ID</th><th>用户名</th><th>手机号</th><th>地址</th><th>状态</th><th>操作</th></tr>
        </thead>
        <tbody>
        <c:forEach items="${pageBean.list}" var="u">
            <tr>
                <td>${u.id}</td>
                <td>${u.username}</td>
                <td>${u.phone}</td>
                <td>${u.address}</td>
                <td>
                    <span class="status-badge ${u.status == 1 ? 'status-on' : 'status-off'}">
                            ${u.status == 1 ? '正常' : '禁用'}
                    </span>
                </td>
                <td>
                    <c:if test="${u.status == 1}">
                        <a class="action-btn btn-disable" href="${pageContext.request.contextPath}/admin/UserStatusServlet?userId=${u.id}&status=0" onclick="return confirm('确定禁用该用户吗？')">禁用</a>
                    </c:if>
                    <c:if test="${u.status == 0}">
                        <a class="action-btn btn-enable" href="${pageContext.request.contextPath}/admin/UserStatusServlet?userId=${u.id}&status=1" onclick="return confirm('确定启用该用户吗？')">启用</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty pageBean.list}">
            <tr><td colspan="6" style="text-align:center;padding:40px;color:#a8937b;">暂无用户</td></tr>
        </c:if>
        </tbody>
    </table>
    <div class="page-box">
        <a class="${pageBean.first ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/UserListServlet?page=${pageBean.prePage}&keyword=${keyword}">上一页</a>
        <c:forEach begin="1" end="${pageBean.totalPage}" var="i">
            <a class="${i == pageBean.currentPage ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/UserListServlet?page=${i}&keyword=${keyword}">${i}</a>
        </c:forEach>
        <a class="${pageBean.last ? 'disabled' : ''}" href="${pageContext.request.contextPath}/admin/UserListServlet?page=${pageBean.nextPage}&keyword=${keyword}">下一页</a>
    </div>
</div>
</body>
</html>
