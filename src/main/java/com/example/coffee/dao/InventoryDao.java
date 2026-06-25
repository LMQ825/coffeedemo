package com.example.coffee.dao;

import com.example.coffee.entity.Inventory;
import java.util.List;

/**
 * 库存DAO接口
 */
public interface InventoryDao {
    /** 分页+搜索查询 */
    List<Inventory> selectInventoryList(String keyword, String category, int start, int pageSize);

    /** 查询总数 */
    int selectInventoryCount(String keyword, String category);

    /** 根据ID查询 */
    Inventory selectInventoryById(int id);

    /** 新增库存 */
    int insertInventory(Inventory inventory);

    /** 更新库存 */
    int updateInventory(Inventory inventory);

    /** 删除库存 */
    int deleteInventory(int id);

    /** 查询所有库存项（用于下拉选择等） */
    List<Inventory> selectAllInventory();

    /** 查询低于预警阈值的库存项 */
    List<Inventory> selectLowStockItems();

    /** 更新库存数量（进货时调用） */
    int updateQuantity(int id, double quantity);
}
