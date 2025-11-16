<%@page import="buildbot.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="org.hibernate.*,org.hibernate.cfg.*"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();

    Query q = s.createQuery("FROM User WHERE username = :uname AND password = :pass");
    q.setParameter("uname", username);
    q.setParameter("pass", password);

    java.util.List<User> result = q.list();
    s.close();

    if (!result.isEmpty()) {
    User user = result.get(0);   
    session.setAttribute("loggedInUser", user.getUsername());
    session.setAttribute("userId", user.getId());   
    response.sendRedirect("dashboard.html");
    } 
    else {
        out.println("<script>alert('Invalid username or password'); window.location='index.html';</script>");
    }

%>
