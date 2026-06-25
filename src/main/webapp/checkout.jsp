<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.coffee.entity.CartItem" %>
<%@ page import="com.example.coffee.entity.User" %>
<%@ page import="com.example.coffee.util.Catalog" %>
<%
    int cid = 0;
    try { cid = Integer.parseInt(request.getParameter("cid")); } catch(Exception e) {}
    CartItem product = Catalog.get(cid);
    if (product == null) {
        response.sendRedirect("coffeeList.jsp");
        return;
    }
    User loginUser = (User) session.getAttribute("loginUser");
    String defaultAddr = (loginUser != null && loginUser.getAddress() != null) ? loginUser.getAddress() : "";
    String defaultPhone = (loginUser != null && loginUser.getPhone() != null) ? loginUser.getPhone() : "";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>直接购买 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:90px;}
        .title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .block {background:#fff;margin:10px 15px;border-radius:14px;padding:15px;}
        .block-title {font-weight:bold;margin-bottom:10px;font-size:16px;}
        .product-row {display:flex;gap:12px;align-items:center;}
        .product-icon {width:60px;height:60px;background:#F7E9D6;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:32px;}
        .product-name {font-weight:bold;font-size:16px;}
        .product-price {color:#C9B48E;font-weight:bold;margin-top:4px;}
        .form-row {display:flex;align-items:center;justify-content:space-between;padding:10px 0;border-bottom:1px solid #F0E6D6;}
        .form-row:last-child {border-bottom:none;}
        .form-label {font-size:15px;flex-shrink:0;width:70px;}
        .form-input {flex:1;border:1px solid #E0CDB4;border-radius:8px;padding:8px 10px;outline:none;background:#FFF9EF;font-size:14px;}
        .form-select {flex:1;border:1px solid #E0CDB4;border-radius:8px;padding:8px 10px;outline:none;background:#FFF9EF;font-size:14px;}
        .qty-box {display:flex;align-items:center;gap:10px;}
        .qty-btn {width:28px;height:28px;border-radius:50%;border:1px solid #C9B48E;background:#fff;cursor:pointer;font-size:15px;line-height:26px;text-align:center;}
        .qty-val {min-width:24px;text-align:center;font-weight:bold;}
        .price-line {display:flex;justify-content:space-between;padding:6px 0;}
        .pay-bar {position:fixed;bottom:0;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .pay-total {font-size:18px;font-weight:bold;color:#C9B48E;}
        .pay-btn {padding:10px 26px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;font-size:15px;}
    </style>
</head>
<body>
<div class="title">确认订单</div>

<form action="OrderSubmitServlet" method="post" id="orderForm">
    <input type="hidden" name="mode" value="buynow">
    <input type="hidden" name="cid" value="<%=cid%>">

    <!-- 商品信息 -->
    <div class="block">
        <div class="block-title">商品</div>
        <div class="product-row">
            <div class="product-icon"><%=product.getIcon()%></div>
            <div>
                <div class="product-name"><%=product.getName()%></div>
                <div class="product-price">¥<%=(int)(double)product.getPrice()%></div>
            </div>
        </div>
    </div>

    <!-- 配送地址 -->
    <div class="block">
        <div class="block-title">配送信息</div>
        <div class="form-row">
            <span class="form-label">手机号</span>
            <input class="form-input" type="text" name="phone" id="phone" value="<%=defaultPhone%>" placeholder="请输入手机号">
        </div>
        <div class="form-row">
            <span class="form-label">地址</span>
            <input class="form-input" type="text" name="address" id="address" value="<%=defaultAddr%>" placeholder="请输入配送地址">
        </div>
    </div>

    <!-- 规格选择 -->
    <div class="block">
        <div class="block-title">规格小料</div>
        <div class="form-row">
            <span class="form-label">杯型</span>
            <select class="form-select" name="cup" id="cup" onchange="calcPrice()">
                <option value="中杯">中杯</option>
                <option value="大杯">大杯 (+¥3)</option>
            </select>
        </div>
        <div class="form-row">
            <span class="form-label">糖度</span>
            <select class="form-select" name="sugar" id="sugar">
                <option value="全糖">全糖</option>
                <option value="七分糖">七分糖</option>
                <option value="半糖">半糖</option>
                <option value="无糖">无糖</option>
            </select>
        </div>
        <div class="form-row">
            <span class="form-label">温度</span>
            <select class="form-select" name="temp" id="temp">
                <option value="热">热</option>
                <option value="常温">常温</option>
                <option value="冰">冰</option>
            </select>
        </div>
        <div class="form-row">
            <span class="form-label">小料</span>
            <select class="form-select" name="topping" id="topping" onchange="calcPrice()">
                <option value="无">无</option>
                <option value="珍珠">珍珠 (+¥3)</option>
                <option value="椰果">椰果 (+¥3)</option>
                <option value="奶盖">奶盖 (+¥5)</option>
            </select>
        </div>
        <div class="form-row">
            <span class="form-label">数量</span>
            <div class="qty-box">
                <span class="qty-btn" onclick="changeQty(-1)">-</span>
                <span class="qty-val" id="qtyVal">1</span>
                <span class="qty-btn" onclick="changeQty(1)">+</span>
            </div>
            <input type="hidden" name="qty" id="qty" value="1">
        </div>
    </div>

    <!-- 备注 -->
    <div class="block">
        <div class="block-title">备注</div>
        <input class="form-input" type="text" name="remark" placeholder="少冰/不要吸管等">
    </div>

    <!-- 底部提交栏 -->
    <div class="pay-bar">
        <div>实付：<span class="pay-total" id="totalDisp">¥<%=(int)(double)product.getPrice()%></span></div>
        <button class="pay-btn" type="button" onclick="submitOrder()">提交订单</button>
    </div>
</form>

<script>
    let basePrice = <%=product.getPrice()%>;
    let qty = 1;

    function changeQty(delta){
        qty += delta;
        if(qty < 1) qty = 1;
        document.getElementById('qtyVal').innerText = qty;
        document.getElementById('qty').value = qty;
        calcPrice();
    }

    function calcPrice(){
        let cup = document.getElementById('cup').value;
        let topping = document.getElementById('topping').value;
        let cupUp = (cup === '大杯') ? 3 : 0;
        let topUp = (topping === '珍珠') ? 3 : (topping === '椰果' ? 3 : (topping === '奶盖' ? 5 : 0));
        let unit = basePrice + cupUp + topUp;
        let total = unit * qty;
        document.getElementById('totalDisp').innerText = '¥' + total;
    }

    function submitOrder(){
        let phone = document.getElementById('phone').value.trim();
        let address = document.getElementById('address').value.trim();
        if(!phone){ alert('请填写手机号'); return; }
        if(!address){ alert('请填写配送地址'); return; }
        document.getElementById('orderForm').submit();
    }
</script>
</body>
</html>
