<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>确认订单</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:90px;}
        .title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .block {background:#fff;margin:10px 15px;border-radius:14px;padding:15px;}
        .block-title {font-weight:bold;margin-bottom:10px;font-size:16px;}
        .item-row {display:flex;justify-content:space-between;padding:6px 0;}
        .input-box {width:100%;padding:10px;border:1px solid #E0CDB4;border-radius:10px;margin-top:8px;outline:none;background:#FFF9EF;}
        .split {height:1px;background:#E9D9C2;margin:10px 0;}
        /* 底部提交栏 */
        .pay-bar {position:fixed;bottom:0;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .pay-total {font-size:18px;font-weight:bold;color:#C9B48E;}
        .pay-btn {padding:10px 26px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;}
    </style>
</head>
<body>
<div class="title">确认订单</div>

<!-- 收货信息 -->
<div class="block">
    <div class="block-title">收货信息</div>
    <input class="input-box" placeholder="请输入手机号">
    <input class="input-box" placeholder="备注（少糖/去冰等）">
</div>

<!-- 商品清单 -->
<div class="block">
    <div class="block-title">商品清单</div>
    <div class="item-row">
        <span>经典拿铁 ×1</span>
        <span>¥22</span>
    </div>
    <div class="item-row">
        <span>提拉米苏 ×2</span>
        <span>¥36</span>
    </div>
    <div class="split"></div>
    <div class="item-row">
        <span>优惠券抵扣</span>
        <span>-¥5</span>
    </div>
    <div class="item-row">
        <span>实付金额</span>
        <span style="color:#C9B48E;font-weight:bold">¥53</span>
    </div>
</div>

<!-- 底部支付栏 -->
<div class="pay-bar">
    <div>实付：<span class="pay-total">¥53</span></div>
    <button class="pay-btn" onclick="location.href='orderSubmitServlet'">提交订单</button>
</div>
</body>
</html>