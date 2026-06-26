package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;
import com.example.coffee.entity.User;
import com.example.coffee.dao.CartDao;
import com.example.coffee.impl.CartDaoImpl;
import com.example.coffee.util.Catalog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

/**
 * 加入购物车：支持 AJAX 请求，不跳转页面。
 * 参数：coffeeId - 商品ID，from - 来源页面（可选）
 */
@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {
    private CartDao cartDao = new CartDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int coffeeId = parseInt(request.getParameter("coffeeId"), 0);
        String from = request.getParameter("from");

        if (coffeeId <= 0) {
            response.sendRedirect(request.getContextPath() + "/coffeeList.jsp");
            return;
        }

        CartItem product = Catalog.get(coffeeId);
        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/coffeeList.jsp");
            return;
        }

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // 检查是否已存在该商品
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId().equals(coffeeId)) {
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                // 同步到数据库
                User user = (User) session.getAttribute("loginUser");
                if (user != null) {
                    cartDao.saveCartItem(user.getId(), coffeeId, item.getQuantity());
                }
                break;
            }
        }

        if (!found) {
            CartItem newItem = new CartItem(coffeeId, product.getName(), product.getPrice(), product.getIcon(), 1, "");
            cart.add(newItem);
            // 同步到数据库
            User user = (User) session.getAttribute("loginUser");
            if (user != null) {
                cartDao.saveCartItem(user.getId(), coffeeId, 1);
            }
        }

        // 检查是否是 AJAX 请求
        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            // AJAX 请求，返回 JSON
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write("{\"success\":true,\"message\":\"已加入购物车\",\"cartSize\":" + cart.size() + "}");
            out.flush();
        } else {
            // 普通请求，跳转到来源页面或点单页
            if ("index".equals(from)) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?page=order");
            } else {
                response.sendRedirect(request.getContextPath() + "/coffeeList.jsp");
            }
        }
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
