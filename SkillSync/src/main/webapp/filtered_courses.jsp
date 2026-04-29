<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="skillsync.Course" %>

<%
String[] selectedFee = (String[]) request.getAttribute("selectedFee");
String[] selectedLevel = (String[]) request.getAttribute("selectedLevel");

boolean freeChecked = false;
boolean paidChecked = false;
boolean beginnerChecked = false;
boolean intermediateChecked = false;
boolean advancedChecked = false;

if(selectedFee != null){
    for(String f : selectedFee){
        if(f.equals("free")) freeChecked = true;
        if(f.equals("paid")) paidChecked = true;
    }
}

if(selectedLevel != null){
    for(String l : selectedLevel){
        if(l.equals("beginner")) beginnerChecked = true;
        if(l.equals("intermediate")) intermediateChecked = true;
        if(l.equals("advanced")) advancedChecked = true;
    }
}
%>

<!DOCTYPE html>
<html>
<head>
    <title>Filtered Courses</title>

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

        .sidebar{
            width:260px;
            height:600px;
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
            margin:8px 0;
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

    <h1 class="page-title">Filtered Courses</h1>

    <div class="content-row">

        <!-- Sidebar -->
        <div class="sidebar">
            <form action="FilterCoursesServlet" method="post">

                <h3>Filters</h3>

                <label>
                    <input type="checkbox" name="fee" value="free"
                        <%= freeChecked ? "checked" : "" %> >
                    Free Courses
                </label>

                <label>
                    <input type="checkbox" name="fee" value="paid"
                        <%= paidChecked ? "checked" : "" %> >
                    Paid Courses
                </label>

                <label>
                    <input type="checkbox" name="level" value="beginner"
                        <%= beginnerChecked ? "checked" : "" %> >
                    Beginner
                </label>

                <label>
                    <input type="checkbox" name="level" value="intermediate"
                        <%= intermediateChecked ? "checked" : "" %> >
                    Intermediate
                </label>

                <label>
                    <input type="checkbox" name="level" value="advanced"
                        <%= advancedChecked ? "checked" : "" %> >
                    Advanced
                </label>

                <button type="submit" class="apply-btn">Apply</button>
            </form>

            <h3 style="margin-top:20px;">Categories</h3>
            <div class="category">JAVA</div>
            <div class="category">AI</div>
            <div class="category">PYTHON</div>
            <div class="category">DevOps</div>
        </div>

        <!-- Main Section -->
        <div class="main">
            <div class="course-grid">

            <%
                List<Course> list = (List<Course>) request.getAttribute("courses");

                if(list != null && !list.isEmpty())
                {
                    for(Course c : list)
                    {
            %>

                <div class="course-card">
                    <div class="course-title"><%= c.getTitle() %></div>

                    <div class="course-content">
                        <div class="course-img">
                            <img src="<%= request.getContextPath() %>/assets/profile_pics/<%= c.getProfileImage() %>"
                                 alt="Profile photo">
                        </div>

                        <div>
                            <strong><%= c.getInstructor() %> • <%= c.getFee() %> </strong><br>
                            Fee: <%= c.getPrice() %><br>
                            Level: <%= c.getLevel() %>
                            <br>
                            <a href="schedulesessions.jsp">
                                <button class="enroll-btn">Enroll</button>
                            </a>
                        </div>
                    </div>
                </div>

            <%
                    }
                }
                else
                {
            %>

                <h2>No courses found</h2>

            <%
                }
            %>

            </div>
        </div>

    </div>

</div>

</body>
</html>