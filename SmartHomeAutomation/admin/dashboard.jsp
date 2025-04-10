<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String adminUser = (session != null) ? (String) session.getAttribute("adminUser") : null;
    if (adminUser == null) {
        response.sendRedirect("../pages/adminLogin.jsp");
        return;
    }

    Map<String, List<Map<String, String>>> userDevices = new HashMap<>();

    try {
        Class.forName("org.mariadb.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/SmartHome", "root", "admin");

        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM devices");

        while (rs.next()) {
            String userName = rs.getString("user_name");
            Map<String, String> device = new HashMap<>();
            device.put("name", rs.getString("name"));
            device.put("type", rs.getString("type"));
            device.put("status", rs.getString("status"));
            device.put("room", rs.getString("room"));
            device.put("created_at", rs.getString("created_at"));

            userDevices.computeIfAbsent(userName, k -> new ArrayList<>()).add(device);
        }

        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Smart Home Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background: #343a40;
            color: white;
            padding: 15px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar h2 {
            margin: 0;
            font-size: 22px;
        }

        .logout-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
        }

        .logout-btn:hover {
            background: #c82333;
        }

        .container {
            padding: 40px 60px;
        }

        .user-card {
            background: white;
            padding: 25px;
            margin-bottom: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .user-card h4 {
            font-size: 20px;
            margin-bottom: 20px;
            color: #343a40;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        .device-block {
            margin-bottom: 20px;
            padding: 20px;
            background: #f1f1f1;
            border-left: 6px solid #0d6efd;
            border-radius: 6px;
        }

        .device-block h5 {
            margin: 0 0 10px 0;
            font-size: 18px;
            color: #0d6efd;
            display: flex;
            align-items: center;
        }

        .device-block h5 i {
            margin-right: 10px;
        }

        .device-detail {
            margin: 5px 0;
            font-size: 14px;
            color: #333;
        }

        footer {
            background: #343a40;
            color: white;
            text-align: center;
            padding: 15px;
            font-size: 14px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <h2>Smart Home Admin Dashboard</h2>
    <form action="../AdminLogoutServlet" method="get">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<div class="container">
    <h3>Welcome, <%= adminUser %> 👋</h3>
    <%
        for (Map.Entry<String, List<Map<String, String>>> entry : userDevices.entrySet()) {
            String user = entry.getKey();
            List<Map<String, String>> devices = entry.getValue();
    %>
        <div class="user-card">
            <h4><i class="fa fa-user"></i> <%= user %></h4>
            <% for (Map<String, String> d : devices) {
                String icon = "fa-plug";
                String type = d.get("type").toLowerCase();
                if (type.contains("light")) icon = "fa-lightbulb";
                else if (type.contains("fan")) icon = "fa-fan";
                else if (type.contains("pump")) icon = "fa-water";
                else if (type.contains("sensor")) icon = "fa-microchip";
            %>
                <div class="device-block">
                    <h5><i class="fa <%= icon %>"></i> <%= d.get("name") %></h5>
                    <div class="device-detail"><strong>Type:</strong> <%= d.get("type") %></div>
                    <div class="device-detail"><strong>Status:</strong> <%= d.get("status") %></div>
                    <div class="device-detail"><strong>Room:</strong> <%= d.get("room") %></div>
                    <div class="device-detail"><strong>Created At:</strong> <%= d.get("created_at") %></div>
                    <!-- Future use: AngularJS icon binding -->
                    <span class="device-icon" ng-class="getIconClass('<%= d.get("type") %>')"></span>
                </div>
            <% } %>
        </div>
    <% } %>
</div>

<footer>
    &copy; 2025 Smart Home Automation – Admin Panel
</footer>

</body>
</html>
