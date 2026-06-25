<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>轮播图管理 - 咩嘢熊仔后台</title>
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
        .banner-grid {display:grid;grid-template-columns:repeat(2,1fr);gap:20px;}
        .banner-card {background:#fff;border-radius:12px;padding:20px;border:1px solid #E9D9C2;}
        .banner-card h4 {color:#5C4836;margin-bottom:12px;}
        .banner-preview {width:100%;height:160px;background:#F7E9D6;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:40px;margin-bottom:12px;border:2px dashed #DBC8A8;}
        .banner-preview img {width:100%;height:100%;object-fit:cover;border-radius:8px;}
        .banner-form {display:flex;flex-direction:column;gap:10px;}
        .banner-form input[type="file"] {padding:8px;border:1px solid #DBC8A8;border-radius:8px;font-size:13px;}
        .banner-form input[type="text"] {padding:8px 12px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:13px;}
        .banner-form label {font-size:13px;color:#7D664F;}
        .banner-actions {display:flex;gap:8px;margin-top:8px;}
        .btn-save {padding:8px 20px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:13px;}
        .btn-toggle {padding:8px 20px;background:#C9B48E;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:13px;}
        .status-tag {display:inline-block;padding:3px 10px;border-radius:10px;font-size:11px;margin-left:8px;}
        .tag-on {background:#d4edda;color:#155724;}
        .tag-off {background:#f8d7da;color:#721c24;}
    </style>
</head>
<body>
<div class="sidebar">
    <div class="logo"><h2>🐻 咩嘢熊仔</h2><small>管理后台</small></div>
    <div class="nav">
        <a href="${pageContext.request.contextPath}/admin/index.jsp">📊 仪表盘</a>
        <a href="${pageContext.request.contextPath}/admin/OrderListServlet">📋 订单管理</a>
        <a href="${pageContext.request.contextPath}/admin/ProductListServlet">☕ 饮品管理</a>
        <a href="${pageContext.request.contextPath}/admin/CategoryListServlet">🏷️ 分类管理</a>
        <a href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
        <a class="active" href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
</div>
<div class="main">
    <div class="header"><h3>🖼️ 轮播图管理</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>

    <div class="banner-grid">
        <div class="banner-card">
            <h4>轮播图 1 <span class="status-tag tag-on">显示中</span></h4>
            <div class="banner-preview">🖼️</div>
            <div class="banner-form">
                <label>上传图片 (建议 750x300)</label>
                <input type="file" accept="image/*">
                <label>跳转链接</label>
                <input type="text" placeholder="如：index.jsp?type=意式咖啡">
                <div class="banner-actions">
                    <button class="btn-save" onclick="alert('保存成功！')">保存</button>
                    <button class="btn-toggle" onclick="alert('已隐藏')">隐藏</button>
                </div>
            </div>
        </div>

        <div class="banner-card">
            <h4>轮播图 2 <span class="status-tag tag-on">显示中</span></h4>
            <div class="banner-preview">🖼️</div>
            <div class="banner-form">
                <label>上传图片 (建议 750x300)</label>
                <input type="file" accept="image/*">
                <label>跳转链接</label>
                <input type="text" placeholder="如：index.jsp?type=特调饮品">
                <div class="banner-actions">
                    <button class="btn-save" onclick="alert('保存成功！')">保存</button>
                    <button class="btn-toggle" onclick="alert('已隐藏')">隐藏</button>
                </div>
            </div>
        </div>

        <div class="banner-card">
            <h4>轮播图 3 <span class="status-tag tag-off">已隐藏</span></h4>
            <div class="banner-preview">🖼️</div>
            <div class="banner-form">
                <label>上传图片 (建议 750x300)</label>
                <input type="file" accept="image/*">
                <label>跳转链接</label>
                <input type="text" placeholder="如：index.jsp?type=甜品小食">
                <div class="banner-actions">
                    <button class="btn-save" onclick="alert('保存成功！')">保存</button>
                    <button class="btn-toggle" onclick="alert('已显示')">显示</button>
                </div>
            </div>
        </div>

        <div class="banner-card">
            <h4>轮播图 4 <span class="status-tag tag-off">已隐藏</span></h4>
            <div class="banner-preview">🖼️</div>
            <div class="banner-form">
                <label>上传图片 (建议 750x300)</label>
                <input type="file" accept="image/*">
                <label>跳转链接</label>
                <input type="text" placeholder="如：index.jsp?type=冷萃咖啡">
                <div class="banner-actions">
                    <button class="btn-save" onclick="alert('保存成功！')">保存</button>
                    <button class="btn-toggle" onclick="alert('已显示')">显示</button>
                </div>
            </div>
        </div>
    </div>
    <p style="color:#a8937b;font-size:13px;margin-top:20px;">💡 提示：轮播图将展示在用户端首页顶部，建议上传高清横版图片。</p>
</div>
</body>
</html>
