package skillsync;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.http.HttpRequest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/register")
public class Register_Student extends HttpServlet {
	@Override
    
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		String Username = req.getParameter("Username");
		String Full_Name = req.getParameter("Full_Name");
		String Email = req.getParameter("Email");
		String WhatsApp_No = req.getParameter("WhatsApp_No");
		String skills = req.getParameter("Skills");
		String Password = req.getParameter("Password");
		String Confirm_Password = req.getParameter("Confirm_Password");
		String College = req.getParameter("College");
		String Degree = req.getParameter("Degree");
		String Starting_Date = req.getParameter("Starting_Date");
		String Ending_Date = req.getParameter("Ending_Date");
		String Gender = req.getParameter("Gender");

		if (Password.equals(Confirm_Password)) {

			String url = "jdbc:mysql://localhost:3306/skillssync";
			String username = "root";
			String password = "1234";
			Connection connection = null;

			try {
				// Register Driver
				Class.forName("com.mysql.cj.jdbc.Driver");

				// Establish connection
				connection = DriverManager.getConnection(url, username, password);

				// Create Statement Object
				String insert = "INSERT INTO register_student(username,full_name,email,whatsapp_no,skills,passwords,confirm_password,college,degree,starting_date,ending_date,gender) VALUES (?, ?, ?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement ps = connection.prepareStatement(insert);
				ps.setString(1, Username);
				ps.setString(2, Full_Name);
				ps.setString(3, Email);
				ps.setString(4, WhatsApp_No);
				ps.setString(5, skills);
				ps.setString(6, Password);
				ps.setString(7, Confirm_Password);
				ps.setString(8, College);
				ps.setString(9, Degree);
				ps.setString(10, Starting_Date);
				ps.setString(11, Ending_Date);
				ps.setString(12, Gender);

				Cookie c=new Cookie("user", Username);
				res.addCookie(c);

				int rows = ps.executeUpdate();
				if (rows > 0) {
					RequestDispatcher rd=req.getRequestDispatcher("login.html");
					rd.forward(req,res);
				} else {
					out.println("Invalid Details. Registration failed.");
				}
			} // try

			catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
			}

		} // if

		else {
			out.println("Passwords Not Matching");
		}

	}
}
