package com.example.coffee.servlet;

import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.service.OrderService;
import com.example.coffee.impl.OrderServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 订单详情接口：返回订单详情的JSON数据，供前端弹窗展示。
 */
@WebServlet("/OrderDetailServlet")
public class OrderDetailServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        int orderId = parseInt(request.getParameter("id"), 0);
        PrintWriter out = response.getWriter();

        if (orderId <= 0) {
            out.print("{\"error\":\"缺少订单ID\"}");
            return;
        }

        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            out.print("{\"error\":\"订单不存在\"}");
            return;
        }

        // 加载订单明细
        order.setItems(orderService.getOrderItems(orderId));

        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"id\":").append(order.getId()).append(",");
        json.append("\"orderNo\":\"").append(order.getOrderNo() != null ? order.getOrderNo() : "").append("\",");
        json.append("\"status\":").append(order.getStatus()).append(",");
        json.append("\"statusText\":\"").append(order.getStatusText()).append("\",");
        json.append("\"totalPrice\":").append(order.getTotalPrice()).append(",");
        json.append("\"remark\":\"").append(order.getRemark() != null ? order.getRemark().replace("\"", "\\\"") : "").append("\",");

        // 订单时间
        json.append("\"createTime\":\"").append(order.getCreateTime() != null ? order.getCreateTime().toString() : "").append("\",");
        json.append("\"payTime\":\"").append(order.getPayTime() != null ? order.getPayTime().toString() : "").append("\",");

        // 订单明细
        json.append("\"items\":[");
        if (order.getItems() != null) {
            for (int i = 0; i < order.getItems().size(); i++) {
                OrderItem item = order.getItems().get(i);
                if (i > 0) json.append(",");
                json.append("{");
                json.append("\"productName\":\"").append(item.getProductName() != null ? item.getProductName().replace("\"", "\\\"") : "").append("\",");
                json.append("\"quantity\":").append(item.getQuantity()).append(",");
                json.append("\"price\":").append(item.getPrice());
                json.append("}");
            }
        }
        json.append("]");
        json.append("}");

        out.print(json.toString());
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
