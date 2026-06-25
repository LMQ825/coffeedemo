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

        // 放行登录请求（虽然现在用 login.jsp，但保留兼容）
        String uri = request.getRequestURI();
        if (uri.endsWith("login.jsp") || uri.endsWith("LoginServlet")) {
            chain.doFilter(req, resp);
            return;
        }

        HttpSession session = request.getSession();
        Object adminUser = session.getAttribute("adminUser");
        if (adminUser == null) {
            // 没有管理员登录，跳转到登录页（并带上提示）
            response.sendRedirect(request.getContextPath() + "/login.jsp?role=admin");
            return;
        }
        chain.doFilter(req, resp);
    }

    @Override
    public void destroy() {}
}