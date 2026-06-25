<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>新增饮品</title>
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
    .main .header {display:flex;justify-content:space-between;margin-bottom:20px;}
    .main .header h3 {color:#5C4836;}
    .form-box {background:#fff;border-radius:12px;padding:30px;border:1px solid #E9D9C2;max-width:600px;}
    .form-group {margin-bottom:18px;}
    .form-group label {display:block;font-weight:bold;margin-bottom:5px;font-size:14px;color:#5C4836;}
    .form-group input,.form-group select,.form-group textarea {width:100%;padding:10px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:14px;}
    .form-group textarea {height:80px;resize:vertical;}
    .form-group .help {font-size:12px;color:#a8937b;margin-top:4px;}
    .btn-submit {padding:10px 30px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;}
    .btn-back {padding:10px 30px;background:#e9d9c2;color:#5C4836;border:none;border-radius:8px;cursor:pointer;text-decoration:none;margin-left:10px;}
    .msg {color:#d9534f;margin-bottom:10px;}
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
  <div class="header"><h3>➕ 新增饮品</h3><span>管理员：${sessionScope.adminUser.nickname}</span></div>
  <div class="form-box">
    <c:if test="${not empty msg}"><div class="msg">${msg}</div></c:if>
    <form action="${pageContext.request.contextPath}/admin/ProductAddServlet" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label>饮品名称</label>
        <input type="text" name="name" required>
      </div>
      <div class="form-group">
        <label>价格 (元)</label>
        <input type="number" step="0.01" name="price" required>
      </div>
      <div class="form-group">
        <label>分类</label>
        <input type="text" name="category" placeholder="如：拿铁系列">
      </div>
      <div class="form-group">
        <label>描述</label>
        <textarea name="description" placeholder="简短描述"></textarea>
      </div>
      <div class="form-group">
        <label>商品图片</label>
        <input type="file" name="image" accept="image/*">
        <div class="help">建议尺寸 400x400，大小不超过5MB</div>
      </div>
      <div class="form-group">
        <label>上架状态</label>
        <select name="status">
          <option value="1">上架</option>
          <option value="0">下架</option>
        </select>
      </div>
      <div>
        <button class="btn-submit" type="submit">确认添加</button>
        <a class="btn-back" href="${pageContext.request.contextPath}/admin/ProductListServlet">返回列表</a>
      </div>
    </form>
  </div>
</div>
</body>
//1
</html>