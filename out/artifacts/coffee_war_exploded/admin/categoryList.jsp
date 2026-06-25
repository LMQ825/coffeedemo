<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>分类管理 - 咩嘢熊仔后台</title>
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
        .header {display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .header h3 {color:#5C4836;}
        .content {background:#fff;border-radius:12px;padding:25px;border:1px solid #E9D9C2;}
        
        /* 消息提示 */
        .msg {padding:12px 20px;border-radius:8px;margin-bottom:20px;font-size:14px;}
        .msg-success {background:#d4edda;color:#155724;border:1px solid #c3e6cb;}
        .msg-fail {background:#f8d7da;color:#721c24;border:1px solid #f5c6cb;}
        
        /* 表格样式 */
        .table-header {display:flex;justify-content:space-between;align-items:center;margin-bottom:15px;}
        .btn-add {padding:10px 20px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;font-size:14px;transition:0.2s;}
        .btn-add:hover {background:#7D664F;}
        
        table {width:100%;border-collapse:collapse;}
        th,td {padding:12px 15px;text-align:left;border-bottom:1px solid #E9D9C2;}
        th {background:#FFF9EF;color:#5C4836;font-weight:600;}
        tr:hover {background:#FFF9EF;}
        
        .status-tag {display:inline-block;padding:4px 12px;border-radius:12px;font-size:12px;}
        .tag-on {background:#d4edda;color:#155724;}
        .tag-off {background:#f8d7da;color:#721c24;}
        
        .btn {padding:6px 14px;border:none;border-radius:6px;cursor:pointer;font-size:12px;transition:0.2s;margin-right:4px;}
        .btn-edit {background:#C9B48E;color:#fff;}
        .btn-toggle {background:#8B7355;color:#fff;}
        .btn-delete {background:#d9534f;color:#fff;}
        .btn:hover {opacity:0.9;}
        
        /* 添加/编辑弹窗 */
        .modal {display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(0,0,0,0.5);z-index:1000;}
        .modal-content {position:absolute;top:50%;left:50%;transform:translate(-50%,-50%);background:#fff;padding:30px;border-radius:12px;width:400px;max-width:90%;}
        .modal-header {display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;}
        .modal-header h4 {color:#5C4836;}
        .modal-close {font-size:24px;color:#7D664F;cursor:pointer;border:none;background:none;}
        .form-group {margin-bottom:15px;}
        .form-group label {display:block;margin-bottom:6px;color:#5C4836;font-size:14px;}
        .form-group input,.form-group textarea {width:100%;padding:10px 12px;border:1px solid #DBC8A8;border-radius:8px;outline:none;font-size:14px;}
        .form-group textarea {resize:vertical;min-height:80px;}
        .form-actions {display:flex;gap:10px;margin-top:20px;}
        .btn-submit {padding:10px 24px;background:#5C4836;color:#fff;border:none;border-radius:8px;cursor:pointer;}
        .btn-cancel {padding:10px 24px;background:#C9B48E;color:#fff;border:none;border-radius:8px;cursor:pointer;}
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
        <a class="active" href="${pageContext.request.contextPath}/admin/CategoryListServlet">🏷️ 分类管理</a>
        <a  href="${pageContext.request.contextPath}/admin/UserListServlet">👤 用户管理</a>
        <a  href="${pageContext.request.contextPath}/admin/InventoryListServlet">📦 库存管理</a>
        <a  href="${pageContext.request.contextPath}/admin/InventoryRecordListServlet">📋 进货记录</a>
        <a  href="${pageContext.request.contextPath}/admin/bannerList.jsp">🖼️ 轮播图管理</a>
        <a  href="${pageContext.request.contextPath}/admin/StatisticsServlet">📈 销售统计</a>
        <a href="${pageContext.request.contextPath}/AdminLogoutServlet" style="margin-top:30px;color:#d9534f;">🚪 退出登录</a>
    </div>
    </div>
</div>

<div class="main">
    <div class="header">
        <h3>🏷️ 分类管理</h3>
        <span>管理员：${sessionScope.adminUser.nickname}</span>
    </div>
    
    <div class="content">
        <!-- 消息提示 -->
        <c:if test="${param.msg == 'add_success'}">
            <div class="msg msg-success">✅ 分类添加成功！</div>
        </c:if>
        <c:if test="${param.msg == 'add_fail'}">
            <div class="msg msg-fail">❌ 分类添加失败！</div>
        </c:if>
        <c:if test="${param.msg == 'update_success'}">
            <div class="msg msg-success">✅ 分类更新成功！</div>
        </c:if>
        <c:if test="${param.msg == 'update_fail'}">
            <div class="msg msg-fail">❌ 分类更新失败！</div>
        </c:if>
        <c:if test="${param.msg == 'delete_success'}">
            <div class="msg msg-success">✅ 分类删除成功！</div>
        </c:if>
        <c:if test="${param.msg == 'delete_fail'}">
            <div class="msg msg-fail">❌ 分类删除失败，可能该分类下还有饮品！</div>
        </c:if>
        
        <!-- 表格头部 -->
        <div class="table-header">
            <span style="color:#7D664F;">共 ${categories.size()} 个分类</span>
            <button class="btn-add" onclick="openAddModal()">+ 新增分类</button>
        </div>
        
        <!-- 分类列表表格 -->
        <c:if test="${not empty categories}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>分类名称</th>
                    <th>描述</th>
                    <th>排序</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${categories}" var="cat">
                <tr>
                    <td>${cat.id}</td>
                    <td><strong>${cat.name}</strong></td>
                    <td>${cat.description != null ? cat.description : '-'}</td>
                    <td>${cat.sortOrder}</td>
                    <td>
                        <c:choose>
                            <c:when test="${cat.status == 1}">
                                <span class="status-tag tag-on">启用</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-tag tag-off">禁用</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <button class="btn btn-edit" onclick="openEditModal(${cat.id}, '${cat.name}', '${cat.description != null ? cat.description : ''}', ${cat.sortOrder}, ${cat.status})">编辑</button>
                        <c:choose>
                            <c:when test="${cat.status == 1}">
                                <button class="btn btn-toggle" onclick="toggleStatus(${cat.id}, 0)">禁用</button>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-toggle" onclick="toggleStatus(${cat.id}, 1)">启用</button>
                            </c:otherwise>
                        </c:choose>
                        <button class="btn btn-delete" onclick="deleteCategory(${cat.id})">删除</button>
                    </td>
                </tr>
                </c:forEach>
            </tbody>
        </table>
        </c:if>
        
        <c:if test="${empty categories}">
            <div style="text-align:center;padding:40px;color:#7D664F;">
                <p style="font-size:16px;">暂无分类数据</p>
                <p style="font-size:14px;margin-top:8px;">点击上方按钮添加第一个分类吧！</p>
            </div>
        </c:if>
    </div>
</div>

<!-- 添加分类弹窗 -->
<div class="modal" id="addModal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>新增分类</h4>
            <button class="modal-close" onclick="closeAddModal()">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/CategoryAddServlet" method="post">
            <div class="form-group">
                <label>分类名称 *</label>
                <input type="text" name="name" required placeholder="如：咖啡、奶茶、茶饮...">
            </div>
            <div class="form-group">
                <label>分类描述</label>
                <textarea name="description" placeholder="可选填写分类描述"></textarea>
            </div>
            <div class="form-group">
                <label>排序（数字越小越靠前）</label>
                <input type="number" name="sortOrder" value="0" min="0">
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-submit">确认添加</button>
                <button type="button" class="btn-cancel" onclick="closeAddModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<!-- 编辑分类弹窗 -->
<div class="modal" id="editModal">
    <div class="modal-content">
        <div class="modal-header">
            <h4>编辑分类</h4>
            <button class="modal-close" onclick="closeEditModal()">&times;</button>
        </div>
        <form action="${pageContext.request.contextPath}/admin/CategoryUpdateServlet" method="post">
            <input type="hidden" name="id" id="editId">
            <div class="form-group">
                <label>分类名称 *</label>
                <input type="text" name="name" id="editName" required>
            </div>
            <div class="form-group">
                <label>分类描述</label>
                <textarea name="description" id="editDesc"></textarea>
            </div>
            <div class="form-group">
                <label>排序</label>
                <input type="number" name="sortOrder" id="editSort" min="0">
            </div>
            <div class="form-group">
                <label>状态</label>
                <select name="status" id="editStatus" style="width:100%;padding:10px;border:1px solid #DBC8A8;border-radius:8px;">
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-submit">确认修改</button>
                <button type="button" class="btn-cancel" onclick="closeEditModal()">取消</button>
            </div>
        </form>
    </div>
</div>

<script>
// 添加弹窗
function openAddModal() {
    document.getElementById('addModal').style.display = 'block';
}
function closeAddModal() {
    document.getElementById('addModal').style.display = 'none';
}

// 编辑弹窗
function openEditModal(id, name, desc, sort, status) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editDesc').value = desc;
    document.getElementById('editSort').value = sort;
    document.getElementById('editStatus').value = status;
    document.getElementById('editModal').style.display = 'block';
}
function closeEditModal() {
    document.getElementById('editModal').style.display = 'none';
}

// 切换状态
function toggleStatus(id, status) {
    if (confirm('确定要切换该分类的状态吗？')) {
        location.href = '${pageContext.request.contextPath}/admin/CategoryStatusServlet?id=' + id + '&status=' + status;
    }
}

// 删除分类
function deleteCategory(id) {
    if (confirm('确定要删除该分类吗？删除后该分类下的饮品将失去分类！')) {
        location.href = '${pageContext.request.contextPath}/admin/CategoryDeleteServlet?id=' + id;
    }
}

// 点击弹窗外部关闭
window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.style.display = 'none';
    }
}
</script>
</body>
</html>