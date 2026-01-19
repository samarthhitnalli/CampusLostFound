//package com.campus.servlet;
//
//import com.campus.dao.FoundDAO;
//import com.campus.model.FoundItem;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.sql.Date;
//
//@WebServlet("/found-item")
//public class FoundItemServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//    private FoundDAO foundDAO = new FoundDAO();
//    
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        
//        String action = request.getParameter("action");
//        
//        if ("add".equals(action)) {
//            addFoundItem(request, response);
//        } else if ("updateStatus".equals(action)) {
//            updateStatus(request, response);
//        } else if ("delete".equals(action)) {
//            deleteItem(request, response);
//        }
//    }
//    
//    private void addFoundItem(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("userId") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//        
//        int userId = (int) session.getAttribute("userId");
//        String itemName = request.getParameter("itemName");
//        String description = request.getParameter("description");
//        String location = request.getParameter("location");
//        Date foundDate = Date.valueOf(request.getParameter("foundDate"));
//        String contact = request.getParameter("contact");
//        
//        FoundItem item = new FoundItem(userId, itemName, description, location, foundDate, contact);
//        
//        if (foundDAO.addFoundItem(item)) {
//            response.sendRedirect("user-dashboard.jsp?success=Found item reported successfully!");
//        } else {
//            response.sendRedirect("report-found.jsp?error=Failed to report item!");
//        }
//    }
//    
//    private void updateStatus(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        
//        int foundId = Integer.parseInt(request.getParameter("foundId"));
//        String status = request.getParameter("status");
//        
//        HttpSession session = request.getSession(false);
//        String userRole = (String) session.getAttribute("userRole");
//        
//        if (foundDAO.updateStatus(foundId, status)) {
//            String redirectPage = "admin".equals(userRole) ? "admin-dashboard.jsp" : "view-found.jsp";
//            response.sendRedirect(redirectPage + "?success=Status updated successfully!");
//        } else {
//            response.sendRedirect("view-found.jsp?error=Failed to update status!");
//        }
//    }
//    
//    private void deleteItem(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        
//        int foundId = Integer.parseInt(request.getParameter("foundId"));
//        
//        if (foundDAO.deleteFoundItem(foundId)) {
//            response.sendRedirect("admin-dashboard.jsp?success=Item deleted successfully!");
//        } else {
//            response.sendRedirect("admin-dashboard.jsp?error=Failed to delete item!");
//        }
//    }
//}
package com.campus.servlet;

import com.campus.dao.FoundDAO;
import com.campus.model.FoundItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;

@WebServlet("/found-item")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 5,       // 5MB
    maxRequestSize = 1024 * 1024 * 10    // 10MB
)
public class FoundItemServlet extends HttpServlet {
    private FoundDAO foundDAO = new FoundDAO();
    
    private static final String UPLOAD_DIRECTORY = "uploads";
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check content type
        String contentType = request.getContentType();
        
        if (contentType != null && contentType.toLowerCase().contains("multipart/form-data")) {
            handleMultipartRequest(request, response);
        } else {
            handleNormalRequest(request, response);
        }
    }
    
    private void handleMultipartRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        try {
            // Get upload path
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // Get form fields
            int userId = (int) session.getAttribute("userId");
            String itemName = request.getParameter("itemName");
            String description = request.getParameter("description");
            String location = request.getParameter("location");
            String foundDate = request.getParameter("foundDate");
            String contact = request.getParameter("contact");
            
            // Handle file upload
            String imagePath = null;
            Part filePart = request.getPart("image");
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = getFileName(filePart);
                String fileExtension = fileName.substring(fileName.lastIndexOf("."));
                String newFileName = "found_" + System.currentTimeMillis() + fileExtension;
                
                String filePath = uploadPath + File.separator + newFileName;
                
                // Save file
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
                }
                
                imagePath = UPLOAD_DIRECTORY + "/" + newFileName;
            }
            
            // Create FoundItem object
            FoundItem foundItem = new FoundItem(userId, itemName, description, location, 
                                               Date.valueOf(foundDate), contact);
            foundItem.setImagePath(imagePath);
            
            // Save to database
            if (foundDAO.addFoundItem(foundItem)) {
                response.sendRedirect("user-dashboard.jsp?success=Found item reported successfully!");
            } else {
                response.sendRedirect("report-found.jsp?error=Failed to report item!");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("report-found.jsp?error=Error: " + e.getMessage());
        }
    }
    
    private void handleNormalRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            updateStatus(request, response);
        } else if ("delete".equals(action)) {
            deleteItem(request, response);
        }
    }
    
    private void updateStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int foundId = Integer.parseInt(request.getParameter("foundId"));
        String status = request.getParameter("status");
        
        HttpSession session = request.getSession(false);
        String userRole = (String) session.getAttribute("userRole");
        
        if (foundDAO.updateStatus(foundId, status)) {
            String redirectPage = "admin".equals(userRole) ? "admin-dashboard.jsp" : "view-found.jsp";
            response.sendRedirect(redirectPage + "?success=Status updated successfully!");
        } else {
            response.sendRedirect("view-found.jsp?error=Failed to update status!");
        }
    }
    
    private void deleteItem(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        int foundId = Integer.parseInt(request.getParameter("foundId"));
        
        if (foundDAO.deleteFoundItem(foundId)) {
            response.sendRedirect("admin-dashboard.jsp?success=Item deleted successfully!");
        } else {
            response.sendRedirect("admin-dashboard.jsp?error=Failed to delete item!");
        }
    }
    
    // Helper method to get file name from Part
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}