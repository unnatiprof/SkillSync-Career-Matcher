<%@page import="jakarta.servlet.annotation.WebServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to bottom right, #e6f5ff, #cceaff);
      margin: 0;
      padding: 0;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      animation: fadeIn 1.5s ease-in-out;
    }

    .container {
      background: #ffffff;
      padding: 40px;
      border-radius: 16px;
      text-align: center;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
      width: 400px;
      animation: slideUp 1s ease-in-out;
    }

    h1 {
      font-size: 28px;
      margin-bottom: 15px;
      color: #0a3d62;
      animation: fadeInDown 1s ease-in-out;
    }

    p {
      font-size: 18px;
      color: #333;
      margin-bottom: 30px;
      animation: fadeIn 1.5s ease-in-out;
    }

    .btn {
      display: inline-block;
      padding: 14px 28px;
      margin: 10px;
      font-size: 16px;
      font-weight: bold;
      border-radius: 10px;
      border: none;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-primary {
      background: #3498db;
      color: white;
      box-shadow: 0 4px 10px rgba(52, 152, 219, 0.4);
    }

    .btn-primary:hover {
      background: #2980b9;
      transform: scale(1.05);
    }

    .btn-secondary {
      background: white;
      border: 2px solid #3498db;
      color: #3498db;
    }

    .btn-secondary:hover {
      background: #3498db;
      color: white;
      transform: scale(1.05);
    }

    /* Animations */
    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    @keyframes fadeInDown {
      from { opacity: 0; transform: translateY(-20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @keyframes slideUp {
      from { opacity: 0; transform: translateY(40px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>


<body>

  <div class="container">
    <h1>Courses</h1>
    <p>You are not enrolled in any courses yet.<br>Browse and join available courses now!</p>
    <a href="browse_courses.jsp"><button class="btn btn-primary">Browse Courses</button></a>
    <br>
    <a href="dashboard.jsp"><button class="btn btn-secondary">Return</button></a>
  </div>
</body>
</html>