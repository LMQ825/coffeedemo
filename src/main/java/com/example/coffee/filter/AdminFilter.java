package com.example.coffee.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");

        HttpSession session = request.getSession();
        Object adminUser = session.getAttribute("adminUser");

        String uri = request.getRequestURI();
        // 登录页面和登录Servlet放行
        if (uri.endsWith("adminLogin.jsp") || uri.endsWith("AdminLoginServlet")) {
            chain.doFilter(req, resp);
            return;
        }

        if (adminUser == null) {
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
            return;
        }

        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {}
}