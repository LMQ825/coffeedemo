package com.example.coffee.servlet;

import com.example.coffee.entity.CartItem;
import com.example.coffee.entity.Product;
import com.example.coffee.entity.User;
import com.example.coffee.service.ProductService;
import com.example.coffee.impl.ProductServiceImpl;
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
import java.util.ArrayList;
import java.util.List;

/**
 * 加入购物车：根据 productId 从数据库查商品，写入 session 购物车后跳转购物车页面。
 */
@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    private CartDao cartDao = new CartDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int id = parseInt(request.getParameter("coffeeId"), 0);
        
        // 先从数据库获取商品信息
        Product product = productService.getProductById(id);
        if (product == null) {
            // 如果数据库没有，尝试从 Catalog 获取（兼容旧代码）
            CartItem proto = Catalog.get(id);
            if (proto == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp?type=意式咖啡");
                return;
            }
            // 从 Catalog 创建商品
            addToCartByCatalog(request, response, id, proto);
            return;
        }
        
        // 从数据库商品创建购物车项
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
        // 根据商品类别设置图标
        String icon = getIconByCategory(product.getCategory());
        
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
            cart.add(new CartItem(id, product.getName(), product.getPrice(), icon, 1, ""));
        }
        
        // 同步到数据库（如果用户已登录）
        if (user != null) {
            if (exist) {
                // 更新数量 - 获取已存在的商品
                CartItem existItem = null;
                for (CartItem item : cart) {
                    if (item.getProductId() != null && item.getProductId() == id) {
                        existItem = item;
                        break;
                    }
                }
                if (existItem != null) {
                    cartDao.updateCartItemQuantity(user.getId(), id, existItem.getQuantity());
                }
            } else {
                // 新增
                cartDao.saveCartItem(user.getId(), id, 1);
            }
        }
        
        // 根据来源页面决定跳转位置
        String from = request.getParameter("from");
        if ("index".equals(from)) {
            // 从 index.jsp 来的，返回 index.jsp 的购物车页面
            response.sendRedirect(request.getContextPath() + "/index.jsp?page=cart");
        } else {
            // 默认跳转到独立的 cart.jsp
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        }
    }
    
    /**
     * 从 Catalog 添加到购物车（兼容旧代码）
     */
    private void addToCartByCatalog(HttpServletRequest request, HttpServletResponse response, int id, CartItem proto) throws IOException {
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        
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
        
        String from = request.getParameter("from");
        if ("index".equals(from)) {
            response.sendRedirect(request.getContextPath() + "/index.jsp?page=cart");
        } else {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
        }
    }
    
    /**
     * 根据商品类别设置图标
     */
    private String getIconByCategory(String category) {
        if (category == null) return "☕";
        if (category.contains("咖啡")) return "☕";
        if (category.contains("冷萃")) return "🧊";
        if (category.contains("美式")) return "🟤";
        if (category.contains("甜品") || category.contains("小食")) return "🍰";
        if (category.contains("特调")) return "🥤";
        return "☕";
    }

    private int parseInt(String s, int def) {
        try { return Integer.parseInt(s); } catch (Exception e) { return def; }
    }
}
