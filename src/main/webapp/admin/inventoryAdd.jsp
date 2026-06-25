<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <title>新增原料 - 咩嘢熊仔后台</title>
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
    .form-card {background:#fff;border-radius:12px;padding:30px;border:1px solid #E9D9C2;max-width:600px;}
    .form-group {margin-bottom:18px;}
    .form-group label {display:block;margin-bottom:6px;color:#5C4836;font-weight:bold;font-size:14px;}
    .form-group input, .form-group select, .form-group textarea {
      width:100%;padding:10px 14px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:14px;
    }
    .form-group input:focus, .form-group select:focus, .form-group textarea:focus {border-color:#5C4836;}
    .form-group textarea {resize:vertical;min-height:60px;}
    .form-group .hint {font-size:12px;color:#a8937b;margin-top:4px;}
    .form-row {display:flex;gap:16px;}
    .form-row .form-group {flex:1;}
    .btn-submit {padding:10px 30px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:15px;margin-right:10px;}
    .btn-cancel {padding:10px 30px;background:#E9D9C2;color:#5C4836;border:none;border-radius:8px;cursor:pointer;font-size:15px;text-decoration:none;display:inline-block;}
    .error-msg {background:#f8d7da;border:1px solid #f5c6cb;border-radius:8px;padding:10px 16px;margin-bottom:16px;color:#721c24;font-size:14px;}
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
    <h3>➕ 新增原料</h3>
    <a class="btn-cancel" href="${pageContext.request.contextPath}/admin/InventoryListServlet">← 返回列表</a>
  </div>

  <c:if test="${not empty error}">
    <div class="error-msg">${error}</div>
  </c:if>

  <div class="form-card">
    <form action="${pageContext.request.contextPath}/admin/InventoryAddServlet" method="post">
      <div class="form-group">
        <label>原料名称 *</label>
        <input type="text" name="name" required placeholder="如：哥伦比亚咖啡豆">
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>分类 *</label>
          <select name="category" required>
            <option value="">请选择分类</option>
            <option value="咖啡豆">咖啡豆</option>
            <option value="乳制品">乳制品</option>
            <option value="糖浆">糖浆</option>
            <option value="茶叶">茶叶</option>
            <option value="水果">水果</option>
            <option value="辅料">辅料</option>
            <option value="包装">包装</option>
            <option value="其他">其他</option>
          </select>
        </div>
        <div class="form-group">
          <label>单位 *</label>
          <select name="unit" required>
            <option value="">请选择单位</option>
            <option value="kg">kg（千克）</option>
            <option value="g">g（克）</option>
            <option value="L">L（升）</option>
            <option value="mL">mL（毫升）</option>
            <option value="个">个</option>
            <option value="包">包</option>
            <option value="袋">袋</option>
            <option value="瓶">瓶</option>
            <option value="箱">箱</option>
          </select>
        </div>
      </div>
      <div class="form-row">
        <div class="form-group">
          <label>当前库存量 *</label>
          <input type="number" name="quantity" required min="0" step="0.1" placeholder="0.0">
          <div class="hint">输入当前实际库存数量</div>
        </div>
        <div class="form-group">
          <label>预警阈值 *</label>
          <input type="number" name="minQuantity" required min="0" step="0.1" value="10" placeholder="10">
          <div class="hint">库存低于此值将触发预警提醒</div>
        </div>
      </div>
      <div class="form-group">
        <label>供应商</label>
        <input type="text" name="supplier" placeholder="如：云南咖啡供应商">
      </div>
      <div class="form-group">
        <label>备注</label>
        <textarea name="description" placeholder="原料说明、产地、规格等"></textarea>
      </div>
      <div style="margin-top:24px;">
        <button type="submit" class="btn-submit">✅ 确认新增</button>
        <a class="btn-cancel" href="${pageContext.request.contextPath}/admin/InventoryListServlet">取消</a>
      </div>
    </form>
  </div>
</div>
</body>
</html>
