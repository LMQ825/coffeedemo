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

@WebServlet("/admin/ProductUpdateServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class ProductUpdateServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String priceStr = request.getParameter("price");
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        String statusStr = request.getParameter("status");

        // 先查询原有数据，获取旧图片路径
        Product oldProduct = productService.getProductById(id);

        String imageUrl = oldProduct.getImageUrl(); // 默认保留旧图

        // 处理新图片上传
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            // 删除旧图片（可选）
            if (imageUrl != null && !imageUrl.isEmpty()) {
                String oldPath = getServletContext().getRealPath("/") + imageUrl;
                File oldFile = new File(oldPath);
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            }
            // 保存新图片
            String fileName = filePart.getSubmittedFileName();
            String ext = fileName.substring(fileName.lastIndexOf("."));
            String newName = UUID.randomUUID().toString() + ext;
            String savePath = getServletContext().getRealPath("/uploads/product/");
            File saveDir = new File(savePath);
            if (!saveDir.exists()) {
                saveDir.mkdirs();
            }
            filePart.write(savePath + File.separator + newName);
            imageUrl = "uploads/product/" + newName;
        }

        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setPrice(Double.parseDouble(priceStr));
        product.setCategory(category);
        product.setDescription(description);
        product.setImageUrl(imageUrl);
        product.setStatus(Integer.parseInt(statusStr));

        int result = productService.updateProduct(product);
        if (result > 0) {
            response.sendRedirect(request.getContextPath() + "/admin/ProductListServlet");
        } else {
            request.setAttribute("msg", "修改失败");
            request.getRequestDispatcher("/admin/productEdit.jsp?id=" + id).forward(request, response);
        }
    }
}