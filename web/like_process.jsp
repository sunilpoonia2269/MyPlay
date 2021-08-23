<%-- 
    Document   : like
    Created on : 22-Jun-2021, 2:55:30 PM
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

    String status = request.getParameter("status");
    String vcode = request.getParameter("vcode");
    String isLiked = request.getParameter("isLiked");
    String isDisliked = request.getParameter("isDisliked");

    int likeSn = 0;
    int dislikeSn = 0;
 

     if(email == null && session.getAttribute(email) ==null){
            response.sendRedirect("login.jsp");
        } else {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();

            if (status.equals("1") && isLiked.equals("true")) {
                int deleteFromLike = st.executeUpdate("delete from liked_video where vcode='" + vcode + "'AND email='" + email + "'");
            }

            if (status.equals("1") && isLiked.equals("false")) {
                 int deleteFromDislike = st.executeUpdate("delete from disliked_video where vcode='" + vcode + "'AND email='" + email + "'");
                ResultSet getLikeSn = st.executeQuery("select Max(sn) as sn from liked_video");
                if (getLikeSn.next()) {
                    likeSn = getLikeSn.getInt("sn");
                    likeSn++;
                }

                PreparedStatement updateLiked = cn.prepareStatement("insert into liked_video values(?,?,?)");

                updateLiked.setInt(1, likeSn);
                updateLiked.setString(2, vcode);
                updateLiked.setString(3, email);

                updateLiked.executeUpdate();
                updateLiked.close();

            }
            if (status.equals("0") && isDisliked.equals("true")) {
                int deleteFromDislike = st.executeUpdate("delete from disliked_video where vcode='" + vcode + "'AND email='" + email + "'");
            }

            if (status.equals("0") && isDisliked.equals("false")) {
                int deleteFromLike = st.executeUpdate("delete from liked_video where vcode='" + vcode + "'AND email='" + email + "'");
                
                ResultSet getdislikeSn = st.executeQuery("select Max(sn) as sn from disliked_video");
                if (getdislikeSn.next()) {
                    dislikeSn = getdislikeSn.getInt("sn");
                    dislikeSn++;
                }

                PreparedStatement updateDisliked = cn.prepareStatement("insert into disliked_video values(?,?,?)");

                updateDisliked.setInt(1, dislikeSn);
                updateDisliked.setString(2, vcode);
                updateDisliked.setString(3, email);
                out.println("reached here");

                updateDisliked.executeUpdate();
                updateDisliked.close();

            }
            
            
            
            
            
            
            
            
        } catch (Exception er) {
            out.print(er.getMessage());
        }



    }


%>













