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
    Transaction t = s.beginTransaction();

    // First delete steps
    Query stepDelete = s.createQuery("DELETE FROM UserBuildStep WHERE build.id = :bid");
    stepDelete.setParameter("bid", buildId);
    stepDelete.executeUpdate();

    // Then delete build (only if user owns it)
    Query buildDelete = s.createQuery("DELETE FROM UserBuild WHERE id = :bid AND createdBy = :uid");
    buildDelete.setParameter("bid", buildId);
    buildDelete.setParameter("uid", userId);
    buildDelete.executeUpdate();

    t.commit();
    s.close();

    response.sendRedirect("myBuilds.jsp");
%>
