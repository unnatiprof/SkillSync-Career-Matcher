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
@WebServlet("/registeruser")
@MultipartConfig   // Needed for profile image upload
public class Register_user extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {

		res.setContentType("text/html");
		PrintWriter out = res.getWriter();

		// Fetching form parameters
		
		String username = req.getParameter("username");//getting data from database columns and storing it into string variables
		String fullname = req.getParameter("fullname");
		Part profileimg = req.getPart("profile_image");
		String fileName = profileimg.getSubmittedFileName();
		String email = req.getParameter("email");
		String whatsapp = req.getParameter("whatsapp");
		String city = req.getParameter("city");
		String role = req.getParameter("role");
		String gender = req.getParameter("gender");

		String skills = req.getParameter("skills");
		String mainSkill = req.getParameter("main_skill");
		String currentProject = req.getParameter("current_project");

		String college = req.getParameter("college");
		String degree = req.getParameter("degree");
		String branch = req.getParameter("branch");
		String semester = req.getParameter("semester");

		String courseInterest = req.getParameter("course_interest");
		String feeType = req.getParameter("fee_type");
		String feeAmount = req.getParameter("fee_amount");
		String courseLevel = req.getParameter("course_level");

		String password = req.getParameter("password");
		String confirmPassword = req.getParameter("confirm_password");

		// For profile image upload
		//Part profileImagePart = req.getPart("profile_image");
		//String profileImageName = profileImagePart.getSubmittedFileName();

		if (password.equals(confirmPassword)) {

			String url = "jdbc:mysql://localhost:3306/skillssync";
			String dbUser = "root";
			String dbPass = "1234";
			Connection con = null;

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url, dbUser, dbPass);

				String query = "INSERT INTO users(fullname,username,profile_image,email,whatsapp_no,city,gender,role,college,degree,branch,semester,main_skill,other_skills,current_projects,courses_interested,course_fee,price,course_level,password_hash) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"; /*("
						+ "fullname, username, email, whatsapp_no, city, gender, role, "
						+ "college, degree, branch, semester, "
						+ "main_skill,other_skills, current_projects,courses_interested, "
						+ "course_fee, price, course_level, "
						+ "password_hash "
						+ ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";*/

				PreparedStatement ps = con.prepareStatement(query);

				ps.setString(1, fullname);
				ps.setString(2, username);
				ps.setString(3, fileName);
				ps.setString(4, email);
				ps.setString(5, whatsapp);
				ps.setString(6, city);
				ps.setString(7, gender);
				ps.setString(8, role);
				
				ps.setString(9, college);
				ps.setString(10, degree);
				ps.setString(11, branch);
				ps.setString(12, semester);
				
				ps.setString(13, mainSkill);
				ps.setString(14, skills);
				ps.setString(15, currentProject);
				ps.setString(16, courseInterest);
				
				ps.setString(17, feeType);
				ps.setString(18, feeAmount);
				ps.setString(19, courseLevel);

				ps.setString(20, password);
				//ps.setString(20, profileImageName);

				// Save image to folder
				//profileImagePart.write("C:/uploads/" + profileImageName);
				
				
				// ===== SAVE IMAGE TO FOLDER =====
				String uploadPath = getServletContext().getRealPath("") 
				        + java.io.File.separator + "assets"
				        + java.io.File.separator + "profile_pics";
				java.io.File uploadDir = new java.io.File(uploadPath);
				if (!uploadDir.exists()) {
				    uploadDir.mkdirs();
				}
				// Save file
				profileimg.write(uploadPath + java.io.File.separator + fileName);
				
				
				Cookie ck = new Cookie("user", username);
				res.addCookie(ck);

				int rows = ps.executeUpdate();
System.out.println("check1");
				if (rows > 0) {
					RequestDispatcher rd = req.getRequestDispatcher("login.html");
					System.out.println("check2");
					rd.forward(req, res);
				} else {
					out.println("Registration Failed.");
					System.out.println("check3");
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			out.println("Passwords do not match.");
		}
	}
}
