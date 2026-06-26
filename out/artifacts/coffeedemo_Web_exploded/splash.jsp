<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>咩嘢熊仔咖啡</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #FFF0DC;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-family: "微软雅黑", sans-serif;
            color: #5C4836;
            position: relative;
            overflow: hidden;
        }
        /* 顶部OPENING+开始营业 */
        .top-text {
            text-align: center;
            margin-bottom: 40px;
        }
        .en-title {
            font-size: 22px;
            letter-spacing: 2px;
            margin-bottom: 12px;
        }
        .cn-title {
            font-size: 38px;
            font-weight: 500;
        }
        /* 小熊主体区域 */
        .bear-wrap {
            text-align: center;
        }
        .bear-icon {
            font-size: 140px;
            line-height: 1;
            display: inline-block;
            animation: softBounce 2s infinite ease-in-out;
        }
        .shop-name {
            font-size: 42px;
            margin: 10px 0;
            letter-spacing: 4px;
        }
        .slogan-box {
            border: 1px solid #C9B48E;
            border-radius: 30px;
            padding: 6px 30px;
            display: inline-block;
            font-size: 16px;
            color: #7D664F;
            margin-bottom: 20px;
        }
        /* 倒计时进度条容器 */
        .progress-wrap {
            width: 220px;
            height: 32px;
            background: #e0cdb4;
            border-radius: 16px;
            overflow: hidden;
            position: relative;
            margin: 0 auto;
            cursor: pointer;
        }
        /* 填充进度 */
        .progress-bar {
            height: 100%;
            background: #5C4836;
            width: 100%;
            transition: width 1s linear;
        }
        /* 进度文字 */
        .progress-text {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            line-height: 32px;
            text-align: center;
            color: #fff;
            font-size: 14px;
        }
        /* 小熊浮动动画 */
        @keyframes softBounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-12px); }
        }
    </style>
</head>
<body>
<!-- 顶部文字 -->
<div class="top-text">
    <div class="en-title">OPENING</div>
    <div class="cn-title">开始营业</div>
</div>

<!-- 小熊店铺logo区域 -->
<div class="bear-wrap">
    <div class="bear-icon">🐻</div>
    <div class="shop-name">咩嘢熊仔</div>
    <div class="slogan-box">早咖晚酒</div>

    <!-- 进度条倒计时（放在早咖晚酒下方） -->
    <div class="progress-wrap" id="skipWrap">
        <div class="progress-bar" id="bar"></div>
        <div class="progress-text" id="txt">跳过 3</div>
    </div>
</div>

<script>
    // 总倒计时3秒
    let totalTime = 3;
    let current = totalTime;
    const bar = document.getElementById("bar");
    const txt = document.getElementById("txt");
    const wrap = document.getElementById("skipWrap");
    // 初始宽度100%，每秒递减
    let perWidth = 100 / totalTime;

    const timer = setInterval(function () {
        current--;
        bar.style.width = perWidth * current + "%";
        txt.innerText = "跳过 " + current;
        if (current <= 0) {
            clearInterval(timer);
            window.location.href = "index.jsp";
        }
    }, 1000);

    // 点击进度条直接跳转首页
    wrap.onclick = function () {
        clearInterval(timer);
        window.location.href = "index.jsp";
    };
</script>
</body>
</html>