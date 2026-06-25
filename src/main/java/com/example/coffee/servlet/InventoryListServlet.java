package com.example.coffee.servlet;

import com.example.coffee.entity.Inventory;
import com.example.coffee.service.InventoryService;
import com.example.coffee.impl.InventoryServiceImpl;
import com.example.coffee.util.PageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 库存列表Servlet
 */
@WebServlet("/admin/InventoryListServlet")
public class InventoryListServlet extends HttpServlet {
    private InventoryService inventoryService = new InventoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }
        int pageSize = 10;

        // 查询库存列表
        PageBean<Inventory> pageBean = inventoryService.listInventory(keyword, category, currentPage, pageSize);
        request.setAttribute("pageBean", pageBean);
        request.setAttribute("keyword", keyword);
        request.setAttribute("category", category);

        // 查询低库存预警
        List<Inventory> lowStockItems = inventoryService.getLowStockItems();
        request.setAttribute("lowStockItems", lowStockItems);
        request.setAttribute("lowStockCount", lowStockItems.size());

        // 获取所有分类（用于筛选下拉）
        List<Inventory> allItems = inventoryService.getAllInventory();
        java.util.Set<String> categories = new java.util.LinkedHashSet<>();
        for (Inventory inv : allItems) {
            if (inv.getCategory() != null && !inv.getCategory().isEmpty()) {
                categories.add(inv.getCategory());
            }
        }
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/admin/inventoryList.jsp").forward(request, response);
    }
}
