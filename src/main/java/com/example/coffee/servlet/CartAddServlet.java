package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;
import com.example.coffee.entity.User;
import com.example.coffee.entity.Product;
import com.example.coffee.dao.CartDao;
import com.example.coffee.dao.ProductDao;
import com.example.coffee.impl.CartDaoImpl;
import com.example.coffee.impl.ProductDaoImpl;
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

@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {
    private CartDao cartDao = new CartDaoImpl();
    private ProductDao productDao = new ProductDaoImpl();

    // ========== 支持 GET 请求 ==========
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 直接调用 doPost 处理
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int coffeeId = parseInt(request.getParameter("coffeeId"), 0);
        String spec = request.getParameter("spec");
        if (spec == null) spec = "";
        String remark = request.getParameter("remark");
        if (remark == null) remark = "";

        // 判断是否是 AJAX 请求
        String requestedWith = request.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(requestedWith);

        // 参数校验
        if (coffeeId <= 0) {
            if (isAjax) {
                response.setContentType("application/json;charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.write("{\"success\":false,\"message\":\"无效商品\"}");
                out.flush();
                return;
            }
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // 先从数据库查询商品信息
        Product product = productDao.selectProductById(coffeeId);
        CartItem cartItem = null;

        if (product != null && product.getStatus() != null && product.getStatus() == 1) {
            // 数据库中有该商品
            cartItem = new CartItem(
                    coffeeId,
                    product.getName(),
                    product.getPrice(),
                    "☕",  // 默认图标
                    1,
                    spec,
                    remark
            );
        } else {
            // 数据库中没找到，尝试从 Catalog 获取（兼容旧数据）
            cartItem = Catalog.get(coffeeId);
            if (cartItem == null) {
                if (isAjax) {
                    response.setContentType("application/json;charset=UTF-8");
                    PrintWriter out = response.getWriter();
                    out.write("{\"success\":false,\"message\":\"商品不存在\"}");
                    out.flush();
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
        }

        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // 查找是否已存在相同商品+相同规格的项
        boolean found = false;
        for (CartItem item : cart) {
            if (item.getProductId().equals(coffeeId)) {
                String itemSpec = item.getSpec() != null ? item.getSpec() : "";
                if (itemSpec.equals(spec)) {
                    item.setQuantity(item.getQuantity() + 1);
                    found = true;
                    break;
                }
            }
        }

        if (!found) {
            cart.add(cartItem);
        }

        // 同步到数据库（如果用户已登录）
        User user = (User) session.getAttribute("loginUser");
        if (user != null) {
            List<CartItem> dbCart = cartDao.selectUserCart(user.getId());
            boolean inDb = false;
            for (CartItem item : dbCart) {
                if (item.getProductId().equals(coffeeId)) {
                    String itemSpec = item.getSpec() != null ? item.getSpec() : "";
                    if (itemSpec.equals(spec)) {
                        cartDao.updateCartItemQuantity(user.getId(), coffeeId, item.getQuantity() + 1);
                        inDb = true;
                        break;
                    }
                }
            }
            if (!inDb) {
                cartDao.saveCartItem(user.getId(), coffeeId, 1, spec, remark);
            }
        }

        // AJAX 请求返回 JSON
        if (isAjax) {
            response.setContentType("application/json;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.write("{\"success\":true,\"message\":\"已加入购物车\",\"cartSize\":" + cart.size() + "}");
            out.flush();
            return;
        }

        // 非 AJAX 请求重定向（兼容旧版）
        response.sendRedirect(request.getContextPath() + "/index.jsp?msg=success");
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}