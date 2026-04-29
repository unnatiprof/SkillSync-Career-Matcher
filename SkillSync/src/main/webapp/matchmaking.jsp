<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*"%>
<%@ page import="skillsync.Instructor" %>
<%@ page import="java.sql.*"%>

<%
    List<Instructor> matches = 
        (List<Instructor>) request.getAttribute("matches");

    if(matches == null){
        matches = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
<title>SkillSync | AI Match Making Engine</title>

<style>

/* ---------------- ROOT THEME ---------------- */
:root{
    --primary:#4f46e5;
    --primary-dark:#3730a3;
    --accent:#06b6d4;
    --bg:#f8fafc;
    --card:#ffffff;
    --text:#0f172a;
    --muted:#64748b;
    --success:#16a34a;
}

/* -------------- GLOBAL RESET --------------- */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    background:linear-gradient(120deg,#eef2ff,#f8fafc);
    color:var(--text);
}

/* ---------------- NAVBAR ---------------- */
.navbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 50px;
    background:white;
    box-shadow:0 5px 25px rgba(0,0,0,0.05);
}

.logo{
    font-size:24px;
    font-weight:700;
    color:var(--primary);
}

.search-container{
    position:relative;
    width:420px;
}

.search-container input{
    width:100%;
    padding:10px 45px 10px 20px;
    border-radius:30px;
    border:1px solid #e2e8f0;
    outline:none;
    transition:0.3s;
}

.search-container input:focus{
    border-color:var(--primary);
    box-shadow:0 0 10px rgba(79,70,229,0.2);
}

.profile{
    font-weight:600;
    color:var(--primary-dark);
}

/* ------------- MAIN GRID LAYOUT ------------- */
.main-container{
    display:grid;
    grid-template-columns:260px 1fr 320px;
    gap:25px;
    padding:30px 50px;
    min-height:calc(100vh - 80px);
}

/* ------------- SIDEBAR ------------- */
.sidebar{
    background:var(--card);
    border-radius:20px;
    padding:20px;
    box-shadow:0 10px 40px rgba(0,0,0,0.05);
    display:flex;
    flex-direction:column;
    gap:15px;
}

.sidebar h3{
    color:var(--primary-dark);
}

.sidebar label{
    font-size:14px;
    color:var(--muted);
}

.sidebar input[type=checkbox]{
    margin-right:6px;
}

.btn{
    padding:10px;
    border-radius:10px;
    border:none;
    cursor:pointer;
    font-weight:600;
}

.btn-primary{
    background:var(--primary);
    color:white;
}

.btn-secondary{
    background:#e2e8f0;
}

/* ------------- CENTER CONTENT ------------- */
.content{
    display:flex;
    flex-direction:column;
    gap:20px;
}

/* Stats */
.stats{
    display:grid;
    grid-template-columns:repeat(3,1fr);
    gap:15px;
}

.stat-card{
    background:white;
    padding:15px;
    border-radius:15px;
    text-align:center;
    box-shadow:0 8px 25px rgba(0,0,0,0.05);
}

.stat-card h4{
    color:var(--primary);
}

/* Instructor Card */
.card{
    background:white;
    border-radius:20px;
    padding:20px;
    display:flex;
    justify-content:space-between;
    box-shadow:0 10px 35px rgba(0,0,0,0.06);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
    box-shadow:0 15px 45px rgba(0,0,0,0.1);
}

.left{
    display:flex;
    gap:20px;
}

.profile-img{
    width:110px;
    height:110px;
    border-radius:50%;
    background-size:cover;
    background-position:center;
    background-color:#e2e8f0;
}

.badge{
    background:var(--success);
    color:white;
    padding:4px 10px;
    border-radius:20px;
    font-size:12px;
}

.tags span{
    background:#e0f2fe;
    color:#0369a1;
    padding:5px 8px;
    border-radius:8px;
    font-size:12px;
    margin-right:6px;
}

.right{
    text-align:right;
    display:flex;
    flex-direction:column;
    justify-content:center;
    gap:10px;
}

/* ------------- RIGHT PANEL ------------- */
.refine{
    background:white;
    padding:20px;
    border-radius:20px;
    box-shadow:0 10px 40px rgba(0,0,0,0.05);
    display:flex;
    flex-direction:column;
    gap:15px;
}

.refine input[type=range]{
    width:100%;
}

.slider-value{
    font-size:14px;
    color:var(--primary);
    font-weight:600;
}

</style>
</head>

<body>

<div class="navbar">
    <div class="logo">SkillSync AI</div>
    <div class="search-container">
        <form action="MatchMakingServlet" method="get">
            <input type="text" name="keyword" placeholder="Search by instructor, skills...">
        </form>
    </div>
    <div class="profile">Welcome, Ankita</div>
</div>

<div class="main-container">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <h3>Preferences</h3>

        <label><input type="checkbox" name="skills" value="Java"> Java</label>
        <label><input type="checkbox" name="skills" value="Python"> Python</label>
        <label><input type="checkbox" name="skills" value="AI"> AI</label>
        <label><input type="checkbox" name="skills" value="DevOps"> DevOps</label>

        <button class="btn btn-secondary">Reset</button>
        <button class="btn btn-primary">Apply</button>
    </div>

    <!-- CONTENT -->
    <div class="content">

        <!-- STATS -->
        <div class="stats">
            <div class="stat-card">
                <h4>24</h4>
                <p>Total Matches</p>
            </div>
            <div class="stat-card">
                <h4>4.8 ⭐</h4>
                <p>Average Rating</p>
            </div>
            <div class="stat-card">
                <h4>12</h4>
                <p>Available Now</p>
            </div>
        </div>

        <!-- DYNAMIC INSTRUCTOR CARDS -->
        <%
            for(Instructor i : matches){
        %>
        <div class="card">
            <div class="left">

                <!-- Dynamic Image Div -->
                <div class="profile-img"
                     style="background-image:url('assets/profile_pics/<%= i.getProfileImage() %>');">
                </div>

                <div>
                    <h3>
                        <%= i.getName() %> 
                        <span class="badge">AI Match 92%</span>
                    </h3>

                    <p>₹<%= i.getHourlyRate() %>/hr • 
                       <%= i.getExperience() %> yrs exp • 
                       ⭐ <%= i.getRating() %></p>

                    <div class="tags">
                        <span><%= i.getSkills() %></span>
                        <span><%= i.getLanguage() %></span>
                    </div>

                    <p style="font-size:13px;color:var(--muted);margin-top:8px;">
                        Recommended based on your learning history & preferences.
                    </p>
                </div>
            </div>

            <div class="right">
                <button class="btn btn-primary">Book Trial</button>
                <button class="btn btn-secondary">View Profile</button>
            </div>
        </div>
        <%
            }
        %>

    </div>

    <!-- REFINE PANEL -->
    <div class="refine">
        <h3>Refine Match Score</h3>
        <form action="MatchMakingServlet" method="get">

        <label>Max Budget</label>
        <input type="range" name="budget" min="500" max="5000">
        <div class="slider-value">₹ 3000</div>

        <label>Minimum Experience</label>
        <input type="range" name="experience" min="1" max="10">
        <div class="slider-value">5 Years</div>

        <button class="btn btn-primary">Update Results</button>
    </div>

</div>

</body>
</html>