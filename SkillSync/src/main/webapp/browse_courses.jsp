<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="skillsync.Course" %>
<%@ page import="java.sql.*"%>

<%
String[] selectedFee = (String[]) request.getAttribute("selectedFee");
String[] selectedLevel = (String[]) request.getAttribute("selectedLevel");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Courses</title>

    <style>
        body{
            margin:0;
            font-family: Arial, Helvetica, sans-serif;
            background-color:#cfd8e3;
        }

        .page{
            padding:40px;
        }

        .page-title{
            text-align:center;
            margin-bottom:30px;
            color:#1f3b6f;
            font-size:32px;
            font-weight:bold;
        }

        .content-row{
            display:flex;
            gap:30px;
            align-items:flex-start;
        }

        /* Sidebar */
        .sidebar{
            width:260px;
            height: 600px;
            background:#e9edf3;
            padding:20px;
            border-radius:15px;
        }

        .sidebar h3{
            margin-top:0;
            color:#1f3b6f;
        }

        .sidebar label{
    display:block;
    margin:12px 0;
    font-size:18px;
    font-weight:500;
}

.sidebar input[type="checkbox"]{
    transform: scale(1.3);
    margin-right:8px;
}

        .apply-btn{
            width:100%;
            padding:10px;
            background:#1f3b6f;
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
            margin-top:10px;
        }

        .category{
            background:#d7dde7;
            padding:10px;
            margin:8px 0;
            border-radius:8px;
            font-weight:bold;
        }

        /* Main Section */
        .main{
            flex:1;
        }

        .course-grid{
            display:grid;
            grid-template-columns: repeat(3, 1fr);
            gap:25px;
        }

        .course-card{
            background:#e9edf3;
            padding:20px;
            border-radius:15px;
        }

        .course-title{
            color:#1f3b6f;
            font-size:20px;
            font-weight:bold;
            margin-bottom:10px;
        }

        .course-content{
            display:flex;
            gap:15px;
            align-items:flex-start;
        }

        .course-img{
            width:70px;
            height:70px;
            border-radius:50%;
            overflow:hidden;
        }

        .course-img img{
            width:100%;
            height:100%;
            object-fit:cover;
        }

        .enroll-btn{
            margin-top:10px;
            padding:8px 16px;
            background:#2f5ea8;
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
        }
    </style>
</head>

<body>

<div class="page">

    <h1 class="page-title">Available Courses</h1>

    <div class="content-row">

        <!-- Sidebar -->
        <div class="sidebar">
            <form action="FilterCoursesServlet" method="post">

    <h2>Filters</h2>

    <label>
        <input type="checkbox" name="fee" value="free"> Free Courses
    </label>

    <label>
        <input type="checkbox" name="fee" value="paid"> Paid Courses
    </label>

    <label>
        <input type="checkbox" name="level" value="beginner"> Beginner
    </label>

    <label>
        <input type="checkbox" name="level" value="intermediate"> Intermediate
    </label>

    <label>
        <input type="checkbox" name="level" value="advanced"> Advanced
    </label>

    <button type="submit" class="apply-btn">Apply</button>

</form>

            <!--<button class="apply-btn">Apply</button>
            <br><a href="schedulesessions.jsp">
            <button class="apply-btn">Apply</button>
            </a>-->
<%-- 
            <h3 style="margin-top:20px;">Categories</h3>

            <div class="category">JAVA</div>
            <div class="category">AI</div>
            <div class="category">PYTHON</div>
            <div class="category">DevOps</div>
            --%>
        </div>

        <!-- Course Cards -->
        <div class="main">
            <div class="course-grid">
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
					rs = st.executeQuery("SELECT main_skill, fullname, price, course_level,course_fee,profile_image FROM users");

					while (rs.next()) {
						String cname = rs.getString("main_skill");
						String tname = rs.getString("fullname");
						String prc = rs.getString("price");
						String level= rs.getString("course_level");
						String fee =  rs.getString("course_fee");
						String pimg =  rs.getString("profile_image");
				%>

                <div class="course-card">
                    <div class="course-title"><%= cname %></div>
                    <div class="course-content">
                        <div class="course-img">
                        <img src="<%= request.getContextPath() %>/assets/profile_pics/<%= pimg %>"
                                 alt="Profile photo">
                        </div>
                        <div>
                            <strong><%= tname %> • <%= fee %> </strong><br>
                            Fee: <%= prc %><br>
                            Level: <%= level %>
                            <br>
                            <!--<br><button class="enroll-btn">Enroll</button>-->
                            <br><a href="schedulesessions.jsp">
                            <button class="enroll-btn">Enroll</button>
                            </a>
                        </div>
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
				</div>
        </div>

    </div>

</div>

</body>
</html>

                