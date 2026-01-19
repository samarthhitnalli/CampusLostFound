<%--
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report Lost Item - Campus Lost & Found</title>
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
    
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-danger text-white">
                        <h4><i class="bi bi-exclamation-circle"></i> Report Lost Item</h4>
                    </div>
                    <div class="card-body">
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger"><%= request.getParameter("error") %></div>
                        <% } %>
                        
                        <form action="lost-item" method="post">
                            <input type="hidden" name="action" value="add">
                            
                            <div class="mb-3">
                                <label class="form-label">Item Name *</label>
                                <input type="text" name="itemName" class="form-control" 
                                       placeholder="e.g., Blue Water Bottle, Black Wallet" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Description *</label>
                                <textarea name="description" class="form-control" rows="3" 
                                          placeholder="Provide detailed description (color, brand, unique features)" required></textarea>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Location Lost *</label>
                                <input type="text" name="location" class="form-control" 
                                       placeholder="e.g., Main Library, Cafeteria, CS Department" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Date Lost *</label>
                                <input type="date" name="lostDate" class="form-control" 
                                       max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Contact Number *</label>
                                <input type="tel" name="contact" class="form-control" 
                                       value="<%= user.getPhone() %>" pattern="[0-9]{10}" required>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-danger">
                                    <i class="bi bi-exclamation-circle"></i> Report Lost Item
                                </button>
                                <a href="user-dashboard.jsp" class="btn btn-secondary">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.campus.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Report Lost Item - Campus Lost & Found</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

<style>
body {
    background: #f4f6f9;
}

/* Navbar */
.navbar {
    box-shadow: 0 2px 8px rgba(0,0,0,0.15);
}

/* Hero header */
.hero {
    background: linear-gradient(135deg, #dc3545, #6610f2);
    color: white;
    padding: 25px;
    border-radius: 15px;
    margin-bottom: 20px;
}

/* Form card */
.form-card {
    border-radius: 15px;
    overflow: hidden;
}

/* Inputs */
.form-control, .form-select {
    border-radius: 10px;
}

/* Image preview */
.image-preview {
    max-width: 100%;
    border: 2px dashed #ccc;
    border-radius: 12px;
    padding: 10px;
    display: none;
    text-align: center;
}

.image-preview img {
    max-width: 100%;
    max-height: 280px;
    border-radius: 8px;
}

/* Buttons */
.btn {
    border-radius: 25px;
}

/* Card header */
.form-card .card-header {
    background: linear-gradient(135deg, #dc3545, #6610f2);
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
<h2><i class="bi bi-exclamation-circle"></i> Report Lost Item</h2>
<p class="mb-0">Help others locate your missing item</p>
</div>

<div class="row justify-content-center">
<div class="col-md-8 col-lg-7">

<div class="card form-card shadow-sm">

<div class="card-header text-white">
<h4 class="mb-0"><i class="bi bi-plus-circle"></i> Lost Item Details</h4>
</div>

<div class="card-body">

<% if (request.getParameter("error") != null) { %>
<div class="alert alert-danger">
<i class="bi bi-exclamation-triangle"></i>
<%= request.getParameter("error") %>
</div>
<% } %>

<form action="lost-item" method="post" enctype="multipart/form-data">

<div class="mb-3">
<label class="form-label fw-bold">Item Name *</label>
<input type="text" name="itemName" class="form-control"
placeholder="e.g., Blue Water Bottle, Black Wallet" required>
</div>

<div class="mb-3">
<label class="form-label fw-bold">Description *</label>
<textarea name="description" class="form-control" rows="3"
placeholder="Color, brand, unique marks, condition..." required></textarea>
</div>

<div class="row">
<div class="col-md-6 mb-3">
<label class="form-label fw-bold">Location Lost *</label>
<input type="text" name="location" class="form-control"
placeholder="e.g., Library, CSE Block, Cafeteria" required>
</div>

<div class="col-md-6 mb-3">
<label class="form-label fw-bold">Date Lost *</label>
<input type="date" name="lostDate" class="form-control"
max="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" required>
</div>
</div>

<div class="mb-3">
<label class="form-label fw-bold">Contact Number *</label>
<input type="tel" name="contact" class="form-control"
value="<%= user.getPhone() %>" pattern="[0-9]{10}" required>
</div>

<div class="mb-3">
<label class="form-label fw-bold">Upload Image (Optional)</label>
<input type="file" name="image" id="imageInput" class="form-control"
accept="image/*" onchange="previewImage(event)">
<small class="text-muted">Max 5MB • JPG, PNG, GIF</small>
</div>

<div class="mb-3 image-preview" id="imagePreview">
<h6 class="text-muted">Image Preview</h6>
<img id="preview" src="" alt="Image Preview">
</div>

<div class="d-grid gap-2 mt-3">
<button type="submit" class="btn btn-danger">
<i class="bi bi-exclamation-circle"></i> Submit Lost Item
</button>
<a href="user-dashboard.jsp" class="btn btn-secondary">Cancel</a>
</div>

</form>

</div>
</div>

</div>
</div>
</div>

<script>
function previewImage(event) {
const file = event.target.files[0];
const preview = document.getElementById('preview');
const previewContainer = document.getElementById('imagePreview');

if (file) {
const reader = new FileReader();
reader.onload = function(e) {
preview.src = e.target.result;
previewContainer.style.display = 'block';
}
reader.readAsDataURL(file);
} else {
previewContainer.style.display = 'none';
}
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

