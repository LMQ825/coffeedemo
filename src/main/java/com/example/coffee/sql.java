//CREATE DATABASE IF NOT EXISTS coffee_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
//        USE coffee_db;
//
//        -- 用户表
//        CREATE TABLE `user` (
//        `id` INT PRIMARY KEY AUTO_INCREMENT COMMENT '用户主键',
//        `username` VARCHAR(30) NOT NULL UNIQUE COMMENT '用户名',
//        `password` VARCHAR(30) NOT NULL COMMENT '密码',
//        `phone` VARCHAR(11) DEFAULT '' COMMENT '手机号',
//        `address` VARCHAR(100) DEFAULT '' COMMENT '收货地址'
//        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
//        -- 饮品商品表
//        CREATE TABLE `coffee` (
//        `coffeeId` INT PRIMARY KEY AUTO_INCREMENT COMMENT '商品ID',
//        `coffeeName` VARCHAR(50) NOT NULL COMMENT '商品名称',
//        `price` DECIMAL(5,2) NOT NULL COMMENT '单价',
//        `type` VARCHAR(20) NOT NULL COMMENT '分类：意式咖啡/冷萃咖啡/特色美式/特调饮品/甜品小食',
//        `icon` VARCHAR(50) DEFAULT '' COMMENT '图标emoji'
//        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
//        -- 购物车表
//        CREATE TABLE `cart` (
//        `cartId` INT PRIMARY KEY AUTO_INCREMENT,
//        `userId` INT NOT NULL,
//        `coffeeId` INT NOT NULL,
//        `num` INT DEFAULT 1 COMMENT '数量',
//        FOREIGN KEY (`userId`) REFERENCES `user`(`id`),
//        FOREIGN KEY (`coffeeId`) REFERENCES `coffee`(`coffeeId`)
//        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
//        -- 订单主表
//        CREATE TABLE `orders` (
//        `orderId` VARCHAR(20) PRIMARY KEY COMMENT '订单编号',
//        `userId` INT NOT NULL,
//        `totalPrice` DECIMAL(6,2) NOT NULL COMMENT '实付总价',
//        `phone` VARCHAR(11) NOT NULL COMMENT '下单手机号',
//        `remark` VARCHAR(100) DEFAULT '' COMMENT '备注',
//        `status` VARCHAR(10) DEFAULT '待取餐' COMMENT '待取餐/已完成',
//        `createTime` DATETIME DEFAULT NOW(),
//        FOREIGN KEY (`userId`) REFERENCES `user`(`id`)
//        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
//        -- 订单详情表
//        CREATE TABLE `order_item` (
//        `itemId` INT PRIMARY KEY AUTO_INCREMENT,
//        `orderId` VARCHAR(20) NOT NULL,
//        `coffeeId` INT NOT NULL,
//        `num` INT NOT NULL,
//        FOREIGN KEY (`orderId`) REFERENCES `orders`(`orderId`),
//        FOREIGN KEY (`coffeeId`) REFERENCES `coffee`(`coffeeId`)
//        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
//
//        -- 插入测试商品数据
//        INSERT INTO coffee(coffeeName,price,type,icon) VALUES
//        ('经典拿铁',22,'意式咖啡','☕'),
//        ('焦糖玛奇朵',24,'意式咖啡','🥤'),
//        ('提拉米苏',18,'甜品小食','🍰'),
//        ('荔枝气泡美式',26,'特调饮品','🫧');
//
//        -- 测试账号（用户名test，密码123456）
//        INSERT INTO user(username,password,phone,address) VALUES
//        ('test','123456','13800138000','四会市东城街道江丽路1座商铺1号');