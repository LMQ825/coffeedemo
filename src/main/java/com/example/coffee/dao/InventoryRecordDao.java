package com.example.coffee.dao;

import com.example.coffee.entity.InventoryRecord;
import java.util.List;

/**
 * 进货记录DAO接口
 */
public interface InventoryRecordDao {
    /** 分页+搜索查询（关联原料名称） */
    List<InventoryRecord> selectRecordList(String keyword, String startDate, String endDate, int start, int pageSize);

    /** 查询总数 */
    int selectRecordCount(String keyword, String startDate, String endDate);

    /** 根据ID查询 */
    InventoryRecord selectRecordById(int id);

    /** 新增进货记录 */
    int insertRecord(InventoryRecord record);

    /** 删除进货记录 */
    int deleteRecord(int id);

    /** 查询指定库存的进货记录 */
    List<InventoryRecord> selectRecordsByInventoryId(int inventoryId);
}
