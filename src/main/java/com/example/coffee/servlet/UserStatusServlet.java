package com.example.coffee.servlet;

import com.example.coffee.service.UserService;
import com.example.coffee.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/UserStatusServlet")
public class UserStatusServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int status = Integer.parseInt(request.getParameter("status"));
        userService.updateUserStatus(userId, status);
        response.sendRedirect(request.getContextPath() + "/admin/UserListServlet");
    }
}