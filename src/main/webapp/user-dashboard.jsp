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
<title>User Dashboard - Campus Lost & Found</title>

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

/* Hero section */
.hero {
    background: linear-gradient(135deg, #0d6efd, #6610f2);
    color: white;
    padding: 30px;
    border-radius: 15px;
    margin-bottom: 25px;
}

/* Dashboard cards */
.dashboard-card {
    border-radius: 15px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    height: 100%;
}

.dashboard-card:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
}

/* Icons */
.big-icon {
    font-size: 3rem;
}

/* How it works card */
.info-card {
    border-radius: 15px;
    overflow: hidden;
}

.info-card .card-header {
    background: linear-gradient(135deg, #0d6efd, #6610f2);
}

/* Buttons */
.btn {
    border-radius: 25px;
}
</style>
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
  <div class="container-fluid">

    <!-- Brand -->
    <a class="navbar-brand fw-bold" href="user-dashboard.jsp">
      <i class="bi bi-search"></i> Campus Lost & Found
    </a>

    <!-- Hamburger button (appears on mobile) -->
    <button class="navbar-toggler" type="button"
            data-bs-toggle="collapse"
            data-bs-target="#userNav"
            aria-controls="userNav"
            aria-expanded="false"
            aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <!-- Collapsible menu -->
    <div class="collapse navbar-collapse" id="userNav">
      <ul class="navbar-nav ms-auto align-items-lg-center">

        <li class="nav-item me-lg-3 mb-2 mb-lg-0">
          <span class="navbar-text text-white">
            Welcome, <strong><%= user.getName() %></strong>!
          </span>
        </li>

        <li class="nav-item me-lg-2 mb-2 mb-lg-0">
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

<% if (request.getParameter("success") != null) { %>
<div class="alert alert-success alert-dismissible fade show">
<%= request.getParameter("success") %>
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<% } %>

<!-- HERO SECTION -->
<div class="hero text-center">
<h2><i class="bi bi-grid"></i> User Dashboard</h2>
<p class="mb-0">Report, track, and recover lost items easily</p>
</div>

<!-- ACTION CARDS -->
<div class="row g-4">

<div class="col-md-6 col-lg-3">
<div class="card dashboard-card text-center shadow-sm">
<div class="card-body">
<i class="bi bi-exclamation-circle text-danger big-icon"></i>
<h5 class="mt-3">Report Lost Item</h5>
<p class="text-muted">Lost something? Report it here</p>
<a href="report-lost.jsp" class="btn btn-danger w-100">Report Lost</a>
</div>
</div>
</div>

<div class="col-md-6 col-lg-3">
<div class="card dashboard-card text-center shadow-sm">
<div class="card-body">
<i class="bi bi-check-circle text-success big-icon"></i>
<h5 class="mt-3">Report Found Item</h5>
<p class="text-muted">Found something? Report it here</p>
<a href="report-found.jsp" class="btn btn-success w-100">Report Found</a>
</div>
</div>
</div>

<div class="col-md-6 col-lg-3">
<div class="card dashboard-card text-center shadow-sm">
<div class="card-body">
<i class="bi bi-list-ul text-primary big-icon"></i>
<h5 class="mt-3">View Lost Items</h5>
<p class="text-muted">Browse all lost items</p>
<a href="view-lost.jsp" class="btn btn-primary w-100">View Lost</a>
</div>
</div>
</div>

<div class="col-md-6 col-lg-3">
<div class="card dashboard-card text-center shadow-sm">
<div class="card-body">
<i class="bi bi-list-check text-info big-icon"></i>
<h5 class="mt-3">View Found Items</h5>
<p class="text-muted">Browse all found items</p>
<a href="view-found.jsp" class="btn btn-info w-100">View Found</a>
</div>
</div>
</div>

</div>

<!-- HOW IT WORKS -->
<div class="row mt-4">
<div class="col-12">

<div class="card info-card shadow-sm">
<div class="card-header text-white">
<h5 class="mb-0"><i class="bi bi-info-circle"></i> How It Works</h5>
</div>

<div class="card-body">
<div class="row g-4">

<div class="col-md-6">
<h6><i class="bi bi-exclamation-circle text-danger"></i> Lost Something?</h6>
<ol>
<li>Click <strong>Report Lost Item</strong></li>
<li>Fill in item details</li>
<li>Check <strong>View Found Items</strong> regularly</li>
<li>Contact the finder if you see your item</li>
</ol>
</div>

<div class="col-md-6">
<h6><i class="bi bi-check-circle text-success"></i> Found Something?</h6>
<ol>
<li>Click <strong>Report Found Item</strong></li>
<li>Provide item description</li>
<li>Wait for the owner to contact you</li>
<li>Mark as resolved after returning</li>
</ol>
</div>

</div>
</div>
</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
