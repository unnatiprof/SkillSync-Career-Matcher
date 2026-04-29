package skillsync;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class Login extends HttpServlet 
{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		String Username = req.getParameter("username"); // from form
		String Password = req.getParameter("password"); // from form

		String url = "jdbc:mysql://localhost:3306/skillssync";
		String dbUser = "root";
		String dbPassword = "1234";
		

		Connection connection = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try 
		{
			// Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Connect
			connection = DriverManager.getConnection(url, dbUser, dbPassword);

			// SQL Query to check username & password
			String query = "SELECT * FROM users WHERE username = ? AND password_hash = ?";
			ps = connection.prepareStatement(query);
			ps.setString(1, Username);
			ps.setString(2, Password);

			rs = ps.executeQuery();

			if (rs.next()) 
			{
                
                String fname=rs.getString("fullname");
				String uname=rs.getString("username");
				String pimg=rs.getString("profile_image");
				String email=rs.getString("email");
				String wa=rs.getString("whatsapp_no");
				String ct=rs.getString("city");
				String gender =rs.getString("gender");
				
				String rol =rs.getString("role");
				
				String clg =rs.getString("college");
				String deg=rs.getString("degree");
				String br =rs.getString("branch");
				String sem =rs.getString("semester");
				
				String mskill=rs.getString("main_skill");
				String oskill=rs.getString("other_skills");
				
				
				String cur_prj=rs.getString("current_projects");
				String cour_int=rs.getString("courses_interested");
				
				
				String cour_fee = rs.getString("course_fee");
				String price = rs.getString("price");
				String course_level=rs.getString("course_level");
				
				
				HttpSession hs= req.getSession();
				hs.setAttribute("Fullname",fname );
				hs.setAttribute("Username",uname );
				hs.setAttribute("Profile_img",pimg );
				
				hs.setAttribute("Email",email );
				hs.setAttribute("Whatsapp_no",wa );
				hs.setAttribute("City",ct );
				hs.setAttribute("Gender",gender );
				
				hs.setAttribute("Role",rol );
				
				hs.setAttribute("College",clg );
				hs.setAttribute("Degree",deg );
				hs.setAttribute("Branch",br );
				hs.setAttribute("Semester",sem );
				
				hs.setAttribute("Main_skills",mskill );
				hs.setAttribute("Other_skills",oskill );
				hs.setAttribute("Current_project",cur_prj );
				hs.setAttribute("Courses_interested",cour_int );
				
				hs.setAttribute("Course_fee",cour_fee );
				hs.setAttribute("Price",price );
				hs.setAttribute("Course_level",course_level );
				
				req.getRequestDispatcher("dashboard.jsp").forward(req, res);
			} 
			else 
			{
				// ❌ User not found
				//out.println("Invalid username or password.");
				out.println("Invalid Username Or Password");
				RequestDispatcher rd=req.getRequestDispatcher("login.html");
				rd.include(req, res);
			}

		}//end of try
		
		catch (Exception e) 
		{
			e.printStackTrace();
		} 
		finally
		{
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} // when 
		}
		
	}
}










