-- ============================================
-- 库存管理系统 - 新增表（追加到 coffee_demo 库）
-- ============================================

USE `coffee_demo`;

/*Table structure for table `inventory` */

DROP TABLE IF EXISTS `inventory`;

CREATE TABLE `inventory` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '库存ID',
  `name` varchar(100) NOT NULL COMMENT '原料名称',
  `category` varchar(50) DEFAULT '' COMMENT '分类（咖啡豆/乳制品/糖浆/茶叶/水果/辅料等）',
  `quantity` double NOT NULL DEFAULT '0' COMMENT '当前库存量',
  `unit` varchar(20) NOT NULL DEFAULT 'kg' COMMENT '单位（kg/L/个/包/袋等）',
  `min_quantity` double NOT NULL DEFAULT '10' COMMENT '预警阈值',
  `supplier` varchar(100) DEFAULT '' COMMENT '默认供应商',
  `description` text COMMENT '备注说明',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='饮品原料库存表';

/*Data for the table `inventory` */

insert  into `inventory`(`id`,`name`,`category`,`quantity`,`unit`,`min_quantity`,`supplier`,`description`,`create_time`,`update_time`) values
(1,'哥伦比亚咖啡豆','咖啡豆',25,'kg',10,'云南咖啡供应商','中深烘焙，适合拿铁','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(2,'埃塞俄比亚咖啡豆','咖啡豆',8,'kg',10,'非洲豆供应商','浅烘焙，果香浓郁','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(3,'全脂牛奶','乳制品',30,'L',15,'本地乳业','全脂鲜牛奶','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(4,'燕麦奶','乳制品',5,'L',8,'植物奶供应商','咖啡师专用燕麦奶','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(5,'香草糖浆','糖浆',3,'瓶',5,'进口糖浆供应商','马达加斯加香草','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(6,'焦糖糖浆','糖浆',6,'瓶',5,'进口糖浆供应商','法式焦糖风味','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(7,'抹茶粉','茶叶',2,'kg',3,'日本直供','宇治抹茶粉','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(8,'红茶茶叶','茶叶',4.5,'kg',3,'福建茶厂','正山小种','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(9,'草莓','水果',12,'kg',8,'本地水果批发','新鲜草莓','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(10,'柠檬','水果',15,'个',10,'本地水果批发','新鲜柠檬','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(11,'冰块','辅料',50,'kg',20,'制冰厂','食用冰块','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(12,'纸杯(中)','辅料',500,'个',200,'包装供应商','360ml中杯','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(13,'纸杯(大)','辅料',300,'个',200,'包装供应商','480ml大杯','2026-06-25 15:44:53','2026-06-25 15:44:53'),
(14,'奶油','乳制品',4,'L',5,'本地乳业','淡奶油，用于奶盖','2026-06-25 15:44:53','2026-06-25 15:44:53');

/*Table structure for table `inventory_record` */

DROP TABLE IF EXISTS `inventory_record`;

CREATE TABLE `inventory_record` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `inventory_id` int NOT NULL COMMENT '关联库存ID',
  `quantity` double NOT NULL COMMENT '进货数量',
  `unit` varchar(20) NOT NULL COMMENT '单位',
  `supplier` varchar(100) DEFAULT '' COMMENT '供应商',
  `unit_price` double DEFAULT '0' COMMENT '单价（元）',
  `total_price` double DEFAULT '0' COMMENT '总价（元）',
  `operator` varchar(50) DEFAULT '' COMMENT '操作人',
  `remark` text COMMENT '备注',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '进货时间',
  PRIMARY KEY (`id`),
  KEY `inventory_id` (`inventory_id`),
  CONSTRAINT `inventory_record_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='进货记录表';

/*Data for the table `inventory_record` */

insert  into `inventory_record`(`id`,`inventory_id`,`quantity`,`unit`,`supplier`,`unit_price`,`total_price`,`operator`,`remark`,`create_time`) values
(1,1,20,'kg','云南咖啡供应商',180,3600,'管理员','月度常规补货','2026-06-25 15:44:53'),
(2,2,10,'kg','非洲豆供应商',220,2200,'管理员','季度采购','2026-06-25 15:44:53'),
(3,3,50,'L','本地乳业',8,400,'管理员','每周配送','2026-06-25 15:44:53'),
(4,4,10,'L','植物奶供应商',18,180,'管理员','补货','2026-06-25 15:44:53'),
(5,5,6,'瓶','进口糖浆供应商',85,510,'管理员','季度补货','2026-06-25 15:44:53'),
(6,10,30,'个','本地水果批发',3,90,'管理员','日常补货','2026-06-25 15:44:53'),
(7,11,100,'kg','制冰厂',2,200,'管理员','夏季加量','2026-06-25 15:44:53'),
(8,12,1000,'个','包装供应商',0.3,300,'管理员','月度采购','2026-06-25 15:44:53');
