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

@WebServlet("/admin/CategoryUpdateServlet")
public class CategoryUpdateServlet extends HttpServlet {
    
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String sortOrderStr = req.getParameter("sortOrder");
        String statusStr = req.getParameter("status");
        
        Category category = new Category();
        category.setId(Integer.parseInt(idStr));
        category.setName(name);
        category.setDescription(description);
        category.setSortOrder(sortOrderStr != null && !sortOrderStr.isEmpty() ? Integer.parseInt(sortOrderStr) : 0);
        category.setStatus(statusStr != null && !statusStr.isEmpty() ? Integer.parseInt(statusStr) : 1);
        
        int result = categoryDao.updateCategory(category);
        
        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet?msg=update_success");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet?msg=update_fail");
        }
    }
}