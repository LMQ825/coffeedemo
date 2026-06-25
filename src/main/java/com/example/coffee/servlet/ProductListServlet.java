package com.example.coffee.servlet;

import com.example.coffee.entity.Product;
import com.example.coffee.service.ProductService;
import com.example.coffee.impl.ProductServiceImpl;
import com.example.coffee.util.PageBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ProductListServlet")
public class ProductListServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String keyword = request.getParameter("keyword");
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            currentPage = Integer.parseInt(pageStr);
        }
        int pageSize = 8;

        PageBean<Product> pageBean = productService.listProducts(keyword, currentPage, pageSize);
        request.setAttribute("pageBean", pageBean);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/admin/productList.jsp").forward(request, response);
    }
}