package com.example.coffee.servlet;

import com.example.coffee.entity.User;
import com.example.coffee.service.UserService;
import com.example.coffee.impl.UserServiceImpl;
import com.example.coffee.util.PageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/UserListServlet")
public class UserListServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("keyword");
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }
        int pageSize = 10;

        PageBean<User> pageBean = userService.listUsers(keyword, currentPage, pageSize);
        request.setAttribute("pageBean", pageBean);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/admin/userList.jsp").forward(request, response);
    }
}