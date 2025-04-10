import java.io.*;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import com.google.gson.*;

@WebServlet("/ToggleDeviceServlet")
public class ToggleDeviceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        BufferedReader reader = request.getReader();
        Gson gson = new Gson();
        Map<String, String> data = gson.fromJson(reader, Map.class);

        String deviceName = data.get("deviceName");
        String newStatus = data.get("newStatus");
        String userName = data.get("userName");

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/SmartHome", "root", "admin");

            String query = "UPDATE devices SET status = ? WHERE name = ? AND user_name = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, newStatus);
            ps.setString(2, deviceName);
            ps.setString(3, userName);

            int updated = ps.executeUpdate();
            response.getWriter().write(updated > 0 ? "success" : "fail");

            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        }
    }
}
