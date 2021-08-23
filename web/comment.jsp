<%-- 
    Document   : comment
    Created on : 05-Jul-2021, 3:39:58 PM
    Author     : MARCOS
--%>


<%@page import="java.util.Collections"%>
<%@page import="java.util.LinkedList"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<%

    Cookie cookie[] = request.getCookies();

    String email = null;
    for (int i = 0; i < cookie.length; i++) {
        if (cookie[i].getName().equals("login")) {
            email = cookie[i].getValue();
        }
    }

    String vcode = request.getParameter("vcode");
    String status = request.getParameter("status");
    String comment = request.getParameter("message");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
        Statement st = cn.createStatement();

        if (email != null && session.getAttribute(email) != null) {
            int sn = 1;

            if (status.equals("add")) {

                String userName = "";

                ResultSet getName = st.executeQuery("select name from user_login where email='" + email + "'");
                if (getName.next()) {
                    userName = getName.getString(1);
                }

                ResultSet rs = st.executeQuery("select Max(sn) as sn from comment_table");
                if (rs.next()) {
                    sn = rs.getInt("sn");
                    sn++;
                }

                String code = "";
                LinkedList l = new LinkedList();
                for (char c = 'A'; c <= 'Z'; c++) {
                    l.add(c + "");
                }
                for (char c = 'a'; c <= 'z'; c++) {
                    l.add(c + "");
                }
                for (int i = 1; i <= 9; i++) {
                    l.add(new Integer(i));
                }
                Collections.shuffle(l);
                for (int i = 0; i <= 6; i++) {
                    code = code + l.get(i);
                }
                code = code + "_" + sn;

                PreparedStatement ps = cn.prepareStatement("insert into comment_table values (?,?,?,?,?,?)");
                ps.setInt(1, sn);
                ps.setString(2, vcode);
                ps.setString(3, userName);
                ps.setString(4, email);
                ps.setString(5, comment);
                ps.setString(6, code);
                ps.executeUpdate();
                ps.close();

                cn.close();

            }
            if (status.equals("update")) {
                String updatedComment = request.getParameter("comment");
                String commentCode = request.getParameter("code");
                PreparedStatement ps1 = cn.prepareStatement("update comment_table set comment=? where code='" + commentCode + "'");
                ps1.setString(1, updatedComment);
                ps1.executeUpdate();
                ps1.close();
            }
            if (status.equals("delete")) {
                String commentCode = request.getParameter("code");
                int deleteComment = st.executeUpdate("delete from comment_table where code='" + commentCode + "'");
                out.println(deleteComment);
            }
        }

    

    if (status.equals("getComment")) {
        ResultSet getName = st.executeQuery("select * from comment_table where vcode='" + vcode + "'");

        while (getName.next()) {
            String name = getName.getString("name");
            String commentBody = getName.getString("comment");
            String commentEmail = getName.getString("email");


%>


<h5 class="comment-name"><%=name%></h5>
<div class="comments-div">
    <div class="media-body">
        <p class="comment-msg"><%=commentBody%></p>
        <span>View all posts by :<a href="#"> Admin </a></span>
    </div>
    <%if (commentEmail.equals(email)) {%>
    <div class="comment-action">
        <div class="edit-comment-icon" val="<%=getName.getString("code")%>"><span class="material-icons">
                edit
            </span>
        </div>

        <div class="delete-comment-icon" val="<%=getName.getString("code")%>"><span class="material-icons">
                delete
            </span>
        </div>

    </div>
    <%}%>
</div>




<%

            }

        }

    }
    catch (Exception er

    
        ) {
        out.println(er.getMessage());

    }


%>