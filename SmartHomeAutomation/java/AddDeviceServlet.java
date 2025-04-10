import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddDeviceServlet")
public class AddDeviceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get parameters from form
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String status = request.getParameter("status");
        String room = request.getParameter("room");

        // Get username from session
        HttpSession session = request.getSession(false);
        String userName = (String) session.getAttribute("userName");

        // Get current timestamp for created_at
        Timestamp createdAt = Timestamp.valueOf(LocalDateTime.now());

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/SmartHome", "root", "admin");

            String sql = "INSERT INTO devices (name, type, status, room, created_at, user_name) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, type);
            ps.setString(3, status);
            ps.setString(4, room);
            ps.setTimestamp(5, createdAt);
            ps.setString(6, userName);

            ps.executeUpdate();

            ps.close();
            con.close();

            // Redirect to MyDevices.jsp after successful addition
            response.sendRedirect("pages/MyDevices.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
