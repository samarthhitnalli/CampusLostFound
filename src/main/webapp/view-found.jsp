<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.User, com.campus.model.FoundItem, com.campus.dao.FoundDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    FoundDAO foundDAO = new FoundDAO();
    List<FoundItem> items;
    
    String keyword = request.getParameter("keyword");
    String location = request.getParameter("location");
    String date = request.getParameter("date");
    
    if (keyword != null || location != null || date != null) {
        items = foundDAO.searchFoundItems(keyword, location, date);
    } else {
        items = foundDAO.getAllFoundItems();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Found Items - Campus Lost & Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
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
        <h2><i class="bi bi-check-circle text-success"></i> Found Items</h2>
        
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <%= request.getParameter("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" action="view-found.jsp">
                    <div class="row">
                        <div class="col-md-4 mb-2">
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Search by item name..." value="<%= keyword != null ? keyword : "" %>">
                        </div>
                        <div class="col-md-3 mb-2">
                            <input type="text" name="location" class="form-control" 
                                   placeholder="Location..." value="<%= location != null ? location : "" %>">
                        </div>
                        <div class="col-md-3 mb-2">
                            <input type="date" name="date" class="form-control" 
                                   value="<%= date != null ? date : "" %>">
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
        
        <div class="row">
            <% if (items.isEmpty()) { %>
                <div class="col-12">
                    <div class="alert alert-info">No found items available.</div>
                </div>
            <% } else {
                for (FoundItem item : items) { %>
                    <div class="col-md-6 mb-3">
                        <div class="card h-100">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><%= item.getItemName() %></h5>
                            </div>
                            <div class="card-body">
                                <p><strong>Description:</strong> <%= item.getDescription() %></p>
                                <p><strong>Location:</strong> <%= item.getLocation() %></p>
                                <p><strong>Date Found:</strong> <%= item.getFoundDate() %></p>
                                <p><strong>Contact:</strong> <%= item.getContact() %></p>
                                <p><strong>Found by:</strong> <%= item.getUserName() %></p>
                                <span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-secondary" : "bg-info" %>">
                                    <%= item.getStatus().toUpperCase() %>
                                </span>
                            </div>
                            <% if (item.getUserId() == user.getUserId() && "found".equals(item.getStatus())) { %>
                                <div class="card-footer">
                                    <form action="found-item" method="post" class="d-inline">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="foundId" value="<%= item.getFoundId() %>">
                                        <input type="hidden" name="status" value="resolved">
                                        <button type="submit" class="btn btn-sm btn-success">
                                            <i class="bi bi-check"></i> Mark as Resolved
                                        </button>
                                    </form>
                                </div>
                            <% } %>
                        </div>
                    </div>
            <% }} %>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.User, com.campus.model.FoundItem, com.campus.dao.FoundDAO, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    FoundDAO foundDAO = new FoundDAO();
    List<FoundItem> items;
    
    String keyword = request.getParameter("keyword");
    String location = request.getParameter("location");
    String date = request.getParameter("date");
    
    if (keyword != null || location != null || date != null) {
        items = foundDAO.searchFoundItems(keyword, location, date);
    } else {
        items = foundDAO.getAllFoundItems();
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Found Items - Campus Lost & Found</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

<style>
body {
    background: #f4f6f9;
}

/* Hero header */
.hero {
    background: linear-gradient(135deg, #0d6efd, #6610f2);
    color: white;
    padding: 25px;
    border-radius: 15px;
    margin-bottom: 20px;
}

/* Search card */
.search-card {
    border-radius: 15px;
    box-shadow: 0 4px 10px rgba(0,0,0,0.1);
}

/* Item cards */
.item-card {
    border-radius: 15px;
    overflow: hidden;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.item-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
}

/* Images */
.item-image {
    width: 100%;
    height: 220px;
    object-fit: cover;
    cursor: pointer;
}

.no-image {
    width: 100%;
    height: 220px;
    background: linear-gradient(135deg, #11998e, #38ef7d);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 60px;
}

/* Badges */
.status-badge {
    font-size: 12px;
    padding: 6px 10px;
}

/* Card footer button */
.card-footer {
    background: #f8f9fa;
}

/* Navbar */
.navbar {
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container-fluid">

    <a class="navbar-brand fw-bold" href="user-dashboard.jsp">
      <i class="bi bi-search"></i> Campus Lost & Found
    </a>

    <!-- Hamburger button for mobile -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navMenu">
      <ul class="navbar-nav ms-auto align-items-lg-center">

        <li class="nav-item me-lg-3">
          <span class="navbar-text text-white">
            Welcome, <strong><%= user.getName() %></strong>
          </span>
        </li>

        <li class="nav-item me-lg-2">
          <a href="user-dashboard.jsp" class="btn btn-outline-light btn-sm">
            <i class="bi bi-grid"></i> Dashboard
          </a>
        </li>

        <li class="nav-item">
          <a href="logout" class="btn btn-danger btn-sm">
            <i class="bi bi-box-arrow-right"></i> Logout
          </a>
        </li>

      </ul>
    </div>
  </div>
</nav>


<div class="container mt-4">

<div class="hero text-center">
<h2><i class="bi bi-check-circle"></i> Found Items</h2>
<p class="mb-0">Browse items found across the campus</p>
</div>

<% if (request.getParameter("success") != null) { %>
<div class="alert alert-success alert-dismissible fade show">
<%= request.getParameter("success") %>
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<!-- Search Section -->
<div class="card search-card mb-4">
<div class="card-body">
<form method="get" action="view-found.jsp">
<div class="row g-3">

<div class="col-md-4">
<input type="text" name="keyword" class="form-control"
placeholder="Search by item name..."
value="<%= keyword != null ? keyword : "" %>">
</div>

<div class="col-md-3">
<input type="text" name="location" class="form-control"
placeholder="Location..."
value="<%= location != null ? location : "" %>">
</div>

<div class="col-md-3">
<input type="date" name="date" class="form-control"
value="<%= date != null ? date : "" %>">
</div>

<div class="col-md-2">
<button type="submit" class="btn btn-primary w-100">
<i class="bi bi-search"></i> Search
</button>
</div>

</div>
</form>
</div>
</div>

<!-- Items Grid -->
<div class="row">

<% if (items.isEmpty()) { %>
<div class="col-12">
<div class="alert alert-info text-center">
<i class="bi bi-info-circle"></i> No found items available.
</div>
</div>
<% } else {
for (FoundItem item : items) { %>

<div class="col-md-4 col-lg-3 mb-4">
<div class="card item-card shadow-sm">

<% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
<img src="<%= item.getImagePath() %>"
class="item-image"
data-bs-toggle="modal"
data-bs-target="#imgModal"
onclick="showImage('<%= item.getImagePath() %>')">
<% } else { %>
<div class="no-image">
<i class="bi bi-image"></i>
</div>
<% } %>

<div class="card-body">
<h5 class="card-title text-success">
<i class="bi bi-check-circle"></i> <%= item.getItemName() %>
</h5>

<p class="card-text small text-muted">
<%= item.getDescription() %>
</p>

<hr>

<p class="mb-1">
<strong><i class="bi bi-geo-alt"></i></strong>
<%= item.getLocation() %>
</p>

<p class="mb-1">
<strong><i class="bi bi-calendar"></i></strong>
<%= item.getFoundDate() %>
</p>

<p class="mb-1">
<strong><i class="bi bi-telephone"></i></strong>
<%= item.getContact() %>
</p>

<p class="mb-2">
<small class="text-muted">By: <%= item.getUserName() %></small>
</p>

<span class="badge status-badge
<%= "resolved".equals(item.getStatus()) ? "bg-secondary" : "bg-info text-dark" %>">
<%= item.getStatus().toUpperCase() %>
</span>
</div>

<% if (item.getUserId() == user.getUserId() && "found".equals(item.getStatus())) { %>
<div class="card-footer">
<form action="found-item" method="post">
<input type="hidden" name="action" value="updateStatus">
<input type="hidden" name="foundId" value="<%= item.getFoundId() %>">
<input type="hidden" name="status" value="resolved">
<button type="submit" class="btn btn-success w-100">
<i class="bi bi-check"></i> Mark as Resolved
</button>
</form>
</div>
<% } %>

</div>
</div>

<% }} %>

</div>
</div>

<!-- Image Preview Modal -->
<div class="modal fade" id="imgModal" tabindex="-1">
<div class="modal-dialog modal-dialog-centered">
<div class="modal-content">
<div class="modal-body text-center">
<img id="modalImg" style="width:100%; border-radius:10px;">
</div>
</div>
</div>
</div>

<script>
function showImage(src) {
document.getElementById("modalImg").src = src;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
