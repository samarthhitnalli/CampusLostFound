<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.*, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<LostItem> lostItems = (List<LostItem>) request.getAttribute("lostItems");
    List<FoundItem> foundItems = (List<FoundItem>) request.getAttribute("foundItems");
    String keyword = (String) request.getAttribute("keyword");
    String location = (String) request.getAttribute("location");
    String date = (String) request.getAttribute("date");
    String type = (String) request.getAttribute("type");
    
    int totalResults = 0;
    if (lostItems != null) totalResults += lostItems.size();
    if (foundItems != null) totalResults += foundItems.size();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results - Campus Lost & Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .item-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px 8px 0 0;
        }
        .no-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px 8px 0 0;
            color: white;
            font-size: 48px;
        }
        .no-image-found {
            background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
        }
        .item-card {
            transition: transform 0.2s;
            height: 100%;
        }
        .item-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="user-dashboard.jsp"><i class="bi bi-search"></i> Campus Lost & Found</a>
            <div class="navbar-nav ms-auto">
                <a href="user-dashboard.jsp" class="btn btn-outline-light btn-sm me-2">Dashboard</a>
                <a href="logout" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <h2><i class="bi bi-search"></i> Search Results</h2>
        <p class="text-muted">Found <%= totalResults %> result(s)</p>
        
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" action="search">
                    <div class="row">
                        <div class="col-md-3 mb-2">
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Item name..." value="<%= keyword != null ? keyword : "" %>">
                        </div>
                        <div class="col-md-3 mb-2">
                            <input type="text" name="location" class="form-control" 
                                   placeholder="Location..." value="<%= location != null ? location : "" %>">
                        </div>
                        <div class="col-md-2 mb-2">
                            <input type="date" name="date" class="form-control" 
                                   value="<%= date != null ? date : "" %>">
                        </div>
                        <div class="col-md-2 mb-2">
                            <select name="type" class="form-select">
                                <option value="all" <%= "all".equals(type) ? "selected" : "" %>>All Items</option>
                                <option value="lost" <%= "lost".equals(type) ? "selected" : "" %>>Lost Only</option>
                                <option value="found" <%= "found".equals(type) ? "selected" : "" %>>Found Only</option>
                            </select>
                        </div>
                        <div class="col-md-2 mb-2">
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> Search
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <% if (lostItems != null && !lostItems.isEmpty()) { %>
            <h4 class="text-danger mt-4"><i class="bi bi-exclamation-circle"></i> Lost Items</h4>
            <div class="row">
                <% for (LostItem item : lostItems) { %>
                    <div class="col-md-4 col-lg-3 mb-4">
                        <div class="card item-card shadow-sm">
                            <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
                                <img src="<%= item.getImagePath() %>" class="item-image" alt="<%= item.getItemName() %>">
                            <% } else { %>
                                <div class="no-image">
                                    <i class="bi bi-image"></i>
                                </div>
                            <% } %>
                            
                            <div class="card-body">
                                <h5 class="card-title text-danger">
                                    <i class="bi bi-exclamation-circle"></i> <%= item.getItemName() %>
                                </h5>
                                <p class="card-text small"><%= item.getDescription() %></p>
                                <hr>
                                <p class="mb-1"><strong><i class="bi bi-geo-alt"></i></strong> <%= item.getLocation() %></p>
                                <p class="mb-1"><strong><i class="bi bi-calendar"></i></strong> <%= item.getLostDate() %></p>
                                <p class="mb-1"><strong><i class="bi bi-telephone"></i></strong> <%= item.getContact() %></p>
                                <p class="mb-2"><small class="text-muted">By: <%= item.getUserName() %></small></p>
                                <span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-success" : "bg-warning text-dark" %>">
                                    <%= item.getStatus().toUpperCase() %>
                                </span>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
        
        <% if (foundItems != null && !foundItems.isEmpty()) { %>
            <h4 class="text-success mt-4"><i class="bi bi-check-circle"></i> Found Items</h4>
            <div class="row">
                <% for (FoundItem item : foundItems) { %>
                    <div class="col-md-4 col-lg-3 mb-4">
                        <div class="card item-card shadow-sm">
                            <% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
                                <img src="<%= item.getImagePath() %>" class="item-image" alt="<%= item.getItemName() %>">
                            <% } else { %>
                                <div class="no-image no-image-found">
                                    <i class="bi bi-image"></i>
                                </div>
                            <% } %>
                            
                            <div class="card-body">
                                <h5 class="card-title text-success">
                                    <i class="bi bi-check-circle"></i> <%= item.getItemName() %>
                                </h5>
                                <p class="card-text small"><%= item.getDescription() %></p>
                                <hr>
                                <p class="mb-1"><strong><i class="bi bi-geo-alt"></i></strong> <%= item.getLocation() %></p>
                                <p class="mb-1"><strong><i class="bi bi-calendar"></i></strong> <%= item.getFoundDate() %></p>
                                <p class="mb-1"><strong><i class="bi bi-telephone"></i></strong> <%= item.getContact() %></p>
                                <p class="mb-2"><small class="text-muted">By: <%= item.getUserName() %></small></p>
                                <span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-secondary" : "bg-info text-dark" %>">
                                    <%= item.getStatus().toUpperCase() %>
                                </span>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
        
        <% if (totalResults == 0) { %>
            <div class="alert alert-info mt-4">
                <i class="bi bi-info-circle"></i> No items found matching your search criteria.
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>