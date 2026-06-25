package com.example.coffee.servlet;

import com.example.coffee.service.ProductService;
import com.example.coffee.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/ProductUpServlet")
public class ProductUpServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productService.upProduct(id);
        response.sendRedirect(request.getContextPath() + "/admin/ProductListServlet");
    }
}