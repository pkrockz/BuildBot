<%@page import="java.util.List"%>
<%@page import="buildbot.UserBuild"%>
<%@page import="buildbot.UserBuildStep"%>
<%@page import="org.hibernate.*,org.hibernate.cfg.*"%>

<%
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.html");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");

    int buildId = Integer.parseInt(request.getParameter("buildId"));

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();

    UserBuild build = (UserBuild) s.get(UserBuild.class, buildId);
    List<UserBuildStep> steps = s.createQuery(
        "FROM UserBuildStep WHERE build.id = :bid ORDER BY stepNumber")
        .setParameter("bid", buildId).list();

    s.close();
%>

<html>
    <head>
        <link rel="stylesheet" href="style.css">
    </head>
    <body style = "background-image: url('images/builds.png');">
        <div class="panel">
            <h2>Edit Build</h2>
        <form action="updateBuild.jsp" method="POST">
            <input type="hidden" name="buildId" value="<%= build.getId() %>">
            Name: <input type="text" name="name" value="<%= build.getName() %>" required><br>
            Civilization: <input type="text" name="civ" value="<%= build.getCiv() %>" required><br>
            Steps (one per line):<br>
            <textarea name="steps" rows="5" cols="50" required><%
                for (UserBuildStep step : steps) {
                    out.print(step.getInstruction() + "\n");
                }
            %></textarea><br>
            <input type="submit" value="Update Build">
        </form>
        <a href="myBuilds.jsp">Cancel</a>
        </div>
    </body>
</html>
