package com.example.coffee.servlet;

import com.example.coffee.service.OrderService;
import com.example.coffee.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 支付：用户在 payment.jsp 选择微信/支付宝后提交到此。
 * 将订单状态置为待取餐(1)并记录支付时间，随后回到我的订单。
 */
@WebServlet("/PayServlet")
public class PayServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int orderId = parseInt(request.getParameter("orderId"));
        String payMethod = request.getParameter("payMethod");
        if (orderId > 0) {
            orderService.payOrder(orderId);
        }
        
        // 检查是否是 AJAX 请求
        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            // AJAX 请求，返回 JSON
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"success\":true,\"payMethod\":\"" + (payMethod == null ? "" : payMethod) + "\"}");
        } else {
            // 普通请求，跳转我的订单并提示
            response.sendRedirect(request.getContextPath() + "/myOrder.jsp?msg=paySuccess&method=" + (payMethod == null ? "" : payMethod));
        }
    }

    private int parseInt(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return 0; }
    }
}
