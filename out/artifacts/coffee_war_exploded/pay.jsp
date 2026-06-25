<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>选择支付方式</title>
  <style>
    * {margin:0;padding:0;box-sizing:border-box;font-family:"微软雅黑";}
    body {background:#FFF0DC;color:#5C4836;}
    .page-title {text-align:center;padding:20px;font-size:20px;font-weight:bold;}
    .pay-price{text-align:center;font-size:24px;color:#C9B48E;font-weight:bold;margin:10px 0 30px;}
    .pay-item{background:#fff;margin:12px 15px;border-radius:14px;padding:18px;display:flex;align-items:center;gap:12px;cursor:pointer;border:2px solid transparent;}
    .pay-item.active{border-color:#C9B48E;}
    .pay-icon{font-size:30px;}
    .pay-text{font-size:16px;}
    .confirm-pay{width:90%;margin:40px auto 0;display:block;padding:12px;background:#C9B48E;color:#fff;border:none;border-radius:20px;font-size:15px;cursor:pointer;}
  </style>
</head>
<body>
<div class="page-title">选择支付方式</div>
<div class="pay-price">支付金额：¥58</div>

<div class="pay-item active" onclick="choosePay(this)">
  <div class="pay-icon">💚</div>
  <div class="pay-text">微信支付</div>
</div>
<div class="pay-item" onclick="choosePay(this)">
  <div class="pay-icon">💙</div>
  <div class="pay-text">支付宝支付</div>
</div>

<button class="confirm-pay" onclick="paySuccess()">确认支付</button>

<script>
  // 选择支付方式
  function choosePay(el){
    document.querySelectorAll('.pay-item').forEach(item=>{
      item.classList.remove('active');
    })
    el.classList.add('active');
  }
  // 模拟支付成功，跳转我的订单
  function paySuccess(){
    alert("支付成功！订单已生成！");
    location.href = "myOrder.jsp";
  }
</script>
</body>
</html>