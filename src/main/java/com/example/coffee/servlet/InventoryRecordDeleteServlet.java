package com.example.coffee.servlet;

import com.example.coffee.service.InventoryService;
import com.example.coffee.impl.InventoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 删除进货记录Servlet
 */
@WebServlet("/admin/InventoryRecordDeleteServlet")
public class InventoryRecordDeleteServlet extends HttpServlet {
    private InventoryService inventoryService = new InventoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            inventoryService.deleteRecord(id);
        }
        response.sendRedirect(request.getContextPath() + "/admin/InventoryRecordListServlet?msg=delete_success");
    }
}
