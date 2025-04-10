<%@ page session="true" %> <%@ page contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <link rel="icon" type="image/png" href="https://img.icons8.com/fluency/48/smart-home-connection.png" />

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Smart Home Dashboard</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
    />
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>

    <style>
      :root {
        --primary-color: #0080ff;
        --secondary-color: #00c2ff;
        --accent-color: #ffd700;
        --dark-bg: rgba(11, 15, 25, 0.85);
        --card-bg: rgba(16, 24, 38, 0.9);
        --text-primary: #ffffff;
        --text-secondary: #e0e0e0;
        --text-accent: #00e5ff;
        --shadow-color: rgba(0, 196, 255, 0.2);
        --transition-speed: 0.3s;
      }

      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(rgba(0, 0, 30, 0.7), rgba(0, 0, 30, 0.7)),
          url("pages/img/smarthome.png") no-repeat center center fixed;
        background-size: cover;
        color: var(--text-primary);
        line-height: 1.6;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
      }

      body::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: radial-gradient(
          circle at center,
          transparent 0%,
          rgba(0, 0, 30, 0.4) 100%
        );
        z-index: -1;
      }

      header {
        background-color: var(--dark-bg);
        padding: 1.2rem 2rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 20px rgba(0, 217, 255, 0.15);
        position: relative;
        z-index: 10;
      }

      .logo {
        display: flex;
        align-items: center;
        gap: 0.8rem;
        font-size: 1.8rem;
        font-weight: 600;
        letter-spacing: 1px;
        text-transform: uppercase;
        color: var(--text-primary);
      }

      .logo i {
        color: var(--secondary-color);
        font-size: 2rem;
      }

      .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 2rem;
      }

      .dashboard {
        display: flex;
        flex-direction: column;
        gap: 2.5rem;
        animation: fadeIn 1s ease-out;
      }

      .welcome-card {
        background-color: var(--card-bg);
        border-radius: 15px;
        padding: 2rem;
        display: flex;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        overflow: hidden;
        position: relative;
        z-index: 1;
      }

      .welcome-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 5px;
        background: linear-gradient(
          90deg,
          var(--primary-color),
          var(--secondary-color)
        );
        z-index: 2;
      }

      .profile-section {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-right: 2rem;
        position: relative;
      }

      .profile-pic {
        position: relative;
        margin-bottom: 5rem;
        margin-top: 3rem;
      }

      .profile-pic img {
        width: 150px;
        height: 150px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid var(--secondary-color);
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        transition: all var(--transition-speed) ease;
      }

      .profile-pic::after {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border-radius: 50%;
        background: radial-gradient(
          circle at center,
          transparent 60%,
          rgba(0, 217, 255, 0.2) 100%
        );
        pointer-events: none;
      }

      .profile-pic img:hover {
        transform: scale(1.05);
        box-shadow: 0 8px 25px rgba(0, 200, 255, 0.4);
      }

      .status-indicator {
        position: absolute;
        bottom: 10px;
        right: 10px;
        width: 20px;
        height: 20px;
        background-color: #4caf50;
        border-radius: 50%;
        border: 3px solid white;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
      }

      .user-info {
        flex: 2;
        padding-left: 2rem;
        border-left: 1px solid rgba(255, 255, 255, 0.1);
      }

      .greeting {
        font-size: 2rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
        color: var(--text-accent);
        position: relative;
        display: inline-block;
        animation: slideInRight 0.8s ease-out;
      }

      .greeting::after {
        content: "";
        position: absolute;
        bottom: -10px;
        left: 0;
        width: 50px;
        height: 3px;
        background: linear-gradient(90deg, var(--secondary-color), transparent);
      }

      .info-item {
        margin-bottom: 1rem;
        display: flex;
        align-items: center;
        animation: fadeIn 1s ease-out;
        animation-fill-mode: both;
      }

      .info-item:nth-child(2) {
        animation-delay: 0.2s;
      }

      .info-item:nth-child(3) {
        animation-delay: 0.4s;
      }

      .info-item i {
        min-width: 30px;
        margin-right: 1rem;
        color: var(--secondary-color);
        font-size: 1.2rem;
      }

      .info-label {
        font-size: 1rem;
        color: var(--text-secondary);
        margin-right: 0.5rem;
      }

      .info-value {
        font-weight: 600;
        color: var(--text-primary);
      }

      .role-badge {
        display: inline-block;
        padding: 0.3rem 1rem;
        background: linear-gradient(
          90deg,
          var(--primary-color),
          var(--secondary-color)
        );
        border-radius: 20px;
        font-size: 0.9rem;
        font-weight: 600;
        color: white;
        box-shadow: 0 3px 10px rgba(0, 150, 255, 0.3);
      }

      .quick-stats {
        display: flex;
        justify-content: space-between;
        gap: 1.5rem;
        margin-top: 2rem;
      }

      .stat-card {
        flex: 1;
        background-color: rgba(255, 255, 255, 0.05);
        border-radius: 10px;
        padding: 1rem;
        display: flex;
        align-items: center;
        transition: all var(--transition-speed) ease;
      }

      .stat-card:hover {
        background-color: rgba(255, 255, 255, 0.1);
        transform: translateY(-5px);
      }

      .stat-icon {
        min-width: 50px;
        height: 50px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 1rem;
        font-size: 1.5rem;
      }

      .stat-card:nth-child(1) .stat-icon {
        background-color: rgba(33, 150, 243, 0.2);
        color: #2196f3;
      }

      .stat-card:nth-child(2) .stat-icon {
        background-color: rgba(76, 175, 80, 0.2);
        color: #4caf50;
      }

      .stat-card:nth-child(3) .stat-icon {
        background-color: rgba(255, 193, 7, 0.2);
        color: #ffc107;
      }

      .stat-info h4 {
        font-size: 0.9rem;
        color: var(--text-secondary);
        margin-bottom: 0.3rem;
      }

      .stat-info p {
        font-size: 1.3rem;
        font-weight: 600;
        color: var(--text-primary);
      }

      .action-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-top: 1rem;
      }

      .action-card {
        background-color: var(--card-bg);
        border-radius: 15px;
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        transition: all var(--transition-speed) ease;
        cursor: pointer;
        overflow: hidden;
        position: relative;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
      }

      .action-card::before {
        content: "";
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        height: 4px;
        background: linear-gradient(
          90deg,
          var(--primary-color),
          var(--secondary-color)
        );
        z-index: 1;
        opacity: 0;
        transition: opacity var(--transition-speed) ease;
      }

      .action-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
      }

      .action-card:hover::before {
        opacity: 1;
      }

      .action-icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: rgba(0, 150, 255, 0.1);
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 1.2rem;
        font-size: 1.8rem;
        color: var(--secondary-color);
        transition: all var(--transition-speed) ease;
      }

      .action-card:hover .action-icon {
        background-color: var(--primary-color);
        color: white;
        transform: scale(1.1);
      }

      .action-title {
        font-size: 1.2rem;
        font-weight: 600;
        margin-bottom: 0.8rem;
        color: var(--text-primary);
      }

      .action-desc {
        font-size: 0.9rem;
        color: var(--text-secondary);
        margin-bottom: 1.5rem;
      }

      .action-btn {
        padding: 0.7rem 1.5rem;
        background: linear-gradient(
          90deg,
          var(--primary-color),
          var(--secondary-color)
        );
        border: none;
        border-radius: 30px;
        color: white;
        font-weight: 600;
        cursor: pointer;
        transition: all var(--transition-speed) ease;
        position: relative;
        overflow: hidden;
        z-index: 1;
      }

      .action-btn::before {
        content: "";
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(255, 255, 255, 0.2),
          transparent
        );
        transition: left 0.7s ease;
        z-index: -1;
      }

      .action-card:hover .action-btn::before {
        left: 100%;
      }

      .logout-btn {
        padding: 0.6rem 1.2rem;
        background-color: rgba(255, 255, 255, 0.1);
        color: var(--text-primary);
        border: none;
        border-radius: 30px;
        font-weight: 500;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: all var(--transition-speed) ease;
        text-decoration: none;
      }

      .logout-btn i {
        font-size: 1rem;
      }

      .logout-btn:hover {
        background-color: rgba(255, 59, 59, 0.2);
        color: #ff5757;
        transform: translateY(-2px);
      }

      /* Responsive adjustments */
      @media (max-width: 992px) {
        .welcome-card {
          flex-direction: column;
        }

        .profile-section {
          margin-bottom: 2rem;
          padding-right: 0;
        }

        .user-info {
          padding-left: 0;
          border-left: none;
          border-top: 1px solid rgba(255, 255, 255, 0.1);
          padding-top: 2rem;
        }

        .quick-stats {
          flex-direction: column;
        }
      }

      @media (max-width: 768px) {
        .container {
          padding: 1rem;
        }

        .action-cards {
          grid-template-columns: 1fr;
        }
      }

      /* Animations */
      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(20px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      @keyframes slideInRight {
        from {
          opacity: 0;
          transform: translateX(-30px);
        }
        to {
          opacity: 1;
          transform: translateX(0);
        }
      }

      @keyframes pulse {
        0% {
          box-shadow: 0 0 0 0 rgba(0, 194, 255, 0.7);
        }
        70% {
          box-shadow: 0 0 0 10px rgba(0, 194, 255, 0);
        }
        100% {
          box-shadow: 0 0 0 0 rgba(0, 194, 255, 0);
        }
      }
    </style>
  </head>
  <body>
    <header>
      <div class="logo">
        <i class="fas fa-home"></i>
        <span>Smart Home</span>
      </div>
      <a href="../LogoutServlet" class="logout-btn">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
      </a>
    </header>

    <div class="container">
      <div class="dashboard">
        <div class="welcome-card">
          <div class="profile-section">
            <div class="profile-pic">
              <img src="avatar.png" alt="User Avatar" />
              <div class="status-indicator"></div>
            </div>
          </div>
          <div class="user-info">
            <h2 class="greeting">
              Welcome, <%= session.getAttribute("userName") %>
            </h2>

            <div class="info-item">
              <i class="fas fa-user"></i>
              <span class="info-label">Full Name:</span>
              <span class="info-value"
                ><%= session.getAttribute("userName") %></span
              >
            </div>

            <div class="info-item">
              <i class="fas fa-envelope"></i>
              <span class="info-label">Email:</span>
              <span class="info-value"
                ><%= session.getAttribute("userEmail") %></span
              >
            </div>

            <div class="info-item">
              <i class="fas fa-key"></i>
              <span class="info-label">Role:</span>
              <span class="role-badge"
                ><%= session.getAttribute("userRole") %></span
              >
            </div>

            <div
              class="quick-stats"
              ng-app="SmartHomeApp"
              ng-controller="DashboardController"
            >
              <div class="stat-card">
                <div class="stat-icon">
                  <i class="fas fa-plug"></i>
                </div>
                <div class="stat-info">
                  <h3>
                    Active Devices:
                    <span id="activeDevices"
                      ><b>{{ activeDevices }}</b></span
                    >
                  </h3>
                </div>
              </div>
              <div class="stat-card">
                <div class="stat-icon">
                  <i class="fas fa-bolt"></i>
                </div>
                <div class="stat-info">
                  <h4>Power Usage</h4>
                  <p>2.4 kWh</p>
                </div>
              </div>
              <div class="stat-card">
                <div class="stat-icon">
                  <i class="fas fa-temperature-low"></i>
                </div>
                <div class="stat-info">
                  <h4>Avg. Temp</h4>
                  <p>72°F</p>
                </div>
              </div>
            </div>
            <script>
              var app = angular.module("SmartHomeApp", []);

              app.controller("DashboardController", function ($scope, $http) {
                const contextPath = "<%= request.getContextPath() %>";

                function fetchActiveDevices() {
                  $http.get(contextPath + "/ActiveDeviceCountServlet").then(
                    function (response) {
                      $scope.activeDevices = response.data;
                    },
                    function (error) {
                      console.error("Error fetching active devices:", error);
                    }
                  );
                }

                fetchActiveDevices();

                // Optional: Auto refresh every 10 seconds
                setInterval(fetchActiveDevices, 10000);
              });
            </script>
          </div>
        </div>

        <div class="action-cards">
          <div
            class="action-card"
            onclick="location.href='pages/MyDevices.jsp'"
          >
            <div class="action-icon">
              <i class="fas fa-mobile-alt"></i>
            </div>
            <h3 class="action-title">My Devices</h3>
            <p class="action-desc">
              Control and monitor all your connected smart devices
            </p>
            <button class="action-btn">View Devices</button>
          </div>

          <div
            class="action-card"
            onclick="location.href='pages/AddDevice.jsp'"
          >
            <div class="action-icon">
              <i class="fas fa-plus-circle"></i>
            </div>
            <h3 class="action-title">Add Device</h3>
            <p class="action-desc">
              Connect a new smart device to your home system
            </p>
            <button class="action-btn">Add New</button>
          </div>
        </div>
      </div>
    </div>

    <script>
      // Add dynamic functionality
      document.addEventListener("DOMContentLoaded", function () {
        // Simulate loading stats
        setTimeout(() => {
          const statValues = document.querySelectorAll(".stat-info p");
          statValues.forEach((stat) => {
            stat.style.opacity = "0";
            setTimeout(() => {
              stat.style.transition = "opacity 0.5s ease";
              stat.style.opacity = "1";
            }, 300);
          });
        }, 800);

        // Add hover effect to action cards
        const actionCards = document.querySelectorAll(".action-card");
        actionCards.forEach((card) => {
          card.addEventListener("mouseenter", function () {
            actionCards.forEach((c) => {
              if (c !== card) c.style.opacity = "0.7";
            });
          });

          card.addEventListener("mouseleave", function () {
            actionCards.forEach((c) => {
              c.style.opacity = "1";
            });
          });
        });
      });
    </script>
  </body>
</html>
