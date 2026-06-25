package com.example.coffee.servlet;

import com.example.coffee.entity.Inventory;
import com.example.coffee.service.InventoryService;
import com.example.coffee.impl.InventoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 新增库存Servlet
 */
@WebServlet("/admin/InventoryAddServlet")
public class InventoryAddServlet extends HttpServlet {
    private InventoryService inventoryService = new InventoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 转发到新增页面
        request.getRequestDispatcher("/admin/inventoryAdd.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Inventory inventory = new Inventory();
        inventory.setName(request.getParameter("name"));
        inventory.setCategory(request.getParameter("category"));
        inventory.setUnit(request.getParameter("unit"));
        inventory.setSupplier(request.getParameter("supplier"));
        inventory.setDescription(request.getParameter("description"));

        // 解析数值参数
        String quantityStr = request.getParameter("quantity");
        String minQuantityStr = request.getParameter("minQuantity");
        inventory.setQuantity(quantityStr != null && !quantityStr.isEmpty() ? Double.parseDouble(quantityStr) : 0);
        inventory.setMinQuantity(minQuantityStr != null && !minQuantityStr.isEmpty() ? Double.parseDouble(minQuantityStr) : 10);

        int result = inventoryService.addInventory(inventory);
        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/InventoryListServlet?msg=add_success");
        } else {
            request.setAttribute("error", "新增库存失败，请重试");
            request.getRequestDispatcher("/admin/inventoryAdd.jsp").forward(request, response);
        }
    }
}
