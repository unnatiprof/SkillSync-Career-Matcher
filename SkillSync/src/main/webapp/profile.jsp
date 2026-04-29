<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- profile.jsp - SkillSync profile UI sample (HTML+CSS embedded). --%>
<%
    // Demo data — replace these with session / DB values in real app// 
    String fname = (String) session.getAttribute("Fullname");//last bracket variables are the avriables used in login.java while setting the attributes
    String role = (String) session.getAttribute("Role");
    String email = (String) session.getAttribute("Email");
    String city = (String) session.getAttribute("City");
    String avatarUrl = (String) session.getAttribute("Profile_img");
    String M_Skill = (String) session.getAttribute("Main_skills");
    int sessionsCount = 0; /*session.getAttribute("Fullname");*/
    int learnersCount = 0;/*(String) session.getAttribute("Fullname");*/
    String upcomingSessionDate = "20 Aug, 1:00 PM";//(String) session.getAttribute("Fullname");
    String upcomingSessionTitle = "Basic Python";//(String) session.getAttribute("Fullname");
    String latestReview ="Great Perl session with John, he was very helpful.";// (String) session.getAttribute("Fullname");
    String curr_project = (String) session.getAttribute("Current_project");

    //String fullname = "John Doe";
    //String role = "Learner & Teacher";
    //String email = "john.doe@email.com";
    //String location = "Somewhere City";
    //String avatarUrl = "https://images.unsplash.com/photo-1595152772835-219674b2a8a6?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&s=3b9a2e7e3f1f6b7a8a1b3d1b9d5f3b50";
   // int sessionsCount = 50;
   // int learnersCount = 15;
   // String upcomingSessionDate = "20 Aug, 1:00 PM";
   // String upcomingSessionTitle = "Basic Python";
   // String latestReview = "Great Perl session with John, he was very helpful.";
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>SkillSync — My Profile</title>

  <!-- Google font -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <style>
    :root{
      --blue-1: #eaf7ff;
      --blue-2: #d7f0ff;
      --accent: #0f4ea8;
      --cta: #1677ff;
      --muted: #6c7a89;
      --card: #ffffff;
      --glass: rgba(255,255,255,0.7);
    }

    html,body{
      height:100%;
      margin:0;
      font-family: "Inter", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
      background:
        radial-gradient(1200px 600px at 10% 10%, rgba(79,162,255,0.08), transparent 15%),
        radial-gradient(900px 400px at 95% 20%, rgba(80,200,255,0.06), transparent 10%),
        linear-gradient(180deg, #f6fbff 0%, #eaf7ff 35%, #f1fbff 100%);
      -webkit-font-smoothing:antialiased;
      -moz-osx-font-smoothing:grayscale;
    }

    /* page layout */
    .page {
      max-width: 1400px;
      margin: 40px auto;
      padding: 40px;
      position: relative;
    }

    /* top header */
    .topbar {
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:20px;
      margin-bottom: 28px;
    }
    .brand {
      display:flex;
      align-items:center;
      gap:14px;
    }
    .brand .logo {
      width:60px;
      height:px;
      border-radius:12px;
      background: linear-gradient(135deg,#ffb86b,#7c5cff);
      display:flex;
      justify-content:center;
      align-items:center;
      box-shadow: 0 6px 18px rgba(124,92,255,0.18);
    }
    .brand .logo svg{ width:30px; height:30px; color:white; transform:translateY(-2px); }
    .brand .title {
      font-weight:800;
      font-size:20px;
      color:var(--accent);
    }

    .page-title {
      text-align:center;
      margin: 6px 0 32px;
    }
    .page-title h1{
      font-size:48px;
      color: #08223e;
      margin-bottom:10px;
      letter-spacing: -0.02em;
    }
    .page-title p{
      margin:0;
      color: #627480;
      font-size:18px;
    }

    /* main card */
    .profile-card {
      background: linear-gradient(180deg, rgba(255,255,255,0.95), rgba(255,255,255,0.95));
      border-radius:18px;
      padding:28px;
      box-shadow: 0 10px 30px rgba(20,60,120,0.06);
      display:grid;
      grid-template-columns: 220px 1fr 220px;
      gap:22px;
      align-items:start;
    }

    /* avatar column */
    .avatar-wrap {
      display:flex;
      flex-direction:column;
      align-items:center;
      gap:14px;
      padding-top:6px;
    }
    .avatar {
      width:150px;
      height:150px;
      border-radius:999px;
      overflow:hidden;
      border: 6px solid rgba(255,255,255,0.9);
      box-shadow: 0 12px 30px rgba(7,27,58,0.06), 0 6px 12px rgba(0,0,0,0.04) inset;
    }
    .avatar img{ width:100%; height:100%; object-fit:cover; display:block; }

    .small-stats {
      display:flex;
      gap:12px;
      width:100%;
      justify-content:center;
    }
    .stat {
      background: linear-gradient(180deg,#ffffff,#fbfdff);
      border-radius:12px;
      padding:12px 14px;
      min-width:88px;
      text-align:center;
      box-shadow: 0 6px 18px rgba(8,34,60,0.04);
    }
    .stat strong { display:block; font-size:20px; color:var(--cta); }
    .stat span { display:block; font-size:12px; color:var(--muted); margin-top:6px; }

    /* center profile details */
    .profile-main {
      padding-top:6px;
    }
    .profile-main h2 {
      font-size:32px;
      color:#08223e;
      margin:4px 0 6px;
      font-weight:700;
    }
    .profile-main .role {
      color: #465c70;
      font-weight:600;
      margin-bottom:8px;
    }
    .profile-main .meta {
      color: #6d7f90;
      font-size:14px;
      margin-bottom:12px;
    }

    .tags {
      display:flex;
      flex-wrap:wrap;
      gap:10px;
      margin:16px 0 22px;
    }
    .tag {
      background: linear-gradient(90deg, rgba(14,122,255,0.06), rgba(124,92,255,0.03));
      color: #063a7a;
      border-radius:28px;
      padding:8px 14px;
      font-weight:600;
      box-shadow: 0 6px 14px rgba(31,87,171,0.04);
      transition: transform 0.25s ease, box-shadow 0.25s;
      cursor:default;
    }
    .tag:hover { transform:translateY(-4px); box-shadow: 0 14px 26px rgba(31,87,171,0.09); }

    /* right column with edit button and badge */
    .profile-actions {
      display:flex;
      flex-direction:column;
      align-items:center;
      gap:14px;
      padding-top:6px;
    }
    .edit-btn {
      background:linear-gradient(180deg,var(--cta),#155fd8);
      color:#fff;
      padding:10px 18px;
      border-radius:12px;
      border:none;
      font-weight:700;
      cursor:pointer;
      box-shadow: 0 12px 30px rgba(21,95,216,0.18);
      transition: transform .18s ease;
    }
    .edit-btn:hover{ transform:translateY(-3px); }

    .badge {
      background: linear-gradient(90deg,#f5fcff,#fff);
      padding:10px 16px;
      border-radius:16px;
      color:#0b4ea8;
      font-weight:700;
      box-shadow: 0 8px 20px rgba(5,66,130,0.05);
      display:flex;
      align-items:center;
      gap:8px;
    }

    /* info grid below */
    .info-grid{
      margin-top:22px;
      display:grid;
      grid-template-columns: repeat(2, 1fr);
      gap:18px;
    }

    .info-card {
      background: radial-gradient(1200px 600px at 10% 10%, rgba(79,162,255,0.08), transparent 15%),
        radial-gradient(900px 400px at 95% 20%, rgba(80,200,255,0.06), transparent 10%),
        linear-gradient(180deg, #f6fbff 0%, #eaf7ff 35%, #f1fbff 100%);
      -webkit-font-smoothing:antialiased;
      -moz-osx-font-smoothing:grayscale;
      border-radius:14px;
      padding:16px;
      box-shadow: 0 8px 22px rgba(20,60,110,0.04);
    }
    .info-card h3{ margin:0 0 10px; color: #0b3d66; }
    .info-small {
      display:flex;
      gap:12px;
      align-items:center;
    }
    .pill {
      background: linear-gradient(90deg,#ffe7f0,#ffeef8);
      border-radius:12px;
      padding:6px 10px;
      color:#6b3b6d;
      font-weight:700;
      margin-left:auto;
    }

    /* cards inside grid */
    .stats-grid{
      display:flex;
      gap:12px;
      margin-top:8px;
    }
    .stat-box{
      flex:1;
      background: linear-gradient(180deg,#ffffff,#f7fbff);
      border-radius:12px;
      padding:12px;
      text-align:center;
      box-shadow: 0 8px 18px rgba(10,40,80,0.04);
    }
    .stat-box .num{ font-size:22px; color:var(--cta); font-weight:800; }
    .stat-box .lbl{ color:var(--muted); font-size:12px; margin-top:6px; }

    .right-cards { display:grid; gap:12px; grid-template-columns:1fr; }

    .session-card {
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:12px;
      padding:12px;
      border-radius:10px;
      background: linear-gradient(180deg,#ffffff,#f7fbff);
      box-shadow: 0 6px 16px rgba(7,27,58,0.03);
    }
    .session-card .meta { color:#2b4b65; font-weight:700; }
    .session-card .sub { color:var(--muted); font-size:13px; margin-top:6px; }
    .session-card .cta {
      background: transparent;
      border: 1px solid var(--cta);
      color: var(--cta);
      padding:8px 12px;
      border-radius:10px;
      cursor:pointer;
      font-weight:700;
    }
    .session-card .cta:hover { background: rgba(22,119,255,0.06); }

    .review {
      background:linear-gradient(180deg,#ffffff,#f7fbff);
      padding:12px;
      border-radius:10px;
      color:#124a6b;
    }

    /* small polish and floating blob animation (soft) */
    .blob {
      position:absolute;
      width:240px; height:220px;
      border-radius:50%;
      filter: blur(60px);
      opacity:0.16;
      pointer-events:none;
      animation: float 8s ease-in-out infinite;
      z-index:0;
    }
    .blob.b1 { left:-60px; top:-40px; background:linear-gradient(90deg,#9fd8ff,#e6f8ff); animation-delay:0s; }
    .blob.b2 { right:-40px; bottom: -80px; background:linear-gradient(90deg,#d7e9ff,#fff0ff); animation-delay:2s; }

    @keyframes float {
      0% { transform: translateY(0) translateX(0) scale(1); }
      50% { transform: translateY(-12px) translateX(6px) scale(1.02); }
      100% { transform: translateY(0) translateX(0) scale(1); }
    }

    /* responsive tweaks */
    @media (max-width: 980px){
      .page { padding:20px; }
      .page-title h1 { font-size:36px; }
      .profile-card { grid-template-columns: 140px 1fr; }
      .profile-actions { display:none; }
      .info-grid { grid-template-columns:1fr; }
    }
    @media (max-width:600px){
      .page-title h1 { font-size:28px; }
      .avatar { width:120px; height:120px; }
      .profile-card { grid-template-columns: 1fr; }
      .small-stats { flex-direction:row; gap:8px; }
    }

  </style>
</head>
<body>
  <div class="page">

    <div class="blob b1" aria-hidden="true"></div>
    <div class="blob b2" aria-hidden="true"></div>

    <div class="topbar" style="z-index:2;">
      <div class="brand">
        <div class="logo" aria-hidden="true">
          <!-- book icon svg -->
          <img src="https://img.icons8.com/color/48/000000/open-book--v2.png"
				alt="logo">
          
        </div>
        <div class="title">SkillSync</div>
      </div>

      <div style="display:flex;gap:12px;align-items:center;">
        <div style="color:#274b6f;font-weight:700;background:rgba(255,255,255,0.9);padding:8px 14px;border-radius:14px;box-shadow:0 8px 20px rgba(6,48,90,0.06);"><button class="cta"><a href="schedulesessions.jsp">Edit Profile</a></button> </div>
      </div>
    </div>

    <div class="page-title">
      <h1>My Profile</h1>
      <p>Search and enroll in courses that match your interests</p>
    </div>

    <section class="profile-card" role="region" aria-label="Profile card">
      <!-- column 1: avatar + mini stats -->
      <div class="avatar-wrap" style="z-index:3;">
        <div class="avatar">
          <img src="assets/profile_pics/<%= avatarUrl %>" alt="Profile photo of <%= fname %>">
        </div>

     <div class="small-stats" aria-hidden="true">
          <!--<div class="stat">
             <strong><%= sessionsCount %></strong>
            <span>Sessions</span>
          </div>
          <div class="stat">
            <strong><%= learnersCount %></strong>
            <span>Learners</span>
          </div>-->
        </div>
      </div>

      <!-- column 2: main details -->
      <div class="profile-main" style="z-index:3;">
        <h2><%= fname %></h2>
        <div class="role"><%= role %></div>
        <div class="meta"><%= email %> • <%= city %></div>

        <div style="display:flex;gap:12px;align-items:center;">
          <div style="font-weight:700;color:#0b4ea8;background:linear-gradient(90deg,#f2fbff,#fff);padding:8px 12px;border-radius:18px;">SKIlls & Learning Interests</div>
        </div>

        <div class="tags" aria-label="Skills list">
          <div class="tag"><%=M_Skill %></div>
          <div class="tag">Python</div>
          <div class="tag">AI & ML</div>
          <div class="tag">Digital Marketing</div>
          <div class="tag">UI/UX</div>
        </div>

        <!-- info grid -->
        <div class="info-grid">
          <div class="info-card">
            <h3>Your Stats</h3>
            <div class="stats-grid">
              <div class="stat-box">
                <div class="num"><%= sessionsCount %></div>
                <div class="lbl">Sessions</div>
              </div>
              <div class="stat-box">
                <div class="num"><%= learnersCount %></div>
                <div class="lbl">Learners</div>
              </div>
            </div>
          </div>

          <div class="info-card">
            <h3>Current Projects</h3>
            <div style="display:flex;flex-direction:column;gap:10px;margin-top:8px;">
              <div class="session-card">
                <div>
                  <div class="meta"><%=curr_project %></div>
                  <!-- <div class="sub">Active</div> -->
                </div>
                <!-- <a href="schedulesessions.jsp">Enroll</a> -->
                <button class="cta"><a href="schedulesessions.jsp">Enroll</a></button>
              </div>

              <div class="session-card">
                <div>
                  <div class="meta">Machine Learning Model</div>
                  <div class="sub">Update Required</div>
                </div>
                <button class="cta"><a href="schedulesessions.jsp">Enroll</a></button>
              </div>
            </div>
          </div>
        </div>

        <!-- more grid under -->
        <div class="info-grid" style="margin-top:14px;">
          <div class="info-card">
            <h3>Latest Review</h3>
            <div class="review">
              “<%= latestReview %>” <div style="margin-top:8px;font-weight:700;color:#0b4ea8;">— Sarah L.</div>
            </div>
          </div>

          <div class="info-card">
            <h3>Upcoming Session</h3>
            <div style="margin-top:8px;">
              <div style="font-weight:800;color:#0b4ea8;"><%= upcomingSessionDate %></div>
              <div style="color:var(--muted);margin-top:6px;"><%= upcomingSessionTitle %></div>
            </div>
          </div>
        </div>

      </div>

      <!-- column 3: actions & badges -->
 <!-- <div class="profile-actions" style="z-index:3;">
        <div class="badge" title="All skills enabled">All SKILL!</div>
        <button class="edit-btn">Edit Profile</button>

        <div style="width:100%; margin-top:6px;">
          <div style="font-weight:700;color:#0b4ea8;margin-bottom:8px;">AI Helper</div>
          <div style="background:linear-gradient(180deg,#fff,#fbfdff);border-radius:12px;padding:12px;text-align:center;box-shadow: 0 8px 20px rgba(10,40,80,0.03);">
            <div style="font-weight:800;color:#124a6b;">Suggest Skills</div>
            <div style="color:var(--muted);font-size:13px;margin-top:8px;">AI suggests courses & matches</div>
            <button style="margin-top:10px;background:linear-gradient(90deg,#5ab0ff,#1677ff);color:#fff;padding:8px 12px;border-radius:10px;border:none;cursor:pointer;font-weight:700;">Run AI</button>
          </div>
        </div>
      </div>-->
    </section>

  </div>
</body>
</html>
