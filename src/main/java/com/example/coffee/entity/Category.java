package com.example.coffee.entity;

public class Category {
    private Integer id;
    private String name;
    private String description;
    private Integer sortOrder;  // 排序顺序，数字越小越靠前
    private Integer status;     // 1启用 0禁用
    
    public Category() {}
    
    public Category(Integer id, String name, String description, Integer sortOrder, Integer status) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.sortOrder = sortOrder;
        this.status = status;
    }
    
    // getter and setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public Integer getSortOrder() { return sortOrder; }
    public void setSortOrder(Integer sortOrder) { this.sortOrder = sortOrder; }
    public Integer getStatus() { return status; }
    public void setStatus(Integer status) { this.status = status; }
    
    @Override
    public String toString() {
        return "Category{id=" + id + ", name='" + name + "', sortOrder=" + sortOrder + ", status=" + status + "}";
    }
}