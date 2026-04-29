package skillsync;



import skillsync.Instructor;


import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/MatchMakingServlet")
public class Match_Making_Servlet extends HttpServlet {

	String url = "jdbc:mysql://localhost:3306/skillssync";
	String dbUser = "root";
	String dbPass = "1234";
	Connection con = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String[] skills = request.getParameterValues("skills");
        //String[] languages = request.getParameterValues("language");
        String maxBudget = request.getParameter("budget");
        String minExperience = request.getParameter("experience");

        List<Instructor> instructors = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPass);

            StringBuilder query = new StringBuilder("SELECT * FROM users WHERE 1=1");

            // 🔍 Search keyword
            if (keyword != null && !keyword.trim().isEmpty()) {
                query.append(" AND (name LIKE ? OR skills LIKE ?)");
            }

            // 🛠 Skill filter
            if (skills != null && skills.length > 0) {
                query.append(" AND (");
                for (int i = 0; i < skills.length; i++) {
                    query.append(" skills LIKE ?");
                    if (i < skills.length - 1) {
                        query.append(" OR ");
                    }
                }
                query.append(")");
            }

            // 🌐 Language filter
            /*if (languages != null && languages.length > 0) {
                query.append(" AND language IN (");
                for (int i = 0; i < languages.length; i++) {
                    query.append("?");
                    if (i < languages.length - 1) {
                        query.append(",");
                    }
                }
                query.append(")");
            }**/

            // 💰 Budget filter
            if (maxBudget != null && !maxBudget.isEmpty()) {
                query.append(" AND hourly_rate <= ?");
            }

            // 📈 Experience filter
            if (minExperience != null && !minExperience.isEmpty()) {
                query.append(" AND experience >= ?");
            }

            query.append(" ORDER BY rating DESC");

            PreparedStatement ps = con.prepareStatement(query.toString());

            int index = 1;

            // Set keyword values
            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword + "%");
                ps.setString(index++, "%" + keyword + "%");
            }

            // Set skills values
            if (skills != null && skills.length > 0) {
                for (String skill : skills) {
                    ps.setString(index++, "%" + skill + "%");
                }
            }

            // Set language values
            /*if (languages != null && languages.length > 0) {
                for (String lang : languages) {
                    ps.setString(index++, lang);
                }
            }**/

            // Set budget
            if (maxBudget != null && !maxBudget.isEmpty()) {
                ps.setInt(index++, Integer.parseInt(maxBudget));
            }

            // Set experience
            if (minExperience != null && !minExperience.isEmpty()) {
                ps.setInt(index++, Integer.parseInt(minExperience));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Instructor ins = new Instructor();
                ins.setId(rs.getInt("email"));
                ins.setName(rs.getString("fullname"));
                ins.setSkills(rs.getString("main_skill"));
                //ins.setLanguage(rs.getString("language"));
                ins.setExperience(rs.getInt("course_level"));
                ins.setHourlyRate(rs.getInt("price"));
                ins.setRating(rs.getDouble("course_level"));
                ins.setProfileImage(rs.getString("profile_image"));

                instructors.add(ins);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("matches", instructors);
        request.getRequestDispatcher("matchmaking.jsp")
                .forward(request, response);
    }
}
