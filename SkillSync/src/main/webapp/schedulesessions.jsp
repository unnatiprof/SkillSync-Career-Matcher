<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%
  // -----------------------------
  // Demo server-side data (replace with DB/JDBC in integration)
  // -----------------------------
  // logged-in user (simulate session)
  String loggedUser = (String) session.getAttribute("username");
  if (loggedUser == null || loggedUser.isEmpty()) loggedUser = "Unnati";

  // Demo available users (these would normally come from DB query)
  class U { String username, fullName, skill, level, dept, sem, avatar; U(String u,String f,String s,String l,String d,String sem,String a){username=u;fullName=f;skill=s;level=l;dept=d;this.sem=sem;avatar=a;} }
  List<U> available = new ArrayList<>();
  available.add(new U("ananya","Ananya","Java","Intermediate","CSE","2nd Sem","https://i.ibb.co/X3F4kd1/girl.png"));
  available.add(new U("karthik","Karthik","Python","Beginner","Electronics","3rd Sem","https://i.ibb.co/K09TnJR/boy.png"));
  available.add(new U("priya","Priya","Web Dev","Advanced","CSE","4th Sem","https://i.ibb.co/X3F4kd1/girl.png"));
  available.add(new U("rahul","Rahul","C++","Intermediate","IT","5th Sem","https://i.ibb.co/K09TnJR/boy.png"));

  // date helper
  SimpleDateFormat dfDate = new SimpleDateFormat("dd MMM yyyy");
  SimpleDateFormat dfTime = new SimpleDateFormat("hh:mm a");
%>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>SkillSync — Schedule Session</title>

  <!-- Google Font -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap" rel="stylesheet">

  <style>
    :root{
      --bg1: #f2fbff;
      --bg2: #eef8ff;
      --card: #ffffff;
      --accent: #0f6fff;
      --muted: #6b7b8a;
      --glass-shadow: 0 14px 40px rgba(12,55,120,0.06);
      --soft: 0 8px 26px rgba(12,55,120,0.04);
      --radius-lg: 18px;
    }
    *{box-sizing:border-box}
    html,body{height:100%;margin:0;font-family:"Inter",system-ui,-apple-system,Segoe UI,Roboto,"Helvetica Neue",Arial;color:#0b2b45;background:linear-gradient(180deg,var(--bg1),var(--bg2));-webkit-font-smoothing:antialiased}

    /* full-width container (fluid) */
    .page {
      width:100%;
      min-height:100vh;
      padding:44px 48px;
      display:flex;
      justify-content:center;
      align-items:flex-start;
    }

    /* main wide panel that centers content but is fluid horizontally */
    .panel {
      width:100%;
      max-width:1600px;
      border-radius:22px;
      padding:28px;
      background: linear-gradient(180deg, rgba(255,255,255,0.98), rgba(255,255,255,0.95));
      box-shadow: var(--glass-shadow);
      position:relative;
      overflow:visible;
    }

    /* decorative soft blobs (background inside panel) */
    .blob {
      position:absolute;
      width:320px;height:320px;border-radius:50%;filter:blur(70px);opacity:0.12;z-index:0;
    }
    .b1 { left:-80px; top:-80px; background: linear-gradient(90deg,#bfe8ff,#f0faff); }
    .b2 { right:-100px; bottom:-100px; background: linear-gradient(90deg,#e6f7ff,#fff0ff); }

    /* header row */
    .header {
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:16px;
      position:relative;
      z-index:2;
      margin-bottom:18px;
    }
    .title {
      font-size:28px;
      font-weight:800;
      color:#08223e;
    }
    .subtitle {
      font-size:14px;
      color:var(--muted);
      margin-top:6px;
    }
    .profile {
      display:flex;
      gap:12px;
      align-items:center;
      background:linear-gradient(180deg,#fff,#fbfeff);
      padding:8px 12px;border-radius:12px; box-shadow:var(--soft);
    }
    .profile img{ width:44px; height:44px; border-radius:10px; object-fit:cover }
    .profile .meta { font-weight:700; color:#0b3a63; }
    .profile .meta small{ display:block; font-weight:400; color:var(--muted); font-size:12px }

    /* layout grid: left form + right ai+availability */
    .layout {
      display:grid;
      grid-template-columns: 1fr 420px;
      gap:26px;
      margin-top:18px;
      position:relative;
      z-index:2;
    }

    /* FORM card */
    .card {
      background:var(--card);
      border-radius:16px;
      padding:20px;
      box-shadow:var(--soft);
      border:1px solid rgba(12,55,120,0.03);
    }

    .section-title {
      font-size:18px;
      font-weight:800;
      color:#0b3a63;
      margin-bottom:12px;
    }

    .row {
      display:flex;
      gap:12px;
      align-items:center;
      margin-bottom:12px;
    }
    .col { flex:1; }
    .label { font-size:13px;color:var(--muted); margin-bottom:6px; display:block; font-weight:600; }

    input[type="text"], input[type="date"], input[type="time"], select, textarea {
      width:100%;
      padding:12px 14px;
      border-radius:10px;
      border:1px solid #e6eef8;
      background:linear-gradient(180deg,#fff,#fbfeff);
      font-size:14px;
      color:#0b2b45;
      outline:none;
      transition: box-shadow .12s, transform .12s;
    }
    input:focus, select:focus, textarea:focus {
      box-shadow:0 8px 20px rgba(16,103,255,0.08);
      transform: translateY(-2px);
      border-color: rgba(16,103,255,0.16);
    }
    textarea { min-height:86px; resize:vertical; }

    .pill { display:inline-block; background:linear-gradient(90deg,#eef8ff,#f6fbff); padding:6px 10px; border-radius:999px; color:#0b3a63; font-weight:700; font-size:13px; }

    /* big search/skill selector with suggestions */
    .skill-search {
      position:relative;
    }
    .skill-search input { padding-left:44px; }
    .skill-icon {
      position:absolute; left:12px; top:10px; width:28px;height:28px; display:flex; align-items:center; justify-content:center; color:var(--accent);
    }
    .suggestions {
      position:absolute; left:0; right:0; top:56px; background:#fff; border-radius:12px; box-shadow:0 12px 26px rgba(6,50,120,0.08); z-index:30; max-height:220px; overflow:auto; border:1px solid rgba(12,55,120,0.04);
    }
    .suggestions div { padding:10px 12px; cursor:pointer; border-bottom:1px solid rgba(8,40,80,0.03); }
    .suggestions div:hover { background:rgba(16,103,255,0.04); }

    /* schedule button row */
    .actions { display:flex; gap:12px; align-items:center; margin-top:14px; }
    .btn-primary {
      background: linear-gradient(90deg,var(--accent),#3aa0ff);
      color:#fff; padding:12px 18px; border-radius:12px; font-weight:800; border:none; cursor:pointer; box-shadow:0 12px 30px rgba(16,103,255,0.14);
    }
    .btn-ghost {
      background:transparent; padding:10px 14px; border-radius:12px; border:1px solid rgba(12,55,120,0.08); font-weight:700; color:var(--muted); cursor:pointer;
    }
    .small-help { font-size:13px;color:var(--muted); margin-left:6px; }

    /* right column - AI suggestions + availability */
    .ai-card { padding:18px; border-radius:12px; background:linear-gradient(180deg,#fbfeff,#fff); box-shadow:var(--soft); border:1px solid rgba(12,55,120,0.03) }
    .ai-card h4 { margin:0 0 8px 0; color:#0b3a63; font-weight:800 }
    .ai-item { display:flex; gap:10px; align-items:center; padding:8px 6px; border-radius:10px; margin-bottom:8px; transition:transform .12s, box-shadow .12s; }
    .ai-item:hover { transform:translateY(-6px); box-shadow: 0 10px 30px rgba(8,40,90,0.06); }
    .avail-list { display:flex; flex-direction:column; gap:10px; margin-top:8px; max-height:320px; overflow:auto; padding-right:6px; }

    .user-card { display:flex; gap:10px; align-items:center; padding:8px; border-radius:10px; background:linear-gradient(180deg,#fff,#fbfeff); border:1px solid rgba(8,40,80,0.03); }
    .user-card img { width:54px;height:54px;border-radius:10px;object-fit:cover }
    .user-meta { font-weight:700; color:#0b3a63; }
    .user-sub { font-size:13px; color:var(--muted); font-weight:600 }

    /* small nice helper bars */
    .hint { font-size:13px; color:var(--muted); margin-top:8px }

    /* responsive */
    @media (max-width:1120px) {
      .layout { grid-template-columns: 1fr; }
      .panel { padding:18px; border-radius:14px; }
      .profile img { width:40px;height:40px }
    }

  </style>
</head>
<body>
  <div class="page">
  <form action="schedulesessions" method="post" id="sessionForm">
    <div class="panel" role="main" aria-label="Schedule session panel">
      <div class="blob b1" aria-hidden="true"></div>
      <div class="blob b2" aria-hidden="true"></div>

      <!-- header -->
      <div class="header">
      
        <div>
          <div class="title">Schedule a Session</div>
          <div class="subtitle">Pick a time, match with an available learner/teacher and confirm — AI helps you pick the best option.</div>
        </div>

        <div class="profile" aria-hidden="false">
          <img alt="avatar" src="https://images.unsplash.com/photo-1545996124-1f6a5f3f1b4a?q=80&w=400&auto=format&fit=crop&s=7f2a9cb8f8abddf0">
          <div>
            <div class="meta"><%= loggedUser %></div>
            <small>Online</small>
          </div>
        </div>
      </div>

      <!-- layout -->
      <div class="layout">
        <!-- LEFT: scheduling form -->
        <div class="card" aria-labelledby="schedule-form">
          <div class="section-title">Session Details</div>

          <!-- skill selector with suggestions -->
          <div class="skill-search" style="margin-bottom:12px;">
            <label class="label">Skill / Topic</label>
            <div class="skill-icon">🔎</div>
            <input id="skillInput" type="text" placeholder="Type or choose a skill (e.g., Java, Python, Web Dev)" autocomplete="on" name="skills">
            <div id="skillSug" class="suggestions" style="display:none;">
              <div data-val="Java">Java · Backend</div>
              <div data-val="Python">Python · Data Science</div>
              <div data-val="Web Dev">Web Development · Frontend</div>
              <div data-val="ML">Machine Learning · AI</div>
              <div data-val="UI/UX">UI/UX Design</div>
            </div>
          </div>

          <!-- <div class="row">
            <div class="col">
              <label class="label">Match With</label>
              <select id="matchWith">
                <option value="">Select learner/teacher — AI will recommend best matches</option>
                <%--for(U u: available) { %>
                  <option value="<%= u.username %>"><%= u.fullName %> — <%= u.skill %> (<%= u.level %>) — <%= u.dept %>, <%= u.sem %></option>
                <% } --%>
              </select>
            </div> -->
            <input id="matchName" type="text" placeholder="Type the name of the tutor " autocomplete="on" name="matchName">
            <input id="User_name" type="text" placeholder="Your username " autocomplete="on" name="User_Name">
            <input id="Course_name" type="text" placeholder="Enter the course you want to register for " autocomplete="on" name="Course_Name">
            <!--<div class="col">
              <label class="label">Mode</label>
              <select id="mode">
                <option>Online</option>
                <option>Offline</option>
                <option>Hybrid</option>
              </select>
            </div>
          </div>-->

          <div class="row">
            <div class="col">
              <label class="label">Date</label>
              <input id="sdate" type="date" name="sdate">
            </div>
            <div class="col">
              <label class="label">Time</label>
              <input id="stime" type="time"name="stime">
            </div>
          </div>

          <div class="row">
            <div class="col">
              <label class="label">Duration (mins)</label>
              <select id="duration" name="duration">
                <option>30</option>
                <option selected>60</option>
                <option>90</option>
                <option>120</option>
              </select>
            </div>
            <div class="col">
              <label class="label">Platform</label>
              <select id="platform" name="platform">
                <option>Zoom</option>
                <option>Google Meet</option>
              </select>
            </div>
          </div>

          <div style="margin-top:8px;">
            <label class="label">Review</label>
            <textarea id="review" required name="review" placeholder="Type your review here..."></textarea>
          </div>

          <div class="hint">AI Tip: Click <span class="pill">Smart Match</span> to auto-select the best match & time.</div>

          <div class="actions">
            <button id="smartMatch" class="btn-ghost" title="Let AI pick best match">🤖 Smart Match</button>
            <button id="scheduleBtn" class="btn-primary">Schedule Now</button>
            <button id="previewBtn" class="btn-ghost">Preview</button>
          </div>
        </div>

        <!-- RIGHT: AI suggestions + availability -->
        <div class="ai-card" aria-label="AI and availability">
          <h4>AI Suggestions</h4>

          <div class="ai-item">
            <div style="flex:1">
              <div style="font-weight:800;color:#0b3a63">Best Match</div>
              <div style="color:var(--muted);font-size:13px">AI suggests the user below who is available and matches your skill topic.</div>
            </div>
            <div style="text-align:right"><button class="btn-ghost" id="useBest">Use</button></div>
          </div>

          <!-- availability / matches list -->
          <div style="margin-top:12px;font-weight:700;color:#0b3a63">Available Users</div>
          <div class="avail-list" id="availList" role="list">
            <% for(U u : available) { %>
              <div class="user-card" data-username="<%=u.username%>">
                <img src="<%= u.avatar %>" alt="<%=u.fullName%>">
                <div style="flex:1">
                  <div class="user-meta"><%= u.fullName %></div>
                  <div class="user-sub">Wants: <strong style="color:var(--accent)"><%=u.skill%></strong> • <%=u.level%> • <%=u.dept%>, <%=u.sem%></div>
                </div>
                <div style="text-align:right">
                  <div class="pill" style="background:linear-gradient(90deg,#eef9ff,#f6fbff); color:var(--accent);">Available</div>
                  <div style="margin-top:8px"><button class="btn-ghost selectUser" data-username="<%=u.username%>">Select</button></div>
                </div>
              </div>
            <% } %>
          </div>

          <hr style="border:none;height:1px;background:linear-gradient(90deg,#eef6ff,#fff);margin:12px 0">

          <div style="margin-top:8px;">
            <div style="font-weight:800;color:#0b3a63">Quick Actions</div>
            <div style="display:flex;gap:8px;margin-top:10px;">
              <button class="btn-ghost" id="autoSuggest">Auto Suggest Times</button>
              <button class="btn-ghost" id="conflictCheck">Conflict Check</button>
            </div>
          </div>

          <div style="margin-top:12px;">
            <div style="font-weight:800;color:#0b3a63">AI Session Summary</div>
            <div style="color:var(--muted);font-size:13px;margin-top:8px" id="aiSummary">No summary yet. Schedule a session to generate an AI-crafted summary and checklist for the learner.</div>
          </div>

        </div>
      </div>

    </div>
  </div>

  <script>
    // skill suggestions UI
    const skillInput = document.getElementById('skillInput');
    const sug = document.getElementById('skillSug');
    skillInput.addEventListener('input', () => {
      const v = skillInput.value.trim().toLowerCase();
      if (!v) { sug.style.display='none'; return; }
      // show suggestions (simple filter)
      Array.from(sug.children).forEach(d=>{
        d.style.display = d.dataset.val.toLowerCase().includes(v) ? '' : 'none';
      });
      sug.style.display='block';
    });
    sug && sug.addEventListener('click', (e) => {
      if (e.target && e.target.dataset && e.target.dataset.val) {
        skillInput.value = e.target.dataset.val;
        sug.style.display='none';
      }
    });
    document.addEventListener('click', (e)=>{ if (!skillInput.contains(e.target) && !sug.contains(e.target)) sug.style.display='none'; });

    // select user from list
    document.querySelectorAll('.selectUser').forEach(btn=>{
      btn.addEventListener('click', e=>{
        const username = btn.dataset.username;
        // set select value
        const sel = document.getElementById('matchWith');
        for (let i=0;i<sel.options.length;i++){
          if (sel.options[i].value===username) { sel.selectedIndex = i; break; }
        }
        // highlight
        document.querySelectorAll('.user-card').forEach(c=>c.style.outline='none');
        btn.closest('.user-card').style.outline = '3px solid rgba(16,103,255,0.12)';
        // hint
        document.getElementById('aiSummary').textContent = 'Selected ' + username + ' — AI will prepare pre-session checklist when you schedule.';
      });
    });

    // smart match - demo AI action
    document.getElementById('smartMatch').addEventListener('click', ()=>{
      // pick first available user that partially matches skill
      const skill = skillInput.value.trim().toLowerCase();
      let picked = null;
      document.querySelectorAll('.user-card').forEach(c=>{
        const txt = c.querySelector('.user-sub').textContent.toLowerCase();
        if (!picked && skill && txt.includes(skill)) { picked = c; }
      });
      if (!picked) picked = document.querySelector('.user-card');
      if (picked) {
        const selUser = picked.getAttribute('data-username');
        // set select
        const sel = document.getElementById('matchWith');
        for (let i=0;i<sel.options.length;i++){
          if (sel.options[i].value===selUser) { sel.selectedIndex = i; break; }
        }
        picked.style.outline = '3px solid rgba(16,103,255,0.12)';
        document.getElementById('aiSummary').textContent = 'AI picked ' + sel.options[sel.selectedIndex].text + ' as best match based on skills and availability.';
      } else {
        alert('No match found (demo)');
      }
    });

    // Use best
    document.getElementById('useBest').addEventListener('click', ()=>{
      document.getElementById('smartMatch').click();
    });

    // Auto suggest times (demo)
    document.getElementById('autoSuggest').addEventListener('click', ()=>{
      const d = new Date();
      d.setDate(d.getDate() + 2);
      // format YYYY-MM-DD for date input
      const yyyy = d.getFullYear(), mm = String(d.getMonth()+1).padStart(2,'0'), dd = String(d.getDate()).padStart(2,'0');
      document.getElementById('sdate').value = yyyy + '-' + mm + '-' + dd;
      document.getElementById('stime').value = '16:00';
      document.getElementById('aiSummary').textContent = 'AI suggested ' + dd + '/' + mm + '/' + yyyy + ' at 04:00 PM as optimal time.';
    });

    // Conflict check (demo)
    document.getElementById('conflictCheck').addEventListener('click', ()=>{
      // In real app: call backend to verify user's calendar & selected participant calendar
      alert('Conflict check complete — no conflicts found (demo).');
    });

    // schedule button (demo)
    document.getElementById('scheduleBtn').addEventListener('click', ()=>{
      const skill = document.getElementById('skillInput').value;
      const match = document.getElementById('matchWith').value;
      const date = document.getElementById('sdate').value;
      const time = document.getElementById('stime').value;
      if (!skill || !match || !date || !time) {
        alert('Please fill skill, match, date and time.');
        return;
      }
      // demo success
      document.getElementById('aiSummary').textContent = 'Session scheduled with ' + match + ' on ' + date + ' at ' + time + '. AI will send a summary and checklist.';
      alert('Session scheduled (demo). In production this will save to DB and send invites.');
    });

    // preview button opens modal demo
    document.getElementById('previewBtn').addEventListener('click', ()=>{
      const s = document.getElementById('skillInput').value || '[Skill]';
      const m = document.getElementById('matchWith').selectedOptions[0].text || '[Match]';
      const d = document.getElementById('sdate').value || '[Date]';
      const t = document.getElementById('stime').value || '[Time]';
      alert('Preview:\\nSkill: '+s+'\\nMatch: '+m+'\\nDate: '+d+'\\nTime: '+t);
    });
  </script>
</body>
</html>
