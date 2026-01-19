package com.campus.servlet;

import com.campus.dao.UserDAO;
import com.campus.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        User user = new User(name, email, phone, password);
        
        if (userDAO.registerUser(user)) {
            response.sendRedirect("login.jsp?success=Registration successful! Please login.");
        } else {
            request.setAttribute("error", "Registration failed! Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}