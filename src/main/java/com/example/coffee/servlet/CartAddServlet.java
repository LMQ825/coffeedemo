package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;
import com.example.coffee.util.Catalog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 加入购物车：根据 coffeeId 从 Catalog 查商品，写入 session 购物车后跳转购物车页面。
 */
@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = parseInt(request.getParameter("coffeeId"), 0);
        CartItem proto = Catalog.get(id);
        if (proto == null) {
            response.sendRedirect(request.getContextPath() + "/coffeeList.jsp");
            return;
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // 同款商品则数量累加
        boolean exist = false;
        for (CartItem item : cart) {
            if (item.getProductId() != null && item.getProductId() == id) {
                item.setQuantity(item.getQuantity() + 1);
                exist = true;
                break;
            }
        }
        if (!exist) {
            cart.add(new CartItem(id, proto.getName(), proto.getPrice(), proto.getIcon(), 1, ""));
        }

        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
