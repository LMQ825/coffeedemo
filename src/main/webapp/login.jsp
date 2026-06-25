<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>登录 - 咩嘢熊仔咖啡</title>
  <style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
    body {background:#FFF0DC;height:100vh;display:flex;flex-direction:column;align-items:center;justify-content:center;color:#5C4836;}
    .login-box {width:90%;max-width:400px;background:#fff;border-radius:16px;padding:30px;border:1px solid #E9D9C2;}
    .title {text-align:center;font-size:24px;font-weight:bold;margin-bottom:10px;letter-spacing:2px;}
    .sub-title {text-align:center;font-size:14px;color:#a8937b;margin-bottom:20px;}
    .role-selector {display:flex;gap:12px;margin-bottom:20px;justify-content:center;}
    .role-btn {flex:1;padding:10px 0;border:2px solid #DBC8A8;border-radius:10px;background:#fff;cursor:pointer;text-align:center;font-size:15px;transition:0.3s;}
    .role-btn.active {border-color:#5C4836;background:#F7E9D6;color:#5C4836;font-weight:bold;}
    .role-btn:hover {border-color:#5C4836;}
    .input-item {margin-bottom:18px;}
    .input-item label {display:block;margin-bottom:6px;font-size:14px;}
    .input-coffee {width:100%;padding:11px 14px;border:1px solid #DBC8A8;border-radius:10px;background:#FFF9EF;outline:none;font-size:15px;}
    .input-coffee:focus {border-color:#5C4836;}
    .login-btn {width:100%;padding:12px;background:#C9B48E;color:#fff;border:none;border-radius:20px;font-size:16px;cursor:pointer;margin-top:10px;}
    .login-btn:hover {background:#5C4836;}
    .tip {text-align:center;margin-top:15px;font-size:14px;}
    .tip a {color:#C9B48E;text-decoration:none;}
    .tip a:hover {text-decoration:underline;}
    .msg {color:#d9534f;text-align:center;margin-bottom:12px;font-size:14px;}
  </style>
</head>
<body>
<div class="login-box">
  <div class="title">🐻 咩嘢熊仔</div>
  <div class="sub-title">登录您的账号</div>

  <c:if test="${not empty msg}">
    <div class="msg">${msg}</div>
  </c:if>

  <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
    <!-- 角色选择（隐藏域存储角色值） -->
    <input type="hidden" name="role" id="roleInput" value="user">

    <div class="role-selector">
      <div class="role-btn active" id="userRoleBtn" onclick="selectRole('user')">👤 用户登录</div>
      <div class="role-btn" id="adminRoleBtn" onclick="selectRole('admin')">🔐 管理员登录</div>
    </div>

    <div class="input-item">
      <label>用户名</label>
      <input class="input-coffee" name="username" placeholder="请输入账号" required>
    </div>
    <div class="input-item">
      <label>登录密码</label>
      <input class="input-coffee" name="password" type="password" placeholder="请输入密码" required>
    </div>
    <button class="login-btn" type="submit">登 录</button>
  </form>

  <div class="tip">没有账号？<a href="register.jsp">立即注册</a></div>
  <div class="tip"><a href="index.jsp">返回首页</a></div>
</div>

<script>
  function selectRole(role) {
    // 更新隐藏域
    document.getElementById('roleInput').value = role;

    // 更新按钮样式
    const userBtn = document.getElementById('userRoleBtn');
    const adminBtn = document.getElementById('adminRoleBtn');
    if (role === 'user') {
      userBtn.classList.add('active');
      adminBtn.classList.remove('active');
    } else {
      adminBtn.classList.add('active');
      userBtn.classList.remove('active');
    }
  }
  //1
</script>
</body>
</html>