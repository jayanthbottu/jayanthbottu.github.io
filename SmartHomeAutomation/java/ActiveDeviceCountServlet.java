import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class ActiveDeviceCountServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve username from session
        String username = (String) request.getSession().getAttribute("userName");
        int count = 0;

        if (username != null && !username.isEmpty()) {
            try {
                Class.forName("org.mariadb.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mariadb://localhost:3306/SmartHome", "root", "admin");

                // Prepare SQL query
                String sql = "SELECT COUNT(*) FROM devices WHERE user_name = ? AND status = 'ON'";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, username);

                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
                }

                // Cleanup
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Return result
        response.setContentType("text/plain");
        response.getWriter().write(String.valueOf(count));
    }
}
