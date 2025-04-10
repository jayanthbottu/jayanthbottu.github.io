<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<% String userName = (String) session.getAttribute("userName"); if (userName== null) { response.sendRedirect("../login.html"); return; } %>
<!DOCTYPE html>
<html ng-app="deviceApp" ng-controller="DeviceController">
  <head>
    <link rel="icon" type="image/png" href="https://img.icons8.com/fluency/48/smart-home-connection.png" />

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Smart Devices | Smart Home</title>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <style>
      :root {
        --primary-color: #0080ff;
        --primary-dark: #0066cc;
        --secondary-color: #00c2ff;
        --accent-color: #00e5ff;
        --success-color: #2ecc71;
        --danger-color: #e74c3c;
        --warning-color: #f39c12;
        --info-color: #3498db;
        --text-primary: #2c3e50;
        --text-secondary: #7f8c8d;
        --bg-primary: #f4f7fa;
        --bg-secondary: #ffffff;
        --bg-dark: #1a1a2e;
        --shadow-sm: 0 2px 5px rgba(0, 0, 0, 0.08);
        --shadow-md: 0 4px 15px rgba(0, 0, 0, 0.1);
        --shadow-lg: 0 10px 25px rgba(0, 0, 0, 0.12);
        --radius-sm: 8px;
        --radius-md: 12px;
        --radius-lg: 24px;
        --transition-fast: 0.2s ease;
        --transition-normal: 0.3s ease;
        --transition-slow: 0.5s ease;
        --font-light: 300;
        --font-regular: 400;
        --font-medium: 500;
        --font-semibold: 600;
        --font-bold: 700;
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", "San Francisco", "Helvetica Neue", sans-serif;
        background-color: var(--bg-primary);
        color: var(--text-primary);
        margin: 0;
        padding: 0;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        position: relative;
      }

      /* Header styles */
      .header {
        background: linear-gradient(135deg, var(--bg-dark), #16213e);
        color: white;
        padding: 0;
        box-shadow: var(--shadow-md);
        position: sticky;
        top: 0;
        z-index: 1000;
      }

      .header-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 2rem;
        height: 80px;
      }

      .logo {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
        color: white;
      }

      .logo-icon {
        font-size: 24px;
        color: var(--accent-color);
      }

      .logo-text {
        font-size: 22px;
        font-weight: var(--font-semibold);
        letter-spacing: 0.5px;
      }

      .nav-menu {
        display: flex;
        align-items: center;
        gap: 1.5rem;
      }

      .nav-item {
        text-decoration: none;
        color: rgba(255, 255, 255, 0.85);
        font-weight: var(--font-medium);
        padding: 0.5rem 0.75rem;
        border-radius: var(--radius-sm);
        transition: all var(--transition-fast);
        position: relative;
        display: flex;
        align-items: center;
        gap: 6px;
      }

      .nav-item:hover {
        color: white;
        background-color: rgba(255, 255, 255, 0.1);
      }

      .nav-item.active {
        color: white;
        background-color: rgba(255, 255, 255, 0.15);
      }

      .nav-item.active::after {
        content: "";
        position: absolute;
        bottom: -2px;
        left: 10%;
        width: 80%;
        height: 3px;
        border-radius: 2px;
        background-color: var(--accent-color);
      }

      .logout-btn {
        background-color: rgba(255, 255, 255, 0.1);
        color: white;
        border: none;
        padding: 0.6rem 1.2rem;
        border-radius: var(--radius-sm);
        font-weight: var(--font-medium);
        cursor: pointer;
        transition: all var(--transition-fast);
        display: flex;
        align-items: center;
        gap: 8px;
        text-decoration: none;
      }

      .logout-btn:hover {
        background-color: rgba(231, 76, 60, 0.2);
        color: #ff6b6b;
      }

      /* Page title section */
      .page-title-container {
        background: linear-gradient(
            to right,
            rgba(171, 171, 171, 0.9),
            rgba(200, 194, 194, 0.7)
          ),
          url("img/mydev.png") no-repeat center center;
        background-size: cover;
        padding: 2.5rem 0;
        text-align: center;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
      }

      .page-title {
        font-size: 2.2rem;
        font-weight: var(--font-bold);
        color: var(--text-primary);
        margin-bottom: 0.5rem;
      }

      .page-subtitle {
        font-size: 1.1rem;
        color: black;
        max-width: 700px;
        margin: 0 auto;
      }

      /* Main content */
      .main-content {
        flex: 1;
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 2rem;
      }

      /* Device grid layout */
      .devices-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
        gap: 1.5rem;
        margin-top: 1rem;
      }

      .category-header {
        grid-column: 1 / -1;
        margin: 1.5rem 0 0.75rem;
        font-size: 1.4rem;
        font-weight: var(--font-semibold);
        color: var(--text-primary);
        display: flex;
        align-items: center;
        gap: 10px;
      }

      .category-header i {
        color: var(--primary-color);
      }

      .device-card {
        background-color: var(--bg-secondary);
        border-radius: var(--radius-md);
        overflow: hidden;
        box-shadow: var(--shadow-sm);
        transition: transform var(--transition-fast),
          box-shadow var(--transition-fast);
        position: relative;
      }

      .device-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-md);
      }

      .device-header {
        padding: 1.25rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
      }

      .device-title {
        display: flex;
        align-items: center;
        gap: 12px;
      }

      .device-icon {
        width: 42px;
        height: 42px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: rgba(0, 128, 255, 0.1);
        border-radius: 50%;
        color: var(--primary-color);
        font-size: 18px;
      }

      .device-icon.lighting {
        background-color: rgba(255, 193, 7, 0.1);
        color: var(--warning-color);
      }

      .device-icon.climate {
        background-color: rgba(52, 152, 219, 0.1);
        color: var(--info-color);
      }

      .device-icon.security {
        background-color: rgba(46, 204, 113, 0.1);
        color: var(--success-color);
      }

      .device-icon.entertainment {
        background-color: rgba(155, 89, 182, 0.1);
        color: #9b59b6;
      }

      .device-name {
        font-size: 1.1rem;
        font-weight: var(--font-semibold);
        color: var(--text-primary);
        margin: 0;
      }

      /* Toggle switch styles */
      .toggle-container {
        position: relative;
        display: inline-block;
        margin-top: 3rem;
      }

      .switch {
        position: relative;
        display: inline-block;
        width: 52px;
        height: 30px;
      }

      .switch input {
        opacity: 0;
        width: 0;
        height: 0;
      }

      .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: #ccc;
        transition: 0.4s;
        border-radius: 34px;
      }

      .slider:before {
        position: absolute;
        content: "";
        height: 22px;
        width: 22px;
        left: 4px;
        bottom: 4px;
        background-color: white;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
        transition: 0.4s;
        border-radius: 50%;
      }

      input:checked + .slider {
        background-color: var(--success-color);
      }

      input:focus + .slider {
        box-shadow: 0 0 2px var(--success-color);
      }

      input:checked + .slider:before {
        transform: translateX(22px);
      }

      .toggle-label {
        position: absolute;
        top: -24px;
        left: 0;
        right: 0;
        text-align: center;
        font-size: 0.8rem;
        font-weight: var(--font-medium);
        color: var(--text-secondary);
        transition: var(--transition-fast);
      }

      input:checked ~ .toggle-label {
        color: var(--success-color);
      }

      /* Device content */
      .device-content {
        padding: 1.25rem;
      }

      .device-details {
        display: flex;
        flex-direction: column;
        gap: 12px;
      }

      .detail-item {
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .detail-icon {
        width: 32px;
        height: 32px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: rgba(127, 140, 141, 0.1);
        border-radius: 8px;
        color: var(--text-secondary);
        font-size: 14px;
      }

      .detail-text {
        font-size: 0.95rem;
        color: var(--text-secondary);
      }

      .detail-value {
        font-weight: var(--font-medium);
        color: var(--text-primary);
      }

      .device-actions {
        display: flex;
        gap: 10px;
        margin-top: 1.25rem;
        justify-content: flex-end;
      }

      .device-btn {
        padding: 0.5rem 0.75rem;
        border: none;
        border-radius: var(--radius-sm);
        background-color: var(--bg-primary);
        color: var(--text-secondary);
        font-weight: var(--font-medium);
        cursor: pointer;
        transition: all var(--transition-fast);
        display: flex;
        align-items: center;
        gap: 6px;
        font-size: 0.85rem;
      }

      .device-btn:hover {
        background-color: var(--bg-dark);
        color: white;
      }

      .device-btn.settings {
        background-color: rgba(52, 152, 219, 0.1);
        color: var(--info-color);
      }

      .device-btn.settings:hover {
        background-color: var(--info-color);
        color: white;
      }

      /* Status badge */
      .status-badge {
        position: absolute;
        top: 12px;
        right: 12px;
        padding: 0.35rem 0.75rem;
        border-radius: 20px;
        font-size: 0.75rem;
        font-weight: var(--font-medium);
        text-transform: uppercase;
        letter-spacing: 0.5px;
      }

      .status-badge.online {
        background-color: rgba(46, 204, 113, 0.1);
        color: var(--success-color);
      }

      .status-badge.offline {
        background-color: rgba(231, 76, 60, 0.1);
        color: var(--danger-color);
      }

      /* Empty state */
      .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        background-color: var(--bg-secondary);
        border-radius: var(--radius-md);
        box-shadow: var(--shadow-sm);
      }

      .empty-state-icon {
        font-size: 4rem;
        color: #d1d8e0;
        margin-bottom: 1.5rem;
      }

      .empty-state-title {
        font-size: 1.5rem;
        font-weight: var(--font-semibold);
        color: var(--text-primary);
        margin-bottom: 0.75rem;
      }

      .empty-state-msg {
        font-size: 1rem;
        color: var(--text-secondary);
        margin-bottom: 2rem;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
      }

      .add-device-btn {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 0.75rem 1.5rem;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: var(--radius-sm);
        font-weight: var(--font-medium);
        cursor: pointer;
        transition: all var(--transition-fast);
        text-decoration: none;
      }

      .add-device-btn:hover {
        background-color: var(--primary-dark);
        transform: translateY(-2px);
      }

      /* Loading spinner */
      .loading-container {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 4rem 2rem;
        text-align: center;
      }

      .loading-spinner {
        border: 4px solid rgba(0, 0, 0, 0.1);
        border-left-color: var(--primary-color);
        border-radius: 50%;
        width: 50px;
        height: 50px;
        animation: spin 1s linear infinite;
        margin-bottom: 1.5rem;
      }

      @keyframes spin {
        0% {
          transform: rotate(0deg);
        }
        100% {
          transform: rotate(360deg);
        }
      }

      .loading-text {
        font-size: 1.1rem;
        color: var(--text-secondary);
        margin: 0;
      }

      .error-container {
        padding: 2rem;
        text-align: center;
        background-color: rgba(231, 76, 60, 0.05);
        border-radius: var(--radius-md);
        max-width: 600px;
        margin: 2rem auto;
      }

      .error-icon {
        font-size: 3rem;
        color: var(--danger-color);
        margin-bottom: 1rem;
      }

      .error-title {
        font-size: 1.5rem;
        font-weight: var(--font-semibold);
        color: var(--danger-color);
        margin-bottom: 0.75rem;
      }

      .error-message {
        color: var(--text-secondary);
        margin-bottom: 1.5rem;
      }

      .retry-btn {
        padding: 0.75rem 1.5rem;
        background-color: var(--danger-color);
        color: white;
        border: none;
        border-radius: var(--radius-sm);
        font-weight: var(--font-medium);
        cursor: pointer;
        transition: all var(--transition-fast);
      }

      .retry-btn:hover {
        background-color: #c0392b;
      }

      /* Filter section */
      .filter-container {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 2rem;
        padding: 1rem 1.5rem;
        background-color: var(--bg-secondary);
        border-radius: var(--radius-md);
        box-shadow: var(--shadow-sm);
      }

      .filter-tabs {
        display: flex;
        gap: 0.5rem;
      }

      .filter-tab {
        padding: 0.5rem 1rem;
        border-radius: var(--radius-sm);
        background-color: transparent;
        color: var(--text-secondary);
        font-weight: var(--font-medium);
        cursor: pointer;
        transition: all var(--transition-fast);
        border: none;
      }

      .filter-tab:hover {
        background-color: rgba(0, 0, 0, 0.03);
        color: var(--text-primary);
      }

      .filter-tab.active {
        background-color: var(--primary-color);
        color: white;
      }

      .search-box {
        position: relative;
        width: 300px;
      }

      .search-input {
        width: 100%;
        padding: 0.6rem 1rem 0.6rem 2.5rem;
        border: 1px solid rgba(0, 0, 0, 0.1);
        border-radius: var(--radius-sm);
        font-size: 0.95rem;
        transition: all var(--transition-fast);
      }

      .search-input:focus {
        outline: none;
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(0, 128, 255, 0.1);
      }

      .search-icon {
        position: absolute;
        left: 10px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--text-secondary);
        font-size: 0.95rem;
      }

      /* Footer */
      .footer {
        background-color: var(--bg-dark);
        color: rgba(255, 255, 255, 0.8);
        padding: 2.5rem 0;
        margin-top: 3rem;
      }

      .footer-container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 2rem;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
      }

      .footer-column h3 {
        color: white;
        font-size: 1.1rem;
        font-weight: var(--font-semibold);
        margin-bottom: 1.25rem;
        position: relative;
      }

      .footer-column h3::after {
        content: "";
        position: absolute;
        left: 0;
        bottom: -8px;
        width: 30px;
        height: 2px;
        background-color: var(--accent-color);
      }

      .footer-links {
        list-style: none;
        padding: 0;
      }

      .footer-links li {
        margin-bottom: 0.75rem;
      }

      .footer-links a {
        color: rgba(255, 255, 255, 0.6);
        text-decoration: none;
        transition: color var(--transition-fast);
        display: flex;
        align-items: center;
        gap: 8px;
      }

      .footer-links a:hover {
        color: white;
      }

      .footer-contact p {
        display: flex;
        align-items: flex-start;
        gap: 12px;
        margin-bottom: 0.75rem;
        color: rgba(255, 255, 255, 0.6);
      }

      .footer-contact i {
        margin-top: 4px;
        color: var(--accent-color);
      }

      .social-links {
        display: flex;
        gap: 1rem;
        margin-top: 1.5rem;
      }

      .social-link {
        width: 36px;
        height: 36px;
        display: flex;
        align-items: center;
        justify-content: center;
        background-color: rgba(255, 255, 255, 0.1);
        border-radius: 50%;
        color: white;
        transition: all var(--transition-fast);
      }

      .social-link:hover {
        background-color: var(--primary-color);
        transform: translateY(-3px);
      }

      .copyright {
        text-align: center;
        padding-top: 2rem;
        margin-top: 2rem;
        border-top: 1px solid rgba(255, 255, 255, 0.1);
        color: rgba(255, 255, 255, 0.5);
        font-size: 0.9rem;
      }

      /* Responsive adjustments */
      @media (max-width: 992px) {
        .header-container {
          padding: 0 1.5rem;
        }

        .main-content {
          padding: 1.5rem;
        }

        .devices-grid {
          grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        }
      }

      @media (max-width: 768px) {
        .header-container {
          padding: 0 1rem;
          height: 70px;
        }

        .logo-text {
          font-size: 18px;
        }

        .nav-menu {
          gap: 0.75rem;
        }

        .nav-item {
          padding: 0.4rem 0.6rem;
          font-size: 0.9rem;
        }

        .logout-btn {
          padding: 0.4rem 0.8rem;
          font-size: 0.9rem;
        }

        .main-content {
          padding: 1rem;
        }

        .devices-grid {
          grid-template-columns: 1fr;
          gap: 1rem;
        }

        .page-title {
          font-size: 1.8rem;
        }

        .filter-container {
          flex-direction: column;
          gap: 1rem;
          align-items: stretch;
        }

        .search-box {
          width: 100%;
        }
      }
    </style>
  </head>
  <body ng-cloak>
    <!-- Header Section -->
    <header class="header">
      <div class="header-container">
        <a href="dashboard.jsp" class="logo">
          <i class="fas fa-home logo-icon"></i>
          <span class="logo-text">Smart Home</span>
        </a>

        <nav class="nav-menu">
          <a href="dashboard.jsp" class="nav-item">
            <i class="fas fa-tachometer-alt"></i>
            <span>Dashboard</span>
          </a>
          <a href="MyDevices.jsp" class="nav-item active">
            <i class="fas fa-tablet-alt"></i>
            <span>Devices</span>
          </a>
          <a href="AddDevice.jsp" class="nav-item">
            <i class="fas fa-plus-circle"></i>
            <span>Add Device</span>
          </a>
          <a href="LogoutServlet" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
          </a>
        </nav>
      </div>
    </header>

    <!-- Page Title Section -->
    <div class="page-title-container">
      <h1 class="page-title">My Smart Devices</h1>
      <p class="page-subtitle">
        Monitor and control all your connected devices from one central location
      </p>
    </div>

    <!-- Main Content -->
    <main class="main-content">
      <!-- Filter Section -->
      <div class="filter-container">
         

        <div class="search-box">
          <i class="fas fa-search search-icon"></i>
          <input
            type="text"
            class="search-input"
            placeholder="Search devices..."
            ng-model="searchQuery"
          />
        </div>
      </div>

      <!-- Loading State -->
      <div class="loading-container" ng-if="loading">
        <div class="loading-spinner"></div>
        <p class="loading-text">Loading your smart devices...</p>
      </div>

      <!-- Error State -->
      <div class="error-container" ng-if="errorMessage && !loading">
        <i class="fas fa-exclamation-circle error-icon"></i>
        <h3 class="error-title">Oops! Something went wrong</h3>
        <p class="error-message">{{ errorMessage }}</p>
        <button class="retry-btn" ng-click="fetchDevices()">
          <i class="fas fa-sync-alt"></i> Try Again
        </button>
      </div>

      <!-- Empty State -->
      <div
        class="empty-state"
        ng-if="devices.length === 0 && !loading && !errorMessage"
      >
        <i class="fas fa-plug empty-state-icon"></i>
        <h3 class="empty-state-title">No devices found</h3>
        <p class="empty-state-msg">
          You haven't added any smart devices yet. Get started by connecting
          your first device to the system.
        </p>
        <a href="AddDevice.jsp" class="add-device-btn">
          <i class="fas fa-plus"></i> Add New Device
        </a>
      </div>

      <!-- Devices Grid -->
      <div ng-if="devices.length > 0 && !loading && !errorMessage">
        <!-- Living Room Devices -->
        <h2
          class="category-header"
          ng-if="(devices | filter : { room: 'Living Room' }).length > 0"
        >
          <i class="fas fa-couch"></i> Living Room
        </h2>
        <div class="devices-grid">
          <div
            class="device-card"
            ng-repeat="device in devices | filter:{room:'Living Room'} | filter:searchQuery"
          >
            <span
              class="status-badge"
              ng-class="device.status == 'ON' ? 'online' : 'offline'"
            >
              {{ device.status == "ON" ? "Active" : "Inactive" }}
            </span>
            <div class="device-header">
              <div class="device-title">
                <div
                  class="device-icon"
                  ng-class="getDeviceCategory(device.type)"
                >
                  <i ng-class="getDeviceIcon(device.type)"></i>
                </div>
                <h3 class="device-name">{{ device.name }}</h3>
              </div>
              <div class="toggle-container">
                <label class="switch">
                  <input
                    type="checkbox"
                    ng-checked="device.status == 'ON'"
                    ng-click="toggleStatus(device)"
                  />
                  <span class="slider"></span>
                </label>
                <span class="toggle-label">{{ device.status }}</span>
              </div>
            </div>
            <div class="device-content">
              <div class="device-details">
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-tag"></i>
                  </div>
                  <div class="detail-text">
                    Type: <span class="detail-value">{{ device.type }}</span>
                  </div>
                </div>
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-map-marker-alt"></i>
                  </div>
                  <div class="detail-text">
                    Location:
                    <span class="detail-value">{{ device.room }}</span>
                  </div>
                </div>
              </div>
              <div class="device-actions">
                <button class="device-btn settings">
                  <i class="fas fa-cog"></i> Settings
                </button>
              </div>
            </div>
          </div>
        </div>
        <!-- Bedroom Devices -->
        <h2
          class="category-header"
          ng-if="(devices | filter : { room: 'Bedroom' }).length > 0"
        >
          <i class="fas fa-bed"></i> Bedroom
        </h2>
        <div class="devices-grid">
          <div
            class="device-card"
            ng-repeat="device in devices | filter:{room:'Bedroom'} | filter:searchQuery"
          >
            <span
              class="status-badge"
              ng-class="device.status == 'ON' ? 'online' : 'offline'"
            >
              {{ device.status == "ON" ? "Active" : "Inactive" }}
            </span>
            <div class="device-header">
              <div class="device-title">
                <div
                  class="device-icon"
                  ng-class="getDeviceCategory(device.type)"
                >
                  <i ng-class="getDeviceIcon(device.type)"></i>
                </div>
                <h3 class="device-name">{{ device.name }}</h3>
              </div>
              <div class="toggle-container">
                <label class="switch">
                  <input
                    type="checkbox"
                    ng-checked="device.status == 'ON'"
                    ng-click="toggleStatus(device)"
                  />
                  <span class="slider"></span>
                </label>
                <span class="toggle-label">{{ device.status }}</span>
              </div>
            </div>
            <div class="device-content">
              <div class="device-details">
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-tag"></i>
                  </div>
                  <div class="detail-text">
                    Type: <span class="detail-value">{{ device.type }}</span>
                  </div>
                </div>
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-map-marker-alt"></i>
                  </div>
                  <div class="detail-text">
                    Location:
                    <span class="detail-value">{{ device.room }}</span>
                  </div>
                </div>
              </div>
              <div class="device-actions">
                <button class="device-btn settings">
                  <i class="fas fa-cog"></i> Settings
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Kitchen Devices -->
        <h2
          class="category-header"
          ng-if="(devices | filter : { room: 'Kitchen' }).length > 0"
        >
          <i class="fas fa-utensils"></i> Kitchen
        </h2>
        <div class="devices-grid">
          <div
            class="device-card"
            ng-repeat="device in devices | filter:{room:'Kitchen'} | filter:searchQuery"
          >
            <span
              class="status-badge"
              ng-class="device.status == 'ON' ? 'online' : 'offline'"
            >
              {{ device.status == "ON" ? "Active" : "Inactive" }}
            </span>
            <div class="device-header">
              <div class="device-title">
                <div
                  class="device-icon"
                  ng-class="getDeviceCategory(device.type)"
                >
                  <i ng-class="getDeviceIcon(device.type)"></i>
                </div>
                <h3 class="device-name">{{ device.name }}</h3>
              </div>
              <div class="toggle-container">
                <label class="switch">
                  <input
                    type="checkbox"
                    ng-checked="device.status == 'ON'"
                    ng-click="toggleStatus(device)"
                  />
                  <span class="slider"></span>
                </label>
                <span class="toggle-label">{{ device.status }}</span>
              </div>
            </div>
            <div class="device-content">
              <div class="device-details">
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-tag"></i>
                  </div>
                  <div class="detail-text">
                    Type: <span class="detail-value">{{ device.type }}</span>
                  </div>
                </div>
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-map-marker-alt"></i>
                  </div>
                  <div class="detail-text">
                    Location:
                    <span class="detail-value">{{ device.room }}</span>
                  </div>
                </div>
              </div>
              <div class="device-actions">
                <button class="device-btn settings">
                  <i class="fas fa-cog"></i> Settings
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Bathroom Devices -->
        <h2
          class="category-header"
          ng-if="(devices | filter : { room: 'Bathroom' }).length > 0"
        >
          <i class="fas fa-bath"></i> Bathroom
        </h2>
        <div class="devices-grid">
          <div
            class="device-card"
            ng-repeat="device in devices | filter:{room:'Bathroom'} | filter:searchQuery"
          >
            <span
              class="status-badge"
              ng-class="device.status == 'ON' ? 'online' : 'offline'"
            >
              {{ device.status == "ON" ? "Active" : "Inactive" }}
            </span>
            <div class="device-header">
              <div class="device-title">
                <div
                  class="device-icon"
                  ng-class="getDeviceCategory(device.type)"
                >
                  <i ng-class="getDeviceIcon(device.type)"></i>
                </div>
                <h3 class="device-name">{{ device.name }}</h3>
              </div>
              <div class="toggle-container">
                <label class="switch">
                  <input
                    type="checkbox"
                    ng-checked="device.status == 'ON'"
                    ng-click="toggleStatus(device)"
                  />
                  <span class="slider"></span>
                </label>
                <span class="toggle-label">{{ device.status }}</span>
              </div>
            </div>
            <div class="device-content">
              <div class="device-details">
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-tag"></i>
                  </div>
                  <div class="detail-text">
                    Type: <span class="detail-value">{{ device.type }}</span>
                  </div>
                </div>
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-map-marker-alt"></i>
                  </div>
                  <div class="detail-text">
                    Location:
                    <span class="detail-value">{{ device.room }}</span>
                  </div>
                </div>
              </div>
              <div class="device-actions">
                <button class="device-btn settings">
                  <i class="fas fa-cog"></i> Settings
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Office Devices -->
        <h2
          class="category-header"
          ng-if="(devices | filter : { room: 'Office' }).length > 0"
        >
          <i class="fas fa-briefcase"></i> Office
        </h2>
        <div class="devices-grid">
          <div
            class="device-card"
            ng-repeat="device in devices | filter:{room:'Office'} | filter:searchQuery"
          >
            <span
              class="status-badge"
              ng-class="device.status == 'ON' ? 'online' : 'offline'"
            >
              {{ device.status == "ON" ? "Active" : "Inactive" }}
            </span>
            <div class="device-header">
              <div class="device-title">
                <div
                  class="device-icon"
                  ng-class="getDeviceCategory(device.type)"
                >
                  <i ng-class="getDeviceIcon(device.type)"></i>
                </div>
                <h3 class="device-name">{{ device.name }}</h3>
              </div>
              <div class="toggle-container">
                <label class="switch">
                  <input
                    type="checkbox"
                    ng-checked="device.status == 'ON'"
                    ng-click="toggleStatus(device)"
                  />
                  <span class="slider"></span>
                </label>
                <span class="toggle-label">{{ device.status }}</span>
              </div>
            </div>
            <div class="device-content">
              <div class="device-details">
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-tag"></i>
                  </div>
                  <div class="detail-text">
                    Type: <span class="detail-value">{{ device.type }}</span>
                  </div>
                </div>
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-map-marker-alt"></i>
                  </div>
                  <div class="detail-text">
                    Location:
                    <span class="detail-value">{{ device.room }}</span>
                  </div>
                </div>
              </div>
              <div class="device-actions">
                <button class="device-btn settings">
                  <i class="fas fa-cog"></i> Settings
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Other Devices -->
        <h2
          class="category-header"
          ng-if="(devices | filter : customRoomFilter).length > 0"
        >
          <i class="fas fa-ellipsis-h"></i> Other Rooms
        </h2>
        <div class="devices-grid">
          <div
            class="device-card"
            ng-repeat="device in devices | filter:customRoomFilter | filter:searchQuery"
          >
            <span
              class="status-badge"
              ng-class="device.status == 'ON' ? 'online' : 'offline'"
            >
              {{ device.status == "ON" ? "Active" : "Inactive" }}
            </span>
            <div class="device-header">
              <div class="device-title">
                <div
                  class="device-icon"
                  ng-class="getDeviceCategory(device.type)"
                >
                  <i ng-class="getDeviceIcon(device.type)"></i>
                </div>
                <h3 class="device-name">{{ device.name }}</h3>
              </div>
              <div class="toggle-container">
                <label class="switch">
                  <input
                    type="checkbox"
                    ng-checked="device.status == 'ON'"
                    ng-click="toggleStatus(device)"
                  />
                  <span class="slider"></span>
                </label>
                <span class="toggle-label">{{ device.status }}</span>
              </div>
            </div>
            <div class="device-content">
              <div class="device-details">
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-tag"></i>
                  </div>
                  <div class="detail-text">
                    Type: <span class="detail-value">{{ device.type }}</span>
                  </div>
                </div>
                <div class="detail-item">
                  <div class="detail-icon">
                    <i class="fas fa-map-marker-alt"></i>
                  </div>
                  <div class="detail-text">
                    Location:
                    <span class="detail-value">{{ device.room }}</span>
                  </div>
                </div>
              </div>
              <div class="device-actions">
                <button class="device-btn settings">
                  <i class="fas fa-cog"></i> Settings
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
      <div class="footer-container">
        <div class="footer-column">
          <h3>Smart Home</h3>
          <ul class="footer-links">
            <li>
              <a href="about.jsp"
                ><i class="fas fa-info-circle"></i> About Us</a
              >
            </li>
            <li>
              <a href="features.jsp"><i class="fas fa-star"></i> Features</a>
            </li>
            <li>
              <a href="pricing.jsp"><i class="fas fa-tag"></i> Pricing</a>
            </li>
            <li>
              <a href="faq.jsp"><i class="fas fa-question-circle"></i> FAQ</a>
            </li>
          </ul>
        </div>
        <div class="footer-column">
          <h3>Support</h3>
          <ul class="footer-links">
            <li>
              <a href="help.jsp"
                ><i class="fas fa-hands-helping"></i> Help Center</a
              >
            </li>
            <li>
              <a href="contact.jsp"
                ><i class="fas fa-envelope"></i> Contact Us</a
              >
            </li>
            <li>
              <a href="documentation.jsp"
                ><i class="fas fa-book"></i> Documentation</a
              >
            </li>
            <li>
              <a href="community.jsp"><i class="fas fa-users"></i> Community</a>
            </li>
          </ul>
        </div>
        <div class="footer-column">
          <h3>Legal</h3>
          <ul class="footer-links">
            <li>
              <a href="terms.jsp"
                ><i class="fas fa-file-contract"></i> Terms of Service</a
              >
            </li>
            <li>
              <a href="privacy.jsp"
                ><i class="fas fa-shield-alt"></i> Privacy Policy</a
              >
            </li>
            <li>
              <a href="cookies.jsp"
                ><i class="fas fa-cookie-bite"></i> Cookie Policy</a
              >
            </li>
            <li>
              <a href="licenses.jsp"
                ><i class="fas fa-certificate"></i> Licenses</a
              >
            </li>
          </ul>
        </div>
        <div class="footer-column">
          <h3>Contact Us</h3>
          <div class="footer-contact">
            <p><i class="fas fa-map-marker-alt"></i> SR University, Warangal</p>
            <p><i class="fas fa-phone-alt"></i> +91 XXX XXX XXXX</p>
            <p><i class="fas fa-envelope"></i> support@smarthome.com</p>
          </div>
          <div class="social-links">
            <a href="#" class="social-link"
              ><i class="fab fa-facebook-f"></i
            ></a>
            <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
            <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
            <a href="#" class="social-link"
              ><i class="fab fa-linkedin-in"></i
            ></a>
          </div>
        </div>
      </div>
      <div class="copyright">&copy; 2025 Smart Home. All rights reserved.</div>
    </footer>

    <script>
      const app = angular.module("deviceApp", []);

      app.controller("DeviceController", function ($scope, $http) {
        $scope.devices = [];
        $scope.filteredDevices = [];
        $scope.statusFilter = "ALL";
        $scope.hasError = false;

        const contextPath = "<%= request.getContextPath() %>";
        const userName = "<%= (String) session.getAttribute("userName") %>";

        // Fetch devices
        $http.get(contextPath + "/FetchDevicesServlet?userName=" + userName)
          .then(function (response) {
            if (Array.isArray(response.data)) {
              $scope.devices = response.data;
              $scope.applyFilter();
            } else {
              $scope.hasError = true;
            }
          })
          .catch(function () {
            $scope.hasError = true;
          });

        // Toggle status
        $scope.toggleStatus = function (device) {
          let newStatus = device.status === "ON" ? "OFF" : "ON";
          $http.post(contextPath + "/ToggleDeviceServlet", {
            deviceName: device.name,
            newStatus: newStatus,
            userName: userName
          }).then(function (response) {
            if (response.data === "success") {
              device.status = newStatus;
              $scope.applyFilter();
            } else {
              alert("Failed to toggle device.");
            }
          });
        };

        // Filter logic
        $scope.setFilter = function (filterValue, event) {
          $scope.statusFilter = filterValue;
          $scope.applyFilter();

          // UI toggle active class
          const buttons = document.querySelectorAll(".filter-tab");
          buttons.forEach(btn => btn.classList.remove("active"));
          event.target.classList.add("active");
        };

        $scope.applyFilter = function () {
          if ($scope.statusFilter === "ALL") {
            $scope.filteredDevices = $scope.devices;
          } else {
            $scope.filteredDevices = $scope.devices.filter(function (device) {
              return device.status === $scope.statusFilter;
            });
          }
        };

        $scope.getDeviceIcon = function(type) {
            // Normalize the input type to lowercase for consistent matching
            type = type.toLowerCase();
        
            // Determine the appropriate icon based on the device type
            if (type.includes('light') || type.includes('lamp')) {
                // Lights and lamps
                return 'fas fa-lightbulb';
            } else if (type.includes('tv') || type.includes('television')) {
                // Televisions
                return 'fas fa-tv';
            } else if (type.includes('thermostat') || type.includes('air conditioner') || type.includes('heating')) {
                // Climate control devices
                return 'fas fa-temperature-low';
            } else if (type.includes('air purifier') || type.includes('fan') || type.includes('ventilator')) {
                // Air quality and ventilation devices
                return 'fas fa-wind';
            } else if (type.includes('refrigerator') || type.includes('fridge') || type.includes('freezer')) {
                // Refrigeration devices
                return 'fas fa-snowflake';
            } else if (type.includes('coffee') || type.includes('kettle') || type.includes('brewer')) {
                // Kitchen appliances for beverages
                return 'fas fa-coffee';
            } else if (type.includes('heater') || type.includes('radiator') || type.includes('boiler')) {
                // Heating devices
                return 'fas fa-fire';
            } else if (type.includes('computer') || type.includes('laptop') || type.includes('desktop')) {
                // Computing devices
                return 'fas fa-desktop';
            } else if (type.includes('door') || type.includes('gate') || type.includes('lock')) {
                // Entry points and locks
                return 'fas fa-door-closed';
            } else if (type.includes('camera') || type.includes('security camera') || type.includes('cctv')) {
                // Security cameras
                return 'fas fa-video';
            } else if (type.includes('speaker') || type.includes('sound system') || type.includes('audio')) {
                // Audio devices
                return 'fas fa-volume-up';
            } else if (type.includes('sensor') || type.includes('detector') || type.includes('alarm')) {
                // Sensors and detectors
                return 'fas fa-shield-alt';
            } else if (type.includes('microwave') || type.includes('oven') || type.includes('stove')) {
                // Cooking appliances
                return 'fas fa-burn';
            } else if (type.includes('washing machine') || type.includes('dryer') || type.includes('laundry')) {
                // Laundry appliances
                return 'fas fa-tshirt';
            } else if (type.includes('vacuum') || type.includes('cleaner')) {
                // Cleaning devices
                return 'fas fa-broom';
            } else if (type.includes('blinds') || type.includes('curtain') || type.includes('shade')) {
                // Window coverings
                return 'fas fa-window-maximize';
            } else if (type.includes('charger') || type.includes('power supply') || type.includes('adapter')) {
                // Power-related devices
                return 'fas fa-plug';
            } else if (type.includes('robot') || type.includes('assistant') || type.includes('smart assistant')) {
                // Smart assistants and robots
                return 'fas fa-robot';
            } else if (type.includes('garden') || type.includes('irrigation') || type.includes('sprinkler')) {
                // Garden and irrigation systems
                return 'fas fa-seedling';
            } else if (type.includes('pool') || type.includes('spa') || type.includes('hot tub')) {
                // Pool and spa systems
                return 'fas fa-swimmer';
            } else if (type.includes('garage') || type.includes('garage door')) {
                // Garage doors
                return 'fas fa-warehouse';
            } else if (type.includes('printer') || type.includes('scanner') || type.includes('copier')) {
                // Office equipment
                return 'fas fa-print';
            } else if (type.includes('router') || type.includes('modem') || type.includes('network')) {
                // Networking devices
                return 'fas fa-network-wired';
            } else if (type.includes('phone') || type.includes('mobile') || type.includes('cell')) {
                // Mobile phones
                return 'fas fa-mobile-alt';
            } else if (type.includes('tablet') || type.includes('pad')) {
                // Tablets
                return 'fas fa-tablet-alt';
            } else if (type.includes('clock') || type.includes('watch') || type.includes('time')) {
                // Timekeeping devices
                return 'fas fa-clock';
            } else {
                // Default fallback for unknown device types
                return 'fas fa-question-circle';
            }
        };
      });

      
    </script>
  </body>
</html>
