package com.example.coffee.servlet;

import com.example.coffee.entity.Inventory;
import com.example.coffee.entity.InventoryRecord;
import com.example.coffee.service.InventoryService;
import com.example.coffee.impl.InventoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 新增进货记录Servlet（进货操作）
 */
@WebServlet("/admin/InventoryRecordAddServlet")
public class InventoryRecordAddServlet extends HttpServlet {
    private InventoryService inventoryService = new InventoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取所有库存项，用于下拉选择
        List<Inventory> allInventory = inventoryService.getAllInventory();
        request.setAttribute("allInventory", allInventory);
        request.getRequestDispatcher("/admin/inventoryRecordAdd.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        InventoryRecord record = new InventoryRecord();
        String inventoryIdStr = request.getParameter("inventoryId");
        record.setInventoryId(inventoryIdStr != null && !inventoryIdStr.isEmpty() ? Integer.parseInt(inventoryIdStr) : 0);

        String quantityStr = request.getParameter("quantity");
        record.setQuantity(quantityStr != null && !quantityStr.isEmpty() ? Double.parseDouble(quantityStr) : 0);
        record.setUnit(request.getParameter("unit"));
        record.setSupplier(request.getParameter("supplier"));

        String unitPriceStr = request.getParameter("unitPrice");
        double unitPrice = unitPriceStr != null && !unitPriceStr.isEmpty() ? Double.parseDouble(unitPriceStr) : 0;
        record.setUnitPrice(unitPrice);
        record.setTotalPrice(unitPrice * record.getQuantity());

        record.setRemark(request.getParameter("remark"));

        // 获取操作人（从session中获取管理员信息）
        HttpSession session = request.getSession();
        Object adminUser = session.getAttribute("adminUser");
        if (adminUser != null) {
            try {
                // 通过反射获取管理员昵称（兼容不同实体结构）
                java.lang.reflect.Method getNickname = adminUser.getClass().getMethod("getNickname");
                record.setOperator((String) getNickname.invoke(adminUser));
            } catch (Exception e) {
                record.setOperator("管理员");
            }
        } else {
            record.setOperator("管理员");
        }

        int result = inventoryService.addStock(record);
        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/InventoryRecordListServlet?msg=add_success");
        } else {
            request.setAttribute("error", "新增进货记录失败，请重试");
            List<Inventory> allInventory = inventoryService.getAllInventory();
            request.setAttribute("allInventory", allInventory);
            request.getRequestDispatcher("/admin/inventoryRecordAdd.jsp").forward(request, response);
        }
    }
}
