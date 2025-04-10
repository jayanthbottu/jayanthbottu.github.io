import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/PasswordRetrievalServlet")
public class PasswordRetrievalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get user input from the form
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // Database connection details
        String url = "jdbc:mariadb://localhost:3306/SmartHome"; // MariaDB JDBC URL
        String user = "root"; // Database username
        String pass = "admin"; // Database password

        try {
            // Load MariaDB JDBC Driver
            Class.forName("org.mariadb.jdbc.Driver");

            // Establish connection
            Connection conn = DriverManager.getConnection(url, user, pass);

            // Query to fetch password based on name & email
            String sql = "SELECT password FROM users WHERE name = ? AND email = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);

            ResultSet rs = pstmt.executeQuery();

            // Check if user exists
            if (rs.next()) {
                String password = rs.getString("password");

                // JavaScript alert with password
                out.println("<script>");
                out.println("alert('Your password is: " + password + "');");
                out.println("window.location.href='pages/password.html';"); // Redirect back
                out.println("</script>");
            } else {
                // Alert if no match found
                out.println("<script>");
                out.println("alert('No matching user found!');");
                out.println("window.location.href='pages/password.html';");
                out.println("</script>");
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (ClassNotFoundException e) {
            out.println("<script>");
            out.println("alert('Error: MariaDB Driver Not Found!');");
            out.println("window.location.href='pages/password.html';");
            out.println("</script>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<script>");
            out.println("alert('Database Error! Check connection and credentials.');");
            out.println("window.location.href='pages/password.html';");
            out.println("</script>");
            e.printStackTrace();
        }
    }
}
