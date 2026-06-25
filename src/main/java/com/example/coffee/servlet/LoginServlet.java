package com.example.coffee.servlet;

import com.example.coffee.entity.Admin;
import com.example.coffee.entity.User;
import com.example.coffee.impl.AdminServiceImpl;
import com.example.coffee.impl.UserServiceImpl;
import com.example.coffee.service.AdminService;
import com.example.coffee.service.UserService;
import com.example.coffee.impl.AdminServiceImpl;
import com.example.coffee.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();
    private AdminService adminService = new AdminServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");  // user 或 admin
        String preUrl = request.getParameter("preUrl");

        HttpSession session = request.getSession();

        if ("admin".equals(role)) {
            // ---- 管理员登录 ----
            Admin admin = adminService.login(username, password);
            if (admin != null) {
                session.setAttribute("adminUser", admin);
                // 如果有 preUrl 且指向 admin 后台，则跳转过去，否则跳转后台首页
                if (preUrl != null && preUrl.contains("/admin/")) {
                    response.sendRedirect(preUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
                }
                return;
            } else {
                request.setAttribute("msg", "管理员账号或密码错误！");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        } else {
            // ---- 普通用户登录 ----
            User user = userService.login(username, password);
            if (user != null) {
                session.setAttribute("loginUser", user);
                if (preUrl != null && !preUrl.isEmpty()) {
                    response.sendRedirect(preUrl);
                } else {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
                return;
            } else {
                request.setAttribute("msg", "用户名或密码错误！");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }
        }
    }
}