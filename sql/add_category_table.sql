-- ============================================
-- 咩嘢熊仔咖啡厅点单系统 - 数据库更新脚本
-- 新增分类管理功能
-- ============================================

-- 1. 创建分类表 (category)
CREATE TABLE IF NOT EXISTS `category` (
    `id` INT AUTO_INCREMENT PRIMARY KEY COMMENT '分类ID',
    `name` VARCHAR(50) NOT NULL COMMENT '分类名称',
    `description` VARCHAR(200) DEFAULT NULL COMMENT '分类描述',
    `sort_order` INT DEFAULT 0 COMMENT '排序顺序，数字越小越靠前',
    `status` INT DEFAULT 1 COMMENT '状态：1启用 0禁用',
    `create_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='饮品分类表';

-- 2. 插入初始分类数据
INSERT INTO `category` (`name`, `description`, `sort_order`, `status`) VALUES
('咖啡系列', '经典咖啡饮品，包括拿铁、美式、卡布奇诺等', 1, 1),
('奶茶系列', '精选奶茶饮品，包括珍珠奶茶、芋泥奶茶等', 2, 1),
('茶饮系列', '健康茶饮，包括绿茶、红茶、乌龙茶等', 3, 1),
('果汁系列', '新鲜果汁饮品，包括橙汁、西瓜汁等', 4, 1),
('特调饮品', '创意特调饮品，季节限定款', 5, 1),
('甜点小吃', '搭配饮品的甜点和轻食', 6, 1);

-- 3. 更新商品表(product)，添加分类关联字段（如果尚未添加）
-- 注意：如果你的 product 表已经有 category 字段（字符串类型），可以跳过此步骤
-- 如果想要改为关联 category 表，可以执行以下SQL：

-- 添加 category_id 外键字段（可选，如果需要精确关联）
-- ALTER TABLE `product` ADD COLUMN `category_id` INT DEFAULT NULL COMMENT '分类ID';
-- ALTER TABLE `product` ADD CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category`(`id`);

-- 4. 将现有商品的分类字段值与分类表关联（可选）
-- UPDATE `product` SET `category_id` = 1 WHERE `category` LIKE '%咖啡%';
-- UPDATE `product` SET `category_id` = 2 WHERE `category` LIKE '%奶茶%';
-- UPDATE `product` SET `category_id` = 3 WHERE `category` LIKE '%茶%';

-- 5. 添加分类统计视图（可选）
CREATE OR REPLACE VIEW `v_category_stats` AS
SELECT 
    c.id AS category_id,
    c.name AS category_name,
    c.status AS category_status,
    COUNT(p.id) AS product_count,
    COALESCE(SUM(p.status = 1), 0) AS active_product_count
FROM `category` c
LEFT JOIN `product` p ON p.category = c.name
GROUP BY c.id, c.name, c.status;

-- 6. 添加销售统计视图（可选）
CREATE OR REPLACE VIEW `v_sales_stats` AS
SELECT 
    DATE(o.create_time) AS order_date,
    COUNT(o.id) AS order_count,
    SUM(o.total_price) AS total_sales,
    COUNT(CASE WHEN o.status = 1 THEN 1 END) AS pending_count,
    COUNT(CASE WHEN o.status = 2 THEN 1 END) AS completed_count
FROM `order` o
WHERE o.status >= 1
GROUP BY DATE(o.create_time)
ORDER BY order_date DESC;

-- ============================================
-- 使用说明：
-- 1. 在MySQL中执行此脚本前，请确保已创建 coffee_demo 数据库
-- 2. 如果部分SQL执行报错（如字段已存在），可以跳过相应语句
-- 3. 根据实际需求调整分类数据
-- ============================================