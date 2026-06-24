<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String preUrl = (String) session.getAttribute("preUrl");
%>
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
    .title {text-align:center;font-size:24px;font-weight:bold;margin-bottom:30px;letter-spacing:2px;}
    .input-item {margin-bottom:18px;}
    .input-item label {display:block;margin-bottom:6px;font-size:14px;}
    .input-coffee {width:100%;padding:11px 14px;border:1px solid #DBC8A8;border-radius:10px;background:#FFF9EF;outline:none;font-size:15px;}
    .login-btn {width:100%;padding:12px;background:#C9B48E;color:#fff;border:none;border-radius:20px;font-size:16px;cursor:pointer;margin-top:10px;}
    .tip {text-align:center;margin-top:15px;font-size:14px;}
    .tip a {color:#C9B48E;text-decoration:none;}
  </style>
</head>
<body>
<div class="login-box">
  <div class="title">🐻 咩嘢熊仔 登录</div>
  <form action="LoginServlet" method="post">
    <input type="hidden" name="preUrl" value="<%=preUrl==null?"index.jsp":preUrl%>">
    <div class="input-item">
      <label>用户名</label>
      <input class="input-coffee" name="username" placeholder="请输入账号" required>
    </div>
    <div class="input-item">
      <label>登录密码</label>
      <input class="input-coffee" name="pwd" type="password" placeholder="请输入密码" required>
    </div>
    <button class="login-btn" type="submit">登录</button>
  </form>
  <div class="tip">没有账号？<a href="register.jsp">立即注册</a></div>
  <div class="tip"><a href="index.jsp">返回首页</a></div>
</div>
</body>
</html>