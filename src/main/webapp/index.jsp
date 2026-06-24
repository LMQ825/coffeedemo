<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>咩嘢熊仔咖啡</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "微软雅黑", sans-serif;
        }
        body {
            background-color: #FFF6E4;
            color: #6D5A47;
            padding: 20px 15px;
            max-width: 480px;
            margin: 0 auto;
        }
        /* 顶部logo区域 */
        .header-logo {
            text-align: center;
            margin: 30px 0 40px;
        }
        .bear-icon {
            font-size: 80px;
            line-height: 1;
        }
        .shop-name {
            font-size: 28px;
            font-weight: bold;
            margin: 10px 0 5px;
            letter-spacing: 3px;
        }
        .shop-slogan {
            font-size: 14px;
            color: #947c64;
            border: 1px solid #C9B48E;
            display: inline-block;
            padding: 4px 16px;
            border-radius: 20px;
            margin-top: 8px;
        }
        /* 四大功能模块卡片 */
        .func-wrap {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }
        .func-card {
            background: #fff;
            border-radius: 14px;
            padding: 20px 10px;
            text-align: center;
            border: 1px solid #E9D9C2;
        }
        .func-icon {
            font-size: 42px;
            margin-bottom: 8px;
        }
        .func-title {
            font-size: 16px;
            font-weight: 500;
        }
        .func-en {
            font-size: 12px;
            color: #a8937b;
            margin-top: 3px;
        }
        /* 礼品卡栏 */
        .gift-card-bar {
            background: #C9B48E;
            border-radius: 10px;
            padding: 12px 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: #fff;
            margin-bottom: 20px;
        }
        .gift-btn {
            background: #fff;
            color: #6D5A47;
            border: none;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 13px;
            cursor: pointer;
        }
        /* 门店模块 */
        .store-box {
            background: #fff;
            border-radius: 14px;
            padding: 16px;
            margin-bottom: 80px;
        }
        .store-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }
        .store-name {
            font-size: 15px;
            font-weight: bold;
        }
        .store-address {
            font-size: 12px;
            color: #947c64;
            line-height: 1.5;
        }
        .go-order-btn {
            font-size: 12px;
            color: #C9B48E;
        }
        /* 底部导航栏 */
        .footer-nav {
            position: fixed;
            bottom: 0;
            left: 0;
            width: 100%;
            max-width: 480px;
            background: #fff;
            display: flex;
            padding: 10px 0;
            border-top: 1px solid #E9D9C2;
        }
        .nav-item {
            flex: 1;
            text-align: center;
            font-size: 12px;
        }
        .nav-icon {
            font-size: 22px;
            margin-bottom: 4px;
            display: block;
        }
        .nav-item.active {
            color: #C9B48E;
        }
    </style>
</head>
<body>
<!-- 顶部店铺logo -->
<div class="header-logo">
    <div class="bear-icon">🐻</div>
    <div class="shop-name">咩嘢熊仔</div>
    <div class="shop-slogan">早咖晚酒</div>
</div>

<!-- 四大功能入口 -->
<div class="func-wrap">
    <div class="func-card" onclick="location.href='coffeeList.jsp'">
        <div class="func-icon">🍸</div>
        <div class="func-title">点单</div>
        <div class="func-en">ORDER</div>
    </div>
    <div class="func-card" onclick="location.href='coffeeList.jsp?type=take'">
        <div class="func-icon">☕</div>
        <div class="func-title">自提</div>
        <div class="func-en">TAKEOUT</div>
    </div>
    <div class="func-card" onclick="location.href='myCoupon.jsp'">
        <div class="func-icon">🎫</div>
        <div class="func-title">优惠券</div>
        <div class="func-en">COUPON</div>
        <div style="font-size:12px;margin-top:4px;color:#a8937b;">0张</div>
    </div>
    <div class="func-card" onclick="location.href='personal.jsp'">
        <div class="func-icon">💰</div>
        <div class="func-title">储值中心</div>
        <div class="func-en">STORED VALUE</div>
        <div style="font-size:12px;margin-top:4px;color:#a8937b;">0.00元</div>
    </div>
</div>

<!-- 礼品卡横幅 -->
<div class="gift-card-bar">
    <span>🎁 礼品卡</span>
    <button class="gift-btn" onclick="alert('礼品卡功能开发中')">立即购买 ></button>
</div>

<!-- 门店信息 -->
<div class="store-box">
    <div class="store-top">
        <span class="store-name">门店 (1)</span>
        <span class="go-order-btn" onclick="location.href='coffeeList.jsp'">去下单 ></span>
    </div>
    <div class="store-name">咩嘢熊仔</div>
    <div class="store-address">四会市东城街道江丽路1座商铺1号（首层）</div>
</div>

<!-- 底部导航 -->
<div class="footer-nav">
    <div class="nav-item active" onclick="location.href='index.jsp'">
        <span class="nav-icon">🏠</span>
        首页
    </div>
    <div class="nav-item" onclick="location.href='coffeeList.jsp'">
        <span class="nav-icon">🍹</span>
        点单
    </div>
    <div class="nav-item" onclick="location.href='myOrder.jsp'">
        <span class="nav-icon">📋</span>
        订单
    </div>
    <div class="nav-item" onclick="location.href='personal.jsp'">
        <span class="nav-icon">👤</span>
        我的
    </div>
</div>
</body>
</html>