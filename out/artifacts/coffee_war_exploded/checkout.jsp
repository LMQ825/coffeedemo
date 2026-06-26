<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.coffee.entity.CartItem" %>
<%@ page import="com.example.coffee.entity.User" %>
<%@ page import="com.example.coffee.util.Catalog" %>
<%
    int cid = 0;
    try { cid = Integer.parseInt(request.getParameter("cid")); } catch(Exception e) {}
    CartItem product = Catalog.get(cid);
    if (product == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    // 从 URL 接收规格参数
    String cupParam    = request.getParameter("cup");    if(cupParam==null) cupParam="中杯";
    String tempParam   = request.getParameter("temp");   if(tempParam==null) tempParam="冰";
    String sugarParam  = request.getParameter("sugar");  if(sugarParam==null) sugarParam="全糖";
    String toppingParam= request.getParameter("topping");if(toppingParam==null) toppingParam="无";
    String remarkParam = request.getParameter("remark"); if(remarkParam==null) remarkParam="";

    User loginUser = (User) session.getAttribute("loginUser");
    String defaultAddr = (loginUser != null && loginUser.getAddress() != null) ? loginUser.getAddress() : "";
    String defaultPhone = (loginUser != null && loginUser.getPhone() != null) ? loginUser.getPhone() : "";

    // 计算价格
    double basePrice = product.getPrice();
    double cupUp = "大杯".equals(cupParam) ? 3 : 0;
    double topUp = "珍珠".equals(toppingParam) ? 3 : ("椰果".equals(toppingParam) ? 3 : ("奶盖".equals(toppingParam) ? 5 : 0));
    double unitPrice = basePrice + cupUp + topUp;
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>确认订单 - 咩嘢熊仔咖啡</title>
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
        .spec-display {background:#F7E9D6;border-radius:8px;padding:8px 12px;font-size:13px;color:#5C4836;line-height:1.6;}
        .qty-box {display:flex;align-items:center;gap:10px;}
        .qty-btn {width:28px;height:28px;border-radius:50%;border:1px solid #C9B48E;background:#fff;cursor:pointer;font-size:15px;line-height:26px;text-align:center;}
        .qty-val {min-width:24px;text-align:center;font-weight:bold;}
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

    <div class="block">
        <div class="block-title">商品</div>
        <div class="product-row">
            <div class="product-icon"><%=product.getIcon()%></div>
            <div>
                <div class="product-name"><%=product.getName()%></div>
                <div class="product-price">¥<%=(int)basePrice%></div>
            </div>
        </div>
    </div>

    <div class="block">
        <div class="block-title">已选规格</div>
        <div class="spec-display">
            杯型：<%= cupParam %> &nbsp;|&nbsp; 温度：<%= tempParam %> &nbsp;|&nbsp; 糖度：<%= sugarParam %> &nbsp;|&nbsp; 加料：<%= toppingParam %>
        </div>
        <% if(!remarkParam.isEmpty()) { %>
        <div class="spec-display" style="margin-top:6px;">备注：<%= remarkParam %></div>
        <% } %>
        <input type="hidden" name="cup" value="<%= cupParam %>">
        <input type="hidden" name="temp" value="<%= tempParam %>">
        <input type="hidden" name="sugar" value="<%= sugarParam %>">
        <input type="hidden" name="topping" value="<%= toppingParam %>">
    </div>

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

    <div class="block">
        <div class="block-title">数量</div>
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

    <div class="block">
        <div class="block-title">备注</div>
        <input class="form-input" type="text" name="remark" value="<%= remarkParam %>" placeholder="少冰/不要吸管等">
    </div>

    <div class="pay-bar">
        <div>实付：<span class="pay-total" id="totalDisp">¥<%=(int)(unitPrice)%></span></div>
        <button class="pay-btn" type="button" onclick="submitOrder()">提交订单</button>
    </div>
</form>

<script>
    let unitPrice = <%= unitPrice %>;
    let qty = 1;

    function changeQty(delta){
        qty += delta;
        if(qty < 1) qty = 1;
        document.getElementById('qtyVal').innerText = qty;
        document.getElementById('qty').value = qty;
        document.getElementById('totalDisp').innerText = '¥' + (unitPrice * qty);
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