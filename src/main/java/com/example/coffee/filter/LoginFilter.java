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
        String contextPath = request.getContextPath();
        String path = uri.substring(contextPath.length());

        // 后台 /admin/* 区域由 AdminFilter 负责鉴权，这里直接放行，
        // 避免把已登录的管理员（session 中是 adminUser 而非 loginUser）误导向用户登录页
        if (path.startsWith("/admin/")) {
            chain.doFilter(req, resp);
            return;
        }

        // 无需登录放行页面(大小写不敏感匹配)
        String[] freeResource = {
                "splash.jsp",
                "index.jsp",
                "coffeelist.jsp",
                "login.jsp",
                "register.jsp",
                "/loginservlet",
                "/registerservlet",
                "/logoutservlet",
                "/userlogoutservlet",
                "/productlistservlet",
                "/cartaddservlet",
                "/cartupdateservlet",
                "/ordersubmitservlet",
                "/orderlistservlet",
                "/payservlet",
                "css/",
                "js/",
                "images/",
                "uploads/"
        };

        String pathLower = path.toLowerCase();
        boolean isFree = false;
        for (String p : freeResource) {
            if (pathLower.contains(p)) {
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
