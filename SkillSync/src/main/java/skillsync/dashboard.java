package skillsync;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/dashboard")
public class dashboard extends HttpServlet 
{
	@Override
       protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
       {
    	        HttpSession hs=req.getSession();
    	        req.getRequestDispatcher("dashboard.jsp").include(req, res);

       }
}
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
    	   
       
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

