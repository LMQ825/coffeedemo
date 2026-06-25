package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * 修改购物车：增/减数量、删除。参数：index, op=inc|dec|del
 */
@WebServlet("/CartUpdateServlet")
public class CartUpdateServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int index = parseInt(request.getParameter("index"));
        String op = request.getParameter("op");

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null && index >= 0 && index < cart.size()) {
            CartItem item = cart.get(index);
            if ("inc".equals(op)) {
                item.setQuantity(item.getQuantity() + 1);
            } else if ("dec".equals(op)) {
                item.setQuantity(item.getQuantity() - 1);
                if (item.getQuantity() <= 0) {
                    cart.remove(index);
                }
            } else if ("del".equals(op)) {
                cart.remove(index);
            }
        }
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }

    private int parseInt(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return -1; }
    }
}
