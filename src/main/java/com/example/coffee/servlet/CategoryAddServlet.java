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

@WebServlet("/admin/CategoryAddServlet")
public class CategoryAddServlet extends HttpServlet {
    
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String sortOrderStr = req.getParameter("sortOrder");
        
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        category.setSortOrder(sortOrderStr != null && !sortOrderStr.isEmpty() ? Integer.parseInt(sortOrderStr) : 0);
        category.setStatus(1);
        
        int result = categoryDao.insertCategory(category);
        
        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet?msg=add_success");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet?msg=add_fail");
        }
    }
}