package com.example.coffee.entity;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * 饮品原料库存实体类
 */
public class Inventory {
    private int id;
    private String name;        // 原料名称
    private String category;    // 分类（咖啡豆/乳制品/糖浆/茶叶/水果/辅料等）
    private double quantity;    // 当前库存量
    private String unit;        // 单位（kg/L/个/包/袋等）
    private double minQuantity; // 预警阈值
    private String supplier;    // 默认供应商
    private String description; // 备注说明
    private String createTime;  // 创建时间
    private String updateTime;  // 更新时间

    public Inventory() {}

    /**
     * 判断库存是否低于预警阈值
     */
    public boolean isLowStock() {
        return quantity <= minQuantity;
    }

    /**
     * 获取库存状态：0=正常, 1=预警(低于阈值), 2=危险(为0)
     */
    public int getStockStatus() {
        if (quantity <= 0) return 2;
        if (quantity <= minQuantity) return 1;
        return 0;
    }

    public String getStockStatusText() {
        int status = getStockStatus();
        if (status == 2) return "缺货";
        if (status == 1) return "预警";
        return "正常";
    }

    // ---- getter / setter ----
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public double getMinQuantity() { return minQuantity; }
    public void setMinQuantity(double minQuantity) { this.minQuantity = minQuantity; }

    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getUpdateTime() { return updateTime; }
    public void setUpdateTime(String updateTime) { this.updateTime = updateTime; }
}
