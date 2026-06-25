package com.example.coffee.servlet;

import com.example.coffee.entity.Inventory;
import com.example.coffee.entity.InventoryRecord;
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
 * 进货记录列表Servlet
 */
@WebServlet("/admin/InventoryRecordListServlet")
public class InventoryRecordListServlet extends HttpServlet {
    private InventoryService inventoryService = new InventoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }
        int pageSize = 10;

        PageBean<InventoryRecord> pageBean = inventoryService.listRecords(keyword, startDate, endDate, currentPage, pageSize);
        request.setAttribute("pageBean", pageBean);
        request.setAttribute("keyword", keyword);
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        request.getRequestDispatcher("/admin/inventoryRecordList.jsp").forward(request, response);
    }
}
