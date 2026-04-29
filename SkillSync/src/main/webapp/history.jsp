<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History | SkillSync</title>

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
body {
	margin: 0;
	font-family: 'Inter', sans-serif;
	background: linear-gradient(135deg, #dff3ff, #b8e5ff);
	padding: 40px;
}

h1 {
	font-size: 36px;
	font-weight: 700;
	margin-bottom: 5px;
	color: #0d1a2d;
}

.subtext {
	font-size: 16px;
	color: #4b5b73;
	margin-bottom: 30px;
}

.history-container {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 28px;
	max-width: 1100px;
}

.card {
	background: #ffffff;
	padding: 24px;
	border-radius: 18px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	min-height: 150px;
	transition: transform .2s ease, box-shadow .2s ease;
}

.card:hover {
	transform: translateY(-4px);
	box-shadow: 0 6px 22px rgba(0, 0, 0, 0.12);
}

.title {
	font-size: 19px;
	font-weight: 700;
	color: #0d1a2d;
}

.subtitle {
	font-size: 17px;
	font-weight: 500;
	color: #1a2b45;
	margin-top: 4px;
}

.date {
	font-size: 14px;
	margin-top: 10px;
	color: #445a77;
}

.rating {
	margin-top: 12px;
	font-size: 18px;
	color: #f7c531;
}

.bottom-row {
	margin-top: 12px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.duration-box {
	background: #e9f4ff;
	padding: 6px 14px;
	border-radius: 10px;
	font-size: 14px;
	font-weight: 600;
	display: flex;
	align-items: center;
	color: #0077ff;
}

.duration-box img {
	width: 18px;
	margin-right: 6px;
}

.details-btn {
	padding: 8px 16px;
	background: #e4f0ff;
	color: #0066ff;
	border-radius: 10px;
	font-weight: 600;
	font-size: 15px;
	cursor: pointer;
	border: none;
	transition: background .2s ease;
}

.details-btn:hover {
	background: #d5e7ff;
}
</style>
</head>

<body>

	<h1>History</h1>
	<div class="subtext">Review your past sessions</div>


	<div class="history-container">
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
			rs = st.executeQuery("SELECT match_name, Course_name, Date, Rating, Duration FROM sessions");

			while (rs.next()) {
				String mname = rs.getString("match_name");
				String course_name = rs.getString("Course_name");
				String date = rs.getString("Date");
				String rating = rs.getString("Rating");
				String duration = rs.getString("Duration");
		%>
		<!-- CARD 1 -->
		<div class="card">
			<div>
				<div class="title"><%=mname%></div>
				<div class="subtitle"><%=course_name%></div>
				<div class="date"><%=date%></div>
				<div class="rating"><%=rating%></div>
			</div>
			<div class="bottom-row">
				<div class="duration-box">
					<img src="https://cdn-icons-png.flaticon.com/512/4149/4149670.png">
					<%=duration%>
				</div>
				<button class="details-btn">View Details</button>
			</div>
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
		<!-- CARD 2 -->
		<!-- <div class="card">
        <div>
            <div class="title">Teacher Name</div>
            <div class="subtitle">Machine Learning</div>
            <div class="date">15 Aug 2024</div>
            <div class="rating">★★★★☆</div>
        </div>
        <div class="bottom-row">
            <button class="details-btn">View Details</button>
        </div>
    </div> -->

		<!-- CARD 3 -->
		<!-- <div class="card">
        <div>
            <div class="title">Teacher Name</div>
            <div class="subtitle">Data Science</div>
            <div class="date">31 Jul 2024</div>
            <div class="rating">★★★★☆</div>
        </div>
        <div class="bottom-row">
            <div class="duration-box">
                <img src="https://cdn-icons-png.flaticon.com/512/4149/4149670.png">
                4.7
            </div>
            <button class="details-btn">View Details</button>
        </div>
    </div> -->

		<!-- CARD 4 -->
		<!-- <div class="card">
        <div>
            <div class="title">Teacher Name</div>
            <div class="subtitle">UI/UX Design</div>
            <div class="date">22 Jun 2024</div>
            <div class="rating">★★★★½</div>
        </div>
        <div class="bottom-row">
            <button class="details-btn">View Details</button>
        </div>
    </div> -->

	</div>

</body>
</html>
