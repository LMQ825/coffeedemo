-- 创建购物车表（如果不存在）
CREATE TABLE IF NOT EXISTS `cart` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `quantity` INT DEFAULT 1 COMMENT '数量',
  `create_time` DATETIME DEFAULT NOW(),
  `update_time` DATETIME DEFAULT NOW() ON UPDATE NOW(),
  FOREIGN KEY (`user_id`) REFERENCES `user`(`id`),
  FOREIGN KEY (`product_id`) REFERENCES `product`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';
