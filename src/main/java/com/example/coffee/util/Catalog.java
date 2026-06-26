package com.example.coffee.util;

import com.example.coffee.entity.CartItem;

import java.util.LinkedHashMap;
import java.util.Map;

public class Catalog {
    private static final Map<Integer, CartItem> ITEMS = new LinkedHashMap<>();
    static {
        // 依次为：id, name, price, icon, quantity, spec, remark
        ITEMS.put(1, new CartItem(1, "经典拿铁", 22.0, "☕", 1, "", ""));
        ITEMS.put(2, new CartItem(2, "焦糖玛奇朵", 24.0, "🥤", 1, "", ""));
        ITEMS.put(3, new CartItem(3, "提拉米苏", 18.0, "🍰", 1, "", ""));
        ITEMS.put(4, new CartItem(4, "荔枝气泡美式", 26.0, "🫧", 1, "", ""));
        ITEMS.put(5, new CartItem(5, "原味美式", 18.0, "🟤", 1, "", ""));
        ITEMS.put(6, new CartItem(6, "原味冷萃", 25.0, "🧊", 1, "", ""));
        ITEMS.put(7, new CartItem(7, "柠檬美式", 23.0, "💧", 1, "", ""));
        ITEMS.put(8, new CartItem(8, "薄荷冷萃", 27.0, "🌿", 1, "", ""));
    }

    public static CartItem get(int id) {
        return ITEMS.get(id);
    }
}