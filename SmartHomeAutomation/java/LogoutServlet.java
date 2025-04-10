// LogoutServlet.java
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false); // prevent creating new session
    if (session != null) {
      session.invalidate(); // remove all session data
    }
    response.sendRedirect("login.html"); // redirect to login page
  }
}
