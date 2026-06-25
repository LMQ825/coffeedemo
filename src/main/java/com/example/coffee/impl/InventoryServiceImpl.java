package com.example.coffee.impl;

import com.example.coffee.dao.InventoryDao;
import com.example.coffee.dao.InventoryRecordDao;
import com.example.coffee.entity.Inventory;
import com.example.coffee.entity.InventoryRecord;
import com.example.coffee.service.InventoryService;
import com.example.coffee.util.PageBean;

import java.util.List;

/**
 * 库存管理服务实现类
 */
public class InventoryServiceImpl implements InventoryService {
    private InventoryDao inventoryDao = new InventoryDaoImpl();
    private InventoryRecordDao recordDao = new InventoryRecordDaoImpl();

    @Override
    public PageBean<Inventory> listInventory(String keyword, String category, int currentPage, int pageSize) {
        int start = (currentPage - 1) * pageSize;
        List<Inventory> list = inventoryDao.selectInventoryList(keyword, category, start, pageSize);
        int totalCount = inventoryDao.selectInventoryCount(keyword, category);
        return new PageBean<>(currentPage, pageSize, totalCount, list);
    }

    @Override
    public Inventory getInventoryById(int id) {
        return inventoryDao.selectInventoryById(id);
    }

    @Override
    public int addInventory(Inventory inventory) {
        return inventoryDao.insertInventory(inventory);
    }

    @Override
    public int updateInventory(Inventory inventory) {
        return inventoryDao.updateInventory(inventory);
    }

    @Override
    public int deleteInventory(int id) {
        return inventoryDao.deleteInventory(id);
    }

    @Override
    public List<Inventory> getAllInventory() {
        return inventoryDao.selectAllInventory();
    }

    @Override
    public List<Inventory> getLowStockItems() {
        return inventoryDao.selectLowStockItems();
    }

    @Override
    public int getLowStockCount() {
        return inventoryDao.selectLowStockItems().size();
    }

    @Override
    public int addStock(InventoryRecord record) {
        // 1. 新增进货记录
        int result = recordDao.insertRecord(record);
        if (result > 0) {
            // 2. 更新库存数量（当前库存 + 进货数量）
            Inventory inv = inventoryDao.selectInventoryById(record.getInventoryId());
            if (inv != null) {
                double newQuantity = inv.getQuantity() + record.getQuantity();
                inventoryDao.updateQuantity(record.getInventoryId(), newQuantity);
            }
        }
        return result;
    }

    @Override
    public PageBean<InventoryRecord> listRecords(String keyword, String startDate, String endDate, int currentPage, int pageSize) {
        int start = (currentPage - 1) * pageSize;
        List<InventoryRecord> list = recordDao.selectRecordList(keyword, startDate, endDate, start, pageSize);
        int totalCount = recordDao.selectRecordCount(keyword, startDate, endDate);
        return new PageBean<>(currentPage, pageSize, totalCount, list);
    }

    @Override
    public int deleteRecord(int id) {
        return recordDao.deleteRecord(id);
    }
}
