package com.example.coffee.util;

import com.example.coffee.entity.CartItem;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 点单界面的商品目录（与 index.jsp 中的 cid 一一对应）。
 * 购物车 / 立即购买 通过 cid 在此查商品基础信息，避免依赖数据库 product 表的 ID。
 */
public class Catalog {
    private static final Map<Integer, CartItem> ITEMS = new LinkedHashMap<>();
    static {
        ITEMS.put(1, new CartItem(1, "经典拿铁", 22.0, "☕", 1, ""));
        ITEMS.put(2, new CartItem(2, "焦糖玛奇朵", 24.0, "🥤", 1, ""));
        ITEMS.put(3, new CartItem(3, "提拉米苏", 18.0, "🍰", 1, ""));
        ITEMS.put(4, new CartItem(4, "荔枝气泡美式", 26.0, "🫧", 1, ""));
        ITEMS.put(5, new CartItem(5, "原味美式", 18.0, "🟤", 1, ""));
        ITEMS.put(6, new CartItem(6, "原味冷萃", 25.0, "🧊", 1, ""));
        ITEMS.put(7, new CartItem(7, "柠檬美式", 23.0, "💧", 1, ""));
        ITEMS.put(8, new CartItem(8, "薄荷冷萃", 27.0, "🌿", 1, ""));
    }

    public static CartItem get(int id) {
        return ITEMS.get(id);
    }
}
