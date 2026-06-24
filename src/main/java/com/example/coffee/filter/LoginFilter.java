package com.example.coffee.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");

        String url = request.getRequestURI();
        // 放行无需登录的页面、静态资源、登录注册servlet
        String[] freePages = {
                "splash.jsp", "index.jsp", "coffeeList.jsp", "login.jsp", "register.jsp",
                "LoginServlet", "RegisterServlet", "css/", "js/", "images/"
        };
        boolean isFree = false;
        for(String path : freePages){
            if(url.contains(path)){
                isFree = true;
                break;
            }
        }
        // 不需要登录，直接放行
        if(isFree){
            chain.doFilter(req, resp);
            return;
        }
        // 需要登录：判断session是否存在用户
        HttpSession session = request.getSession();
        Object user = session.getAttribute("loginUser");
        if(user == null){
            // 保存当前跳转前页面，登录成功后返回原页面
            session.setAttribute("preUrl", url);
            response.sendRedirect("login.jsp");
            return;
        }
        // 已登录，放行
        chain.doFilter(req, resp);
    }
}