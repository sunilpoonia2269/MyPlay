<%-- 
    Document   : logout
    Created on : 02-Jun-2021, 11:52:23 AM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

 Cookie c = new Cookie("login","");
c.setMaxAge(0);
response.addCookie(c);

session.invalidate();
response.sendRedirect("index.jsp?logout=1");







%>
