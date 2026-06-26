package com.example.coffee.entity;

public class CartItem {
    private Integer productId;
    private String name;
    private Double price;
    private String icon;
    private Integer quantity;
    private String spec;      // 规格（杯型/糖度/冷热/加料）
    private String remark;    // 备注
    private String imageUrl;  // 图片（可选）

    public CartItem() {}

    public CartItem(Integer productId, String name, Double price, String icon, Integer quantity, String spec, String remark) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.icon = icon;
        this.quantity = quantity;
        this.spec = spec;
        this.remark = remark;
    }

    // ---- getter / setter 全部生成 ----
    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
    public String getSpec() { return spec; }
    public void setSpec(String spec) { this.spec = spec; }
    public String getRemark() { return remark; }
    public void setRemark(String remark) { this.remark = remark; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Double getSubtotal() {
        return (price == null ? 0 : price) * (quantity == null ? 0 : quantity);
    }
}