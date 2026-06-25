package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;
import com.example.coffee.entity.Order;
import com.example.coffee.entity.OrderItem;
import com.example.coffee.entity.User;
import com.example.coffee.service.OrderService;
import com.example.coffee.impl.OrderServiceImpl;
import com.example.coffee.util.Catalog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 提交订单：支持立即购买(mode=buynow)和购物车结算(mode=cart)。
 * 订单创建后进入支付选择页 payment.jsp。
 */
@WebServlet("/OrderSubmitServlet")
public class OrderSubmitServlet extends HttpServlet {
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String mode = request.getParameter("mode");
        String address = request.getParameter("address");
        if (address == null || address.trim().isEmpty()) {
            address = user.getAddress() == null ? "" : user.getAddress();
        }
        String note = request.getParameter("remark");
        if (note == null) note = "";

        Order order = new Order();
        order.setOrderNo(new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()));
        order.setUserId(user.getId());
        order.setStatus(0); // 待付款
        List<OrderItem> items = new ArrayList<>();

        if ("buynow".equals(mode)) {
            int cid = parseInt(request.getParameter("cid"), 0);
            CartItem bi = Catalog.get(cid);
            if (bi == null) {
                response.sendRedirect(request.getContextPath() + "/coffeeList.jsp");
                return;
            }
            int qty = parseInt(request.getParameter("qty"), 1);
            String cup = request.getParameter("cup");
            String sugar = request.getParameter("sugar");
            String temp = request.getParameter("temp");
            String topping = request.getParameter("topping");

            double cupUp = "大杯".equals(cup) ? 3 : 0;
            double topUp = "珍珠".equals(topping) ? 3 : ("椰果".equals(topping) ? 3 : ("奶盖".equals(topping) ? 5 : 0));
            double unitPrice = bi.getPrice() + cupUp + topUp;
            double total = unitPrice * qty;

            String spec = cup + "/" + sugar + "/" + temp + "/" + topping;
            StringBuilder remark = new StringBuilder();
            remark.append(bi.getName()).append(" ×").append(qty).append(" [").append(spec).append("] | 送:").append(address);
            if (!note.trim().isEmpty()) remark.append(" 备注:").append(note);

            order.setTotalPrice(total);
            order.setRemark(remark.toString());

            OrderItem oi = new OrderItem();
            oi.setProductId(cid);
            oi.setQuantity(qty);
            oi.setPrice(unitPrice);
            items.add(oi);
        } else {
            // 购物车结算
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null || cart.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart.jsp");
                return;
            }
            double total = 0;
            StringBuilder summary = new StringBuilder();
            for (int i = 0; i < cart.size(); i++) {
                CartItem ci = cart.get(i);
                total += ci.getSubtotal();
                if (i > 0) summary.append(", ");
                summary.append(ci.getName()).append(" ×").append(ci.getQuantity());

                OrderItem oi = new OrderItem();
                oi.setProductId(ci.getProductId());
                oi.setQuantity(ci.getQuantity());
                oi.setPrice(ci.getPrice());
                items.add(oi);
            }
            StringBuilder remark = new StringBuilder();
            remark.append(summary).append(" | 送:").append(address);
            if (!note.trim().isEmpty()) remark.append(" 备注:").append(note);

            order.setTotalPrice(total);
            order.setRemark(remark.toString());

            session.removeAttribute("cart");
        }

        int orderId = orderService.createOrder(order, items);
        if (orderId > 0) {
            response.sendRedirect(request.getContextPath() + "/payment.jsp?orderId=" + orderId);
        } else {
            request.setAttribute("msg", "订单创建失败，请重试");
            request.getRequestDispatcher("coffeeList.jsp").forward(request, response);
        }
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
