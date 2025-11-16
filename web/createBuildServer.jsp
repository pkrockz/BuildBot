<%@page import="buildbot.UserBuild"%>
<%@page import="buildbot.UserBuildStep"%>
<%@page import="org.hibernate.*,org.hibernate.cfg.*"%>

<%
    // Ensure the user is logged in
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.html");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");

    // Get form inputs
    String name = request.getParameter("name");
    String civ = request.getParameter("civ");
    String stepsText = request.getParameter("steps");

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();
    Transaction t = s.beginTransaction();

    // Create the build
    UserBuild b = new UserBuild();
    b.setName(name);
    b.setCiv(civ);
    b.setCreatedBy(userId);
    s.persist(b);

    // Save the steps
    if (stepsText != null && !stepsText.trim().isEmpty()) {
        String[] steps = stepsText.split("\\r?\\n");
        int stepNumber = 1;
        for (String step : steps) {
            UserBuildStep stepObj = new UserBuildStep();
            stepObj.setBuild(b);
            stepObj.setStepNumber(stepNumber++);
            stepObj.setInstruction(step.trim());
            s.persist(stepObj);
        }
    }

    t.commit();
    s.close();

    out.println("<script>alert('Build created successfully!'); window.location='myBuilds.jsp';</script>");
%>