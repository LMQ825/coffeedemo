<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.coffee.entity.CartItem" %>
<%@ page import="com.example.coffee.entity.User" %>
<%@ page import="java.util.List" %>
<%
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double total = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
    }
    request.setAttribute("cartTotal", total);
    User loginUser = (User) session.getAttribute("loginUser");
    String defaultAddr = (loginUser != null && loginUser.getAddress() != null) ? loginUser.getAddress() : "";
    String defaultPhone = (loginUser != null && loginUser.getPhone() != null) ? loginUser.getPhone() : "";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>确认订单 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:90px;}
        .title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .block {background:#fff;margin:10px 15px;border-radius:14px;padding:15px;}
        .block-title {font-weight:bold;margin-bottom:10px;font-size:16px;}
        .item-row {display:flex;justify-content:space-between;padding:6px 0;align-items:center;}
        .item-name {flex:1;}
        .item-sub {color:#947c64;font-size:13px;}
        .input-box {width:100%;padding:10px;border:1px solid #E0CDB4;border-radius:10px;margin-top:8px;outline:none;background:#FFF9EF;font-size:14px;}
        .split {height:1px;background:#E9D9C2;margin:10px 0;}
        .pay-bar {position:fixed;bottom:0;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .pay-total {font-size:18px;font-weight:bold;color:#C9B48E;}
        .pay-btn {padding:10px 26px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;font-size:15px;}
        .empty-tip {text-align:center;margin-top:60px;color:#947c64;}
        .empty-tip a {color:#C9B48E;}
    </style>
</head>
<body>
<div class="title">确认订单</div>

<c:choose>
    <c:when test="${empty cart || cartTotal == 0}">
        <div class="empty-tip">
            <p style="font-size:40px;">🛒</p>
            <p style="margin-top:10px;">购物车为空，无法提交订单</p>
            <p style="margin-top:10px;"><a href="coffeeList.jsp">去点单 ></a></p>
        </div>
    </c:when>
    <c:otherwise>
        <form action="OrderSubmitServlet" method="post" id="orderForm">
            <!-- 配送信息 -->
            <div class="block">
                <div class="block-title">配送信息</div>
                <input class="input-box" type="text" name="phone" id="phone" value="<%=defaultPhone%>" placeholder="请输入手机号">
                <input class="input-box" type="text" name="address" id="address" value="<%=defaultAddr%>" placeholder="请输入配送地址">
            </div>

            <!-- 商品清单 -->
            <div class="block">
                <div class="block-title">商品清单</div>
                <c:forEach items="${cart}" var="item">
                    <div class="item-row">
                        <span class="item-name">${item.icon} ${item.name} ×${item.quantity}</span>
                        <span class="item-sub">¥<fmt:formatNumber value="${item.subtotal}" pattern="#"/></span>
                    </div>
                </c:forEach>
                <div class="split"></div>
                <div class="item-row">
                    <span>实付金额</span>
                    <span style="color:#C9B48E;font-weight:bold;font-size:18px;">¥<fmt:formatNumber value="${cartTotal}" pattern="#"/></span>
                </div>
            </div>

            <!-- 备注 -->
            <div class="block">
                <div class="block-title">备注</div>
                <input class="input-box" type="text" name="remark" placeholder="少冰/不要吸管等">
            </div>

            <!-- 底部提交栏 -->
            <div class="pay-bar">
                <div>实付：<span class="pay-total">¥<fmt:formatNumber value="${cartTotal}" pattern="#"/></span></div>
                <button class="pay-btn" type="button" onclick="submitOrder()">提交订单</button>
            </div>
        </form>

        <script>
            let loginUser = ${sessionScope.loginUser != null ? 1 : 0};
            function submitOrder(){
                if(loginUser !== 1){
                    alert("请先登录账号！");
                    location.href = "login.jsp";
                    return;
                }
                let phone = document.getElementById("phone").value.trim();
                let address = document.getElementById("address").value.trim();
                if(!phone){ alert("请填写收货手机号"); return; }
                if(!address){ alert("请填写配送地址"); return; }
                document.getElementById("orderForm").submit();
            }
        </script>
    </c:otherwise>
</c:choose>
</body>
</html>
