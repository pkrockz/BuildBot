<%@page import="buildbot.UserBuild"%>
<%@page import="buildbot.UserBuildStep"%>
<%@page import="buildbot.PresetBuild"%>
<%@page import="buildbot.PresetBuildStep"%>
<%@page import="org.hibernate.*,org.hibernate.cfg.*"%>
<%@page import="java.util.List"%>

<%
    String loggedInUser = (String) session.getAttribute("loggedInUser");
    Integer userId = (Integer) session.getAttribute("userId");

    if (loggedInUser == null || userId == null) {
        response.sendRedirect("login.html");
        return;
    }

    String buildIdStr = request.getParameter("buildId");
    if (buildIdStr == null || buildIdStr.isEmpty()) {
        out.println("<p>Error: Build ID missing.</p>");
        return;
    }

    int buildId = Integer.parseInt(buildIdStr);

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();
    Transaction t = s.beginTransaction();

    try {
        // Fetch the preset build
        PresetBuild preset = (PresetBuild) s.get(PresetBuild.class, buildId);

        if (preset != null) {
            // Save build into user_builds
            UserBuild newBuild = new UserBuild();
            newBuild.setName(preset.getName());
            newBuild.setCiv(preset.getCiv());
            newBuild.setCreatedBy(userId);

            s.persist(newBuild);
            s.flush(); // ensure newBuild ID is generated

            // Fetch steps of preset build
            Query stepQuery = s.createQuery("FROM PresetBuildStep ps WHERE ps.build.id = :bid ORDER BY ps.stepNumber");
            stepQuery.setParameter("bid", preset.getId());

            List<PresetBuildStep> presetSteps = stepQuery.list();

            // Copy steps into user_build_steps
            for (PresetBuildStep ps : presetSteps) {
                UserBuildStep ubs = new UserBuildStep();
                ubs.setInstruction(ps.getInstruction());
                ubs.setStepNumber(ps.getStepNumber());
                ubs.setBuild(newBuild);  // link step to new user build
                s.persist(ubs);
            }

            t.commit();

            out.println("<script>alert('Build + Steps saved successfully!');window.location='exploreBuilds.jsp';</script>");
        } else {
            out.println("<p>Error: Preset build not found.</p>");
        }
    } catch (Exception e) {
        if (t != null) t.rollback();
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        s.close();
    }
%>
