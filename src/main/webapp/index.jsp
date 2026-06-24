<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>咩嘢熊仔咖啡-管理后台</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            list-style: none;
            text-decoration: none;
        }
        body {
            background-color: #FFF0DC;
            font-family: "微软雅黑", sans-serif;
            color: #5C4836;
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        /* 左侧侧边栏 */
        .sidebar {
            width: 240px;
            background: linear-gradient(180deg, #F3E2CD, #E8D4BC);
            border-right: 1px solid #D9C3A8;
            padding: 30px 0;
            display: flex;
            flex-direction: column;
        }
        /* Logo区域 */
        .logo-box {
            text-align: center;
            padding-bottom: 30px;
            border-bottom: 1px solid #D9C3A8;
            margin: 0 20px 20px;
        }
        .bear-icon {
            font-size: 80px;
            line-height: 1;
        }
        .logo-text {
            font-size: 22px;
            font-weight: 600;
            color: #5C4836;
            letter-spacing: 2px;
            margin-top:8px;
        }
        .logo-slogan {
            font-size: 13px;
            color: #7D664F;
            margin-top: 4px;
        }
        /* 导航菜单 */
        .nav-list {
            flex: 1;
            padding: 0 10px;
        }
        .nav-item {
            margin-bottom: 6px;
            border-radius: 10px;
            overflow: hidden;
        }
        .nav-link {
            display: flex;
            align-items: center;
            padding: 14px 16px;
            color: #5C4836;
            font-size: 15px;
            gap: 10px;
            cursor: pointer;
            transition: 0.2s;
        }
        .nav-link:hover, .nav-link.active {
            background-color: #5C4836;
            color: #FFF0DC;
        }
        .nav-icon {
            font-size: 18px;
            width: 22px;
            text-align: center;
        }
        /* 子菜单（点单展开） */
        .sub-menu {
            background-color: #E8D4BC;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        .sub-menu.show {
            max-height: 240px;
        }
        .sub-link {
            display: block;
            padding: 12px 16px 12px 48px;
            color: #7D664F;
            font-size: 14px;
            transition: 0.2s;
        }
        .sub-link:hover {
            background-color: #D9C3A8;
            color: #5C4836;
        }
        /* 右侧主内容区 */
        .main-wrap {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        /* 顶部搜索栏 */
        .top-bar {
            height: 70px;
            background: #F9EBD9;
            display: flex;
            align-items: center;
            padding: 0 30px;
            border-bottom: 1px solid #D9C3A8;
            gap: 20px;
        }
        .search-input {
            width: 320px;
            height: 38px;
            border: 1px solid #C9B48E;
            border-radius: 20px;
            padding: 0 16px;
            background: #fff;
            outline: none;
            color: #5C4836;
        }
        .search-input::placeholder {
            color: #B8A388;
        }
        .top-right {
            margin-left: auto;
            display: flex;
            gap: 16px;
            align-items: center;
        }
        .top-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: #E8D4BC;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #5C4836;
        }
        /* 内容区域 */
        .content-box {
            flex: 1;
            padding: 30px;
            overflow-y: auto;
        }
        .content-inner {
            width: 100%;
            padding:25px;
            background: #fff;
            border-radius: 16px;
            border: 1px solid #E8D4BC;
        }
        /* 首页功能卡片原有样式完全保留 */
        .func-wrap {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }
        .func-card {
            background: #fff;
            border-radius: 14px;
            padding: 20px 10px;
            text-align: center;
            border: 1px solid #E9D9C2;
            cursor: pointer;
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
        .store-box {
            background: #fff;
            border-radius: 14px;
            padding: 16px;
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
            cursor: pointer;
        }
    </style>
</head>
<body>
<!-- 左侧侧边栏 -->
<div class="sidebar">
    <div class="logo-box">
        <div class="bear-icon">🐻</div>
        <div class="logo-text">咩嘢熊仔</div>
        <div class="logo-slogan">早咖晚酒</div>
    </div>
    <ul class="nav-list">
        <li class="nav-item">
            <a href="index.jsp" class="nav-link active">
                <span class="nav-icon">🏠</span>
                <span>首页</span>
            </a>
        </li>
        <li class="nav-item">
            <div class="nav-link" id="orderMenuBtn">
                <span class="nav-icon">☕</span>
                <span>点单</span>
            </div>
            <ul class="sub-menu" id="orderSubMenu">
                <li><a href="coffeeList.jsp" class="sub-link">意式咖啡</a></li>
                <li><a href="coffeeList.jsp" class="sub-link">冷萃咖啡</a></li>
                <li><a href="coffeeList.jsp" class="sub-link">特色美式</a></li>
                <li><a href="coffeeList.jsp" class="sub-link">特调饮品</a></li>
                <li><a href="coffeeList.jsp" class="sub-link">甜品小食</a></li>
            </ul>
        </li>
        <li class="nav-item">
            <a href="myOrder.jsp" class="nav-link">
                <span class="nav-icon">📋</span>
                <span>订单</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="personal.jsp" class="nav-link">
                <span class="nav-icon">👤</span>
                <span>我的</span>
            </a>
        </li>
    </ul>
</div>

<!-- 右侧主区域 -->
<div class="main-wrap">
    <div class="top-bar">
        <input type="text" class="search-input" placeholder="关键词搜索">
        <div class="top-right">
            <div class="top-icon">🕐</div>
            <div class="top-icon">🔔</div>
            <div class="top-icon">👨</div>
        </div>
    </div>
    <div class="content-box">
        <div class="content-inner">
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
            <div class="gift-card-bar">
                <span>🎁 礼品卡</span>
                <button class="gift-btn" onclick="alert('礼品卡功能开发中')">立即购买 ></button>
            </div>
            <div class="store-box">
                <div class="store-top">
                    <span class="store-name">门店 (1)</span>
                    <span class="go-order-btn" onclick="location.href='coffeeList.jsp'">去下单 ></span>
                </div>
                <div class="store-name">咩嘢熊仔</div>
                <div class="store-address">四会市东城街道江丽路1座商铺1号（首层）</div>
            </div>
        </div>
    </div>
</div>

<script>
    const menuBtn = document.getElementById('orderMenuBtn');
    const subMenu = document.getElementById('orderSubMenu');
    menuBtn.addEventListener('click', function () {
        subMenu.classList.toggle('show');
    })
</script>
</body>
</html>