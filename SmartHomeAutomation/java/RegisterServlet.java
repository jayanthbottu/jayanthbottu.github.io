import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class RegisterServlet extends HttpServlet {

    // Database details for MariaDB
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/SmartHome";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "admin";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try {
            // Load MariaDB driver
            Class.forName("org.mariadb.jdbc.Driver");

            // Connect to the database
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            // Prepare SQL insert statement
            String sql = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password);
            stmt.setString(4, role);

            // Execute and check success
            int result = stmt.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('✅ Registration Successful! Redirecting to Login...');"
                        + "window.location='login.html';</script>");
            } else {
                out.println("<script>alert('❌ Registration Failed! Please try again.');"
                        + "window.location='register.html';</script>");
            }

            stmt.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('❌ Error occurred! Check server logs.');"
                    + "window.location='register.html';</script>");
        }
    }
}
