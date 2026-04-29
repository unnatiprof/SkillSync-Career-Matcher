<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.util.ArrayList"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SkillSync Dashboard</title>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	display: flex;
	background: linear-gradient(to bottom right, #eaf4ff, #f7faff);
	min-height: 100vh;
}

/* Sidebar */
.sidebar {
	width: 250px;
	background: #4a90e2;
	color: white;
	padding: 20px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	animation: slideInLeft 0.7s ease;
}

.sidebar h2 {
	margin-bottom: 30px;
	font-size: 24px;
}

.menu-item {
	margin: 12px 0;
	cursor: pointer;
	padding: 10px;
	border-radius: 8px;
	transition: background 0.3s;
	color: white;
	padding: 10px 15px;
	display: block;
	cursor: pointer;
	text-decoration: none; /* removes underline */
}

.menu-item:hover {
	background: rgba(255, 255, 255, 0.2);
	transform: translateX(5px);
	background-color: #2a6cd6; /* hover effect */
}

/* Main */
.main {
	flex: 1;
	padding: 30px;
	animation: fadeIn 1s ease;
}

.welcome {
	font-size: 24px;
	font-weight: bold;
	margin-bottom: 20px;
}

.grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
}

.card {
	background: white;
	padding: 20px;
	border-radius: 16px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s, box-shadow 0.3s;
	animation: popUp 0.6s ease;
}

.card:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 18px rgba(0, 0, 0, 0.15);
}

.card h3 {
	margin-bottom: 15px;
}

.btn {
	background: #4a90e2;
	color: white;
	padding: 8px 16px;
	border: none;
	border-radius: 12px;
	cursor: pointer;
	font-size: 14px;
	transition: background 0.3s;
}

.btn:hover {
	background: #003cbf;
}

.project-item, .session-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 12px;
	padding: 10px;
	border-radius: 10px;
	background: #f7faff;
	transition: transform 0.3s;
}

.project-item:hover, .session-item:hover {
	transform: scale(1.02);
}

/* Animations */
@
keyframes slideInLeft {from { transform:translateX(-100%);
	
}

to {
	transform: translateX(0);
}

}
@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
@
keyframes popUp {from { transform:scale(0.9);
	opacity: 0;
}

to {
	transform: scale(1);
	opacity: 1;
}
}
</style>
</head>
<body>
	<div class="sidebar">
		<div>
			<h2>SkillSync</h2>
			<!--  <div class="menu-item">Dashboard</div>-->
			<!--  <div class="menu-item">Profile</div>-->

			<!--	<form action='dashboard.jsp' method='post' class='menu-item'>
				Dashboard
				</button>
			</form>
			<form action='profile.jsp' method='post' class='menu-item'>
				Profile
				</button>
			</form>
			<!--  <form action='courses.jsp' method='post' type='submit' class="menu-item" >Courses</form>-->
			<a href="dashboard.jsp" class="menu-item">Dashboard</a> <a
				href="profile.jsp" class="menu-item">Profile</a> <a
				href="courses.jsp" class="menu-item">Courses</a> <a
				href="searchengine.jsp" class="menu-item">Search Engine</a> <a
				href="sessions.jsp" class="menu-item">Sessions</a> <a
				href="matchmaking.jsp" class="menu-item">Matchmaking</a> <a
				href="history.jsp" class="menu-item">History</a> <a
				href="schedulesessions.jsp" class="menu-item">Schedule Sessions</a>

			<a href="index.html" class="menu-item">Logout</a>
			<!-- <form action='search_engine.jsp' method='post' class='menu-item'>
				Search Engine
				</button>
			</form>
			<form action='sessions.jsp' method='post' class='menu-item'>
				Sessions
				</button>
			</form>
			<form action='matchmaking.jsp' method='post' type='submit'
				class='menu-item'>Matchmaking</form>
			<div class="menu-item" form action='courses.jsp' method='post'
				type='submit'>History</div>-->



			<!-- <div class="menu-item">Search Engine</div>
      <div class="menu-item">Sessions</div>
      <div class="menu-item">Matchmaking</div>
      <div class="menu-item">History</div>
		</div>
		<div>
			<div class="menu-item">Schedule Session</div>
			<div class="menu-item">Previous Sessions</div>
			<div class="menu-item">Settings</div>
			<div class="menu-item">Logout</div>-->
		</div>
	</div>

	<div class="main">
		<%
		String fname = (String) session.getAttribute("Fullname");
		LocalDate today = LocalDate.now(); 
		%>

		<div class="welcome">
			Welcome,
			<%=fname%>!
		</div>
		<%
String url = "jdbc:mysql://localhost:3306/skillssync";
String user = "root";
String pass = "1234";

String username = (String) session.getAttribute("User_Name");
// Debug: remove later
// out.println("USERNAME = " + username);

LocalDate today1 = LocalDate.now();

Connection con = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(url, user, pass);

    String sql = "SELECT match_name, Date, Time FROM sessions " +
                 "WHERE username = ? AND Date > ? ORDER BY Date ASC";
    
    PreparedStatement ps = con.prepareStatement(sql);
    ps.setString(1, username);
    ps.setDate(2, java.sql.Date.valueOf(today));

    ResultSet rs = ps.executeQuery();
    
    String query = "SELECT current_projects FROM users ";
    PreparedStatement ps1 = con.prepareStatement(query);
    //ps1.setString(1, current_projects);
    

    ResultSet rs1 = ps1.executeQuery();
%>

		<div class="grid">
			<!-- Upcoming Sessions Card -->
			<div class="card">
				<h3>Upcoming Sessions</h3>

				<%
        boolean found = false;
        while (rs.next()) {
            found = true;
            String mname = rs.getString("match_name");
            Date date = rs.getDate("Date");
            String time = rs.getString("Time");
        %>

				<div class="session-item">
					<span>Session with <%= mname %> (<%= date %> @ <%= time %>)
					</span>
				</div>

				<% } %>

				<% if (!found) { %>
				<div class="session-item">
					<span>No upcoming sessions</span>
				</div>
				<% } %>

				<button class="btn">
					<a href="sessions.jsp" style="color: white;">View All</a>
				</button>
			</div>

			<%
            

            

        } catch (Exception e) {
            e.printStackTrace();
        }

        finally {
			
			if (con != null)
			con.close();
			}     %>
			<!-- Quick Access -->

			<div class="card">
				<h3>Quick Access</h3>
				<div class="project-item">
					<span>Zoom Meeting</span>
					<button class="btn">
						<a href="https://www.zoom.com/" style="color: white;">Go to zoom</a>

					</button>
				</div>
				<div class="project-item">
					<span>Google Meet</span>
					<button class="btn">
						<a href="https://meet.google.com/landing" style="color: white;">Go to meet</a>
					</button>
				</div>
			</div>

			<!-- Your Projects -->
			
			<%
String url1 = "jdbc:mysql://localhost:3306/skillssync";
String user1 = "root";
String pass1 = "1234";

String username1 = (String) session.getAttribute("User_Name");
// Debug: remove later
// out.println("USERNAME = " + username);

LocalDate today11 = LocalDate.now();

Connection con1 = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    con = DriverManager.getConnection(url, user, pass);

    
    
    String query = "SELECT current_projects FROM users ";
    PreparedStatement ps = con.prepareStatement(query);
    //ps1.setString(1, current_projects);
    

    ResultSet rs = ps.executeQuery();
%>
			
				<div class="card">
    <h3>Your Projects</h3>

    <%
        boolean found = false;
        while (rs.next()) {
            found = true;
            String curr_p = rs.getString("current_projects");
    %>

        <div class="project-item">
            <span><%= curr_p %></span>
        </div>

    <% } %>

    <% if (!found) { %>
        <div class="session-item">
            <span>No projects found</span>
        </div>
    <% } %>
</div>

			
			<%
            

            

        } catch (Exception e) {
            e.printStackTrace();
        }

        finally {
			
			if (con1 != null)
			con1.close();
			}     %>
			<!-- Recommended -->
			<div class="card">
				<h3>Recommended for You</h3>
				<div class="project-item">
					<span>Introduction to Data Science</span>
					<button class="btn">Browse</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>