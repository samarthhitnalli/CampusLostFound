<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Campus Lost and Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-md-5">
                <div class="card shadow">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <i class="bi bi-search text-primary" style="font-size: 3rem;"></i>
                            <h2 class="mt-2">Campus Lost and Found</h2>
                            <p class="text-muted">Login to your account</p>
                        </div>
                        
                        <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success"><%= request.getParameter("success") %></div>
                        <% } %>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
                        <% } %>
                        
                        <form action="login" method="post">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" required>
                            </div>
                            
                            <button type="submit" class="btn btn-primary w-100">Login</button>
                        </form>
                        
                        <div class="text-center mt-3">
                            <p>Don't have an account? <a href="register.jsp">Register here</a></p>
                        </div>
                        
                        <div class="alert alert-info mt-3">
                            <small><strong>Demo Credentials:</strong><br>
                            Admin: admin@campus.com / admin123<br>
                            User: john@campus.com / pass123</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>