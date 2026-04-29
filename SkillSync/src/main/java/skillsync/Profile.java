package skillsync;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/profile")
public class Profile extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{

		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		// Or get from session

		String url = "jdbc:mysql://localhost:3306/skillssync";
		String dbUser = "root";
		String dbPassword = "1234";

		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection = DriverManager.getConnection(url, dbUser, dbPassword);

			String query = "SELECT FULL_NAME FROM register_student WHERE USERNAME=?";
			PreparedStatement ps1 = connection.prepareStatement(query);
			String username=request.getParameter("username");
			ps1.setString(1, username);
			
			ResultSet rs1 = ps1.executeQuery();
			String fn="";
			if (rs1.next()) 
			{
				System.out.println(rs1.getString(1));
				fn=rs1.getString(1);
			}
			

			String insert = "SELECT * FROM register_student WHERE full_name=?";
			PreparedStatement ps = connection.prepareStatement(insert);
			
			ps.setString(1, fn);

			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				out.println("<!DOCTYPE html>");
				out.println("<html lang='en'>");
				out.println("<head>");
				out.println("<meta charset='UTF-8'>");
				out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
				out.println("<title>User Profile</title>");
				out.println("<style>");
				out.println(
						"body { font-family: Arial; background:#f3f7ff; display:flex; justify-content:center; align-items:center; height:100vh; }");
				out.println(
						".card { background:white; padding:30px; border-radius:15px; box-shadow:0 4px 12px rgba(0,0,0,0.1); width:600px; }");
				out.println(".card h2 { margin-bottom:20px; }");
				out.println(".field { margin:10px 0; }");
				out.println(".field label { font-weight:bold; display:inline-block; width:150px; }");
				out.println(".value { background:#f5f5f5; padding:8px; border-radius:8px; display:inline-block; }");
				out.println(
						".btn { background:#007bff; color:white; padding:10px 20px; text-decoration:none; border-radius:8px; }");
				out.println("</style>");
				out.println("</head>");
				out.println("<body>");
				out.println("<div class='card'>");
				out.println("<h2>Profile</h2>");
				out.println("<div class='field'><label>Full Name:</label><span class='value'>"
						+ rs.getString("full_name") + "</span></div>");
				out.println("<div class='field'><label>Email:</label><span class='value'>" + rs.getString("email")
						+ "</span></div>");
				out.println("<div class='field'><label>Whatsapp:</label><span class='value'>"
						+ rs.getString("whatsapp_no") + "</span></div>");
				out.println("<div class='field'><label>Skills:</label><span class='value'>" + rs.getString("skills")
						+ "</span></div>");
				out.println("<div class='field'><label>College:</label><span class='value'>" + rs.getString("college")
						+ "</span></div>");
				out.println("<div class='field'><label>Degree:</label><span class='value'>" + rs.getString("degree")
						+ "</span></div>");
				out.println("<div class='field'><label>Starting Date:</label><span class='value'>"
						+ rs.getString("starting_date") + "</span></div>");
				out.println("<div class='field'><label>Ending Date:</label><span class='value'>"
						+ rs.getString("ending_date") + "</span></div>");
				out.println("<br><a href='dashboard.html' class='btn'>Return to Dashboard</a>");
				out.println("</div>");
				out.println("</body>");
				out.println("</html>");
			} else {
				out.println("User not found!");
			}

			connection.close();

		} catch (Exception e) {
			e.printStackTrace();
			out.println("Error: " + e.getMessage());
		}
	}
}
