<%-- 
    Document   : history
    Created on : 30-Jun-2021, 5:54:24 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String dp_name = "";
    boolean hasChannel = false;
    String chCode="";

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
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();

            Statement st1 = cn.createStatement();
            Statement st2 = cn.createStatement();
            ResultSet getImage = st.executeQuery("select usercode from user_login where email='" + email + "'");
            if(getImage.next()){
                dp_name = getImage.getString(1);
            }
            ResultSet getUserChannel = st.executeQuery("select chcode from channel where usercode='" + dp_name + "'");
            if(getUserChannel.next()){
                chCode = getUserChannel.getString(1);
                hasChannel = true;
            }


%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>History | YouTube</title>
        <!-- bootstrap -->
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' media="all" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- //bootstrap -->
        <link href="css/dashboard.css" rel="stylesheet">
        <!-- Custom Theme files -->
        <link href="css/style.css" rel='stylesheet' type='text/css' media="all" />
        <script src="js/jquery-1.11.1.min.js"></script>
        <link href="css/custom.css" rel="stylesheet">
        <!--start-smoth-scrolling-->
        <style>
            
            .main{
                padding-top: 20px;
            }
            .video-section{
                margin: 3% auto;
            }
            

        </style>
    </head>

    <body>
        <!-- Navbar Section -->

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                            aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp">
                        <h1><img src="images/youtubelogo.jpg" alt="" style="width: 153px; height:49px;" /></h1>
                    </a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <div class="top-search">
                        <form class="navbar-form navbar-right">
                            <input type="text" class="form-control" placeholder="Search...">
                            <input type="submit" value=" ">
                        </form>
                    </div>
                    <div class="header-top-right col-lg-3">

                        <!--                    <div class="profile-div">
                                                <button class="btn btn-dark upload-btn"><a href="upload.html">Upload</a></button> 
                                            </div>-->


                        <!--                    <div class="create-channel">
                        
                        
                                              
                                                <button class="btn btn-danger"><a href="create_channel.jsp"
                                                        >Create Channel</a></button>
                                               
                                            </div>-->






                       <div class="profile-icon">
                            <button class="profile-button" onclick="myFunction()"><img class="profile-img" src="upload/<%=dp_name%>.jpg"alt="Hello"/></button>
                            <div id="myDropdown" class="dropdown-content">
                                <%if(hasChannel){%>
                                <a href="profile.jsp?chcode=<%=chCode%>">My Channel</a>
                                <%}%>
                                <a href="user_profile.jsp">My Profile</a>
                                <a href="logout.jsp">Log Out</a>
                            </div>
                        </div>
                        <script>

                            function myFunction() {
                                document.getElementById("myDropdown").classList.toggle("show");
                            }


                        </script>

                        <div class="clearfix"> </div>

                    </div>
                </div>
                <div class="clearfix"> </div>
            </div>
        </nav>




        <!-- SideBar Section -->

        <div class="col-sm-3 col-md-2 sidebar">
            <div class="top-navigation">
                <div class="t-menu">MENU</div>
                <div class="t-img">
                    <img src="images/lines.png" alt="" />
                </div>
                <div class="clearfix"> </div>
            </div>
            <div class="drop-navigation drop-navigation">
                <ul class="nav nav-sidebar">
                    <li><a href="index.jsp" class="home-icon"><span class="glyphicon glyphicon-home"
                                                                    aria-hidden="true"></span>Home</a></li>
                    <li><a href="shows.html" class="user-icon"><span class="glyphicon glyphicon-home glyphicon-blackboard"
                                                                     aria-hidden="true"></span>TV Shows</a></li>
                    <li class="active"><a href="history.jsp" class="sub-icon"><span class="glyphicon glyphicon-home glyphicon-hourglass"
                                                                                    aria-hidden="true"></span>History</a></li>
                    <li><a href="#" class="menu1"><span class="glyphicon glyphicon-film"
                                                        aria-hidden="true"></span>Movies<span class="glyphicon glyphicon-menu-down"
                                                        aria-hidden="true"></span></a></li>

                    <ul class="cl-effect-2">
                        <li><a href="movies.html">English</a></li>
                        <li><a href="movies.html">Chinese</a></li>
                        <li><a href="movies.html">Hindi</a></li>
                    </ul>
                    <!-- script-for-menu -->
                    <script>
                        $("li a.menu1").click(function () {
                            $("ul.cl-effect-2").slideToggle(300, function () {
                                // Animation complete.
                            });
                        });
                    </script>
                    <li><a href="#" class="menu"><span class="glyphicon glyphicon-film glyphicon-king"
                                                       aria-hidden="true"></span>Sports<span class="glyphicon glyphicon-menu-down"
                                                       aria-hidden="true"></span></a></li>
                    <ul class="cl-effect-1">
                        <li><a href="sports.html">Football</a></li>
                        <li><a href="sports.html">Cricket</a></li>
                        <li><a href="sports.html">Tennis</a></li>
                        <li><a href="sports.html">Shattil</a></li>
                    </ul>
                    <!-- script-for-menu -->
                    <script>
                        $("li a.menu").click(function () {
                            $("ul.cl-effect-1").slideToggle(300, function () {
                                // Animation complete.
                            });
                        });
                    </script>
                    <li><a href="movies.html" class="song-icon"><span class="glyphicon glyphicon-music"
                                                                      aria-hidden="true"></span>Songs</a></li>
                    <li><a href="news.html" class="news-icon"><span class="glyphicon glyphicon-envelope"
                                                                    aria-hidden="true"></span>News</a></li>
                    <li><a href="user_profile.jsp" class="home-icon"><span class="glyphicon glyphicon-home"
                                                                           aria-hidden="true"></span>Profile</a></li>
                    <li><a href="favourite.jsp" class="home-icon"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Favourite</a></li>
                </ul>
                <!-- script-for-menu -->
                <script>
                    $(".top-navigation").click(function () {
                        $(".drop-navigation").slideToggle(300, function () {
                            // Animation complete.
                        });
                    });
                </script>
                <div class="side-bottom">
                    <div class="side-bottom-icons">
                        <ul class="nav2">
                            <li><a href="#" class="facebook"> </a></li>
                            <li><a href="#" class="facebook twitter"> </a></li>
                            <li><a href="#" class="facebook chrome"> </a></li>
                            <li><a href="#" class="facebook dribbble"> </a></li>
                        </ul>
                    </div>
                    <div class="copyright">
                        <p>Copyright © 2015 My Play. All Rights Reserved | Design by <a
                                href="http://w3layouts.com/">W3layouts</a></p>
                    </div>
                </div>
            </div>
        </div>




       
        <section class="video-section">
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <div class="main-grids">
                    <div class="top-grids">
                        <div class="recommended-info">
                            <h3>Watched Videos</h3>
                        </div>
                        <%

                            ResultSet getHistory = st.executeQuery("select * from history where email='" + email + "'");

                            while (getHistory.next()) {

                                ResultSet rs = st1.executeQuery("select * from uploaded_videos where vcode='" + getHistory.getString("vcode") + "'");

                                while (rs.next()) {

                                    ResultSet getChannel = st2.executeQuery("select name, usercode from channel where chcode='" + rs.getString("chcode") + "'");

                                    if (getChannel.next()) {


                        %>





                        <div class="col-md-3 resent-grid recommended-grid slider-first">
                            <div class="random-class">
                                <div class="resent-grid-img recommended-grid-img">
                                    <a href="single.jsp?vcode=<%=rs.getString("vcode")%>">
                                        <video class="image-class" width="100%" poster="thumbnail/<%=rs.getString("vcode")%>.jpg">
                                            <source src="uploadVideo/<%=rs.getString("vcode")%>.mp4" type="video/mp4">
                                            <source src="movie.ogg" type="video/ogg">
                                            Your browser does not support the video tag.
                                        </video>

                                    </a>
                                    <div class="time small-time slider-time">
                                        <p id="duration">7:34</p>
                                    </div>
                                    <div class="clck small-clck">
                                        <span class="glyphicon glyphicon-time" aria-hidden="true"></span>
                                    </div>
                                </div>
                                <div class="resent-grid-info recommended-grid-info">
                                    <div class="video-title-image">




                                        <div>
                                            <h5><a href="single.jsp?vcode=<%=rs.getString("vcode")%>" class="title"><%=rs.getString("title")%></a></h5>
                                            <div class="slid-bottom-grids">
                                                <div class="slid-bottom-grid">
                                                    <a href="#" class="author"><%=getChannel.getString("name")%> <span class="material-icons check-icon">
                                                            check_circle
                                                        </span></a>
                                                </div>
                                                <div class="slid-bottom-grid slid-bottom-right">
                                                    <p class="views views-info"><%=rs.getInt("views")%> views | </p><p class="views views-info"><%=rs.getString("date")%></p>
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
                                    }

                                } catch (Exception er) {
                                    out.println(er.getMessage());
                                }
                            }

                        %>

                        <div class="clearfix"> </div>                                    

                    </div>
                </div>
            </div>
        </section>








        <!-- Footer Section -->

    </body>

</html>
