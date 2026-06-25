package com.example.coffee.servlet;

import com.example.coffee.entity.Product;
import com.example.coffee.service.ProductService;
import com.example.coffee.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/admin/ProductAddServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class ProductAddServlet extends HttpServlet {

    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");

        String isNewStr = request.getParameter("isNew");
// 在构建 Product 对象时增加

        // 处理图片上传
        String imageUrl = "";
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newName = UUID.randomUUID().toString() + ext;

            // 保存路径：项目部署目录下的 uploads/product/
            String savePath = getServletContext().getRealPath("/uploads/product/");
            File saveDir = new File(savePath);
            if (!saveDir.exists()) {
                saveDir.mkdirs();
            }
            filePart.write(savePath + File.separator + newName);
            imageUrl = "uploads/product/" + newName;
        }

        Product product = new Product();
        product.setName(name);
        product.setPrice(Double.parseDouble(priceStr));
        product.setCategory(category);
        product.setDescription(description);
        product.setImageUrl(imageUrl);
        product.setStatus(Integer.parseInt(statusStr));
        product.setIsNew(isNewStr != null && "1".equals(isNewStr) ? 1 : 0);

        int result = productService.addProduct(product);
        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/ProductListServlet");
        } else {
            request.setAttribute("msg", "添加失败，请重试");
            request.getRequestDispatcher("/admin/productAdd.jsp").forward(request, response);
        }
    }
}