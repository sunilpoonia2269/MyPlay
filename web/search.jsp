<%-- 
    Document   : index_process
    Created on : 15 Jul, 2021, 6:20:37 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String value = request.getParameter("search");
	
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
        Statement st = cn.createStatement();
        Statement st1 = cn.createStatement();


            ResultSet rs1 = st.executeQuery("select * from uploaded_videos where title LIKE '%"+value+"%'");
            while (rs1.next()) {
                ResultSet getChannel1 = st1.executeQuery("select * from channel where chcode='" + rs1.getString("chcode") + "'");
                if (getChannel1.next()) {


%>

<div class="col-md-3 resent-grid recommended-grid slider-first">
    <div class="random-class">
        <div class="resent-grid-img recommended-grid-img">
            <a href="single.jsp?vcode=<%=rs1.getString("vcode")%>">
                <!--                                                    <video width="100%" controls>
                                                                        <source src="uploadVideo/<%=rs1.getString("vcode")%>.mp4" type="video/mp4">
                                                                        <source src="movie.ogg" type="video/ogg">
                                                                        Your browser does not support the video tag.
                                                                    </video>-->
                <img class="image-class" src="thumbnail/<%=rs1.getString("vcode")%>.jpg" alt="" />
            </a>
            <div class="time small-time slider-time">
                <p>7:34</p>
            </div>
            <div class="clck small-clck">
                <span class="glyphicon glyphicon-time" aria-hidden="true"></span>
            </div>
        </div>
        <div class="resent-grid-info recommended-grid-info">
            <div class="video-title-image">
                <div>
                    <img src="upload/<%=getChannel1.getString("usercode")%>.jpg" alt="channel-img" class="channel-img">
                </div>



                <div>
                    <h5><a href="single.jsp?vcode=<%=rs1.getString("vcode")%>" class="title"><%=rs1.getString("title")%></a></h5>
                    <div class="slid-bottom-grids">
                        <div class="slid-bottom-grid">
                            <a href="profile.jsp?chcode=<%=getChannel1.getString("chcode")%>" class="author"><%=getChannel1.getString("name")%> <span class="material-icons check-icon">
                                    check_circle
                                </span></a>
                        </div>
                        <div class="slid-bottom-grid slid-bottom-right">
                            <p class="views views-info"><%=rs1.getInt("views")%> views | </p><p class="views views-info"><%=rs1.getString("date")%></p>
                        </div>
                    </div>
                </div>

            </div>
            <div class="clearfix"> </div>

        </div>
    </div>
</div>
<%
        }
    } 

    } catch (Exception e) {
        out.println(e.getMessage());
    }


%>