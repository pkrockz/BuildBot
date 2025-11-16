<%@page import="java.util.List"%>
<%@page import="buildbot.UserBuild"%>
<%@page import="buildbot.UserBuildStep"%>
<%@page import="org.hibernate.*,org.hibernate.cfg.*"%>

<%
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    Integer userId = (Integer) session.getAttribute("userId");

    if (loggedInUser == null || userId == null) {
        response.sendRedirect("login.html");
        return;
    }

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();

    Query buildQuery = s.createQuery("FROM UserBuild ub WHERE ub.createdBy = :uid");
    buildQuery.setParameter("uid", userId);
    List<UserBuild> builds = buildQuery.list();
%>

<html>
<head>
    <link rel="stylesheet" href="builds.css">
</head>
<body class="mybuilds">

<div class="panel"> 
    <h2>My Builds</h2>
<% if (builds.isEmpty()) { %>
    <p>You don't have any builds yet.</p>
<% } else { %>
    <% for (UserBuild b : builds) { %>
        <div class="build-card">
            <h3><%= b.getName() %> - <%= b.getCiv() %></h3>

            <ul class="steps-list">
            <%
                Query stepQuery = s.createQuery("FROM UserBuildStep us WHERE us.build.id = :bid ORDER BY us.stepNumber");
                stepQuery.setParameter("bid", b.getId());
                List<UserBuildStep> steps = stepQuery.list();

                for (UserBuildStep step : steps) {
            %>
                    <li>Step <%= step.getStepNumber() %>: <%= step.getInstruction() %></li>
            <%
                }
            %>
            </ul>

            <div class="actions">
                <!-- Edit button -->
                <form action="editBuild.jsp" method="GET" style="display:inline;">
                    <input type="hidden" name="buildId" value="<%= b.getId() %>">
                    <input type="submit" value="Edit" class="btn">
                </form>

                <!-- Delete button -->
                <form action="deleteBuild.jsp" method="POST" style="display:inline;">
                    <input type="hidden" name="buildId" value="<%= b.getId() %>">
                    <input type="submit" value="Delete" class="btn">
                </form>
            </div>
        </div>
    <% } %>
<% } %>

<div class="back-btn">
    <a href="dashboard.html">Back to Dashboard</a>
</div>

</div>
</body>
</html>

<%
    s.close();
%>
