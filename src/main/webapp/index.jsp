<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // 页面标识：home / order / cart / personal / 饮品分类
    String pageFlag = request.getParameter("page") == null ? "home" : request.getParameter("page");
    String type = request.getParameter("type");
    if(type == null) type = "";
%>
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
        /* 左侧侧边栏 完全原样 */
        .sidebar {
            width: 240px;
            background: linear-gradient(180deg, #F3E2CD, #E8D4BC);
            border-right: 1px solid #D9C3A8;
            padding: 30px 0;
            display: flex;
            flex-direction: column;
        }
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
        /* 点单子菜单 */
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
            cursor: pointer;
        }
        .sub-link.active {
            background-color: #D9C3A8;
            color: #5C4836;
            font-weight:bold;
        }
        .sub-link:hover {
            background-color: #D9C3A8;
            color: #5C4836;
        }
        /* 右侧主区域 */
        .main-wrap {
            flex: 1;
            display: flex;
            flex-direction: column;
        }
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
        /* 首页功能卡片 */
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
        /* 饮品商品卡片 */
        .coffee-title{
            font-size:18px;
            font-weight:bold;
            margin-bottom:16px;
        }
        .coffee-wrap{
            display:grid;
            grid-template-columns: repeat(4,1fr);
            gap:14px;
            margin-bottom:20px;
        }
        .coffee-card{
            background:#FFF0DC;
            border-radius:14px;
            overflow:hidden;
            border:1px solid #E9D9C2;
        }
        .coffee-img{
            height:130px;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:52px;
        }
        .coffee-info{
            padding:12px;
            background:#fff;
        }
        .coffee-name{
            font-weight:bold;
            font-size:15px;
            margin-bottom:5px;
        }
        .coffee-price{
            color:#C9B48E;
            font-weight:bold;
            margin-bottom:10px;
        }
        .btn-row{
            display:flex;
            gap:8px;
        }
        .buy-now{
            flex:1;
            padding:7px 0;
            background:#5C4836;
            color:#fff;
            border:none;
            border-radius:12px;
            cursor:pointer;
            font-size:14px;
        }
        .add-cart{
            flex:0.5;
            padding:7px 0;
            background:#C9B48E;
            color:#fff;
            border:none;
            border-radius:12px;
            cursor:pointer;
            font-size:14px;
        }
        /* 购物车样式 */
        .cart-item {background:#fff;margin:10px 0;border-radius:14px;padding:12px;display:flex;gap:12px;align-items:center;}
        .item-icon {width:60px;height:60px;background:#F7E9D6;border-radius:10px;display:flex;align-items:center;justify-content:center;font-size:30px;}
        .item-info {flex:1;}
        .item-name {font-weight:bold;margin-bottom:4px;}
        .item-price {color:#C9B48E;}
        .num-box {display:flex;gap:8px;align-items:center;}
        .num-btn {width:26px;height:26px;border-radius:50%;border:1px solid #C9B48E;background:#fff;cursor:pointer;}
        .del-btn {color:#ff6b6b;font-size:13px;cursor:pointer;margin-left:8px;}
        .settle-bar {margin-top:20px;padding-top:15px;border-top:1px solid #E9D9C2;display:flex;justify-content:space-between;align-items:center;}
        .submit-btn {padding:10px 24px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;}
        /* 订单双列布局 */
        .order-container {display:grid;grid-template-columns:repeat(2,1fr);gap:12px;}
        .order-card {background:#fff;border-radius:14px;padding:15px;border:1px solid #E9D9C2;}
        .order-top {display:flex;justify-content:space-between;margin-bottom:10px;}
        .order-status {color:#C9B48E;font-weight:bold;}
        .order-item {display:flex;gap:10px;align-items:center;margin:8px 0;}
        .order-icon {width:40px;height:40px;background:#F7E9D6;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:20px;}
        .order-bottom {display:flex;justify-content:space-between;margin-top:12px;padding-top:10px;border-top:1px solid #E9D9C2;}
        .detail-btn {border:1px solid #C9B48E;padding:4px 12px;border-radius:14px;font-size:13px;cursor:pointer;background:#fff;color:#5C4836;}
        /* 我的页面 */
        .personal-box{text-align:center;padding:40px 0;}
        .avatar{width:100px;height:100px;border-radius:50%;background:#E8D4BC;margin:0 auto 20px;display:flex;align-items:center;justify-content:center;font-size:40px;}
        .personal-name{font-size:20px;font-weight:bold;margin-bottom:30px;}
        .personal-menu{display:grid;grid-template-columns:1fr 1fr;gap:12px;}
        .personal-menu-item{background:#FFF0DC;padding:20px;border-radius:14px;cursor:pointer;}

        /* 自定义面板 */
        .customize-wrap{display:none;gap:20px;}
        .customize-wrap.show{display:flex;}
        .customize-left{flex:1;min-width:0;}
        .customize-right{width:260px;flex-shrink:0;}
        .selected-card{background:#FFF0DC;border-radius:16px;border:2px solid #C9B48E;overflow:hidden;position:sticky;top:0;}
        .selected-card-img{height:160px;display:flex;align-items:center;justify-content:center;font-size:72px;}
        .selected-card-info{padding:16px;background:#fff;}
        .selected-card-name{font-size:18px;font-weight:bold;margin-bottom:6px;}
        .selected-card-price{color:#C9B48E;font-weight:bold;font-size:16px;margin-bottom:14px;}
        .action-row{display:flex;gap:10px;}
        .back-btn{flex:1;padding:10px 0;background:#fff;color:#5C4836;border:1.5px solid #C9B48E;border-radius:12px;cursor:pointer;font-size:14px;}
        .checkout-btn{flex:1;padding:10px 0;background:#5C4836;color:#fff;border:none;border-radius:12px;cursor:pointer;font-size:14px;}
        .opt-section{margin-bottom:18px;}
        .opt-label{font-size:14px;font-weight:bold;color:#5C4836;margin-bottom:8px;}
        .opt-chips{display:flex;flex-wrap:wrap;gap:8px;}
        .opt-chip{padding:6px 14px;border-radius:20px;border:1.5px solid #D9C3A8;background:#fff;color:#5C4836;font-size:13px;cursor:pointer;transition:.15s;}
        .opt-chip.selected{background:#5C4836;color:#fff;border-color:#5C4836;}
        .opt-chip:hover:not(.selected){background:#F3E2CD;}

        /* 支付弹窗 */
        .pay-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.45);z-index:1000;align-items:center;justify-content:center;}
        .pay-overlay.show{display:flex;}
        .pay-modal{background:#fff;border-radius:20px;padding:32px 28px;width:380px;max-width:95vw;}
        .pay-modal-title{font-size:18px;font-weight:bold;color:#5C4836;margin-bottom:6px;}
        .pay-modal-sub{font-size:13px;color:#a8937b;margin-bottom:24px;}
        .pay-amount{font-size:28px;font-weight:bold;color:#5C4836;margin-bottom:24px;}
        .pay-methods{display:flex;gap:14px;margin-bottom:28px;}
        .pay-method{flex:1;border:2px solid #E9D9C2;border-radius:14px;padding:16px 10px;text-align:center;cursor:pointer;transition:.15s;}
        .pay-method.selected{border-color:#5C4836;background:#FFF0DC;}
        .pay-method-icon{font-size:36px;margin-bottom:6px;}
        .pay-method-name{font-size:14px;color:#5C4836;font-weight:500;}
        .pay-confirm-btn{width:100%;padding:12px 0;background:#5C4836;color:#fff;border:none;border-radius:14px;font-size:16px;cursor:pointer;}
        .pay-cancel-btn{width:100%;margin-top:10px;padding:10px 0;background:#fff;color:#a8937b;border:none;border-radius:14px;font-size:14px;cursor:pointer;}

        /* 支付成功弹窗 */
        .success-overlay{display:none;position:fixed;inset:0;background:rgba(0,0,0,.45);z-index:1001;align-items:center;justify-content:center;}
        .success-overlay.show{display:flex;}
        .success-modal{background:#fff;border-radius:20px;padding:40px 32px;width:320px;text-align:center;}
        .success-icon{font-size:56px;margin-bottom:12px;}
        .success-title{font-size:20px;font-weight:bold;color:#5C4836;margin-bottom:8px;}
        .success-sub{font-size:13px;color:#a8937b;margin-bottom:24px;}
        .success-btn{padding:10px 32px;background:#5C4836;color:#fff;border:none;border-radius:14px;font-size:15px;cursor:pointer;}
    </style>
</head>
<body>
<!-- 左侧侧边栏 购物车提升为一级菜单，和订单/我的同级 -->
<div class="sidebar">
    <div class="logo-box">
        <div class="bear-icon">🐻</div>
        <div class="logo-text">咩嘢熊仔</div>
        <div class="logo-slogan">早咖晚酒</div>
    </div>
    <ul class="nav-list">
        <li class="nav-item">
            <div class="nav-link <%=pageFlag.equals("home")?"active":""%>" onclick="switchPage('home')">
                <span class="nav-icon">🏠</span>
                <span>首页</span>
            </div>
        </li>
        <li class="nav-item">
            <div class="nav-link" id="orderMenuBtn">
                <span class="nav-icon">☕</span>
                <span>点单</span>
            </div>
            <ul class="sub-menu" id="orderSubMenu">
                <li><div class="sub-link <%="意式咖啡".equals(type)?"active":""%>" onclick="switchType('意式咖啡')">意式咖啡</div></li>
                <li><div class="sub-link <%="冷萃咖啡".equals(type)?"active":""%>" onclick="switchType('冷萃咖啡')">冷萃咖啡</div></li>
                <li><div class="sub-link <%="特色美式".equals(type)?"active":""%>" onclick="switchType('特色美式')">特色美式</div></li>
                <li><div class="sub-link <%="特调饮品".equals(type)?"active":""%>" onclick="switchType('特调饮品')">特调饮品</div></li>
                <li><div class="sub-link <%="甜品小食".equals(type)?"active":""%>" onclick="switchType('甜品小食')">甜品小食</div></li>
            </ul>
        </li>
        <!-- 购物车 一级菜单 -->
        <li class="nav-item">
            <div class="nav-link <%=pageFlag.equals("cart")?"active":""%>" onclick="switchPage('cart')">
                <span class="nav-icon">🛒</span>
                <span>购物车</span>
            </div>
        </li>
        <!-- 订单 一级菜单 -->
        <li class="nav-item">
            <div class="nav-link <%=pageFlag.equals("order")?"active":""%>" onclick="switchPage('order')">
                <span class="nav-icon">📋</span>
                <span>订单</span>
            </div>
        </li>
        <!-- 我的 一级菜单 -->
        <li class="nav-item">
            <div class="nav-link <%=pageFlag.equals("personal")?"active":""%>" onclick="switchPage('personal')">
                <span class="nav-icon">👤</span>
                <span>我的</span>
            </div>
        </li>
    </ul>
</div>

<!-- 右侧主区域 所有内容同页渲染，不跳转新页面 -->
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
            <%-- 首页页面 --%>
            <% if(pageFlag.equals("home") && type.equals("")){ %>
            <div class="func-wrap">
                <div class="func-card" onclick="expandMenu()">
                    <div class="func-icon">🍸</div>
                    <div class="func-title">点单</div>
                    <div class="func-en">ORDER</div>
                </div>
                <div class="func-card" onclick="switchType('意式咖啡')">
                    <div class="func-icon">☕</div>
                    <div class="func-title">自提</div>
                    <div class="func-en">TAKEOUT</div>
                </div>
                <div class="func-card">
                    <div class="func-icon">🎫</div>
                    <div class="func-title">优惠券</div>
                    <div class="func-en">COUPON</div>
                    <div style="font-size:12px;margin-top:4px;color:#a8937b;">0张</div>
                </div>
                <div class="func-card">
                    <div class="func-icon">💰</div>
                    <div class="func-title">储值中心</div>
                    <div class="func-en">STORED VALUE</div>
                    <div style="font-size:12px;margin-top:4px;color:#a8937b;">0.00元</div>
                </div>
            </div>
            <% } %>

            <%-- 点单饮品分类页面 --%>
            <% if(!type.equals("")){ %>
            <%-- 饮品列表 --%>
            <div id="drinkListPanel">
            <div class="coffee-title"><%=type%></div>
            <div class="coffee-wrap">
                <% if(type.equals("意式咖啡")){ %>
                <div class="coffee-card">
                    <div class="coffee-img">☕</div>
                    <div class="coffee-info">
                        <div class="coffee-name">经典拿铁</div>
                        <div class="coffee-price">¥22</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('经典拿铁','¥22','☕')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <div class="coffee-card">
                    <div class="coffee-img">🥤</div>
                    <div class="coffee-info">
                        <div class="coffee-name">焦糖玛奇朵</div>
                        <div class="coffee-price">¥24</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('焦糖玛奇朵','¥24','🥤')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <div class="coffee-card">
                    <div class="coffee-img">🟤</div>
                    <div class="coffee-info">
                        <div class="coffee-name">原味美式</div>
                        <div class="coffee-price">¥18</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('原味美式','¥18','🟤')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <% } %>
                <% if(type.equals("冷萃咖啡")){ %>
                <div class="coffee-card">
                    <div class="coffee-img">🧊</div>
                    <div class="coffee-info">
                        <div class="coffee-name">原味冷萃</div>
                        <div class="coffee-price">¥25</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('原味冷萃','¥25','🧊')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <% } %>
                <% if(type.equals("特色美式")){ %>
                <div class="coffee-card">
                    <div class="coffee-img">💧</div>
                    <div class="coffee-info">
                        <div class="coffee-name">柠檬美式</div>
                        <div class="coffee-price">¥23</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('柠檬美式','¥23','💧')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <% } %>
                <% if(type.equals("特调饮品")){ %>
                <div class="coffee-card">
                    <div class="coffee-img">🫧</div>
                    <div class="coffee-info">
                        <div class="coffee-name">荔枝气泡美式</div>
                        <div class="coffee-price">¥26</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('荔枝气泡美式','¥26','🫧')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <% } %>
                <% if(type.equals("甜品小食")){ %>
                <div class="coffee-card">
                    <div class="coffee-img">🍰</div>
                    <div class="coffee-info">
                        <div class="coffee-name">提拉米苏</div>
                        <div class="coffee-price">¥18</div>
                        <div class="btn-row">
                            <button class="buy-now" onclick="openCustomize('提拉米苏','¥18','🍰')">直接购买</button>
                            <button class="add-cart" onclick="switchPage('cart')">加购</button>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            </div>

            <%-- 自定义规格面板 --%>
            <div class="customize-wrap" id="customizePanel">
                <div class="customize-left">
                    <div class="opt-section">
                        <div class="opt-label">杯型</div>
                        <div class="opt-chips" id="opt-size">
                            <div class="opt-chip selected" onclick="selectChip(this,'size')">中杯</div>
                            <div class="opt-chip" onclick="selectChip(this,'size')">大杯</div>
                        </div>
                    </div>
                    <div class="opt-section">
                        <div class="opt-label">温度</div>
                        <div class="opt-chips" id="opt-temp">
                            <div class="opt-chip selected" onclick="selectChip(this,'temp')">常温</div>
                            <div class="opt-chip" onclick="selectChip(this,'temp')">加冰</div>
                            <div class="opt-chip" onclick="selectChip(this,'temp')">少冰</div>
                            <div class="opt-chip" onclick="selectChip(this,'temp')">加热</div>
                        </div>
                    </div>
                    <div class="opt-section">
                        <div class="opt-label">咖啡豆</div>
                        <div class="opt-chips" id="opt-bean">
                            <div class="opt-chip selected" onclick="selectChip(this,'bean')">意式拼配</div>
                            <div class="opt-chip" onclick="selectChip(this,'bean')">深烘拼配</div>
                        </div>
                    </div>
                    <div class="opt-section">
                        <div class="opt-label">咖啡浓度</div>
                        <div class="opt-chips" id="opt-strength">
                            <div class="opt-chip selected" onclick="selectChip(this,'strength')">默认浓度</div>
                            <div class="opt-chip" onclick="selectChip(this,'strength')">加倍浓缩</div>
                        </div>
                    </div>
                    <div class="opt-section">
                        <div class="opt-label">糖度</div>
                        <div class="opt-chips" id="opt-sugar">
                            <div class="opt-chip selected" onclick="selectChip(this,'sugar')">标准甜</div>
                            <div class="opt-chip" onclick="selectChip(this,'sugar')">少甜</div>
                            <div class="opt-chip" onclick="selectChip(this,'sugar')">少少甜</div>
                            <div class="opt-chip" onclick="selectChip(this,'sugar')">微甜</div>
                            <div class="opt-chip" onclick="selectChip(this,'sugar')">不另外加糖</div>
                        </div>
                    </div>
                    <div class="opt-section">
                        <div class="opt-label">奶基</div>
                        <div class="opt-chips" id="opt-milk">
                            <div class="opt-chip selected" onclick="selectChip(this,'milk')">牛奶</div>
                        </div>
                    </div>
                </div>
                <div class="customize-right">
                    <div class="selected-card">
                        <div class="selected-card-img" id="selectedIcon"></div>
                        <div class="selected-card-info">
                            <div class="selected-card-name" id="selectedName"></div>
                            <div class="selected-card-price" id="selectedPrice"></div>
                            <div class="action-row">
                                <button class="back-btn" onclick="closeCustomize()">← 返回</button>
                                <button class="checkout-btn" onclick="openPayModal()">去结算</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>

            <%-- 购物车页面 --%>
            <% if(pageFlag.equals("cart")){ %>
            <h2 style="margin-bottom:20px;">我的购物车</h2>
            <div class="cart-item">
                <div class="item-icon">☕</div>
                <div class="item-info">
                    <div class="item-name">经典拿铁</div>
                    <div class="item-price">¥22</div>
                </div>
                <div class="num-box">
                    <button class="num-btn">-</button>
                    <span>1</span>
                    <button class="num-btn">+</button>
                    <span class="del-btn">删除</span>
                </div>
            </div>
            <div class="cart-item">
                <div class="item-icon">🍰</div>
                <div class="item-info">
                    <div class="item-name">提拉米苏</div>
                    <div class="item-price">¥18</div>
                </div>
                <div class="num-box">
                    <button class="num-btn">-</button>
                    <span>2</span>
                    <button class="num-btn">+</button>
                    <span class="del-btn">删除</span>
                </div>
            </div>
            <div class="settle-bar">
                <div class="total-text">合计：<span class="total-price">¥58</span></div>
                <button class="submit-btn" onclick="alert('跳转确认订单')">去结算</button>
            </div>
            <% } %>

            <%-- 订单页面 --%>
            <% if(pageFlag.equals("order")){ %>
            <h2 style="margin-bottom:20px;">我的订单</h2>
            <div class="order-container" id="dynamicOrders">
                <div class="order-card">
                    <div class="order-top">
                        <span>订单号：202606241001</span>
                        <span class="order-status">待取餐</span>
                    </div>
                    <div class="order-item">
                        <div class="order-icon">☕</div>
                        <span>经典拿铁 ×1</span>
                    </div>
                    <div class="order-item">
                        <div class="order-icon">🍰</div>
                        <span>提拉米苏 ×2</span>
                    </div>
                    <div class="order-bottom">
                        <span>实付 ¥53</span>
                        <button class="detail-btn">查看详情</button>
                    </div>
                </div>
                <div class="order-card">
                    <div class="order-top">
                        <span>订单号：202606231805</span>
                        <span class="order-status">已完成</span>
                    </div>
                    <div class="order-item">
                        <div class="order-icon">🫧</div>
                        <span>荔枝气泡美式 ×1</span>
                    </div>
                    <div class="order-bottom">
                        <span>实付 ¥26</span>
                        <button class="detail-btn">查看详情</button>
                    </div>
                </div>
            </div>
            <% } %>

            <%-- 我的页面 --%>
            <% if(pageFlag.equals("personal")){ %>
            <div class="personal-box">
                <div class="avatar">👤</div>
                <div class="personal-name">咩嘢熊仔用户</div>
                <div class="personal-menu">
                    <div class="personal-menu-item">收货地址管理</div>
                    <div class="personal-menu-item">优惠券</div>
                    <div class="personal-menu-item">储值记录</div>
                    <div class="personal-menu-item">设置</div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
</div>

<%-- 支付弹窗 --%>
<div class="pay-overlay" id="payOverlay">
    <div class="pay-modal">
        <div class="pay-modal-title">确认支付</div>
        <div class="pay-modal-sub" id="payModalSub"></div>
        <div class="pay-amount" id="payModalAmount"></div>
        <div class="pay-methods">
            <div class="pay-method selected" id="wechatMethod" onclick="selectPayMethod('wechat')">
                <div class="pay-method-icon">💚</div>
                <div class="pay-method-name">微信支付</div>
            </div>
            <div class="pay-method" id="alipayMethod" onclick="selectPayMethod('alipay')">
                <div class="pay-method-icon">💙</div>
                <div class="pay-method-name">支付宝</div>
            </div>
        </div>
        <button class="pay-confirm-btn" onclick="confirmPay()">确认支付</button>
        <button class="pay-cancel-btn" onclick="closePayModal()">取消</button>
    </div>
</div>

<%-- 支付成功弹窗 --%>
<div class="success-overlay" id="successOverlay">
    <div class="success-modal">
        <div class="success-icon">✅</div>
        <div class="success-title">支付成功！</div>
        <div class="success-sub">您的订单已提交，请稍候取餐</div>
        <button class="success-btn" onclick="goToOrders()">查看订单</button>
    </div>
</div>

<script>
    // 点单折叠
    const menuBtn = document.getElementById('orderMenuBtn');
    const subMenu = document.getElementById('orderSubMenu');
    menuBtn.addEventListener('click', function () {
        subMenu.classList.toggle('show');
    })
    window.onload = function(){
        subMenu.classList.add('show');
        // 订单页动态渲染
        var orderContainer = document.getElementById('dynamicOrders');
        if(orderContainer){
            var orders = JSON.parse(sessionStorage.getItem('pendingOrders')||'[]');
            orders.forEach(function(o){
                var card = document.createElement('div');
                card.className = 'order-card';
                card.innerHTML =
                    '<div class="order-top"><span>订单号：'+o.id+'</span><span class="order-status">'+o.status+'</span></div>'+
                    '<div class="order-item"><div class="order-icon">'+o.icon+'</div><span>'+o.name+' ×1</span></div>'+
                    '<div style="font-size:12px;color:#a8937b;margin:4px 0 8px 50px;">'+o.spec+'</div>'+
                    '<div class="order-bottom"><span>实付 '+o.price+'</span><button class="detail-btn">查看详情</button></div>';
                orderContainer.prepend(card);
            });
        }
    }
    // 切换一级页面：首页/购物车/订单/我的 同页刷新，不新开页面
    function switchPage(pageName){
        window.location.href = "index.jsp?page="+pageName;
    }
    // 切换饮品分类
    function switchType(typeName){
        window.location.href = "index.jsp?type="+typeName;
    }
    // 首页点单卡片展开菜单
    function expandMenu(){
        subMenu.classList.add('show');
    }

    // ===== 自定义规格面板 =====
    var currentDrink = {name:'', price:'', icon:''};

    function openCustomize(name, price, icon){
        currentDrink = {name:name, price:price, icon:icon};
        document.getElementById('selectedName').textContent = name;
        document.getElementById('selectedPrice').textContent = price;
        document.getElementById('selectedIcon').textContent = icon;
        document.getElementById('drinkListPanel').style.display = 'none';
        document.getElementById('customizePanel').classList.add('show');
        // 重置所有选项到默认第一项
        ['opt-size','opt-temp','opt-bean','opt-strength','opt-sugar','opt-milk'].forEach(function(id){
            var chips = document.querySelectorAll('#'+id+' .opt-chip');
            chips.forEach(function(c){ c.classList.remove('selected'); });
            if(chips.length > 0) chips[0].classList.add('selected');
        });
    }

    function closeCustomize(){
        document.getElementById('customizePanel').classList.remove('show');
        document.getElementById('drinkListPanel').style.display = '';
    }

    function selectChip(el, group){
        var chips = document.querySelectorAll('#opt-'+group+' .opt-chip');
        chips.forEach(function(c){ c.classList.remove('selected'); });
        el.classList.add('selected');
    }

    // ===== 支付弹窗 =====
    var selectedPayMethod = 'wechat';

    function openPayModal(){
        var size = getSelected('opt-size');
        var temp = getSelected('opt-temp');
        var bean = getSelected('opt-bean');
        var strength = getSelected('opt-strength');
        var sugar = getSelected('opt-sugar');
        var milk = getSelected('opt-milk');
        document.getElementById('payModalSub').textContent = currentDrink.name + ' · ' + size + ' · ' + temp;
        document.getElementById('payModalAmount').textContent = currentDrink.price;
        selectedPayMethod = 'wechat';
        document.getElementById('wechatMethod').classList.add('selected');
        document.getElementById('alipayMethod').classList.remove('selected');
        document.getElementById('payOverlay').classList.add('show');
    }

    function closePayModal(){
        document.getElementById('payOverlay').classList.remove('show');
    }

    function selectPayMethod(method){
        selectedPayMethod = method;
        document.getElementById('wechatMethod').classList.toggle('selected', method==='wechat');
        document.getElementById('alipayMethod').classList.toggle('selected', method==='alipay');
    }

    function getSelected(groupId){
        var sel = document.querySelector('#'+groupId+' .opt-chip.selected');
        return sel ? sel.textContent : '';
    }

    // ===== 确认支付 → 生成订单 =====
    function confirmPay(){
        var orderId = '2026' + Math.floor(Date.now()/1000);
        var size = getSelected('opt-size');
        var temp = getSelected('opt-temp');
        var bean = getSelected('opt-bean');
        var strength = getSelected('opt-strength');
        var sugar = getSelected('opt-sugar');
        var milk = getSelected('opt-milk');
        var order = {
            id: orderId,
            name: currentDrink.name,
            icon: currentDrink.icon,
            price: currentDrink.price,
            spec: size+' · '+temp+' · '+bean+' · '+strength+' · '+sugar+' · '+milk,
            method: selectedPayMethod === 'wechat' ? '微信支付' : '支付宝',
            status: '待取餐'
        };
        var orders = JSON.parse(sessionStorage.getItem('pendingOrders')||'[]');
        orders.unshift(order);
        sessionStorage.setItem('pendingOrders', JSON.stringify(orders));
        document.getElementById('payOverlay').classList.remove('show');
        document.getElementById('successOverlay').classList.add('show');
    }

    function goToOrders(){
        document.getElementById('successOverlay').classList.remove('show');
        window.location.href = 'index.jsp?page=order';
    }
</script>
</body>
</html>