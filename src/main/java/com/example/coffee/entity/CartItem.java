package com.example.coffee.entity;

/**
 * 购物车 / 立即购买 使用的会话级商品项（不落库）
 */
public class CartItem {
    private Integer productId;
    private String name;
    private Double price;   // 单价（不含规格加价）
    private String icon;    // 展示用 emoji
    private Integer quantity;
    private String spec;    // 规格描述（购物车一般为空，立即购买时由下单页选择）

    public CartItem() {}

    public CartItem(Integer productId, String name, Double price, String icon, Integer quantity, String spec) {
        this.productId = productId;
        this.name = name;
        this.price = price;
        this.icon = icon;
        this.quantity = quantity;
        this.spec = spec;
    }

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

    public Double getSubtotal() {
        return (price == null ? 0 : price) * (quantity == null ? 0 : quantity);
    }
}
