<%-- 
    Document   : login_check.jsp
    Created on : 26-May-2021, 11:15:14 AM
    Author     : MARCOS
--%>





<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page contentType="text/html" import="java.sql.*, java.util.Date" pageEncoding="UTF-8"%>
<%

    String email = request.getParameter("email");
    String pass = request.getParameter("password");

    try {
        Class.forName("com.mysql.jdbc.Driver");

        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
        Statement st = cn.createStatement();
        Statement st1 = cn.createStatement();
        ResultSet rs = st.executeQuery("select * from user_login where email='" + email + "'");

        if (rs.next()) {

            if (rs.getString("password").equals(pass)) {

                Cookie c = new Cookie("login", email);
                c.setMaxAge(3000);
                response.addCookie(c);
                
                session.setAttribute(email,pass);
                session.setMaxInactiveInterval(2000);
                    


                LocalDate today = LocalDate.now().minusDays(3);
                String formattedDate = today.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
                
                 
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy"); 
                LocalDate dateAgo = LocalDate.parse(formattedDate, formatter);

                
                
                
                     
               

                ResultSet getHistory = st1.executeQuery("select date from history where email='" + email + "'");
                while (getHistory.next()) {
                    String historyStringDate = getHistory.getString(1);
                     
                    
                    LocalDate historyDate = LocalDate.parse(historyStringDate, formatter);
                    out.println(dateAgo.compareTo(historyDate));
                    
                  if((historyDate.compareTo(dateAgo) <= 0)){
                      
                      int deleteHistory = st1.executeUpdate("delete from history where email='" +email+ "'");
                  }
                 

                }
                 response.sendRedirect("index.jsp?login_success=1");

            } else {
                response.sendRedirect("login.jsp?invalid_pass=1");
            }
        } else {
            response.sendRedirect("login.jsp?invalid_email=1");
        }
        cn.close();

    } catch (Exception er) {
        out.print(er.getMessage());
    }


%>
