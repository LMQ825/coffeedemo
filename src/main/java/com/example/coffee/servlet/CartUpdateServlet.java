package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;
import com.example.coffee.entity.User;
import com.example.coffee.dao.CartDao;
import com.example.coffee.impl.CartDaoImpl;

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
    private CartDao cartDao = new CartDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int index = parseInt(request.getParameter("index"));
        String op = request.getParameter("op");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null && index >= 0 && index < cart.size()) {
            CartItem item = cart.get(index);
            if ("inc".equals(op)) {
                item.setQuantity(item.getQuantity() + 1);
                // 同步到数据库
                if (user != null) {
                    cartDao.updateCartItemQuantity(user.getId(), item.getProductId(), item.getQuantity());
                }
            } else if ("dec".equals(op)) {
                item.setQuantity(item.getQuantity() - 1);
                if (item.getQuantity() <= 0) {
                    cart.remove(index);
                    // 同步到数据库
                    if (user != null) {
                        cartDao.deleteCartItem(user.getId(), item.getProductId());
                    }
                } else {
                    // 同步到数据库
                    if (user != null) {
                        cartDao.updateCartItemQuantity(user.getId(), item.getProductId(), item.getQuantity());
                    }
                }
            } else if ("del".equals(op)) {
                int productId = item.getProductId();
                cart.remove(index);
                // 同步到数据库
                if (user != null) {
                    cartDao.deleteCartItem(user.getId(), productId);
                }
            }
        }
        
        // 根据来源页面决定跳转位置
        String page = request.getParameter("page");
        if ("cart".equals(page)) {
            // 从 index.jsp 的购物车页面来的，返回 index.jsp?page=cart
            response.sendRedirect(request.getContextPath() + "/index.jsp?page=cart");
        } else {
            // 默认跳转到独立的 cart.jsp
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        }
    }

    private int parseInt(String s) {
        try { return Integer.parseInt(s); } catch (Exception e) { return -1; }
    }
}
