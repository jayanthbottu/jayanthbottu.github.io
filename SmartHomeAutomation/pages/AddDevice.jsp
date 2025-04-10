<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%
    String userName = (String) session.getAttribute("userName");
    if (userName == null) {
        response.sendRedirect("login.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Add New Device | Smart Home Solutions</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- CSS Styles -->
    <style>
        :root {
            --primary: #2c3e50;
            --primary-light: #34495e;
            --accent: #3498db;
            --accent-hover: #2980b9;
            --success: #27ae60;
            --background: #ecf0f1;
            --card-bg: #ffffff;
            --text: #333333;
            --text-light: #7f8c8d;
            --border: #bdc3c7;
            --shadow: rgba(0, 0, 0, 0.1);
            --shadow-hover: rgba(0, 0, 0, 0.2);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--background);
            color: var(--text);
            line-height: 1.6;
            position: relative;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        header {
            background: var(--primary);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px var(--shadow);
        }

        .header-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            font-size: 1.5rem;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 0.9rem;
        }

        .user-greeting {
            text-align: right;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            background: var(--accent);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
        }

        /* Main Content */
        main {
            max-width: 1200px;
            width: 100%;
            margin: 2rem auto;
            flex: 1;
            padding: 0 1rem;
        }

        .page-title {
            margin-bottom: 1.5rem;
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary);
            border-bottom: 2px solid var(--primary-light);
            padding-bottom: 0.5rem;
        }

        .card {
            background: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 4px 6px var(--shadow);
            padding: 2rem;
            transition: var(--transition);
        }

        .card:hover {
            box-shadow: 0 8px 15px var(--shadow-hover);
            transform: translateY(-5px);
        }

        .form-header {
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .form-header h2 {
            font-size: 1.8rem;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .form-header p {
            color: var(--text-light);
        }

        .form-group {
            margin-bottom: 1.2rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--primary);
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border);
            border-radius: 6px;
            background: #f9f9f9;
            transition: var(--transition);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--accent);
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        .form-control:hover {
            border-color: var(--primary-light);
        }

        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 5px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 5px;
            cursor: pointer;
            padding: 5px;
            border-radius: 4px;
            transition: var(--transition);
        }

        .radio-option:hover {
            background: rgba(52, 152, 219, 0.1);
        }

        .radio-option input {
            cursor: pointer;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary {
            background: var(--accent);
        }

        .btn-primary:hover {
            background: var(--accent-hover);
        }

        .btn-block {
            display: block;
            width: 100%;
        }

        .btn-with-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        /* Footer */
        footer {
            background: var(--primary);
            color: white;
            padding: 1rem;
            text-align: center;
            font-size: 0.9rem;
            margin-top: auto;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .footer-links {
            display: flex;
            gap: 20px;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-links a:hover {
            color: var(--accent);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .header-container {
                flex-direction: column;
                gap: 1rem;
            }

            .user-info {
                justify-content: center;
                width: 100%;
            }

            .footer-content {
                flex-direction: column;
                gap: 1rem;
            }

            .card {
                padding: 1.5rem;
            }
        }
    </style>
    <link rel="icon" type="image/png" href="https://img.icons8.com/fluency/48/smart-home-connection.png" />

</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="header-container">
            <div class="logo">
                <i class="fas fa-home"></i>
                <span>Smart Home Solutions</span>
            </div>
            <div class="user-info">
                <div class="user-greeting">
                    <p>Welcome back,</p>
                    <strong><%= userName %></strong>
                </div>
                <div class="user-avatar">
                    <i class="fas fa-user"></i>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <h1 class="page-title">Device Management</h1>
        <div class="card">
            <div class="form-header">
                <h2>Add New Device</h2>
                <p>Configure and add a new smart device to your home network</p>
            </div>
            <form action="/SmartHomeAutomation/AddDeviceServlet" method="post">
                <div class="form-group">
                    <label for="name">Device Name</label>
                    <input type="text" class="form-control" name="name" id="name" placeholder="Enter a unique name for your device" required />
                </div>

                <div class="form-group">
                    <label for="type">Device Type</label>
                    <select class="form-control" name="type" id="type" required>
                        <option value="" disabled selected>Select device category</option>
                        <option value="Lighting">Lighting</option>
                        <option value="Cooling">Cooling</option>
                        <option value="Temperature Control">Temperature Control</option>
                        <option value="Surveillance">Surveillance</option>
                        <option value="Irrigation">Irrigation</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Initial Status</label>
                    <div class="radio-group">
                        <label class="radio-option">
                            <input type="radio" name="status" value="ON" checked />
                            <span>Active (ON)</span>
                        </label>
                        <label class="radio-option">
                            <input type="radio" name="status" value="OFF" />
                            <span>Standby (OFF)</span>
                        </label>
                    </div>
                </div>

                <div class="form-group">
                    <label for="room">Location</label>
                    <select class="form-control" name="room" id="room" required>
                        <option value="" disabled selected>Select room location</option>
                        <option value="Living Room">Living Room</option>
                        <option value="Bedroom">Bedroom</option>
                        <option value="Kitchen">Kitchen</option>
                        <option value="Bathroom">Bathroom</option>
                        <option value="Balcony">Balcony</option>
                    </select>
                </div>

                <input type="hidden" name="user_name" value="<%= userName %>" />

                <button type="submit" class="btn btn-primary btn-block btn-with-icon">
                    <i class="fas fa-plus-circle"></i>
                    <span>Add Device</span>
                </button>
            </form>
        </div>
    </main>

    <!-- Footer Section -->
    <footer>
        <div class="footer-content">
            <p>&copy; 2023 Smart Home Solutions. All rights reserved.</p>
            <div class="footer-links">
                <a href="#"><i class="fas fa-question-circle"></i> Help</a>
                <a href="#"><i class="fas fa-envelope"></i> support@smarthome.com</a>
            </div>
        </div>
    </footer>
</body>
</html>