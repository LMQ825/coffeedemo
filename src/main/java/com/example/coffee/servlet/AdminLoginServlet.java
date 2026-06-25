package com.example.coffee.servlet;

import com.example.coffee.entity.Admin;
import com.example.coffee.service.AdminService;
import com.example.coffee.impl.AdminServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private AdminService adminService = new AdminServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("========== 管理员登录请求到达 ==========");
        System.out.println("用户名: " + request.getParameter("username"));
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("管理员登录尝试: " + username);   // 打印日志

        Admin admin = adminService.login(username, password);
        HttpSession session = request.getSession();

        if (admin != null) {
            System.out.println("登录成功，管理员ID=" + admin.getId());  // 打印成功
            session.setAttribute("adminUser", admin);
            response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        } else {
            System.out.println("登录失败，用户名或密码错误");
            request.setAttribute("msg", "用户名或密码错误！");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}