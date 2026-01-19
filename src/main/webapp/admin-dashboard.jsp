<%-- 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.*, com.campus.dao.*, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    LostDAO lostDAO = new LostDAO();
    FoundDAO foundDAO = new FoundDAO();
    
    List<User> users = userDAO.getAllUsers();
    List<LostItem> lostItems = lostDAO.getAllLostItems();
    List<FoundItem> foundItems = foundDAO.getAllFoundItems();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Campus Lost and Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#"><i class="bi bi-shield-check"></i> Admin Panel</a>
            <div class="navbar-nav ms-auto">
                <span class="navbar-text text-white me-3">Welcome, Admin!</span>
                <a href="logout" class="btn btn-outline-light btn-sm">Logout</a>
            </div>
        </div>
    </nav>
    
    <div class="container-fluid mt-4">
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success alert-dismissible fade show">
                <%= request.getParameter("success") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>
        
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card text-center bg-primary text-white">
                    <div class="card-body">
                        <h1><%= users.size() %></h1>
                        <p>Total Users</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center bg-danger text-white">
                    <div class="card-body">
                        <h1><%= lostItems.size() %></h1>
                        <p>Lost Items</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center bg-success text-white">
                    <div class="card-body">
                        <h1><%= foundItems.size() %></h1>
                        <p>Found Items</p>
                    </div>
                </div>
            </div>
        </div>
        
        <ul class="nav nav-tabs" id="adminTabs" role="tablist">
            <li class="nav-item">
                <a class="nav-link active" data-bs-toggle="tab" href="#users">Users</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#lost">Lost Items</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#found">Found Items</a>
            </li>
        </ul>
        
        <div class="tab-content mt-3">
            <div class="tab-pane fade show active" id="users">
                <div class="card">
                    <div class="card-header"><h5>All Users</h5></div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Role</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (User u : users) { %>
                                    <tr>
                                        <td><%= u.getUserId() %></td>
                                        <td><%= u.getName() %></td>
                                        <td><%= u.getEmail() %></td>
                                        <td><%= u.getPhone() %></td>
                                        <td><span class="badge bg-info"><%= u.getRole() %></span></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="lost">
                <div class="card">
                    <div class="card-header"><h5>All Lost Items</h5></div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Item</th>
                                    <th>Location</th>
                                    <th>Date</th>
                                    <th>Contact</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (LostItem item : lostItems) { %>
                                    <tr>
                                        <td><%= item.getLostId() %></td>
                                        <td><%= item.getItemName() %></td>
                                        <td><%= item.getLocation() %></td>
                                        <td><%= item.getLostDate() %></td>
                                        <td><%= item.getContact() %></td>
                                        <td><span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-success" : "bg-warning" %>">
                                            <%= item.getStatus() %></span></td>
                                        <td>
                                            <form action="lost-item" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="lostId" value="<%= item.getLostId() %>">
                                                <button class="btn btn-sm btn-danger" onclick="return confirm('Delete this item?')">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <div class="tab-pane fade" id="found">
                <div class="card">
                    <div class="card-header"><h5>All Found Items</h5></div>
                    <div class="card-body">
                        <table class="table table-striped">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Item</th>
                                    <th>Location</th>
                                    <th>Date</th>
                                    <th>Contact</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (FoundItem item : foundItems) { %>
                                    <tr>
                                        <td><%= item.getFoundId() %></td>
                                        <td><%= item.getItemName() %></td>
                                        <td><%= item.getLocation() %></td>
                                        <td><%= item.getFoundDate() %></td>
                                        <td><%= item.getContact() %></td>
                                        <td><span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-secondary" : "bg-info" %>">
                                            <%= item.getStatus() %></span></td>
                                        <td>
                                            <form action="found-item" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="foundId" value="<%= item.getFoundId() %>">
                                                <button class="btn btn-sm btn-danger" onclick="return confirm('Delete this item?')">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.*, com.campus.dao.*, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    UserDAO userDAO = new UserDAO();
    LostDAO lostDAO = new LostDAO();
    FoundDAO foundDAO = new FoundDAO();
    
    List<User> users = userDAO.getAllUsers();
    List<LostItem> lostItems = lostDAO.getAllLostItems();
    List<FoundItem> foundItems = foundDAO.getAllFoundItems();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Campus Lost & Found</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <style>
        body {
            background: #f4f6f9;
        }

        .stat-card {
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: transform 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .item-thumbnail {
            width: 120px;
            height: 90px;
            object-fit: cover;
            border-radius: 10px;
            cursor: pointer;
            transition: transform 0.2s;
        }

        .item-thumbnail:hover {
            transform: scale(1.1);
        }

        .no-image-small {
            width: 120px;
            height: 90px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 10px;
            color: white;
            font-size: 24px;
        }

        .card {
            border-radius: 15px;
            border: none;
        }

        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="bi bi-shield-check"></i> Admin Panel
        </a>
        <div class="navbar-nav ms-auto">
            <span class="navbar-text text-white me-3">Welcome, Admin!</span>
            <a href="logout" class="btn btn-outline-light btn-sm">Logout</a>
        </div>
    </div>
</nav>

<div class="container-fluid mt-4">

<% if (request.getParameter("success") != null) { %>
<div class="alert alert-success alert-dismissible fade show">
    <%= request.getParameter("success") %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<!-- Dashboard Stats -->
<div class="row mb-4">
    <div class="col-md-4">
        <div class="card stat-card bg-primary text-white text-center p-3">
            <h1><%= users.size() %></h1>
            <h5>Total Users</h5>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card stat-card bg-danger text-white text-center p-3">
            <h1><%= lostItems.size() %></h1>
            <h5>Lost Items</h5>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card stat-card bg-success text-white text-center p-3">
            <h1><%= foundItems.size() %></h1>
            <h5>Found Items</h5>
        </div>
    </div>
</div>

<ul class="nav nav-tabs" id="adminTabs" role="tablist">
    <li class="nav-item">
        <a class="nav-link active" data-bs-toggle="tab" href="#users">Users</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="tab" href="#lost">Lost Items</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" data-bs-toggle="tab" href="#found">Found Items</a>
    </li>
</ul>

<div class="tab-content mt-3">

<!-- USERS TAB -->
<div class="tab-pane fade show active" id="users">
<div class="card">
<div class="card-header"><h5>All Users</h5></div>
<div class="card-body table-responsive">

<table class="table table-striped">
<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>Role</th>
</tr>
</thead>
<tbody>
<% for (User u : users) { %>
<tr>
<td><%= u.getUserId() %></td>
<td><%= u.getName() %></td>
<td><%= u.getEmail() %></td>
<td><%= u.getPhone() %></td>
<td><span class="badge bg-info"><%= u.getRole() %></span></td>
</tr>
<% } %>
</tbody>
</table>

</div>
</div>
</div>

<!-- LOST ITEMS TAB -->
<div class="tab-pane fade" id="lost">
<div class="card">
<div class="card-header"><h5>All Lost Items (With Images)</h5></div>
<div class="card-body table-responsive">

<table class="table table-striped">
<thead>
<tr>
<th>Image</th>
<th>ID</th>
<th>Item Name</th>
<th>Location</th>
<th>Date</th>
<th>Contact</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead>
<tbody>

<% for (LostItem item : lostItems) { %>
<tr>
<td>
<% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
<img src="<%= item.getImagePath() %>" 
     class="item-thumbnail"
     data-bs-toggle="modal"
     data-bs-target="#imgModal"
     onclick="showImage('<%= item.getImagePath() %>')">
<% } else { %>
<div class="no-image-small">
<i class="bi bi-image"></i>
</div>
<% } %>
</td>

<td><%= item.getLostId() %></td>
<td><strong><%= item.getItemName() %></strong></td>
<td><%= item.getLocation() %></td>
<td><%= item.getLostDate() %></td>
<td><%= item.getContact() %></td>

<td>
<span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-success" : "bg-warning text-dark" %>">
<%= item.getStatus() %>
</span>
</td>

<td>
<form action="lost-item" method="post" style="display:inline;">
<input type="hidden" name="action" value="delete">
<input type="hidden" name="lostId" value="<%= item.getLostId() %>">
<button class="btn btn-sm btn-danger" onclick="return confirm('Delete this item?')">
<i class="bi bi-trash"></i>
</button>
</form>
</td>
</tr>
<% } %>

</tbody>
</table>

</div>
</div>
</div>

<!-- FOUND ITEMS TAB -->
<div class="tab-pane fade" id="found">
<div class="card">
<div class="card-header"><h5>All Found Items (With Images)</h5></div>
<div class="card-body table-responsive">

<table class="table table-striped">
<thead>
<tr>
<th>Image</th>
<th>ID</th>
<th>Item Name</th>
<th>Location</th>
<th>Date</th>
<th>Contact</th>
<th>Status</th>
<th>Actions</th>
</tr>
</thead>
<tbody>

<% for (FoundItem item : foundItems) { %>
<tr>
<td>
<% if (item.getImagePath() != null && !item.getImagePath().isEmpty()) { %>
<img src="<%= item.getImagePath() %>" 
     class="item-thumbnail"
     data-bs-toggle="modal"
     data-bs-target="#imgModal"
     onclick="showImage('<%= item.getImagePath() %>')">
<% } else { %>
<div class="no-image-small">
<i class="bi bi-image"></i>
</div>
<% } %>
</td>

<td><%= item.getFoundId() %></td>
<td><strong><%= item.getItemName() %></strong></td>
<td><%= item.getLocation() %></td>
<td><%= item.getFoundDate() %></td>
<td><%= item.getContact() %></td>

<td>
<span class="badge <%= "resolved".equals(item.getStatus()) ? "bg-secondary" : "bg-info text-dark" %>">
<%= item.getStatus() %>
</span>
</td>

<td>
<form action="found-item" method="post" style="display:inline;">
<input type="hidden" name="action" value="delete">
<input type="hidden" name="foundId" value="<%= item.getFoundId() %>">
<button class="btn btn-sm btn-danger" onclick="return confirm('Delete this item?')">
<i class="bi bi-trash"></i>
</button>
</form>
</td>
</tr>
<% } %>

</tbody>
</table>

</div>
</div>
</div>

</div> <!-- container -->

<!-- IMAGE PREVIEW MODAL -->
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
