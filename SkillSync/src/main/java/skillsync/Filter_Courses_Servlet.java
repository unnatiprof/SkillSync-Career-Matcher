package skillsync;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/FilterCoursesServlet")
public class Filter_Courses_Servlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] fee = request.getParameterValues("fee");
        String[] level = request.getParameterValues("level");

        List<Course> filteredCourses = new ArrayList<>();

        String url = "jdbc:mysql://localhost:3306/skillssync";
		String dbUser = "root";
		String dbPass = "1234";
		Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPass);

            StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");

            if (fee != null) {
                query.append(" AND course_fee IN (");
                for (int i = 0; i < fee.length; i++) {
                    query.append("?");
                    if (i < fee.length - 1) query.append(",");
                }
                query.append(")");
            }

            if (level != null) {
                query.append(" AND course_level IN (");
                for (int i = 0; i < level.length; i++) {
                    query.append("?");
                    if (i < level.length - 1) query.append(",");
                }
                query.append(")");
            }

            PreparedStatement ps = con.prepareStatement(query.toString());

            int index = 1;

            if (fee != null) {
                for (String f : fee) {
                    ps.setString(index++, f);
                }
            }

            if (level != null) {
                for (String l : level) {
                    ps.setString(index++, l);
                }
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) 
            {
                Course c = new Course();
                c.setTitle(rs.getString("main_skill"));
                c.setInstructor(rs.getString("fullname"));
                c.setFee(rs.getString("course_fee"));
                c.setLevel(rs.getString("course_level"));
                c.setProfileImage(rs.getString("profile_image"));
                c.setPrice(rs.getString("price"));
                filteredCourses.add(c);
            }

            request.setAttribute("courses", filteredCourses);
            request.setAttribute("selectedFee", fee);
            request.setAttribute("selectedLevel", level);
            request.getRequestDispatcher("filtered_courses.jsp")
                   .forward(request, response);
            request.getRequestDispatcher("browse_courses.jsp")
            .forward(request, response);

        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
    }
}