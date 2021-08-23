<%-- 
    Document   : favourite_process
    Created on : 22-Jun-2021, 2:24:24 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%

    Cookie c[] = request.getCookies();

    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }
    String chCode = request.getParameter("chcode");
    String isFav = request.getParameter("status");
    String vcode = request.getParameter("vcode");
    int sn = 0;

     if(email == null && session.getAttribute(email) ==null){
            response.sendRedirect("login.jsp");
        } else {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select Max(sn) as sn from favourite");
            if (rs.next()) {
                sn = rs.getInt("sn");
                sn++;
            }

            if (isFav.equals("true")) {
                int updateFav = st.executeUpdate("delete from favourite where vcode='" + vcode + "'AND email='" + email + "'");
            }

            if (isFav.equals("false")) {

                PreparedStatement updateFav = cn.prepareStatement("insert into favourite values(?,?,?,?)");

                updateFav.setInt(1, sn);
                updateFav.setString(2, vcode);
                updateFav.setString(3, chCode);
                updateFav.setString(4, email);
                updateFav.executeUpdate();
                updateFav.close();

            }
        } catch (Exception er) {
            out.print(er.getMessage());
        }

    }


%>





