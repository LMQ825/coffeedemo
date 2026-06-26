package com.example.coffee.servlet;

import com.example.coffee.dao.CategoryDao;
import com.example.coffee.entity.Category;
import com.example.coffee.impl.CategoryDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/CategoryListServlet")
public class CategoryListServlet extends HttpServlet {
    
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryDao.selectAllCategories();
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/admin/categoryList.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}