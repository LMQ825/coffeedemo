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
 * 更新库存Servlet
 */
@WebServlet("/admin/InventoryUpdateServlet")
public class InventoryUpdateServlet extends HttpServlet {
    private InventoryService inventoryService = new InventoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 根据ID查询库存信息，转发到编辑页面
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Inventory inventory = inventoryService.getInventoryById(id);
            request.setAttribute("inventory", inventory);
        }
        request.getRequestDispatcher("/admin/inventoryEdit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        Inventory inventory = new Inventory();
        String idStr = request.getParameter("id");
        inventory.setId(idStr != null && !idStr.isEmpty() ? Integer.parseInt(idStr) : 0);
        inventory.setName(request.getParameter("name"));
        inventory.setCategory(request.getParameter("category"));
        inventory.setUnit(request.getParameter("unit"));
        inventory.setSupplier(request.getParameter("supplier"));
        inventory.setDescription(request.getParameter("description"));

        String quantityStr = request.getParameter("quantity");
        String minQuantityStr = request.getParameter("minQuantity");
        inventory.setQuantity(quantityStr != null && !quantityStr.isEmpty() ? Double.parseDouble(quantityStr) : 0);
        inventory.setMinQuantity(minQuantityStr != null && !minQuantityStr.isEmpty() ? Double.parseDouble(minQuantityStr) : 10);

        int result = inventoryService.updateInventory(inventory);
        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/InventoryListServlet?msg=update_success");
        } else {
            request.setAttribute("error", "更新库存失败，请重试");
            request.setAttribute("inventory", inventory);
            request.getRequestDispatcher("/admin/inventoryEdit.jsp").forward(request, response);
        }
    }
}
