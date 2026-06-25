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
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = adminService.login(username, password);
        HttpSession session = request.getSession();

        if (admin != null) {
            session.setAttribute("adminUser", admin);
            response.sendRedirect(request.getContextPath() + "/admin/index.jsp");
        } else {
            request.setAttribute("msg", "用户名或密码错误！");
            request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
        }
    }
}