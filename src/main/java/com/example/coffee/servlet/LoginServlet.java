package com.example.coffee.servlet;

import com.example.coffee.entity.User;
import com.example.coffee.service.UserService;
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
    private UserService userService = (UserService) new UserServiceImpl();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String pwd = request.getParameter("pwd");
        String preUrl = request.getParameter("preUrl");
        User loginUser = userService.login(username, pwd);
        HttpSession session = request.getSession();
        if(loginUser != null){
            // 登录成功存入session
            session.setAttribute("loginUser", loginUser);
            session.removeAttribute("preUrl");
            // 跳回拦截前页面
            response.sendRedirect(preUrl);
        }else{
            request.setAttribute("msg","账号或密码错误");
            request.getRequestDispatcher("login.jsp").forward(request,response);
        }
    }
}