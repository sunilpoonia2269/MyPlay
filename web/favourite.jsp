<%-- 
    Document   : favourite
    Created on : 21-Jun-2021, 8:35:10 AM
    Author     : MARCOS
--%>

<%-- 
    Document   : index
    Created on : 25-May-2021, 12:28:03 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    Cookie c[] = request.getCookies();
    String dp_name = "";

    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }

     if(email == null && session.getAttribute(email) ==null){
            response.sendRedirect("login.jsp");
        }
       
    else {
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();
            Connection cn1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st1 = cn1.createStatement();
            Statement st2 = cn1.createStatement();
            ResultSet getImage = st.executeQuery("select usercode from user_login where email='" + email + "'");
            if (getImage.next()) {
                dp_name = getImage.getString(1);
            }


%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Favourite Videos | YouTube</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="My Play Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- bootstrap -->
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' media="all" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- //bootstrap -->
        <link href="css/dashboard.css" rel="stylesheet">
        <!-- Custom Theme files -->
        <link href="css/style.css" rel='stylesheet' type='text/css' media="all" />
        <script src="js/jquery-1.11.1.min.js"></script>
        <!--start-smoth-scrolling-->
        <!-- fonts -->
        <link href='//fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='//fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
        <link href="css/custom.css" rel="stylesheet">
        <!-- //fonts -->
        <style>
            .file{
                position: absolute;
                right:8%;
            }
            
            
            

        </style>
    </head>
    <body>

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp"><h1><img src="images/youtubelogo.jpg" alt="" style="width: 153px; height:49px;" /></h1></a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <div class="top-search">
                        <form class="navbar-form navbar-right">
                            <input type="text" class="form-control" placeholder="Search...">
                            <input type="submit" value=" ">
                        </form>
                    </div>
                    <div class="header-top-right">








                        <div class="profile-icon">
                            <button class="profile-button" onclick="myFunction()"><img class="profile-img" src="upload/<%=dp_name%>.jpg" alt="Hello"/></button>
                            <div id="myDropdown" class="dropdown-content">
                                <a href="user_profile.jsp">Profile</a>
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
                    <li><a href="index.jsp" class="home-icon"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Home</a></li>
                    <li><a href="shows.html" class="user-icon"><span class="glyphicon glyphicon-home glyphicon-blackboard" aria-hidden="true"></span>TV Shows</a></li>
                    <li><a href="history.jsp" class="sub-icon"><span class="glyphicon glyphicon-home glyphicon-hourglass" aria-hidden="true"></span>History</a></li>
                    <li><a href="#" class="menu1"><span class="glyphicon glyphicon-film" aria-hidden="true"></span>Movies<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span></a></li>
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
                    <li><a href="#" class="menu"><span class="glyphicon glyphicon-film glyphicon-king" aria-hidden="true"></span>Sports<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span></a></li>
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
                    <li><a href="movies.html" class="song-icon"><span class="glyphicon glyphicon-music" aria-hidden="true"></span>Songs</a></li>
                    <li><a href="news.html" class="news-icon"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span>News</a></li>

                    <li class="active"><a href="favourite.jsp" class="home-icon"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Favourite</a></li>
                    

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
                        <p>Copyright © 2015 My Play. All Rights Reserved | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
                    </div>
                </div>
            </div>
        </div>


        <!--video Column-->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="main-grids">
                <div class="top-grids">
                    <div class="recommended-info">
                        <h3>Favourite Videos</h3>
                    </div>
                    <%

                        ResultSet getFav = st.executeQuery("select * from favourite where email='" + email + "'");

                        while (getFav.next()) {
                            ResultSet rs = st2.executeQuery("select * from uploaded_videos where vcode='" + getFav.getString("vcode") + "'");
                            while (rs.next()) {

                                ResultSet getChannel = st1.executeQuery("select name, usercode from channel where chcode='" + rs.getString("chcode") + "'");

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
                    <img src="upload/<%=getChannel.getString("usercode")%>.jpg" alt="channel-img" class="channel-img">
                </div>



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










        <!-- footer -->

        <!-- //footer -->

        <div class="clearfix"> </div>
        <div class="drop-menu">
            <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu4">
                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Regular link</a></li>
                <li role="presentation" class="disabled"><a role="menuitem" tabindex="-1" href="#">Disabled link</a></li>
                <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another link</a></li>
            </ul>
        </div>
        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="js/bootstrap.min.js"></script>
        <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    </body>
</html>