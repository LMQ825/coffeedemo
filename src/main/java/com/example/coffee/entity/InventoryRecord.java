package com.example.coffee.entity;

/**
 * 进货记录实体类
 */
public class InventoryRecord {
    private int id;
    private int inventoryId;    // 关联库存ID
    private double quantity;    // 进货数量
    private String unit;        // 单位
    private String supplier;    // 供应商
    private double unitPrice;   // 单价
    private double totalPrice;  // 总价
    private String operator;    // 操作人
    private String remark;      // 备注
    private String createTime;  // 进货时间

    // 关联查询时使用的原料名称
    private String inventoryName;

    public InventoryRecord() {}

    // ---- getter / setter ----
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getInventoryId() { return inventoryId; }
    public void setInventoryId(int inventoryId) { this.inventoryId = inventoryId; }

    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public String getSupplier() { return supplier; }
    public void setSupplier(String supplier) { this.supplier = supplier; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getOperator() { return operator; }
    public void setOperator(String operator) { this.operator = operator; }

    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }

    public String getCreateTime() { return createTime; }
    public void setCreateTime(String createTime) { this.createTime = createTime; }

    public String getInventoryName() { return inventoryName; }
    public void setInventoryName(String inventoryName) { this.inventoryName = inventoryName; }
}
