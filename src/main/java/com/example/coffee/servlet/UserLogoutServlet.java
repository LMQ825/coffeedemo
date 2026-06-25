package com.example.coffee.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 用户退出登录Servlet
 * 清除session并跳转到登录页面
 */
@WebServlet("/UserLogoutServlet")
public class UserLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            // 清除用户登录信息
            session.removeAttribute("loginUser");
            // 可选:清除购物车
            session.removeAttribute("cart");
            // 销毁session
            session.invalidate();
        }
        // 跳转到登录页面
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
