package skillsync;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@SuppressWarnings("serial")
@WebServlet("/schedulesessions")
@MultipartConfig   // Needed for profile image upload
public class Schedule_session extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {

		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		// Fetching form parameters
		
		String user_name = req.getParameter("User_Name");
		String coursename = req.getParameter("Course_Name");
		String skills = req.getParameter("skills");
		String date = req.getParameter("sdate");
		String time = req.getParameter("stime");
		String duration = req.getParameter("duration");
		String platform = req.getParameter("platform");
		String review = req.getParameter("review");
		String Match_name = req.getParameter("matchName");      // only if you add rating input in JSP
		//String course_level = req.getParameter("Course_level");   // only if added in JSP


		

		// For profile image upload
		//Part profileImagePart = req.getPart("profile_image");
		//String profileImageName = profileImagePart.getSubmittedFileName();

		

			String url = "jdbc:mysql://localhost:3306/skillssync";
			String dbUser = "root";
			String dbPass = "1234";
			Connection con = null;

			try 
			{
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, dbUser, dbPass);

				String query = "INSERT INTO sessions(username,Course_name,Skills,Date,Time,Duration,Platform,Review,match_name) VALUES(?,?,?,?,?,?,?,?,?)"; 

				PreparedStatement ps = con.prepareStatement(query);

				ps.setString(1, user_name);
				ps.setString(2, coursename);
				ps.setString(3, skills);
				ps.setString(4, date);
				ps.setString(5, time);
				ps.setString(6, duration);
				ps.setString(7, platform);
				
				ps.setString(8, review);
				ps.setString(9, Match_name);
				//ps.setString(10, course_level);
				

				Cookie ck = new Cookie("user", user_name);
				res.addCookie(ck);

				int rows = ps.executeUpdate();
                System.out.println("check1");
				if (rows > 0) 
				{
					RequestDispatcher rd = req.getRequestDispatcher("sessions.jsp");
					System.out.println("check2");
					rd.forward(req, res);
				} 
				else 
				{
					out.println("Registration Failed.");
					System.out.println("check3");
				}

			} //end of try
			catch (Exception e) 
			{
				e.printStackTrace();
			}

		
	}
}
