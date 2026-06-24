<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>咩嘢熊仔 - 首页</title>
    <!-- 引入 Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入图标库 (可选) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #FFF8E7; padding-bottom: 70px; font-family: sans-serif; }
        /* 顶部导航 */
        .app-header { background: #D8C3A5; padding: 15px; color: #5D4037; border-radius: 0 0 20px 20px; }
        /* 快捷入口卡片 */
        .quick-card { background: white; border-radius: 15px; padding: 15px 5px; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.05); height: 100%; }
        .quick-card i { font-size: 24px; color: #8E6E53; }
        /* 商品列表卡片 */
        .product-card { background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 2px 6px rgba(0,0,0,0.05); margin-bottom: 15px; transition: transform 0.2s; }
        .product-card:hover { transform: translateY(-3px); }
        .product-img { width: 100%; height: 120px; object-fit: cover; background: #eee; }
        .product-info { padding: 10px; }
        .product-title { font-size: 14px; font-weight: bold; margin: 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .product-price { color: #D32F2F; font-weight: bold; margin-top: 5px; }
        /* 底部导航 */
        .bottom-nav { position: fixed; bottom: 0; left: 0; width: 100%; background: white; border-top: 1px solid #ddd; padding: 8px 0; display: flex; justify-content: space-around; z-index: 999; }
        .nav-item { text-align: center; color: #888; text-decoration: none; font-size: 12px; }
        .nav-item.active { color: #8E6E53; font-weight: bold; }
        .nav-item i { font-size: 20px; display: block; margin-bottom: 2px; }
    </style>
</head>
<body>

<!-- 1. 顶部 Header -->
<div class="app-header d-flex justify-content-between align-items-center">
    <div>
        <h4 class="m-0">咩嘢熊仔</h4>
        <small>早咖晚酒 · 门店</small>
    </div>
    <div>
        <i class="bi bi-cart fs-4 me-3"></i>
        <i class="bi bi-person-circle fs-4"></i>
    </div>
</div>

<!-- 2. 快捷功能入口 (核心菜单) -->
<div class="container mt-4">
    <div class="row g-2">
        <div class="col-3">
            <div class="quick-card"><i class="bi bi-cup-hot-fill"></i><div class="mt-1 fw-bold">点单</div></div>
        </div>
        <div class="col-3">
            <div class="quick-card"><i class="bi bi-box-seam"></i><div class="mt-1 fw-bold">自提</div></div>
        </div>
        <div class="col-3">
            <div class="quick-card"><i class="bi bi-ticket-perforated-fill"></i><div class="mt-1 fw-bold">优惠券</div></div>
        </div>
        <div class="col-3">
            <div class="quick-card"><i class="bi bi-wallet2"></i><div class="mt-1 fw-bold">储值</div></div>
        </div>
    </div>
</div>

<!-- 3. 首页中间商品信息展示区 -->
<div class="container mt-4">
    <!-- 模块标题 -->
    <div class="d-flex justify-content-between align-items-center mb-2">
        <h5 class="fw-bold m-0">🔥 今日推荐</h5>
        <a href="#" class="text-muted text-decoration-none small">查看全部 ></a>
    </div>

    <div class="row">
        <!-- 这里是 JSTL 循环展示后端传来的商品列表 -->
        <c:forEach items="${productList}" var="product">
            <div class="col-6">
                <div class="product-card">
                    <!-- 如果库里有图片路径，用 ${product.imgUrl} -->
                    <img src="${product.imageUrl != null ? product.imageUrl : 'https://via.placeholder.com/200x150?text=Coffee'}" class="product-img" alt="商品图片">
                    <div class="product-info">
                        <div class="product-title">${product.name}</div>
                        <div class="text-muted small" style="font-size: 12px;">${product.description}</div>
                        <div class="product-price">¥ ${product.price}</div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <!-- 如果后端没传数据，下面这段占位代码会生效（测试时用） -->
        <c:if test="${empty productList}">
            <div class="col-6"><div class="product-card"><img src="https://via.placeholder.com/200x150?text=Latte" class="product-img"><div class="product-info"><div class="product-title">拿铁咖啡</div><div class="product-price">¥ 22.00</div></div></div></div>
            <div class="col-6"><div class="product-card"><img src="https://via.placeholder.com/200x150?text=Americano" class="product-img"><div class="product-info"><div class="product-title">美式咖啡</div><div class="product-price">¥ 18.00</div></div></div></div>
        </c:if>
    </div>
</div>

<br><br><br>

<!-- 4. 底部导航栏 -->
<div class="bottom-nav">
    <a href="index.jsp" class="nav-item active">
        <i class="bi bi-house-fill"></i> 首页
    </a>
    <a href="#" class="nav-item">
        <i class="bi bi-grid-3x3-gap-fill"></i> 点单
    </a>
    <a href="#" class="nav-item">
        <i class="bi bi-clipboard-check"></i> 订单
    </a>
    <a href="#" class="nav-item">
        <i class="bi bi-person"></i> 我的
    </a>
</div>

</body>
</html>