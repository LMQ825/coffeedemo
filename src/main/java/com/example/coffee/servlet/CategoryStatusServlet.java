package com.example.coffee.servlet;

import com.example.coffee.dao.CategoryDao;
import com.example.coffee.impl.CategoryDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/CategoryStatusServlet")
public class CategoryStatusServlet extends HttpServlet {
    
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String statusStr = req.getParameter("status");
        
        if (idStr != null && statusStr != null) {
            int id = Integer.parseInt(idStr);
            int status = Integer.parseInt(statusStr);
            categoryDao.updateCategoryStatus(id, status);
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet");
    }
}