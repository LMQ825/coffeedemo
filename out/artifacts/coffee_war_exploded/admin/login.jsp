<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>咩嘢熊仔 · 后台登录</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;height:100vh;display:flex;justify-content:center;align-items:center;}
        .login-box {width:380px;background:#fff;border-radius:16px;padding:40px;border:1px solid #E9D9C2;text-align:center;}
        .login-box h1 {font-size:24px;margin-bottom:8px;color:#5C4836;}
        .login-box p.sub {color:#a8937b;margin-bottom:30px;}
        .input-group {margin-bottom:18px;text-align:left;}
        .input-group label {font-size:14px;display:block;margin-bottom:4px;}
        .input-group input {width:100%;padding:12px 14px;border:1px solid #DBC8A8;border-radius:10px;outline:none;font-size:15px;background:#FFF9EF;}
        .login-btn {width:100%;padding:12px;background:#5C4836;color:#fff;border:none;border-radius:20px;font-size:16px;cursor:pointer;}
        .login-btn:hover {background:#4a3728;}
        .msg {color:#d9534f;margin-bottom:12px;font-size:14px;}
        .back-link {display:block;margin-top:15px;color:#a8937b;font-size:13px;text-decoration:none;}
    </style>
</head>
<body>
<div class="login-box">
    <h1>🐻 咩嘢熊仔</h1>
    <p class="sub">管理员登录</p>
    <form action="${pageContext.request.contextPath}/AdminLoginServlet" method="post">
        <div class="input-group">
            <label>管理员账号</label>
            <input type="text" name="username" placeholder="请输入账号" required>
        </div>
        <div class="input-group">
            <label>登录密码</label>
            <input type="password" name="password" placeholder="请输入密码" required>
        </div>
        <c:if test="${not empty msg}">
            <div class="msg">${msg}</div>
        </c:if>
        <button class="login-btn" type="submit">登 录</button>
    </form>
    <a class="back-link" href="${pageContext.request.contextPath}/index.jsp">← 返回首页</a>
</div>
</body>
</html>
