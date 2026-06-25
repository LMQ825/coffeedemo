package com.example.coffee.servlet;

import com.example.coffee.dao.CategoryDao;
import com.example.coffee.dao.OrderDao;
import com.example.coffee.dao.ProductDao;
import com.example.coffee.dao.UserDao;
import com.example.coffee.impl.CategoryDaoImpl;
import com.example.coffee.impl.OrderDaoImpl;
import com.example.coffee.impl.ProductDaoImpl;
import com.example.coffee.impl.UserDaoImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/StatisticsServlet")
public class StatisticsServlet extends HttpServlet {
    
    private OrderDao orderDao = new OrderDaoImpl();
    private ProductDao productDao = new ProductDaoImpl();
    private UserDao userDao = new UserDaoImpl();
    private CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 今日统计
        Double todaySales = orderDao.selectTodaySales();
        int todayOrders = orderDao.selectTodayOrderCount();
        int pendingOrders = orderDao.selectPendingOrderCount();
        
        // 总体统计
        int totalProducts = productDao.selectProductCount(null);
        int totalUsers = userDao.selectUserCount(null);
        int totalCategories = categoryDao.selectCategoryCount();
        
        // 销量排行榜（前10）
        List<Map<String, Object>> topProducts = orderDao.selectTopSellingProducts(10);
        
        // 订单状态分布
        List<Map<String, Object>> statusDistribution = orderDao.selectOrderStatusDistribution();
        
        // 最近7天销售趋势
        List<Map<String, Object>> dailySales = orderDao.selectDailySalesLast7Days();
        
        // 分类销售占比
        List<Map<String, Object>> categorySales = orderDao.selectCategorySalesDistribution();
        
        // 设置属性
        req.setAttribute("todaySales", todaySales != null ? todaySales : 0.0);
        req.setAttribute("todayOrders", todayOrders);
        req.setAttribute("pendingOrders", pendingOrders);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("totalCategories", totalCategories);
        req.setAttribute("topProducts", topProducts);
        req.setAttribute("statusDistribution", statusDistribution);
        req.setAttribute("dailySales", dailySales);
        req.setAttribute("categorySales", categorySales);
        
        req.getRequestDispatcher("/admin/statistics.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}