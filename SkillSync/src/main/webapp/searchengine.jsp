<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // SESSION VARIABLES
    String C_name = (String) session.getAttribute("Main_skills");
    String Skill = (String) session.getAttribute("Other_skills");
    String Fullname = (String) session.getAttribute("Fullname");
    String Profile_pic = (String) session.getAttribute("Fullname");

    // DB CONNECTION DETAILS
    String dbUrl = "jdbc:mysql://localhost:3306/skillssync";
    String dbUser = "root";
    String dbPass = "1234";

    // SEARCH INPUT
    String searchQuery = request.getParameter("q");

    List<String> result_course = new ArrayList<>();
    List<String> result_skill = new ArrayList<>();
    List<String> result_img = new ArrayList<>();

    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            String sql = "SELECT fullname, main_skill, other_skills FROM users WHERE main_skill LIKE ? OR other_skills LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + searchQuery + "%");
            ps.setString(2, "%" + searchQuery + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                result_img.add(rs.getString("fullname"));
                result_course.add(rs.getString("main_skill"));
                result_skill.add(rs.getString("other_skills"));
            }

            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            out.println("DB ERROR: " + e.getMessage());
        }
    }
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>SkillSync — Search Engine</title>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <style>
    /* YOUR ORIGINAL CSS (unchanged) */
    :root{
      --bg1: #f3fbff;
      --bg2: #e9f6ff;
      --card: #ffffff;
      --accent: #1677ff;
      --muted: #6a7d8c;
      --soft-shadow: 0 12px 30px rgba(10,40,90,0.06);
      --glass-shadow: 0 8px 24px rgba(10,40,90,0.04);
      --radius: 18px;
    }
    *{box-sizing:border-box}
    html,body{height:100%;margin:0;font-family:"Inter";color:#0b2b45;background:linear-gradient(180deg,var(--bg1),var(--bg2));}
    .page {min-height:100vh;display:flex;align-items:center;justify-content:center;padding:48px;}
    .panel {width:1200px;background:white;border-radius:22px;padding:36px;box-shadow:var(--soft-shadow);position:relative;overflow:hidden;}
    .title {font-size:36px;font-weight:700;margin-bottom:18px;}
    .search-row {display:flex;gap:22px;margin-bottom:24px;}
    .search {flex:1;background:white;border-radius:14px;padding:18px 20px;box-shadow:var(--glass-shadow);display:flex;gap:12px;}
    .search input{border:0;outline:0;background:transparent;font-size:18px;width:100%;}
    .mic{width:48px;height:48px;border-radius:12px;background:linear-gradient(180deg,#5fb0ff,#1677ff);display:flex;align-items:center;justify-content:center;color:#fff;}
    .content {display:grid;grid-template-columns:320px 1fr;gap:24px;}
    .left-col{display:flex;flex-direction:column;gap:18px;}
    .card{background:white;border-radius:14px;padding:18px;box-shadow:var(--glass-shadow);}
    .list-card ul{list-style:none;padding:0;margin:0;}
    .list-card li{padding:12px;border-radius:10px;font-weight:600;margin-bottom:10px;}
    .right-col{display:grid;grid-template-columns:repeat(2,1fr);gap:16px;}
    .course-card{background:white;border-radius:12px;padding:14px;box-shadow:0 10px 28px rgba(10,40,90,0.04);display:flex;gap:12px;}
    .course-avatar img{width:100%;height:100%;object-fit:cover;}
    .enroll{background:#1677ff;color:white;padding:8px 12px;border-radius:10px;border:none;font-weight:700;}
    a{text-decoration:none;color:white;}
  </style>
</head>

<body>

<div class="page">
  <div class="panel">

    <div class="title">Search Engine</div>

    <!-- SEARCH BAR -->
    <div class="search-row">
      <form action="search.jsp" method="get" style="flex:1;">
        <div class="search">
          <input type="search" name="q" placeholder="Search anything..." value="<%= (searchQuery!=null?searchQuery:"") %>"/>
        </div>
      </form>
      <div class="mic">🎤</div>
    </div>

    <div class="content">

      <!-- LEFT SIDE (unchanged) -->
      <div class="left-col">
        <div class="card list-card">
          <ul>
            <li>Data Science</li>
            <li>Machine Learning</li>
            <li>Artificial Intelligence</li>
            <li>Deep Learning</li>
          </ul>
        </div>

        <div class="card">
          <div style="font-weight:800;">Filters</div>
          <div>Category</div>
          <div>Skill Level</div>
          <div>Ratings</div>
          <div>Price</div>
        </div>
      </div>

      <!-- RIGHT SIDE RESULTS -->
      <div style="display:flex;flex-direction:column;gap:16px;">
        <div style="font-weight:700;">Results</div>

        <div class="right-col">

          <%
            // IF USER SEARCHED → SHOW DB RESULTS
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {

                if (result_course.size() == 0) {
          %>

              <div>No results found for "<%= searchQuery %>"</div>

          <%
                } else {
                    for (int i = 0; i < result_course.size(); i++) {
          %>

          <div class="course-card">
            <div class="course-avatar" style="width:72px;height:72px;overflow:hidden;border-radius:10px;">
              <img src="<%= result_img.get(i) %>" />
            </div>

            <div style="flex:1;">
              <div class="course-title"><%= result_course.get(i) %></div>
              <div class="course-sub"><%= result_skill.get(i) %></div>

              <button class="enroll"><a href="schedulesessions.jsp">Enroll</a></button>
            </div>
          </div>

          <%
                    }
                }
            }
            else {
                // DEFAULT CARD USING SESSION VALUES
          %>

          <div class="course-card">
            <div class="course-avatar" style="width:72px;height:72px;overflow:hidden;border-radius:10px;">
              <img src="<%=Profile_pic%>" />
            </div>

            <div style="flex:1;">
              <div class="course-title"><%=C_name%></div>
              <div class="course-sub"><%=Skill%></div>

              <button class="enroll"><a href="schedulesessions.jsp">Enroll</a></button>
            </div>
          </div>

          <% } %>

        </div>
      </div>

    </div>
  </div>
</div>

</body>
</html>
