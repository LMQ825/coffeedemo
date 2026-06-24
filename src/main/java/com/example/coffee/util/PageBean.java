package com.example.coffee.util;

import java.util.List;

public class PageBean<T> {
    private int currentPage;   // 当前页码
    private int pageSize;      // 每页条数
    private int totalCount;    // 总记录数
    private int totalPage;     // 总页数
    private List<T> list;      // 当前页数据

    public PageBean() {}

    public PageBean(int currentPage, int pageSize, int totalCount, List<T> list) {
        this.currentPage = currentPage;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.list = list;
        this.totalPage = (totalCount + pageSize - 1) / pageSize;
    }

    // ---- getter / setter ----
    public int getCurrentPage() { return currentPage; }
    public void setCurrentPage(int currentPage) { this.currentPage = currentPage; }
    public int getPageSize() { return pageSize; }
    public void setPageSize(int pageSize) { this.pageSize = pageSize; }
    public int getTotalCount() { return totalCount; }
    public void setTotalCount(int totalCount) { this.totalCount = totalCount; }
    public int getTotalPage() { return totalPage; }
    public void setTotalPage(int totalPage) { this.totalPage = totalPage; }
    public List<T> getList() { return list; }
    public void setList(List<T> list) { this.list = list; }

    // 是否首页
    public boolean isFirst() { return currentPage == 1; }
    // 是否末页
    public boolean isLast() { return currentPage == totalPage; }
    // 上一页
    public int getPrePage() { return currentPage > 1 ? currentPage - 1 : 1; }
    // 下一页
    public int getNextPage() { return currentPage < totalPage ? currentPage + 1 : totalPage; }
}