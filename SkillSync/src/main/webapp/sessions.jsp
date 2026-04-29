<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
    // Demo data — replace these with session / DB values in real app
    String fname = (String) session.getAttribute("Fullname");
    String email = (String) session.getAttribute("Email");
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Sessions</title>

    <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Poppins", sans-serif;
    }

    body {
        background: linear-gradient(135deg, #dff3ff, #a8d8ff, #d0eaff);
        min-height: 100vh;
        padding: 30px;

        /* Smooth fade animation */
        animation: fadeIn 0.9s ease-in-out;
    }

    /* Fade animation */
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .main-container {
        width: 100%;
    }

    /* ------------------------ TOP BAR ------------------------ */

    .top-bar {
        width: 100%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 40px;

        /* subtle glass effect */
        background: rgba(255, 255, 255, 0.35);
        padding: 18px 25px;
        border-radius: 18px;
        backdrop-filter: blur(12px);
        box-shadow: 0 8px 26px rgba(80, 160, 255, 0.25);
        animation: slideDown 0.7s ease-out;
    }

    @keyframes slideDown {
        from { transform: translateY(-20px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .page-title {
        font-size: 34px;
        font-weight: 700;
        color: #234d72;
        letter-spacing: 1px;
        background: linear-gradient(45deg, #1d5acb, #3ca0ff);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    /* PROFILE BOX */
    .profile-box {
        display: flex;
        align-items: center;
        background: rgba(255, 255, 255, 0.45);
        padding: 12px 20px;
        border-radius: 16px;
        backdrop-filter: blur(10px);

        box-shadow: 0px 8px 24px rgba(0, 120, 255, 0.18);
        transition: 0.3s ease;
    }

    .profile-box:hover {
        transform: scale(1.03);
        box-shadow: 0px 12px 30px rgba(0, 120, 255, 0.24);
    }

    .profile-img {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        object-fit: cover;
        border: 3px solid #ffffffaa;
    }

    .profile-details {
        margin-left: 14px;
    }

    .profile-details .name {
        font-size: 18px;
        font-weight: 600;
        color: #003b6a;
    }

    .profile-details .email {
        font-size: 14px;
        color: #456c8e;
    }

    /* ------------------------ SESSION CARDS ------------------------ */

    .sessions-container {
        display: flex;
        gap: 30px;
        flex-wrap: wrap;
        padding-bottom: 40px;
        animation: fadeIn 1.2s ease-in-out;
    }

    .session-card {
        width: 330px;
        background: rgba(255, 255, 255, 0.55);
        padding: 25px;
        border-radius: 22px;
        backdrop-filter: blur(12px);

        box-shadow: 0px 10px 25px rgba(0, 120, 255, 0.25);
        transition: 0.3s ease-in-out;

        transform: translateY(0);
    }

    .session-card:hover {
        transform: translateY(-10px) scale(1.03);
        box-shadow: 0px 14px 32px rgba(0, 120, 255, 0.35);
    }

    .session-title {
        font-size: 22px;
        font-weight: 600;
        margin-bottom: 10px;
        color: #004a80;

        text-shadow: 0 1px 2px #c8e8ff;
    }

    .session-date,
    .session-time {
        font-size: 15px;
        color: #346b95;
        margin-bottom: 6px;

        animation: fadeIn 1.4s ease;
    }

    /* BUTTON */
    .cta {
        margin-top: 15px;
        width: 100%;
        padding: 12px;
        background: linear-gradient(130deg, #73b6ff, #3c8afc);
        color: white;
        font-size: 15px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 600;
        transition: 0.25s ease;
        text-align: center;
    }

    .cta a {
        color: white;
        text-decoration: none;
    }

    .cta:hover {
        background: linear-gradient(130deg, #4da0ff, #1e6def);
        transform: scale(1.05);
        box-shadow: 0px 8px 20px rgba(30, 90, 200, 0.35);
    }
</style>


</head>

<body>

    <div class="main-container">

        <!-- Top Bar -->
        <div class="top-bar">
            <h1 class="page-title">Your Sessions</h1>

            <div class="profile-box">
                <img src="profile.jpg" alt="profile" class="profile-img">

                <div class="profile-details">
                    <p class="name"><%=fname %></p>
                    <p class="email"><%=email %></p>
                </div>
            </div>
        </div>

        <!-- Session Cards Section -->
        <div class="sessions-container" class="scrollable">
				<%
				Connection con = null;
				Statement st = null;
				ResultSet rs = null;
				String url = "jdbc:mysql://localhost:3306/skillssync";
				String dbUser = "root";
				String dbPassword = "1234";
				try {
					Class.forName("com.mysql.cj.jdbc.Driver");
					con = DriverManager.getConnection(url, dbUser, dbPassword);
					st = con.createStatement();
					rs = st.executeQuery("SELECT Course_name, Date, Time FROM sessions");

					while (rs.next()) {
						String cname = rs.getString("Course_name");
						String date = rs.getString("Date");
						String time = rs.getString("Time");
				%>
            <div class="session-card">
                <h2 class="session-title"><%=cname %></h2>
                <p class="session-date"><%=date %></p>
                <p class="session-time"><%=time %></p>
               <!--  <button class="cta"><a href="sessions.jsp">Enroll</a></button> -->
            </div>
            
            <%
				}
				} catch (Exception e) {
				out.println("<p>Error: " + e.getMessage() + "</p>");
				} finally {
				if (rs != null)
				rs.close();
				if (st != null)
				st.close();
				if (con != null)
				con.close();
				}
			%>
            <!-- <div class="session-card">
                <h2 class="session-title">Java Backend Session</h2>
                <p class="session-date">12th December 2025</p>
                <p class="session-time">11:00 AM - 1:00 PM</p>
                <button class="join-btn">Join Now</button>
            </div>

            <div class="session-card">
                <h2 class="session-title">DSA Problem Solving</h2>
                <p class="session-date">14th December 2025</p>
                <p class="session-time">9:00 AM - 11:00 AM</p>
                <button class="join-btn">Join Now</button>
            </div> -->

        </div>

    </div>

</body>

</html>
