import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;
import java.util.*;
import com.google.gson.*;

@WebServlet("/FetchDevicesServlet")
public class FetchDevicesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userName = (String) request.getSession().getAttribute("userName");
        List<Map<String, String>> deviceList = new ArrayList<>();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/SmartHome", "root", "admin");

            String query = "SELECT * FROM devices WHERE user_name = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, userName);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, String> device = new HashMap<>();
                device.put("name", rs.getString("name"));
                device.put("type", rs.getString("type"));
                device.put("status", rs.getString("status"));
                device.put("room", rs.getString("room"));
                device.put("image", "device.jpg"); // Change to dynamic if needed
                device.put("user_name", userName);
                deviceList.add(device);
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.setContentType("application/json");
        response.getWriter().write(new Gson().toJson(deviceList));
    }
}
