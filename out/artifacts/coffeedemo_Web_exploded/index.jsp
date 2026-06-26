<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.coffee.service.ProductService" %>
<%@ page import="com.example.coffee.impl.ProductServiceImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.coffee.entity.Product" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // 页面标识：home / order / cart / personal / 饮品分类
    String pageFlag = request.getParameter("page") == null ? "home" : request.getParameter("page");
    String type = request.getParameter("type");
    if (type == null) type = "";
    String keyword = request.getParameter("keyword");
    if (keyword == null) keyword = "";

    // ---- 根据分类查询商品列表 ----
    ProductService productService = new ProductServiceImpl();
    List<Product> productList = null;
    String categoryTitle = "";

    if ("search".equals(type) && !keyword.isEmpty()) {
        // 搜索功能:搜索所有商品
        productList = productService.searchProducts(keyword);
        categoryTitle = "搜索 \"" + keyword + "\"";
    } else if ("new".equals(type)) {
        // 新品推荐
        productList = productService.getNewProducts();
        categoryTitle = "🌟 新品推荐";
    } else if (!type.isEmpty()) {
        // 指定分类
        productList = productService.getProductsByCategory(type);
        categoryTitle = type;
    } else {
        // 默认不显示商品列表
        productList = new java.util.ArrayList<>();
        categoryTitle = "";
    }
    request.setAttribute("productList", productList);
    request.setAttribute("categoryTitle", categoryTitle);
    request.setAttribute("pageFlag", pageFlag);
    request.setAttribute("type", type);
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
        /* 左侧侧边栏 */
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
            margin-top: 8px;
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
            max-height: 300px;
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
            font-weight: bold;
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
        /* 搜索框容器 */
        .search-wrap {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .search-btn {
            height: 38px;
            padding: 0 16px;
            background: #C9B48E;
            color: #fff;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 14px;
            white-space: nowrap;
            transition: .15s;
        }
        .search-btn:hover {
            background: #b8a07a;
        }
        .search-btn:active {
            background: #a89070;
        }
        /* 地址选择器样式 */
        .address-selector {
            width: 320px;
            height: 38px;
            border: 1px solid #C9B48E;
            border-radius: 20px;
            padding: 0 16px;
            background: #fff;
            outline: none;
            color: #5C4836;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }
        .address-selector:hover {
            background: #FFF9EF;
        }
        .address-icon {
            font-size: 16px;
        }
        .address-text {
            flex: 1;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .address-arrow {
            font-size: 12px;
            color: #B8A388;
        }
        /* 地址选择弹窗 */
        .address-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .45);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        .address-overlay.show {
            display: flex;
        }
        .address-modal {
            background: #fff;
            border-radius: 20px;
            padding: 28px;
            width: 450px;
            max-width: 95vw;
            max-height: 80vh;
            overflow-y: auto;
        }
        .address-modal-title {
            font-size: 18px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 20px;
            text-align: center;
        }
        .address-item {
            padding: 14px 16px;
            border: 2px solid #E9D9C2;
            border-radius: 12px;
            margin-bottom: 12px;
            cursor: pointer;
            transition: .15s;
        }
        .address-item:hover {
            border-color: #C9B48E;
            background: #FFF9EF;
        }
        .address-item.selected {
            border-color: #5C4836;
            background: #FFF0DC;
        }
        .address-item-name {
            font-size: 15px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 4px;
        }
        .address-item-detail {
            font-size: 13px;
            color: #a8937b;
        }
        .address-item-phone {
            font-size: 13px;
            color: #5C4836;
            margin-top: 4px;
        }
        .address-add-btn {
            width: 100%;
            padding: 12px;
            background: #C9B48E;
            color: #fff;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            cursor: pointer;
            margin-top: 8px;
        }
        .address-add-btn:hover {
            background: #b8a07a;
        }
        .address-close-btn {
            width: 100%;
            padding: 10px;
            background: #fff;
            color: #a8937b;
            border: none;
            border-radius: 12px;
            font-size: 14px;
            cursor: pointer;
            margin-top: 10px;
        }
        .address-close-btn:hover {
            background: #F7F0EA;
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
            padding: 25px;
            background: #fff;
            border-radius: 16px;
            border: 1px solid #E8D4BC;
            min-height: 400px;
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
        .func-card:hover {
            background: #FFF9EF;
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
        .coffee-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 16px;
        }
        .coffee-wrap {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 20px;
        }
        .coffee-card {
            background: #FFF0DC;
            border-radius: 14px;
            overflow: hidden;
            border: 1px solid #E9D9C2;
        }
        .coffee-img {
            height: 130px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 52px;
            background: #F7E9D6;
        }
        .coffee-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .coffee-info {
            padding: 12px;
            background: #fff;
        }
        .coffee-name {
            font-weight: bold;
            font-size: 15px;
            margin-bottom: 5px;
        }
        .coffee-price {
            color: #C9B48E;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .btn-row {
            display: flex;
            gap: 8px;
        }
        .buy-now {
            flex: 1;
            padding: 7px 0;
            background: #5C4836;
            color: #fff;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
        }
        .buy-now:hover {
            background: #4a3728;
        }
        .add-cart {
            flex: 0.5;
            padding: 7px 0;
            background: #C9B48E;
            color: #fff;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
        }
        .add-cart:hover {
            background: #b8a07a;
        }
        /* 购物车样式 */
        .cart-item {
            background: #fff;
            margin: 10px 0;
            border-radius: 14px;
            padding: 12px;
            display: flex;
            gap: 12px;
            align-items: center;
            border: 1px solid #E9D9C2;
        }
        .item-icon {
            width: 60px;
            height: 60px;
            background: #F7E9D6;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
        }
        .item-info {
            flex: 1;
        }
        .item-name {
            font-weight: bold;
            margin-bottom: 4px;
        }
        .item-price {
            color: #C9B48E;
        }
        .num-box {
            display: flex;
            gap: 8px;
            align-items: center;
        }
        .num-btn {
            width: 26px;
            height: 26px;
            border-radius: 50%;
            border: 1px solid #C9B48E;
            background: #fff;
            cursor: pointer;
            font-size: 16px;
            line-height: 26px;
            text-align: center;
        }
        .num-btn:hover {
            background: #F7E9D6;
        }
        .del-btn {
            color: #ff6b6b;
            font-size: 13px;
            cursor: pointer;
            margin-left: 8px;
        }
        .del-btn:hover {
            text-decoration: underline;
        }
        .settle-bar {
            margin-top: 20px;
            padding-top: 15px;
            border-top: 1px solid #E9D9C2;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .total-text {
            font-size: 16px;
        }
        .total-price {
            font-size: 20px;
            color: #C9B48E;
            font-weight: bold;
        }
        .submit-btn {
            padding: 10px 24px;
            background: #C9B48E;
            color: #fff;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-size: 15px;
        }
        .submit-btn:hover {
            background: #b8a07a;
        }
        /* 订单双列布局 */
        .order-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }
        .order-card {
            background: #fff;
            border-radius: 14px;
            padding: 15px;
            border: 1px solid #E9D9C2;
        }
        .order-top {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .order-status {
            color: #C9B48E;
            font-weight: bold;
        }
        .order-item {
            display: flex;
            gap: 10px;
            align-items: center;
            margin: 8px 0;
        }
        .order-icon {
            width: 40px;
            height: 40px;
            background: #F7E9D6;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        .order-bottom {
            display: flex;
            justify-content: space-between;
            margin-top: 12px;
            padding-top: 10px;
            border-top: 1px solid #E9D9C2;
        }
        .detail-btn {
            border: 1px solid #C9B48E;
            padding: 4px 12px;
            border-radius: 14px;
            font-size: 13px;
            cursor: pointer;
            background: #fff;
            color: #5C4836;
        }
        .detail-btn:hover {
            background: #F7E9D6;
        }
        /* 我的页面 */
        .personal-box {
            text-align: center;
            padding: 40px 0;
        }
        .avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: #E8D4BC;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
        }
        .personal-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 30px;
        }
        .personal-menu {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .personal-menu-item {
            background: #FFF0DC;
            padding: 20px;
            border-radius: 14px;
            cursor: pointer;
            border: 1px solid #E9D9C2;
            transition: 0.2s;
        }
        .personal-menu-item:hover {
            background: #F7E9D6;
        }
        .logout-item {
            background: #ffebee !important;
            color: #d32f2f !important;
            border-color: #ffcdd2 !important;
            font-weight: bold;
        }
        .logout-item:hover {
            background: #ffcdd2 !important;
        }
        /* 自定义面板 */
        .customize-wrap {
            display: none;
            gap: 20px;
        }
        .customize-wrap.show {
            display: flex;
        }
        .customize-left {
            flex: 1;
            min-width: 0;
        }
        .customize-right {
            width: 260px;
            flex-shrink: 0;
        }
        .selected-card {
            background: #FFF0DC;
            border-radius: 16px;
            border: 2px solid #C9B48E;
            overflow: hidden;
            position: sticky;
            top: 0;
        }
        .selected-card-img {
            height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 72px;
            background: #F7E9D6;
        }
        .selected-card-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .selected-card-info {
            padding: 16px;
            background: #fff;
        }
        .selected-card-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 6px;
        }
        .selected-card-price {
            color: #C9B48E;
            font-weight: bold;
            font-size: 16px;
            margin-bottom: 14px;
        }
        .action-row {
            display: flex;
            gap: 10px;
        }
        .back-btn {
            flex: 1;
            padding: 10px 0;
            background: #fff;
            color: #5C4836;
            border: 1.5px solid #C9B48E;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
        }
        .back-btn:hover {
            background: #F7E9D6;
        }
        .checkout-btn {
            flex: 1;
            padding: 10px 0;
            background: #5C4836;
            color: #fff;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
        }
        .checkout-btn:hover {
            background: #4a3728;
        }
        .opt-section {
            margin-bottom: 18px;
        }
        .opt-label {
            font-size: 14px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 8px;
        }
        .opt-chips {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }
        .opt-chip {
            padding: 6px 14px;
            border-radius: 20px;
            border: 1.5px solid #D9C3A8;
            background: #fff;
            color: #5C4836;
            font-size: 13px;
            cursor: pointer;
            transition: .15s;
        }
        .opt-chip.selected {
            background: #5C4836;
            color: #fff;
            border-color: #5C4836;
        }
        .opt-chip:hover:not(.selected) {
            background: #F3E2CD;
        }
        /* 支付弹窗 */
        .pay-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .45);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }
        .pay-overlay.show {
            display: flex;
        }
        .pay-modal {
            background: #fff;
            border-radius: 20px;
            padding: 32px 28px;
            width: 380px;
            max-width: 95vw;
        }
        .pay-modal-title {
            font-size: 18px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 6px;
        }
        .pay-modal-sub {
            font-size: 13px;
            color: #a8937b;
            margin-bottom: 24px;
        }
        .pay-amount {
            font-size: 28px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 24px;
        }
        .pay-methods {
            display: flex;
            gap: 14px;
            margin-bottom: 28px;
        }
        .pay-method {
            flex: 1;
            border: 2px solid #E9D9C2;
            border-radius: 14px;
            padding: 16px 10px;
            text-align: center;
            cursor: pointer;
            transition: .15s;
        }
        .pay-method.selected {
            border-color: #5C4836;
            background: #FFF0DC;
        }
        .pay-method:hover:not(.selected) {
            border-color: #C9B48E;
        }
        .pay-method-icon {
            font-size: 36px;
            margin-bottom: 6px;
        }
        .pay-method-name {
            font-size: 14px;
            color: #5C4836;
            font-weight: 500;
        }
        .pay-confirm-btn {
            width: 100%;
            padding: 12px 0;
            background: #5C4836;
            color: #fff;
            border: none;
            border-radius: 14px;
            font-size: 16px;
            cursor: pointer;
        }
        .pay-confirm-btn:hover {
            background: #4a3728;
        }
        .pay-cancel-btn {
            width: 100%;
            margin-top: 10px;
            padding: 10px 0;
            background: #fff;
            color: #a8937b;
            border: none;
            border-radius: 14px;
            font-size: 14px;
            cursor: pointer;
        }
        .pay-cancel-btn:hover {
            background: #F7F0EA;
        }
        /* 支付成功弹窗 */
        .success-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .45);
            z-index: 1001;
            align-items: center;
            justify-content: center;
        }
        .success-overlay.show {
            display: flex;
        }
        .success-modal {
            background: #fff;
            border-radius: 20px;
            padding: 40px 32px;
            width: 320px;
            text-align: center;
        }
        .success-icon {
            font-size: 56px;
            margin-bottom: 12px;
        }
        .success-title {
            font-size: 20px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 8px;
        }
        .success-sub {
            font-size: 13px;
            color: #a8937b;
            margin-bottom: 24px;
        }
        .success-btn {
            padding: 10px 32px;
            background: #5C4836;
            color: #fff;
            border: none;
            border-radius: 14px;
            font-size: 15px;
            cursor: pointer;
        }
        .success-btn:hover {
            background: #4a3728;
        }
        /* 订单详情弹窗 */
        .order-detail-overlay {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0, 0, 0, .45);
            z-index: 1002;
            align-items: center;
            justify-content: center;
            overflow-y: auto;
            padding: 20px;
        }
        .order-detail-overlay.show {
            display: flex;
        }
        .order-detail-modal {
            background: #fff;
            border-radius: 20px;
            width: 600px;
            max-width: 95vw;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 8px 32px rgba(0,0,0,0.15);
        }
        .order-detail-header {
            padding: 24px 28px;
            border-bottom: 1px solid #E9D9C2;
            position: sticky;
            top: 0;
            background: #fff;
            border-radius: 20px 20px 0 0;
            z-index: 1;
        }
        .order-detail-title {
            font-size: 20px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 8px;
        }
        .order-detail-status {
            display: inline-block;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
        }
        .order-detail-close {
            position: absolute;
            top: 20px;
            right: 24px;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: none;
            background: #F7E9D6;
            color: #5C4836;
            font-size: 18px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: .15s;
        }
        .order-detail-close:hover {
            background: #E8D4BC;
        }
        .order-detail-body {
            padding: 24px 28px;
        }
        .detail-section {
            margin-bottom: 24px;
        }
        .detail-section-title {
            font-size: 16px;
            font-weight: bold;
            color: #5C4836;
            margin-bottom: 14px;
            padding-bottom: 8px;
            border-bottom: 2px solid #FFF0DC;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            font-size: 14px;
        }
        .detail-label {
            color: #a8937b;
        }
        .detail-value {
            color: #5C4836;
            font-weight: 500;
            text-align: right;
        }
        .detail-item-card {
            background: #FFF9EF;
            border-radius: 12px;
            padding: 14px;
            margin-bottom: 12px;
            display: flex;
            gap: 12px;
        }
        .detail-item-icon {
            width: 60px;
            height: 60px;
            background: #F7E9D6;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            flex-shrink: 0;
        }
        .detail-item-info {
            flex: 1;
            min-width: 0;
        }
        .detail-item-name {
            font-weight: bold;
            font-size: 15px;
            color: #5C4836;
            margin-bottom: 6px;
        }
        .detail-item-spec {
            font-size: 12px;
            color: #a8937b;
            margin-bottom: 6px;
        }
        .detail-item-price-row {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
        }
        .detail-item-price {
            color: #C9B48E;
            font-weight: bold;
        }
        .detail-divider {
            height: 1px;
            background: #E9D9C2;
            margin: 12px 0;
        }
        .detail-price-summary {
            background: #FFF9EF;
            border-radius: 12px;
            padding: 16px;
        }
        .detail-total-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            font-size: 14px;
        }
        .detail-total-final {
            border-top: 2px solid #E9D9C2;
            margin-top: 8px;
            padding-top: 12px;
            font-size: 16px;
            font-weight: bold;
        }
        .detail-total-final .detail-value {
            color: #C9B48E;
            font-size: 20px;
        }
        .detail-actions {
            display: flex;
            gap: 12px;
            padding: 20px 28px;
            border-top: 1px solid #E9D9C2;
            background: #fff;
            border-radius: 0 0 20px 20px;
            position: sticky;
            bottom: 0;
        }
        .detail-action-btn {
            flex: 1;
            padding: 12px 0;
            border-radius: 12px;
            font-size: 14px;
            cursor: pointer;
            transition: .15s;
            text-align: center;
            border: none;
        }
        .detail-action-btn.primary {
            background: #5C4836;
            color: #fff;
        }
        .detail-action-btn.primary:hover {
            background: #4a3728;
        }
        .detail-action-btn.secondary {
            background: #FFF0DC;
            color: #5C4836;
            border: 1px solid #E9D9C2;
        }
        .detail-action-btn.secondary:hover {
            background: #F7E9D6;
        }
        .timeline-item {
            display: flex;
            gap: 12px;
            padding: 10px 0;
        }
        .timeline-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #C9B48E;
            margin-top: 4px;
            flex-shrink: 0;
            position: relative;
        }
        .timeline-dot.active {
            background: #5C4836;
            box-shadow: 0 0 0 4px rgba(92,72,54,0.1);
        }
        .timeline-dot::after {
            content: '';
            position: absolute;
            left: 50%;
            top: 12px;
            width: 2px;
            height: 30px;
            background: #E9D9C2;
            transform: translateX(-50%);
        }
        .timeline-item:last-child .timeline-dot::after {
            display: none;
        }
        .timeline-content {
            flex: 1;
        }
        .timeline-title {
            font-size: 14px;
            font-weight: 500;
            color: #5C4836;
            margin-bottom: 4px;
        }
        .timeline-time {
            font-size: 12px;
            color: #a8937b;
        }
        /* 空状态 */
        .empty-tip {
            grid-column: 1 / -1;
            text-align: center;
            padding: 60px 20px;
            color: #a8937b;
            font-size: 16px;
        }
        .empty-tip .big-icon {
            font-size: 48px;
            display: block;
            margin-bottom: 12px;
        }
        /* 新品标签 */
        .new-badge {
            display: inline-block;
            background: #ff6b6b;
            color: #fff;
            font-size: 11px;
            padding: 1px 10px;
            border-radius: 12px;
            margin-left: 6px;
            vertical-align: middle;
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
            <div class="nav-link ${pageFlag eq 'home' and empty type ? 'active' : ''}" onclick="switchPage('home')">
                <span class="nav-icon">🏠</span>
                <span>首页</span>
            </div>
        </li>
        <li class="nav-item">
            <div class="nav-link ${(pageFlag eq 'order' or type eq 'new' or type eq '意式咖啡' or type eq '冷萃咖啡' or type eq '特色美式' or type eq '特调饮品' or type eq '甜品小食' or type eq 'search') ? 'active' : ''}" id="orderMenuBtn">
                <span class="nav-icon">☕</span>
                <span>点单</span>
            </div>
            <ul class="sub-menu show" id="orderSubMenu">
                <li><div class="sub-link ${type eq '新品推荐' ? 'active' : ''}" onclick="switchType('new')">🌟 新品推荐</div></li>
                <li><div class="sub-link ${type eq '意式咖啡' ? 'active' : ''}" onclick="switchType('意式咖啡')">意式咖啡</div></li>
                <li><div class="sub-link ${type eq '冷萃咖啡' ? 'active' : ''}" onclick="switchType('冷萃咖啡')">冷萃咖啡</div></li>
                <li><div class="sub-link ${type eq '特色美式' ? 'active' : ''}" onclick="switchType('特色美式')">特色美式</div></li>
                <li><div class="sub-link ${type eq '特调饮品' ? 'active' : ''}" onclick="switchType('特调饮品')">特调饮品</div></li>
                <li><div class="sub-link ${type eq '甜品小食' ? 'active' : ''}" onclick="switchType('甜品小食')">甜品小食</div></li>
            </ul>
        </li>
        <!-- 购物车 -->
        <li class="nav-item">
            <div class="nav-link ${pageFlag eq 'cart' ? 'active' : ''}" onclick="switchPage('cart')">
                <span class="nav-icon">🛒</span>
                <span>购物车</span>
            </div>
        </li>
        <!-- 订单 -->
        <li class="nav-item">
            <div class="nav-link ${pageFlag eq 'order' ? 'active' : ''}" onclick="switchPage('order')">
                <span class="nav-icon">📋</span>
                <span>订单</span>
            </div>
        </li>
        <!-- 我的 -->
        <li class="nav-item">
            <div class="nav-link ${pageFlag eq 'personal' ? 'active' : ''}" onclick="switchPage('personal')">
                <span class="nav-icon">👤</span>
                <span>我的</span>
            </div>
        </li>
    </ul>
</div>

<!-- 右侧主区域 -->
<div class="main-wrap">
    <div class="top-bar">
        <div class="address-selector" onclick="openAddressModal()">
            <span class="address-icon">📍</span>
            <span class="address-text" id="currentAddressText">请选择配送地址</span>
            <span class="address-arrow">▼</span>
        </div>
        <div class="search-wrap">
            <input type="text" class="search-input" id="productSearchInput" placeholder="搜索饮品...">
            <button class="search-btn" onclick="searchProducts()">🔍 搜索</button>
        </div>
        <div class="top-right">
            <div class="top-icon">🕐</div>
            <div class="top-icon">🔔</div>
            <div class="top-icon">👨</div>
        </div>
    </div>
    <div class="content-box">
        <div class="content-inner">
            <!-- ===== 首页 ===== -->
            <c:if test="${pageFlag eq 'home' and empty type}">
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
                <div class="gift-card-bar">
                    <span>🎁 礼品卡</span>
                    <button class="gift-btn" onclick="alert('礼品卡功能开发中')">立即购买 ></button>
                </div>
                <div class="store-box">
                    <div class="store-top">
                        <span class="store-name">门店 (1)</span>
                        <span class="go-order-btn" onclick="expandMenu()">去下单 ></span>
                    </div>
                    <div class="store-name">咩嘢熊仔</div>
                    <div class="store-address">四会市东城街道江丽路1座商铺1号（首层）</div>
                </div>
            </c:if>

            <!-- ===== 点单分类 ===== -->
            <c:if test="${not empty type or pageFlag eq 'order'}">
                <c:if test="${not empty type}">
                    <div id="drinkListPanel">
                        <div class="coffee-title">${categoryTitle}</div>
                        <div class="coffee-wrap">
                            <c:forEach items="${productList}" var="p">
                                <div class="coffee-card">
                                    <div class="coffee-img">
                                        <c:choose>
                                            <c:when test="${not empty p.imageUrl}">
                                                <img src="${pageContext.request.contextPath}/${p.imageUrl}" alt="${p.name}">
                                            </c:when>
                                            <c:otherwise>
                                                ☕
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="coffee-info">
                                        <div class="coffee-name">
                                                ${p.name}
                                            <c:if test="${p.isNew eq 1}">
                                                <span class="new-badge">新品</span>
                                            </c:if>
                                        </div>
                                        <div class="coffee-price">¥${p.price}</div>
                                        <div class="btn-row">
                                            <button class="buy-now" onclick="openCustomize('${p.name}','¥${p.price}','${not empty p.imageUrl ? p.imageUrl : ''}')">直接购买</button>
                                            <button class="add-cart" onclick="addToCart(${p.id})">加购</button>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <c:if test="${empty productList}">
                                <div class="empty-tip">
                                    <span class="big-icon">☕</span>
                                    暂无商品<br>
                                    <span style="font-size:13px;">敬请期待</span>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 自定义规格面板 -->
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
                                    <div class="opt-chip" onclick="selectChip(this,'milk')">燕麦奶</div>
                                </div>
                            </div>
                        </div>
                        <div class="customize-right">
                            <div class="selected-card">
                                <div class="selected-card-img" id="selectedIcon">☕</div>
                                <div class="selected-card-info">
                                    <div class="selected-card-name" id="selectedName">请选择饮品</div>
                                    <div class="selected-card-price" id="selectedPrice">¥0</div>
                                    <div class="action-row">
                                        <button class="back-btn" onclick="closeCustomize()">← 返回</button>
                                        <button class="checkout-btn" onclick="openPayModal()">去结算</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:if>

            <!-- ===== 购物车 ===== -->
            <c:if test="${pageFlag eq 'cart'}">
                <%
                    java.util.List<com.example.coffee.entity.CartItem> cart = (java.util.List<com.example.coffee.entity.CartItem>) session.getAttribute("cart");
                    double cartTotal = 0;
                    if (cart != null) {
                        for (com.example.coffee.entity.CartItem item : cart) {
                            cartTotal += item.getSubtotal();
                        }
                    }
                    request.setAttribute("cartItems", cart);
                    request.setAttribute("cartTotal", cartTotal);
                %>
                <h2 style="margin-bottom:20px;">🛒 我的购物车</h2>

                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div style="text-align:center;padding:60px 20px;color:#a8937b;">
                            <div style="font-size:48px;margin-bottom:12px;">🛒</div>
                            <p>购物车还是空的，去点单看看吧～</p>
                            <p style="margin-top:15px;"><a href="index.jsp?type=意式咖啡" style="color:#C9B48E;">去点单 ></a></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${cartItems}" var="item" varStatus="vs">
                            <div class="cart-item">
                                <div class="item-icon">${item.icon}</div>
                                <div class="item-info">
                                    <div class="item-name">${item.name}</div>
                                    <div class="item-price">¥<fmt:formatNumber value="${item.price}" pattern="#"/></div>
                                </div>
                                <div class="num-box">
                                    <button class="num-btn" onclick="updateCart(${vs.index}, 'dec')">-</button>
                                    <span>${item.quantity}</span>
                                    <button class="num-btn" onclick="updateCart(${vs.index}, 'inc')">+</button>
                                    <span class="del-btn" onclick="updateCart(${vs.index}, 'del')">删除</span>
                                </div>
                            </div>
                        </c:forEach>

                        <div class="settle-bar">
                            <div class="total-text">合计：<span class="total-price">¥<fmt:formatNumber value="${cartTotal}" pattern="#"/></span></div>
                            <button class="submit-btn" onclick="goCartPay()">结算</button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:if>

            <!-- ===== 订单 ===== -->
            <c:if test="${pageFlag eq 'order'}">
                <%
                    com.example.coffee.entity.User orderUser = (com.example.coffee.entity.User) session.getAttribute("loginUser");
                    if (orderUser != null) {
                        com.example.coffee.impl.OrderServiceImpl orderService = new com.example.coffee.impl.OrderServiceImpl();
                        java.util.List<com.example.coffee.entity.Order> userOrders = orderService.listUserOrders(orderUser.getId());
                        request.setAttribute("userOrders", userOrders);
                    }
                %>
                <h2 style="margin-bottom:20px;">📋 我的订单</h2>
                <div class="order-container" id="orderContainer">
                    <!-- 数据库订单（从后端查询） -->
                    <c:choose>
                        <c:when test="${not empty userOrders}">
                            <c:forEach items="${userOrders}" var="order">
                                <div class="order-card" data-order-id="${order.id}">
                                    <div class="order-top">
                                        <span>订单号：${order.orderNo}</span>
                                        <span class="order-status" style="color:
                                            <c:choose>
                                                <c:when test="${order.status eq 0}">#ff9800</c:when>
                                                <c:when test="${order.status eq 1}">#C9B48E</c:when>
                                                <c:when test="${order.status eq 2}">#4caf50</c:when>
                                                <c:when test="${order.status eq 3}">#999</c:when>
                                                <c:otherwise>#C9B48E</c:otherwise>
                                            </c:choose>
                                        ">${order.statusText}</span>
                                    </div>
                                    <c:forEach items="${order.items}" var="item">
                                        <div class="order-item">
                                            <div class="order-icon">${item.productName eq null || empty item.productName ? '☕' :
                                                fn:contains(item.productName, '拿铁') ? '☕' :
                                                fn:contains(item.productName, '美式') ? '☕' :
                                                fn:contains(item.productName, '气泡') ? '🫧' :
                                                fn:contains(item.productName, '提拉米苏') ? '🍰' :
                                                fn:contains(item.productName, '蛋糕') ? '🍰' :
                                                fn:contains(item.productName, '甜品') ? '🧁' :
                                                fn:contains(item.productName, '冷萃') ? '🧊' :
                                                fn:contains(item.productName, '特调') ? '🍹' :
                                                '☕'}</div>
                                            <span>${item.productName} ×${item.quantity}</span>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty order.items and not empty order.remark}">
                                        <div class="order-item">
                                            <div class="order-icon">☕</div>
                                            <span>${order.remark}</span>
                                        </div>
                                    </c:if>
                                    <div class="order-bottom">
                                        <span>实付 ¥<fmt:formatNumber value="${order.totalPrice}" pattern="#"/></span>
                                        <button class="detail-btn" onclick="viewOrderDetail(${order.id})">查看详情</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${empty sessionScope.loginUser}">
                                <div class="empty-tip">
                                    <span class="big-icon">🔒</span>
                                    请先登录后查看订单<br>
                                    <span style="font-size:13px;"><a href="login.jsp" style="color:#C9B48E;">去登录 ></a></span>
                                </div>
                            </c:if>
                            <c:if test="${not empty sessionScope.loginUser}">
                                <div class="empty-tip" id="noDbOrdersTip">
                                    <span class="big-icon">📋</span>
                                    暂无订单<br>
                                    <span style="font-size:13px;">去点单看看吧～</span>
                                </div>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                </div>
                <!-- 前端直接购买产生的订单（从 sessionStorage 读取），直接插入到 order-container 中 -->
                <div id="dynamicOrders" style="display:none;"></div>
            </c:if>

            <!-- ===== 我的 ===== -->
            <c:if test="${pageFlag eq 'personal'}">
                <%
                    com.example.coffee.entity.User loginUser = (com.example.coffee.entity.User) session.getAttribute("loginUser");
                    if (loginUser == null) {
                        // 未登录，跳转到登录页面
                        response.sendRedirect(request.getContextPath() + "/login.jsp");
                        return;
                    }
                    request.setAttribute("loginUser", loginUser);
                %>
                <div class="personal-box">
                    <div class="avatar">👤</div>
                    <div class="personal-name">${loginUser.username}</div>
                    <div class="personal-menu">
                        <div class="personal-menu-item">📦 收货地址管理</div>
                        <div class="personal-menu-item">🎫 优惠券</div>
                        <div class="personal-menu-item">💰 储值记录</div>
                        <div class="personal-menu-item">⚙️ 设置</div>
                        <div class="personal-menu-item logout-item" onclick="if(confirm('确定要退出登录吗？'))location.href='${pageContext.request.contextPath}/UserLogoutServlet'">
                            🚪 退出登录
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- 地址选择弹窗 -->
<div class="address-overlay" id="addressOverlay">
    <div class="address-modal">
        <div class="address-modal-title">📍 选择配送地址</div>
        <div id="addressList">
            <!-- 地址列表将通过JavaScript动斀生成 -->
        </div>
        <button class="address-add-btn" onclick="alert('添加地址功能开发中')">+ 添加新地址</button>
        <button class="address-close-btn" onclick="closeAddressModal()">取消</button>
    </div>
</div>

<!-- 支付弹窗 -->
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

<!-- 支付成功弹窗 -->
<div class="success-overlay" id="successOverlay">
    <div class="success-modal">
        <div class="success-icon">✅</div>
        <div class="success-title">支付成功！</div>
        <div class="success-sub">您的订单已提交，请稍候取餐</div>
        <button class="success-btn" onclick="goToOrders()">查看订单</button>
    </div>
</div>

<!-- 订单详情弹窗 -->
<div class="order-detail-overlay" id="orderDetailOverlay">
    <div class="order-detail-modal">
        <div class="order-detail-header">
            <button class="order-detail-close" onclick="closeOrderDetail()">✕</button>
            <div class="order-detail-title" id="orderDetailTitle">订单详情</div>
            <div class="order-detail-status" id="orderDetailStatus"></div>
        </div>
        <div class="order-detail-body" id="orderDetailBody">
            <!-- 动态内容 -->
        </div>
        <div class="detail-actions">
            <button class="detail-action-btn secondary" onclick="alert('联系商家功能开发中')">📞 联系商家</button>
            <button class="detail-action-btn secondary" onclick="alert('再次下单功能开发中')">🔄 再次下单</button>
            <button class="detail-action-btn primary" onclick="alert('评价功能开发中')">⭐ 评价订单</button>
        </div>
    </div>
</div>

<script>
    // ===== 地址选择功能 =====
    var addresses = [
        { id: 1, name: '家', detail: '四会市东城街道江丽路1座商铺1号（首层）', phone: '138****8000' },
        { id: 2, name: '公司', detail: '四会市商业大道88号写字楼3楼', phone: '139****9000' },
        { id: 3, name: '学校', detail: '四会市教育路123号学生宿舍5栋', phone: '137****7000' }
    ];
    var selectedAddressId = null;

    // 初始化：从 localStorage 读取上次选择的地址
    window.addEventListener('load', function () {
        var savedAddressId = localStorage.getItem('selectedAddressId');
        if (savedAddressId) {
            selectedAddressId = parseInt(savedAddressId);
            updateAddressDisplay();
        }
    });

    function openAddressModal() {
        renderAddressList();
        document.getElementById('addressOverlay').classList.add('show');
    }

    function closeAddressModal() {
        document.getElementById('addressOverlay').classList.remove('show');
    }

    function renderAddressList() {
        var container = document.getElementById('addressList');
        container.innerHTML = '';

        addresses.forEach(function(addr) {
            var div = document.createElement('div');
            div.className = 'address-item' + (selectedAddressId === addr.id ? ' selected' : '');
            div.onclick = function() { selectAddress(addr.id); };
            div.innerHTML =
                '<div class="address-item-name">' + addr.name + '</div>' +
                '<div class="address-item-detail">📍 ' + addr.detail + '</div>' +
                '<div class="address-item-phone">📞 ' + addr.phone + '</div>';
            container.appendChild(div);
        });
    }

    function selectAddress(addressId) {
        selectedAddressId = addressId;
        localStorage.setItem('selectedAddressId', addressId);
        updateAddressDisplay();
        closeAddressModal();
    }

    function updateAddressDisplay() {
        var addr = addresses.find(function(a) { return a.id === selectedAddressId; });
        if (addr) {
            document.getElementById('currentAddressText').textContent = addr.name + ' - ' + addr.detail;
        } else {
            document.getElementById('currentAddressText').textContent = '请选择配送地址';
        }
    }

    // ===== 搜索功能 =====
    function searchProducts() {
        var keyword = document.getElementById('productSearchInput').value.trim();
        
        // 检查是否为空
        if (keyword === '') {
            alert('请输入搜索关键词');
            return;
        }
        
        // 跳转到点单页面并传递搜索关键词
        window.location.href = 'index.jsp?type=search&keyword=' + encodeURIComponent(keyword);
    }
    
    // 监听Enter键
    document.addEventListener('DOMContentLoaded', function() {
        var searchInput = document.getElementById('productSearchInput');
        if (searchInput) {
            searchInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    searchProducts();
                }
            });
        }
    });
    
    function showAllProducts() {
        var productCards = document.querySelectorAll('.coffee-card');
        productCards.forEach(function(card) {
            card.style.display = '';
        });
        hideNoResultMessage();
    }
    
    function showNoResultMessage(keyword) {
        // 检查是否已经存在提示消息
        var existingMsg = document.getElementById('noResultMessage');
        if (!existingMsg) {
            var msgDiv = document.createElement('div');
            msgDiv.id = 'noResultMessage';
            msgDiv.className = 'empty-tip';
            msgDiv.innerHTML = '<span class="big-icon">🔍</span>没有找到与 "' + keyword + '" 相关的饮品<br><span style="font-size:13px;">请尝试其他关键词</span>';
            
            var drinkList = document.getElementById('drinkListPanel');
            if (drinkList) {
                var wrap = drinkList.querySelector('.coffee-wrap');
                if (wrap) {
                    wrap.appendChild(msgDiv);
                }
            }
        }
    }
    
    function hideNoResultMessage() {
        var msg = document.getElementById('noResultMessage');
        if (msg) {
            msg.remove();
        }
    }
    
    // 点单折叠
    const menuBtn = document.getElementById('orderMenuBtn');
    const subMenu = document.getElementById('orderSubMenu');
    menuBtn.addEventListener('click', function () {
        subMenu.classList.toggle('show');
    });

    // 默认展开点单菜单
    window.addEventListener('load', function () {
        subMenu.classList.add('show');

        // 订单页动态渲染（从 sessionStorage 读取前端直接购买的订单）
        renderDynamicOrders();
    });

    // 渲染前端直接购买的订单（从 sessionStorage 读取）
    function renderDynamicOrders() {
        var orderContainer = document.getElementById('orderContainer');
        if (!orderContainer) return;

        var orders = JSON.parse(sessionStorage.getItem('pendingOrders') || '[]');
        if (orders.length === 0) return;

        // 隐藏空状态提示
        var noDbOrdersTip = document.getElementById('noDbOrdersTip');
        if (noDbOrdersTip) {
            noDbOrdersTip.style.display = 'none';
        }

        orders.forEach(function (o) {
            var card = document.createElement('div');
            card.className = 'order-card';
            card.innerHTML =
                '<div class="order-top"><span>订单号：' + o.id + '</span><span class="order-status" style="color:#C9B48E">' + o.status + '</span></div>' +
                '<div class="order-item"><div class="order-icon">' + o.icon + '</div><span>' + o.name + ' ×1</span></div>' +
                '<div style="font-size:12px;color:#a8937b;margin:4px 0 8px 50px;">' + o.spec + '</div>' +
                '<div class="order-bottom"><span>实付 ' + o.price + '</span><button class="detail-btn" onclick=\'viewDynamicOrderDetail("' + o.id + '","' + o.name + '","' + o.price + '","' + o.spec + '","' + o.status + '")\'>查看详情</button></div>';
            orderContainer.insertBefore(card, orderContainer.firstChild);
        });
    }

    // 查看前端动态订单详情
    function viewDynamicOrderDetail(orderId, name, price, spec, status) {
        var mockData = {
            orderNo: orderId,
            statusText: status,
            status: 1,
            createTime: new Date().toLocaleString('zh-CN'),
            payTime: new Date().toLocaleString('zh-CN'),
            payMethod: '微信支付',
            payNo: 'PAY' + Date.now(),
            totalPrice: price.replace('¥', ''),
            originalPrice: price.replace('¥', ''),
            items: [{
                productName: name,
                quantity: 1,
                price: price.replace('¥', ''),
                specification: spec
            }]
        };
        renderOrderDetail(mockData);
    }

    // 查看订单详情（精致弹窗展示，从后端获取数据）
    function viewOrderDetail(orderId) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', '${pageContext.request.contextPath}/OrderDetailServlet?id=' + orderId, true);
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var data = JSON.parse(xhr.responseText);
                    if (data.error) {
                        alert(data.error);
                        return;
                    }
                    renderOrderDetail(data);
                } catch(e) {
                    alert('订单详情加载失败');
                }
            } else {
                alert('订单详情加载失败');
            }
        };
        xhr.onerror = function() {
            alert('网络错误，请重试');
        };
        xhr.send();
    }

    // 渲染订单详情
    function renderOrderDetail(data) {
        // 设置标题和状态
        document.getElementById('orderDetailTitle').textContent = '订单号：' + (data.orderNo || '-');
        var statusEl = document.getElementById('orderDetailStatus');
        statusEl.textContent = data.statusText || '未知状态';
        
        // 根据状态设置颜色
        var statusColors = {
            '待付款': { bg: '#fff3e0', color: '#ff9800' },
            '待制作': { bg: '#e3f2fd', color: '#2196f3' },
            '配送中': { bg: '#e8f5e9', color: '#4caf50' },
            '待取餐': { bg: '#e8f5e9', color: '#4caf50' },
            '已完成': { bg: '#f5f5f5', color: '#999' },
            '已取消': { bg: '#f5f5f5', color: '#999' }
        };
        var statusColor = statusColors[data.statusText] || { bg: '#FFF0DC', color: '#C9B48E' };
        statusEl.style.background = statusColor.bg;
        statusEl.style.color = statusColor.color;

        // 构建详情内容
        var html = '';

        // 一、订单状态时间线
        html += '<div class="detail-section">';
        html += '<div class="detail-section-title">📍 订单状态</div>';
        html += '<div class="timeline-item">';
        html += '<div class="timeline-dot active"></div>';
        html += '<div class="timeline-content">';
        html += '<div class="timeline-title">订单已提交</div>';
        html += '<div class="timeline-time">' + (data.createTime || '-') + '</div>';
        html += '</div></div>';
        
        if (data.payTime) {
            html += '<div class="timeline-item">';
            html += '<div class="timeline-dot active"></div>';
            html += '<div class="timeline-content">';
            html += '<div class="timeline-title">已支付</div>';
            html += '<div class="timeline-time">' + data.payTime + '</div>';
            html += '</div></div>';
        }
        
        if (data.status >= 1) {
            html += '<div class="timeline-item">';
            html += '<div class="timeline-dot active"></div>';
            html += '<div class="timeline-content">';
            html += '<div class="timeline-title">商家已接单</div>';
            html += '<div class="timeline-time">处理中...</div>';
            html += '</div></div>';
        }
        html += '</div>';

        // 二、商家门店信息
        html += '<div class="detail-section">';
        html += '<div class="detail-section-title">🏪 商家信息</div>';
        html += '<div class="detail-row"><span class="detail-label">店铺名称</span><span class="detail-value">咩嘢熊仔咖啡</span></div>';
        html += '<div class="detail-row"><span class="detail-label">门店地址</span><span class="detail-value">四会市东城街道江丽路1座商铺1号</span></div>';
        html += '<div class="detail-row"><span class="detail-label">联系电话</span><span class="detail-value">0758-1234567</span></div>';
        html += '<div class="detail-row"><span class="detail-label">营业时间</span><span class="detail-value">08:00-22:00</span></div>';
        html += '</div>';

        // 三、商品消费明细
        if (data.items && data.items.length > 0) {
            html += '<div class="detail-section">';
            html += '<div class="detail-section-title">🛍️ 商品明细</div>';
            
            data.items.forEach(function(item) {
                // 判断图标
                var icon = '☕';
                if (item.productName) {
                    if (item.productName.indexOf('拿铁') !== -1) icon = '☕';
                    else if (item.productName.indexOf('美式') !== -1) icon = '☕';
                    else if (item.productName.indexOf('气泡') !== -1) icon = '🫧';
                    else if (item.productName.indexOf('提拉米苏') !== -1 || item.productName.indexOf('蛋糕') !== -1) icon = '🍰';
                    else if (item.productName.indexOf('甜品') !== -1) icon = '🧁';
                    else if (item.productName.indexOf('冷萃') !== -1) icon = '🧊';
                    else if (item.productName.indexOf('特调') !== -1) icon = '🍹';
                }

                html += '<div class="detail-item-card">';
                html += '<div class="detail-item-icon">' + icon + '</div>';
                html += '<div class="detail-item-info">';
                html += '<div class="detail-item-name">' + (item.productName || '商品') + '</div>';
                
                // 规格信息
                if (item.specification || item.remark) {
                    html += '<div class="detail-item-spec">' + (item.specification || item.remark || '') + '</div>';
                }
                
                html += '<div class="detail-item-price-row">';
                html += '<span>×' + (item.quantity || 1) + '</span>';
                html += '<span class="detail-item-price">¥' + (item.price || 0) + '</span>';
                html += '</div>';
                html += '</div></div>';
            });
            html += '</div>';
        }

        // 四、价格汇总
        html += '<div class="detail-section">';
        html += '<div class="detail-section-title">💰 费用明细</div>';
        html += '<div class="detail-price-summary">';
        html += '<div class="detail-total-row"><span class="detail-label">商品原价</span><span class="detail-value">¥' + (data.originalPrice || data.totalPrice || 0) + '</span></div>';
        
        if (data.discountPrice && data.discountPrice > 0) {
            html += '<div class="detail-total-row"><span class="detail-label">优惠减免</span><span class="detail-value" style="color:#4caf50;">-¥' + data.discountPrice + '</span></div>';
        }
        
        if (data.deliveryFee && data.deliveryFee > 0) {
            html += '<div class="detail-total-row"><span class="detail-label">配送费</span><span class="detail-value">¥' + data.deliveryFee + '</span></div>';
        }
        
        if (data.packFee && data.packFee > 0) {
            html += '<div class="detail-total-row"><span class="detail-label">打包费</span><span class="detail-value">¥' + data.packFee + '</span></div>';
        }
        
        html += '<div class="detail-total-row detail-total-final">';
        html += '<span style="font-weight:bold;">实付金额</span>';
        html += '<span class="detail-value">¥' + (data.totalPrice || 0) + '</span>';
        html += '</div>';
        html += '</div></div>';

        // 五、支付信息
        html += '<div class="detail-section">';
        html += '<div class="detail-section-title">💳 支付信息</div>';
        html += '<div class="detail-row"><span class="detail-label">支付方式</span><span class="detail-value">' + (data.payMethod || '微信支付') + '</span></div>';
        html += '<div class="detail-row"><span class="detail-label">支付流水号</span><span class="detail-value">' + (data.payNo || 'PAY' + Date.now()) + '</span></div>';
        html += '<div class="detail-row"><span class="detail-label">下单时间</span><span class="detail-value">' + (data.createTime || '-') + '</span></div>';
        if (data.payTime) {
            html += '<div class="detail-row"><span class="detail-label">支付时间</span><span class="detail-value">' + data.payTime + '</span></div>';
        }
        html += '</div>';

        // 六、收货信息（如果有）
        if (data.address || data.receiver || data.receiverPhone) {
            html += '<div class="detail-section">';
            html += '<div class="detail-section-title">📦 收货信息</div>';
            if (data.receiver) {
                html += '<div class="detail-row"><span class="detail-label">收货人</span><span class="detail-value">' + data.receiver + '</span></div>';
            }
            if (data.receiverPhone) {
                html += '<div class="detail-row"><span class="detail-label">联系电话</span><span class="detail-value">' + data.receiverPhone + '</span></div>';
            }
            if (data.address) {
                html += '<div class="detail-row"><span class="detail-label">收货地址</span><span class="detail-value">' + data.address + '</span></div>';
            }
            if (data.deliveryRemark) {
                html += '<div class="detail-row"><span class="detail-label">送达备注</span><span class="detail-value">' + data.deliveryRemark + '</span></div>';
            }
            html += '</div>';
        }

        // 七、备注
        if (data.remark) {
            html += '<div class="detail-section">';
            html += '<div class="detail-section-title">📝 订单备注</div>';
            html += '<div style="background:#FFF9EF;padding:12px;border-radius:8px;font-size:14px;color:#5C4836;">' + data.remark + '</div>';
            html += '</div>';
        }

        // 设置内容并显示弹窗
        document.getElementById('orderDetailBody').innerHTML = html;
        document.getElementById('orderDetailOverlay').classList.add('show');
    }

    // 关闭订单详情弹窗
    function closeOrderDetail() {
        document.getElementById('orderDetailOverlay').classList.remove('show');
    }

    // 点击遮罩层关闭
    document.addEventListener('DOMContentLoaded', function() {
        var overlay = document.getElementById('orderDetailOverlay');
        if (overlay) {
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) {
                    closeOrderDetail();
                }
            });
        }
    });

    // 切换一级页面
    function switchPage(pageName) {
        window.location.href = "index.jsp?page=" + pageName;
    }

    // 切换饮品分类（包括新品）
    function switchType(typeName) {
        window.location.href = "index.jsp?type=" + typeName;
    }

    // 首页点单卡片展开菜单
    function expandMenu() {
        subMenu.classList.add('show');
        // 切换首页到点单分类默认（意式咖啡）
        window.location.href = "index.jsp?type=意式咖啡";
    }

    // ===== 自定义规格面板 =====
    var currentDrink = {name: '', price: '', imageUrl: ''};

    function openCustomize(name, price, imageUrl) {
        currentDrink = {name: name, price: price, imageUrl: imageUrl};
        document.getElementById('selectedName').textContent = name;
        document.getElementById('selectedPrice').textContent = price;
        // 图片显示
        var iconContainer = document.getElementById('selectedIcon');
        if (imageUrl && imageUrl !== '') {
            iconContainer.innerHTML = '<img src="${pageContext.request.contextPath}/' + imageUrl + '" alt="' + name + '">';
        } else {
            iconContainer.textContent = '☕';
        }
        document.getElementById('drinkListPanel').style.display = 'none';
        document.getElementById('customizePanel').classList.add('show');
        // 重置所有选项到默认第一项
        ['opt-size', 'opt-temp', 'opt-bean', 'opt-strength', 'opt-sugar', 'opt-milk'].forEach(function (id) {
            var chips = document.querySelectorAll('#' + id + ' .opt-chip');
            chips.forEach(function (c) {
                c.classList.remove('selected');
            });
            if (chips.length > 0) chips[0].classList.add('selected');
        });
    }

    function closeCustomize() {
        document.getElementById('customizePanel').classList.remove('show');
        document.getElementById('drinkListPanel').style.display = '';
    }

    function selectChip(el, group) {
        var chips = document.querySelectorAll('#opt-' + group + ' .opt-chip');
        chips.forEach(function (c) {
            c.classList.remove('selected');
        });
        el.classList.add('selected');
    }

    // ===== 支付弹窗 =====
    var selectedPayMethod = 'wechat';

    function openPayModal() {
        var size = getSelected('opt-size');
        var temp = getSelected('opt-temp');
        document.getElementById('payModalSub').textContent = currentDrink.name + ' · ' + size + ' · ' + temp;
        document.getElementById('payModalAmount').textContent = currentDrink.price;
        selectedPayMethod = 'wechat';
        document.getElementById('wechatMethod').classList.add('selected');
        document.getElementById('alipayMethod').classList.remove('selected');
        document.getElementById('payOverlay').classList.add('show');
    }

    function closePayModal() {
        document.getElementById('payOverlay').classList.remove('show');
    }

    function selectPayMethod(method) {
        selectedPayMethod = method;
        document.getElementById('wechatMethod').classList.toggle('selected', method === 'wechat');
        document.getElementById('alipayMethod').classList.toggle('selected', method === 'alipay');
    }

    function getSelected(groupId) {
        var sel = document.querySelector('#' + groupId + ' .opt-chip.selected');
        return sel ? sel.textContent : '';
    }

    // ===== 确认支付 → 生成订单 =====
    function confirmPay() {
        // 检查是否是购物车支付
        if (currentCartOrderId > 0) {
            // 购物车支付：调用后端 PayServlet
            completeCartPayment();
            return;
        }

        // 点单直接购买：前端模拟支付
        var orderId = '2026' + Math.floor(Date.now() / 1000);
        var size = getSelected('opt-size');
        var temp = getSelected('opt-temp');
        var bean = getSelected('opt-bean');
        var strength = getSelected('opt-strength');
        var sugar = getSelected('opt-sugar');
        var milk = getSelected('opt-milk');
        var order = {
            id: orderId,
            name: currentDrink.name,
            icon: '☕',
            price: currentDrink.price,
            spec: size + ' · ' + temp + ' · ' + bean + ' · ' + strength + ' · ' + sugar + ' · ' + milk,
            method: selectedPayMethod === 'wechat' ? '微信支付' : '支付宝',
            status: '待取餐'
        };
        var orders = JSON.parse(sessionStorage.getItem('pendingOrders') || '[]');
        orders.unshift(order);
        sessionStorage.setItem('pendingOrders', JSON.stringify(orders));
        document.getElementById('payOverlay').classList.remove('show');
        document.getElementById('successOverlay').classList.add('show');
    }

    // 完成购物车支付
    function completeCartPayment() {
        var payMethodName = selectedPayMethod === 'wechat' ? '微信支付' : '支付宝';

        // 使用 AJAX 调用 PayServlet
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '${pageContext.request.contextPath}/PayServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');

        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var result = JSON.parse(xhr.responseText);
                    if (result.success) {
                        // 支付成功，关闭支付弹窗，显示成功弹窗
                        document.getElementById('payOverlay').classList.remove('show');
                        document.getElementById('successOverlay').classList.add('show');

                        // 重置购物车订单 ID
                        currentCartOrderId = 0;
                        currentCartOrderPrice = 0;
                    } else {
                        alert('支付失败，请重试');
                    }
                } catch(e) {
                    // 支付成功，关闭支付弹窗，显示成功弹窗
                    document.getElementById('payOverlay').classList.remove('show');
                    document.getElementById('successOverlay').classList.add('show');

                    // 重置购物车订单 ID
                    currentCartOrderId = 0;
                    currentCartOrderPrice = 0;
                }
            } else {
                alert('支付失败，请重试');
            }
        };

        xhr.onerror = function() {
            alert('网络错误，请重试');
        };

        xhr.send('orderId=' + currentCartOrderId + '&payMethod=' + selectedPayMethod);
    }

    function goToOrders() {
        document.getElementById('successOverlay').classList.remove('show');
        window.location.href = 'index.jsp?page=order';
    }

    // 加入购物车
    function addToCart(productId) {
        window.location.href = '${pageContext.request.contextPath}/CartAddServlet?coffeeId=' + productId + '&from=index';
    }

    // 购物车结算
    function goCartPay(){
        var loginUser = ${sessionScope.loginUser != null ? 1 : 0};
        if(loginUser !== 1){
            alert("下单前需要登录账号！");
            location.href = "login.jsp";
            return;
        }

        // 使用 AJAX 提交订单
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '${pageContext.request.contextPath}/OrderSubmitServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');

        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var result = JSON.parse(xhr.responseText);
                    // 打开支付弹窗
                    openCartPayModal(result.orderId, result.totalPrice, result.orderNo);
                } catch(e) {
                    alert('订单创建失败');
                }
            } else {
                alert('网络错误，请重试');
            }
        };

        xhr.onerror = function() {
            alert('网络错误，请重试');
        };

        xhr.send('mode=cart');
    }

    // 购物车支付弹窗
    var currentCartOrderId = 0;
    var currentCartOrderPrice = 0;

    function openCartPayModal(orderId, totalPrice, orderNo) {
        currentCartOrderId = orderId;
        currentCartOrderPrice = totalPrice;

        document.getElementById('payModalSub').textContent = '订单号：' + orderNo;
        document.getElementById('payModalAmount').textContent = '￥' + Math.floor(totalPrice);
        selectedPayMethod = 'wechat';
        document.getElementById('wechatMethod').classList.add('selected');
        document.getElementById('alipayMethod').classList.remove('selected');
        document.getElementById('payOverlay').classList.add('show');
    }

    // 更新购物车商品数量
    function updateCart(index, op) {
        location.href = "${pageContext.request.contextPath}/CartUpdateServlet?index=" + index + "&op=" + op + "&page=cart";
    }
</script>
</body>
</html>



///