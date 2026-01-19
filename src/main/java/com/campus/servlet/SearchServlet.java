package com.campus.servlet;

import com.campus.dao.LostDAO;
import com.campus.dao.FoundDAO;
import com.campus.model.LostItem;
import com.campus.model.FoundItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private LostDAO lostDAO = new LostDAO();
    private FoundDAO foundDAO = new FoundDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String keyword = request.getParameter("keyword");
        String location = request.getParameter("location");
        String date = request.getParameter("date");
        String type = request.getParameter("type"); // "lost" or "found" or "all"
        
        if (type == null || type.isEmpty()) {
            type = "all";
        }
        
        List<LostItem> lostItems = null;
        List<FoundItem> foundItems = null;
        
        if ("lost".equals(type) || "all".equals(type)) {
            lostItems = lostDAO.searchLostItems(keyword, location, date);
        }
        
        if ("found".equals(type) || "all".equals(type)) {
            foundItems = foundDAO.searchFoundItems(keyword, location, date);
        }
        
        request.setAttribute("lostItems", lostItems);
        request.setAttribute("foundItems", foundItems);
        request.setAttribute("keyword", keyword);
        request.setAttribute("location", location);
        request.setAttribute("date", date);
        request.setAttribute("type", type);
        
        request.getRequestDispatcher("search-results.jsp").forward(request, response);
    }
}