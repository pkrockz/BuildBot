<%@page import="buildbot.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="org.hibernate.*,org.hibernate.cfg.*"%>
<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    SessionFactory sf = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
    Session s = sf.openSession();

    Query q = s.createQuery("FROM User WHERE email = :email");
    q.setParameter("email", email);
    java.util.List<User> existing = q.list();

    if (!existing.isEmpty()) {
        s.close();
        out.println("<script>alert('Email already registered! Please login.'); window.location='index.html';</script>");
        return;
    }

    Transaction t = s.beginTransaction();
    User u = new User();
    u.setUsername(username);
    u.setEmail(email);
    u.setPassword(password);

    s.persist(u);
    t.commit();
    s.close();

    out.println("<script>alert('Signup successful! Please login.'); window.location='index.html';</script>");
%>
