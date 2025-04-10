<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Login</title>
  <style>
    body {
      font-family: Arial;
      background: #f0f4f7;
      margin: 0;
      padding: 0;
    }

    .header {
      background-color: #343a40;
      color: white;
      padding: 15px 30px;
      font-size: 20px;
    }

    .header a {
      color: white;
      text-decoration: none;
      font-weight: bold;
    }

    .center-box {
      display: flex;
      justify-content: center;
      align-items: center;
      height: calc(100vh - 60px); /* Adjust height because of header */
    }

    .login-box {
      background: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
      width: 300px;
    }

    input, button {
      display: block;
      width: 100%;
      padding: 10px;
      margin: 10px 0;
    }

    button {
      background-color: #007bff;
      color: white;
      border: none;
      cursor: pointer;
    }

    button:hover {
      background-color: #0056b3;
    }
  </style>
</head>
<body>

  <div class="header">
    <a href="../index.html">Smart Home</a>
  </div>

  <div class="center-box">
    <div class="login-box">
      <h2>Admin Login</h2>
      <form action="../AdminLoginServlet" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Login</button>
      </form>
    </div>
  </div>

</body>
</html>
