package com.example.coffee.servlet;

import com.example.coffee.entity.Order;
import com.example.coffee.service.OrderService;
import com.example.coffee.impl.OrderServiceImpl;
import com.example.coffee.util.PageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/OrderListServlet")
public class OrderListServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String statusStr = request.getParameter("status");
        String pageStr = request.getParameter("page");

        Integer status = null;
        if (statusStr != null && !statusStr.isEmpty()) {
            status = Integer.parseInt(statusStr);
        }
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }
        int pageSize = 10;

        PageBean<Order> pageBean = orderService.listOrders(status, currentPage, pageSize);
        request.setAttribute("pageBean", pageBean);
        request.setAttribute("statusFilter", status);
        request.getRequestDispatcher("/admin/orderList.jsp").forward(request, response);
    }
}