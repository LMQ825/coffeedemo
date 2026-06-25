<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String idStr = request.getParameter("id");
    if (idStr != null && !idStr.isEmpty()) {
        com.example.coffee.service.ProductService service = new com.example.coffee.impl.ProductServiceImpl();
        com.example.coffee.entity.Product p = service.getProductById(Integer.parseInt(idStr));
        request.setAttribute("p", p);
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑饮品 - 咩嘢熊仔后台</title>
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
        .main .header {display:flex;justify-content:space-between;margin-bottom:20px;}
        .main .header h3 {color:#5C4836;}
        .form-box {background:#fff;border-radius:12px;padding:30px;border:1px solid #E9D9C2;max-width:600px;}
        .form-group {margin-bottom:18px;}
        .form-group label {display:block;font-weight:bold;margin-bottom:5px;font-size:14px;color:#5C4836;}
        .form-group input,.form-group select,.form-group textarea {width:100%;padding:10px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:14px;}
        .form-group textarea {height:80px;resize:vertical;}
        .form-group .help {font-size:12px;color:#a8937b;margin-top:4px;}
        .form-group .current-img img {max-height:120px;border-radius:8px;border:1px solid #ddd;margin-top:6px;}
        .btn-submit {padding:10px 30px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;}
        .btn-back {padding:10px 30px;background:#e9d9c2;color:#5C4836;border:none;border-radius:8px;cursor:pointer;text-decoration:none;margin-left:10px;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h2>🐻 咩嘢熊仔</h2><small>管理后台</small></div>
    <div class="nav">
        <a href="${pageContext.request.contextPath}/admin/index.jsp">📊 仪表盘</a>
        <a href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
        <a class="active" href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
        <a href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
        <a href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
</div>
<div class="main">
    <div class="header"><h3>✏️ 编辑饮品</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>
    <div class="form-box">
        <c:if test="${empty p}">
            <p style="color:#d9534f;">数据不存在，请返回列表重试。</p>
            <a class="btn-back" href="${pageContext.request.contextPath}/admin/ProductListServlet">返回列表</a>
        </c:if>
        <c:if test="${not empty p}">
            <form action="${pageContext.request.contextPath}/admin/ProductUpdateServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${p.id}">
                <div class="form-group">
                    <label>饮品名称</label>
                    <input type="text" name="name" value="${p.name}" required>
                </div>
                <div class="form-group">
                    <label>价格 (元)</label>
                    <input type="number" step="0.01" name="price" value="${p.price}" required>
                </div>
                <div class="form-group">
                    <label>分类</label>
                    <input type="text" name="category" value="${p.category}">
                </div>
                <div class="form-group">
                    <label>描述</label>
                    <textarea name="description">${p.description}</textarea>
                </div>
                <div class="form-group">
                    <label>当前图片</label>
                    <div class="current-img">
                        <c:if test="${not empty p.imageUrl}">
                            <img src="${pageContext.request.contextPath}/${p.imageUrl}" alt="当前图片">
                        </c:if>
                        <c:if test="${empty p.imageUrl}">
                            <span style="color:#a8937b;">暂无图片</span>
                        </c:if>
                    </div>
                </div>
                <div class="form-group">
                    <label>更换图片 (留空则不修改)</label>
                    <input type="file" name="image" accept="image/*">
                    <div class="help">建议尺寸 400x400</div>
                </div>
                <div class="form-group">
                    <label>上架状态</label>
                    <select name="status">
                        <option value="1" ${p.status == 1 ? 'selected' : ''}>上架</option>
                        <option value="0" ${p.status == 0 ? 'selected' : ''}>下架</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>是否新品</label>
                    <select name="isNew">
                        <option value="0" ${p.isNew == 0 ? 'selected' : ''}>否</option>
                        <option value="1" ${p.isNew == 1 ? 'selected' : ''}>是</option>
                    </select>
                </div>
                <div>
                    <button class="btn-submit" type="submit">确认修改</button>
                    <a class="btn-back" href="${pageContext.request.contextPath}/admin/ProductListServlet">返回列表</a>
                </div>
            </form>
        </c:if>
    </div>
</div>
</body>
</html>
