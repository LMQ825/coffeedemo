<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.coffee.entity.Order" %>
<%@ page import="com.example.coffee.impl.OrderServiceImpl" %>
<%
    int orderId = 0;
    try { orderId = Integer.parseInt(request.getParameter("orderId")); } catch(Exception e) {}
    Order order = new OrderServiceImpl().getOrderDetail(orderId);
    if (order == null) {
        response.sendRedirect("myOrder.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>支付 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:90px;}
        .title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .block {background:#fff;margin:10px 15px;border-radius:14px;padding:15px;}
        .block-title {font-weight:bold;margin-bottom:10px;font-size:16px;}
        .order-no {color:#947c64;font-size:13px;margin-bottom:8px;}
        .price-row {display:flex;justify-content:space-between;padding:6px 0;}
        .price-total {font-size:20px;color:#C9B48E;font-weight:bold;}
        .pay-method {display:flex;gap:12px;margin-top:15px;}
        .pay-card {flex:1;border:2px solid #E9D9C2;border-radius:12px;padding:20px;text-align:center;cursor:pointer;transition:0.2s;}
        .pay-card.selected {border-color:#C9B48E;background:#FFF9EF;}
        .pay-icon {font-size:40px;margin-bottom:8px;}
        .pay-name {font-size:15px;font-weight:bold;}
        .pay-bar {position:fixed;bottom:0;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .pay-total {font-size:18px;font-weight:bold;color:#C9B48E;}
        .pay-btn {padding:10px 30px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;font-size:15px;}
    </style>
</head>
<body>
<div class="title">订单支付</div>

<form action="PayServlet" method="post" id="payForm">
    <input type="hidden" name="orderId" value="<%=orderId%>">
    <input type="hidden" name="payMethod" id="payMethod" value="wechat">

    <div class="block">
        <div class="block-title">订单信息</div>
        <div class="order-no">订单号：<%=order.getOrderNo()%></div>
        <div class="price-row">
            <span>订单金额</span>
            <span>¥<%=(int)(double)order.getTotalPrice()%></span>
        </div>
        <div class="price-row">
            <span>实付金额</span>
            <span class="price-total">¥<%=(int)(double)order.getTotalPrice()%></span>
        </div>
    </div>

    <div class="block">
        <div class="block-title">选择支付方式</div>
        <div class="pay-method">
            <div class="pay-card selected" onclick="selectPay('wechat', this)">
                <div class="pay-icon">💚</div>
                <div class="pay-name">微信支付</div>
            </div>
            <div class="pay-card" onclick="selectPay('alipay', this)">
                <div class="pay-icon">💙</div>
                <div class="pay-name">支付宝</div>
            </div>
        </div>
    </div>

    <div class="pay-bar">
        <div>实付：<span class="pay-total">¥<%=(int)(double)order.getTotalPrice()%></span></div>
        <button class="pay-btn" type="button" onclick="doPay()">确认支付</button>
    </div>
</form>

<script>
    function selectPay(method, el){
        document.getElementById('payMethod').value = method;
        document.querySelectorAll('.pay-card').forEach(c => c.classList.remove('selected'));
        el.classList.add('selected');
    }

    function doPay(){
        if(confirm('确认支付？')){
            document.getElementById('payForm').submit();
        }
    }
</script>
</body>
</html>
