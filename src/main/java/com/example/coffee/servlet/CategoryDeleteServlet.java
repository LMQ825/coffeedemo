package com.example.coffee.servlet;

import com.example.coffee.dao.CategoryDao;
import com.example.coffee.impl.CategoryDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/CategoryDeleteServlet")
public class CategoryDeleteServlet extends HttpServlet {
    
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            int result = categoryDao.deleteCategory(id);
            if (result > 0) {
                resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet?msg=delete_success");
            } else {
                resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet?msg=delete_fail");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/CategoryListServlet");
        }
    }
}