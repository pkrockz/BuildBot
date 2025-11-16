<%@page import="java.util.List"%>
<%@page import="buildbot.PresetBuild"%>
<%@page import="org.hibernate.*,org.hibernate.cfg.*"%>

<%
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.html");
        return;
    }

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();

    List<PresetBuild> presetBuilds = s.createQuery("FROM PresetBuild").list();
    s.close();
%>

<html>
<head>
    <title>Explore Builds</title>
    <link rel="stylesheet" href="exploreBuilds.css">
</head>
<body>
<div class="container">
    <h2>Explore New Builds</h2>
    <% for (PresetBuild b : presetBuilds) { %>
        <div class="build-card">
            <b><%= b.getName() %></b> - <%= b.getCiv() %>
            <form action="savePreset.jsp" method="POST" style="margin-top:10px;">
                <input type="hidden" name="buildId" value="<%= b.getId() %>">
                <input type="submit" value="Save to My Builds">
            </form>
        </div>
    <% } %>
    <div class="back-btn">
        <a href="dashboard.html">Back to Dashboard</a>
    </div>
</div>
</body>
</html>
