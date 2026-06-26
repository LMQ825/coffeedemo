<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.example.coffee.entity.User" %>
<%@ page import="com.example.coffee.entity.CartItem" %>
<%@ page import="com.example.coffee.entity.Product" %>
<%@ page import="com.example.coffee.service.ProductService" %>
<%@ page import="com.example.coffee.impl.ProductServiceImpl" %>
<%@ page import="java.util.List" %>
<%
    // ========== 接收直接购买参数 ==========
    String mode = request.getParameter("mode");
    String cidStr = request.getParameter("cid");
    String qtyStr = request.getParameter("qty");
    String cup = request.getParameter("cup");
    String sugar = request.getParameter("sugar");
    String temp = request.getParameter("temp");
    String topping = request.getParameter("topping");  // 可能为 "珍珠+椰果" 等多选
    String specRemark = request.getParameter("remark");

    int cid = 0;
    int qty = 1;
    Product buyProduct = null;
    double itemTotal = 0;

    if ("buynow".equals(mode) && cidStr != null && !cidStr.isEmpty()) {
        cid = Integer.parseInt(cidStr);
        qty = Integer.parseInt(qtyStr);

        // 从数据库加载商品
        ProductService productService = new ProductServiceImpl();
        buyProduct = productService.getProductById(cid);  // 请确保 ProductServiceImpl 中存在该方法

        if (buyProduct != null) {
            double basePrice = buyProduct.getPrice();
            double extra = 0;

            // 计算加价（支持多选加料）
            if ("大杯".equals(cup)) extra += 3;
            if (topping != null && !topping.isEmpty()) {
                if (topping.contains("珍珠")) extra += 3;
                if (topping.contains("椰果")) extra += 3;
                if (topping.contains("奶盖")) extra += 5;
            }

            itemTotal = (basePrice + extra) * qty;
        }
    }

    // ========== 购物车数据 ==========
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double cartTotal = 0;
    if (cart != null) {
        for (CartItem ci : cart) {
            cartTotal += ci.getSubtotal();
        }
    }

    // ========== 用户地址/手机 ==========
    User loginUser = (User) session.getAttribute("loginUser");
    String defAddr = "";
    String defPhone = "";
    if (loginUser != null) {
        defAddr = loginUser.getAddress() == null ? "" : loginUser.getAddress();
        defPhone = loginUser.getPhone() == null ? "" : loginUser.getPhone();
    }

    // 设置 request 属性以便 EL 使用
    request.setAttribute("mode", mode);
    request.setAttribute("buyProduct", buyProduct);
    request.setAttribute("cid", cid);
    request.setAttribute("qty", qty);
    request.setAttribute("cup", cup);
    request.setAttribute("sugar", sugar);
    request.setAttribute("temp", temp);
    request.setAttribute("topping", topping);
    request.setAttribute("specRemark", specRemark);
    request.setAttribute("itemTotal", itemTotal);
    request.setAttribute("cart", cart);
    request.setAttribute("cartTotal", cartTotal);
    request.setAttribute("defAddr", defAddr);
    request.setAttribute("defPhone", defPhone);
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
    </style>
</head>
<body>
<div class="title">确认订单</div>

<form action="OrderSubmitServlet" method="post" id="orderForm">
    <input type="hidden" name="mode" value="${mode}">
    <c:if test="${mode == 'buynow'}">
        <input type="hidden" name="cid" value="${cid}">
        <input type="hidden" name="qty" value="${qty}">
        <input type="hidden" name="cup" value="${cup}">
        <input type="hidden" name="sugar" value="${sugar}">
        <input type="hidden" name="temp" value="${temp}">
        <input type="hidden" name="topping" value="${topping}">
        <input type="hidden" name="remark" value="${specRemark}">
    </c:if>

    <!-- 配送信息 -->
    <div class="block">
        <div class="block-title">配送信息</div>
        <input class="input-box" type="text" name="phone" value="${defPhone}" placeholder="请输入手机号" required>
        <input class="input-box" type="text" name="address" value="${defAddr}" placeholder="请输入配送地址" required>
    </div>

    <!-- 商品清单 -->
    <div class="block">
        <div class="block-title">商品清单</div>

        <%-- 直接购买单品 --%>
        <c:if test="${mode == 'buynow' && buyProduct != null}">
            <div class="item-row">
                <span class="item-name">☕ ${buyProduct.name} ×${qty}</span>
                <span class="item-sub">¥<fmt:formatNumber value="${itemTotal}" pattern="#"/></span>
            </div>
            <div class="item-row">
                <span class="item-sub">
                    规格：${cup} / ${temp} / ${sugar} / ${topping}
                </span>
            </div>
            <c:if test="${not empty specRemark}">
                <div class="item-row">
                    <span class="item-sub">备注：${specRemark}</span>
                </div>
            </c:if>
        </c:if>
        <c:if test="${mode == 'buynow' && buyProduct == null}">
            <div class="item-row" style="color:red;">商品信息加载失败，请返回重试</div>
        </c:if>

        <%-- 购物车结算 --%>
        <c:if test="${mode != 'buynow'}">
            <c:choose>
                <c:when test="${not empty cart}">
                    <c:forEach items="${cart}" var="item">
                        <div class="item-row">
                            <span class="item-name">☕ ${item.name} ×${item.quantity}</span>
                            <span class="item-sub">¥<fmt:formatNumber value="${item.subtotal}" pattern="#"/></span>
                        </div>
                        <div class="item-row">
                            <span class="item-sub">规格：${item.spec}</span>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="item-row">购物车为空，请先添加商品</div>
                </c:otherwise>
            </c:choose>
        </c:if>

        <div class="split"></div>
        <div class="item-row">
            <span>实付金额</span>
            <span style="color:#C9B48E;font-weight:bold;font-size:18px;">
                <c:choose>
                    <c:when test="${mode == 'buynow'}">¥<fmt:formatNumber value="${itemTotal}" pattern="#"/></c:when>
                    <c:otherwise>¥<fmt:formatNumber value="${cartTotal}" pattern="#"/></c:otherwise>
                </c:choose>
            </span>
        </div>
    </div>

    <!-- 订单备注 -->
    <div class="block">
        <div class="block-title">额外备注</div>
        <input class="input-box" type="text" name="remark" value="${specRemark}" placeholder="少冰/不要吸管等">
    </div>

    <!-- 底部提交栏 -->
    <div class="pay-bar">
        <div>实付：
            <span class="pay-total">
                <c:choose>
                    <c:when test="${mode == 'buynow'}">¥<fmt:formatNumber value="${itemTotal}" pattern="#"/></c:when>
                    <c:otherwise>¥<fmt:formatNumber value="${cartTotal}" pattern="#"/></c:otherwise>
                </c:choose>
            </span>
        </div>
        <button class="pay-btn" type="button" onclick="submitOrder()">提交订单</button>
    </div>
</form>

<script>
    function submitOrder(){
        let phone = document.querySelector('input[name="phone"]').value.trim();
        let address = document.querySelector('input[name="address"]').value.trim();
        if(!phone){
            alert("请填写手机号");
            return;
        }
        if(!address){
            alert("请填写配送地址");
            return;
        }
        <c:if test="${mode == 'buynow' && buyProduct == null}">
        alert("商品信息无效，无法提交");
        return;
        </c:if>
        document.getElementById("orderForm").submit();
    }
</script>
</body>
</html>