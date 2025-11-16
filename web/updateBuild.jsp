<%@page import="buildbot.UserBuild"%>
<%@page import="buildbot.UserBuildStep"%>
<%@page import="org.hibernate.*,org.hibernate.cfg.*"%>

<%
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("index.html");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");

    int buildId = Integer.parseInt(request.getParameter("buildId"));
    String name = request.getParameter("name");
    String civ = request.getParameter("civ");
    String stepsText = request.getParameter("steps");

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();
    Transaction t = s.beginTransaction();

    // Fetch build and update its details
    UserBuild build = (UserBuild) s.get(UserBuild.class, buildId);
    if (build != null && build.getCreatedBy() == userId) {
        build.setName(name);
        build.setCiv(civ);
        s.update(build);

        // Delete old steps
        Query stepDelete = s.createQuery("DELETE FROM UserBuildStep WHERE build.id = :bid");
        stepDelete.setParameter("bid", buildId);
        stepDelete.executeUpdate();

        // Insert new steps
        String[] steps = stepsText.split("\\r?\\n");
        int stepNumber = 1;
        for (String step : steps) {
            UserBuildStep stepObj = new UserBuildStep();
            stepObj.setBuild(build);
            stepObj.setStepNumber(stepNumber++);
            stepObj.setInstruction(step.trim());
            s.persist(stepObj);
        }
    }

    t.commit();
    s.close();

    response.sendRedirect("myBuilds.jsp");
%>
