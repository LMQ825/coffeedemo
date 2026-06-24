package com.example.coffee.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    // 必须重写初始化方法
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 无业务需求留空即可
    }

    // 核心过滤逻辑
    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");

        String uri = request.getRequestURI();
        // 无需登录放行页面
        String[] freeResource = {
                "splash.jsp",
                "index.jsp",
                "coffeeList.jsp",
                "login.jsp",
                "register.jsp",
                "LoginServlet",
                "RegisterServlet",
                "css/",
                "js/",
                "images/"
        };

        boolean isFree = false;
        for (String path : freeResource) {
            if (uri.contains(path)) {
                isFree = true;
                break;
            }
        }

        if (isFree) {
            chain.doFilter(req, resp);
            return;
        }

        // 需要登录校验
        HttpSession session = request.getSession();
        Object loginUser = session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("preUrl", uri);
            response.sendRedirect("login.jsp");
            return;
        }
        chain.doFilter(req, resp);
    }

    // 必须重写销毁方法
    @Override
    public void destroy() {
        // 无资源释放需求留空即可
    }
}