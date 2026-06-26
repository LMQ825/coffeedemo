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
    <title>确认地址 - 咩嘢熊仔咖啡</title>
    <style>
        * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
        body {background:#FFF0DC;color:#5C4836;padding-bottom:90px;}
        .title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
        .block {background:#fff;margin:10px 15px;border-radius:14px;padding:15px;}
        .block-title {font-weight:bold;margin-bottom:10px;font-size:16px;}
        .address-card {background:#FFF9EF;border:2px solid #C9B48E;border-radius:12px;padding:14px;margin-bottom:12px;}
        .address-row {display:flex;align-items:center;padding:6px 0;}
        .address-label {font-size:13px;color:#947c64;width:60px;flex-shrink:0;}
        .address-value {flex:1;font-size:14px;}
        .edit-btn {color:#C9B48E;font-size:13px;cursor:pointer;margin-left:8px;}
        .input-box {width:100%;padding:10px;border:1px solid #E0CDB4;border-radius:10px;margin-top:8px;outline:none;background:#FFF9EF;font-size:14px;}
        .split {height:1px;background:#E9D9C2;margin:10px 0;}
        .item-row {display:flex;justify-content:space-between;padding:6px 0;align-items:center;}
        .item-name {flex:1;}
        .item-sub {color:#947c64;font-size:13px;}
        .confirm-bar {position:fixed;bottom:0;left:0;width:100%;background:#fff;padding:12px 15px;display:flex;justify-content:space-between;align-items:center;border-top:1px solid #E9D9C2;}
        .confirm-total {font-size:18px;font-weight:bold;color:#C9B48E;}
        .confirm-btn {padding:10px 26px;background:#C9B48E;color:#fff;border:none;border-radius:20px;cursor:pointer;font-size:15px;}
        .confirm-btn:hover {background:#b8a07a;}
        .tip-text {font-size:13px;color:#947c64;margin-top:8px;}
        .hidden {display:none;}
    </style>
</head>
<body>
<div class="title">确认配送地址</div>

<!-- 地址确认区域 -->
<div class="block">
    <div class="block-title">📍 配送地址</div>
    <div class="address-card" id="addressCard">
        <div class="address-row">
            <span class="address-label">手机号</span>
            <span class="address-value" id="displayPhone"><%=defaultPhone.isEmpty() ? "未设置" : defaultPhone%></span>
            <span class="edit-btn" onclick="toggleEdit()">修改</span>
        </div>
        <div class="address-row">
            <span class="address-label">地址</span>
            <span class="address-value" id="displayAddr"><%=defaultAddr.isEmpty() ? "未设置" : defaultAddr%></span>
        </div>
    </div>
    <!-- 编辑表单 -->
    <div id="editForm" class="hidden">
        <input class="input-box" type="text" id="editPhone" value="<%=defaultPhone%>" placeholder="请输入手机号">
        <input class="input-box" type="text" id="editAddr" value="<%=defaultAddr%>" placeholder="请输入配送地址">
        <div style="display:flex;gap:10px;margin-top:10px;">
            <button style="flex:1;padding:10px;background:#fff;color:#C9B48E;border:1px solid #C9B48E;border-radius:10px;cursor:pointer;" onclick="toggleEdit()">取消</button>
            <button style="flex:1;padding:10px;background:#C9B48E;color:#fff;border:none;border-radius:10px;cursor:pointer;" onclick="saveAddress()">保存</button>
        </div>
    </div>
    <div class="tip-text">请确认以上地址是否正确，如需修改请点击"修改"按钮</div>
</div>

<!-- 商品清单 -->
<div class="block">
    <div class="block-title">🛍️ 商品清单</div>
    <% if (cart != null && !cart.isEmpty()) { %>
        <% for (CartItem item : cart) { %>
        <div class="item-row">
            <span class="item-name"><%=item.getIcon()%> <%=item.getName()%> ×<%=item.getQuantity()%></span>
            <span class="item-sub">¥<%= (int)item.getSubtotal() %></span>
        </div>
        <% } %>
        <div class="split"></div>
        <div class="item-row">
            <span>实付金额</span>
            <span style="color:#C9B48E;font-weight:bold;font-size:18px;">¥<%= (int)total %></span>
        </div>
    <% } else { %>
        <div style="text-align:center;color:#947c64;padding:20px;">购物车为空</div>
    <% } %>
</div>

<!-- 备注 -->
<div class="block">
    <div class="block-title">📝 备注</div>
    <input class="input-box" type="text" id="remark" placeholder="少冰/不要吸管等">
</div>

<!-- 底部确认栏 -->
<div class="confirm-bar">
    <div>实付：<span class="confirm-total">¥<%= (int)total %></span></div>
    <button class="confirm-btn" onclick="confirmAndSubmit()">确认提交</button>
</div>

<script>
    let isEditing = false;
    
    function toggleEdit() {
        isEditing = !isEditing;
        document.getElementById('addressCard').classList.toggle('hidden', isEditing);
        document.getElementById('editForm').classList.toggle('hidden', !isEditing);
    }
    
    function saveAddress() {
        let phone = document.getElementById('editPhone').value.trim();
        let addr = document.getElementById('editAddr').value.trim();
        
        if (!phone) {
            alert('请填写手机号');
            return;
        }
        if (!addr) {
            alert('请填写配送地址');
            return;
        }
        
        document.getElementById('displayPhone').textContent = phone;
        document.getElementById('displayAddr').textContent = addr;
        toggleEdit();
    }
    
    function confirmAndSubmit() {
        let phone = document.getElementById('displayPhone').textContent;
        let addr = document.getElementById('displayAddr').textContent;
        
        if (phone === '未设置' || addr === '未设置') {
            alert('请先设置配送地址');
            return;
        }
        
        let remark = document.getElementById('remark').value.trim();
        
        // 使用 AJAX 提交订单
        var xhr = new XMLHttpRequest();
        xhr.open('POST', 'OrderSubmitServlet', true);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
        
        xhr.onload = function() {
            if (xhr.status === 200) {
                try {
                    var result = JSON.parse(xhr.responseText);
                    if (result.orderId) {
                        // 跳转到支付页面
                        window.location.href = 'payment.jsp?orderId=' + result.orderId;
                    } else {
                        alert('订单创建失败，请重试');
                    }
                } catch(e) {
                    alert('订单提交成功，正在跳转...');
                    window.location.href = 'cart.jsp';
                }
            } else {
                alert('网络错误，请重试');
            }
        };
        
        xhr.onerror = function() {
            alert('网络错误，请重试');
        };
        
        var params = 'mode=cart&address=' + encodeURIComponent(addr) + '&phone=' + encodeURIComponent(phone) + '&remark=' + encodeURIComponent(remark);
        xhr.send(params);
    }
</script>
</body>
</html>
