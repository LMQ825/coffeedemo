package com.example.coffee.service;

import com.example.coffee.entity.Inventory;
import com.example.coffee.entity.InventoryRecord;
import com.example.coffee.util.PageBean;

import java.util.List;

/**
 * 库存管理服务接口
 */
public interface InventoryService {
    /** 分页查询库存列表 */
    PageBean<Inventory> listInventory(String keyword, String category, int currentPage, int pageSize);

    /** 根据ID获取库存项 */
    Inventory getInventoryById(int id);

    /** 新增库存项 */
    int addInventory(Inventory inventory);

    /** 更新库存项 */
    int updateInventory(Inventory inventory);

    /** 删除库存项 */
    int deleteInventory(int id);

    /** 获取所有库存项（下拉选择用） */
    List<Inventory> getAllInventory();

    /** 获取低库存预警列表 */
    List<Inventory> getLowStockItems();

    /** 获取低库存数量 */
    int getLowStockCount();

    /** 进货操作：新增进货记录 + 更新库存数量 */
    int addStock(InventoryRecord record);

    /** 分页查询进货记录 */
    PageBean<InventoryRecord> listRecords(String keyword, String startDate, String endDate, int currentPage, int pageSize);

    /** 删除进货记录 */
    int deleteRecord(int id);
}
