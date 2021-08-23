<%-- 
    Document   : edit_video
    Created on : 06-Jul-2021, 5:46:13 PM
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

    if (email == null && session.getAttribute(email) == null) {
        response.sendRedirect("login.jsp");
    } else {

        String vcode = request.getParameter("vcode");
        String title = request.getParameter("title");
        String chCode = request.getParameter("chcode");
        int videoCount = 0;

        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();
 
            ResultSet getVideoCount = st.executeQuery("select videocount from channel where chcode='" + chCode + "'");
            if (getVideoCount.next()) {
                
                videoCount = Integer.parseInt(getVideoCount.getString(1));
            }

            if (title.equals("1")) {
                ResultSet rs = st.executeQuery("select * from uploaded_videos where vcode=" + vcode + "");
                if (rs.next()) {

                    out.print(rs.getString("title"));
                }
            }

            if (title.equals("2")) {
                ResultSet rs = st.executeQuery("select description from uploaded_videos where vcode=" + vcode + "");
                if (rs.next()) {
                    out.print(rs.getString(1).trim());
                }
            }

            if (title.equals("3")) {
                videoCount--;
                PreparedStatement updateChannel = cn.prepareStatement("update channel set videoCount=? where chcode='"+chCode+"'");
                updateChannel.setInt(1, videoCount);
                updateChannel.executeUpdate();
                updateChannel.close();

                int deleteVideo = st.executeUpdate("delete from uploaded_videos where vcode='" + vcode + "'");

                out.println(deleteVideo);
            }

        } catch (Exception er) {
            out.println(er.getMessage());
        }
    }


%>

