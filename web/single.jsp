<%-- 
    Document   : single
    Created on : 01-Jun-2021, 4:33:41 PM
    Author     : MARCOS
--%>


<%@page contentType="text/html" import="java.sql.*" pageEncoding="UTF-8"%>

<%

    String vcode = request.getParameter("vcode");

    String channelName = "";
    String chCode = "";
    String dp_name = "";
    boolean isSubscribed = false;
    boolean isFav = false;
    boolean isLiked = false;
    boolean isDisliked = false;
    boolean isLogin = false;

    Cookie c[] = request.getCookies();

    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }

    int subs = 0;
    int views = 0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
        Statement st = cn.createStatement();

        ResultSet getViews = st.executeQuery("select views from uploaded_videos where vcode='" + vcode + "'");
        if (getViews.next()) {
            views = getViews.getInt("views");
            views++;
        }
        ResultSet getchCode = st.executeQuery("select chcode from uploaded_videos where vcode='" + vcode + "'");
        if (getchCode.next()) {
            chCode = getchCode.getString(1);
        }
        ResultSet getChannel = st.executeQuery("select * from channel where chcode='" + chCode + "'");
        if (getChannel.next()) {
            channelName = getChannel.getString("name");
            subs = getChannel.getInt("subs");

        }

        if (email != null && session.getAttribute(email) != null) {
            isLogin = true;

            ResultSet getImage = st.executeQuery("select usercode from user_login where email='" + email + "'");
            if (getImage.next()) {
                dp_name = getImage.getString(1);
            }

            ResultSet getSubscription = st.executeQuery("select chcode from sub_channel where email='" + email + "'");
            while (getSubscription.next()) {
                if (chCode.equals(getSubscription.getString("chcode"))) {
                    isSubscribed = true;
                }
            }
            ResultSet getFav = st.executeQuery("select * from favourite where email='" + email + "' AND vcode='" + vcode + "'");
            if (getFav.next()) {
                isFav = true;
            }
            ResultSet getLike = st.executeQuery("select * from liked_video where email='" + email + "' AND vcode='" + vcode + "'");
            if (getLike.next()) {
                isLiked = true;
            }
            ResultSet getdisLike = st.executeQuery("select * from disliked_video where email='" + email + "' AND vcode='" + vcode + "'");
            if (getdisLike.next()) {
                isDisliked = true;
            }

        }
        PreparedStatement ps = cn.prepareStatement("Update uploaded_videos set views=? where vcode='" + vcode + "'");
        ps.setInt(1, views);
        ps.executeUpdate();
        ps.close();

        ResultSet rs = st.executeQuery("select * from uploaded_videos where vcode='" + vcode + "'");
        if (rs.next()) {


%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>My Play a Entertainment Category Flat Bootstrap Responsive Website Template | single :: w3layouts</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="My Play Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <!-- bootstrap -->
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' media="all" />
        <!-- //bootstrap -->
        <link href="css/dashboard.css" rel="stylesheet">
        <!-- Font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Custom Theme files -->
        <link href="css/style.css" rel='stylesheet' type='text/css' media="all" />
        <script src="js/jquery-1.11.1.min.js"></script>
        <link href="css/single-style.css" rel='stylesheet' type='text/css' media="all" />
        <!--start-smoth-scrolling-->
        <!-- fonts -->
        <link href='//fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='//fonts.googleapis.com/css?family=Poiret+One' rel='stylesheet' type='text/css'>
        <!--Google fonts-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">


        <!-- //fonts -->

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
                    <a class="navbar-brand" href="index.jsp"><h1><img src="images/logo.png" alt="" style="width: 153px; height:49px;" /></h1></a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <div class="top-search">
                        <form class="navbar-form navbar-right">
                            <input type="text" class="form-control" placeholder="Search...">
                            <input type="submit" value=" ">
                        </form>
                    </div>
                    <div class="header-top-right">


                        <%                                    if (email == null) {


                        %>
                        <div class="signin">
                            <a href="#small-dialog3" class="play-icon popup-with-zoom-anim">Sign Up</a>
                            <!--                             pop-up-box 
                                                        <script type="text/javascript" src="js/modernizr.custom.min.js"></script>    
                                                        <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
                                                        <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
                                                        //pop-up-box -->

                            <div id="small-dialog3" class="mfp-hide">
                                <h3>Create Account</h3> 
                                <div class="social-sits">
                                    <div class="facebook-button">
                                        <a href="#">Connect with Facebook</a>
                                    </div>
                                    <div class="chrome-button">
                                        <a href="#">Connect with Google</a>
                                    </div>
                                    <div class="button-bottom">
                                        <p>Already have an account? <a href="#small-dialog" class="play-icon popup-with-zoom-anim">Login</a></p>
                                    </div>
                                </div>
                                <div class="signup">
                                    <form method="POST" action="account_create.jsp">
                                        <input type="text" class="email" name="username" placeholder="Your Name" required="required" />
                                        <input type="text" class="email" name="email" placeholder="Email" required="required" pattern="([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?" title="Enter a valid email"/>
                                        <input type="password" name="pass" placeholder="Password" required="required" pattern=".{6,}" title="Minimum 6 characters required" autocomplete="off" />
                                        <input type="password" name="repass" placeholder="Re-Type Password" required="required" pattern=".{6,}" title="Minimum 6 characters required" autocomplete="off" />

                                        <input type="submit"  value="Sign Up"/>
                                    </form>
                                </div>
                                <div class="clearfix"> </div>
                            </div>	
                            <div id="small-dialog7" class="mfp-hide">
                                <h3>Create Account</h3> 
                                <div class="social-sits">
                                    <div class="facebook-button">
                                        <a href="#">Connect with Facebook</a>
                                    </div>
                                    <div class="chrome-button">
                                        <a href="#">Connect with Google</a>
                                    </div>
                                    <div class="button-bottom">
                                        <p>Already have an account? <a href="#small-dialog" class="play-icon popup-with-zoom-anim">Login</a></p>
                                    </div>
                                </div>
                                <div class="signup">
                                    <form action="upload.html">
                                        <input type="text" class="email" placeholder="Email" required="required" pattern="([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?" title="Enter a valid email"/>
                                        <input type="password" placeholder="Password" required="required" pattern=".{6,}" title="Minimum 6 characters required" autocomplete="off" />
                                        <input type="submit"  value="Sign In"/>
                                    </form>
                                </div>
                                <div class="clearfix"> </div>
                            </div>		
                            <div id="small-dialog4" class="mfp-hide">
                                <h3>Feedback</h3> 
                                <div class="feedback-grids">
                                    <div class="feedback-grid">
                                        <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis lectus ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
                                    </div>
                                    <div class="button-bottom">
                                        <p><a href="#small-dialog" class="play-icon popup-with-zoom-anim">Sign in</a> to get started.</p>
                                    </div>
                                </div>
                            </div>
                            <div id="small-dialog5" class="mfp-hide">
                                <h3>Help</h3> 
                                <div class="help-grid">
                                    <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis lectus ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
                                </div>
                                <div class="help-grids">
                                    <div class="help-button-bottom">
                                        <p><a href="#small-dialog4" class="play-icon popup-with-zoom-anim">Feedback</a></p>
                                    </div>
                                    <div class="help-button-bottom">
                                        <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Lorem ipsum dolor sit amet</a></p>
                                    </div>
                                    <div class="help-button-bottom">
                                        <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Nunc vitae rutrum enim</a></p>
                                    </div>
                                    <div class="help-button-bottom">
                                        <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Mauris at volutpat leo</a></p>
                                    </div>
                                    <div class="help-button-bottom">
                                        <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Mauris vehicula rutrum velit</a></p>
                                    </div>
                                    <div class="help-button-bottom">
                                        <p><a href="#small-dialog6" class="play-icon popup-with-zoom-anim">Aliquam eget ante non orci fac</a></p>
                                    </div>
                                </div>
                            </div>
                            <div id="small-dialog6" class="mfp-hide">
                                <div class="video-information-text">
                                    <h4>Video information & settings</h4>
                                    <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis lectus ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
                                    <ol>
                                        <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum tincidunt.</li>
                                        <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum tincidunt.</li>
                                        <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum tincidunt.</li>
                                        <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum tincidunt.</li>
                                        <li>Nunc vitae rutrum enim. Mauris at volutpat leo. Vivamus dapibus mi ut elit fermentum tincidunt.</li>
                                    </ol>
                                </div>
                            </div>
                            <script>
                                $(document).ready(function () {
                                    $('.popup-with-zoom-anim').magnificPopup({
                                        type: 'inline',
                                        fixedContentPos: false,
                                        fixedBgPos: true,
                                        overflowY: 'auto',
                                        closeBtnInside: true,
                                        preloader: false,
                                        midClick: true,
                                        removalDelay: 300,
                                        mainClass: 'my-mfp-zoom-in'
                                    });
                                });
                            </script>	
                        </div>
                        <div class="signin">
                            <a href="login.jsp" class="play-icon">Sign In</a>

                        </div>

                        <%                                    } else {


                        %>



                        <div class="profile-icon">
                            <button class="profile-button" onclick="myFunction()"><img class="profile-img" src="upload/<%=dp_name%>.jpg"alt="Hello"/></button>
                            <div id="myDropdown" class="dropdown-content">
                                <a href="user_profile.jsp">My Profile</a>
                                <a href="logout.jsp">Log Out</a>
                            </div>
                        </div>
                        <script>

                            function myFunction() {
                                document.getElementById("myDropdown").classList.toggle("show");
                            }


                        </script>

                        <%
                            }
                        %>










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
                        <p>Copyright © 2015 My Play. All Rights Reserved | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
                    </div>
                </div>
            </div>
        </div>




        <!--      Video Player-->
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="show-top-grids">
                <div class="col-sm-8 single-left">
                    <div class="song">

                        <div class="video-grid">
                            <video width="100%" controls>
                                <source src="uploadVideo/<%=vcode%>.mp4" type="video/mp4">
                                <source src="movie.ogg" type="video/ogg">
                                Your browser does not support the video tag.
                            </video>
                        </div>
                    </div>
                    <!--					<div class="song-grid-right">
                                                    
                                                            </div>-->
                    <div class="clearfix"> </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <h1 class="video-title"><%=rs.getString("title")%></h1>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-8"><h3><%=rs.getInt("views")%> Views</h3></div>
                        <div class="col-lg-3">

                            <span class="material-icons icon-button" id="like">
                                thumb_up
                            </span>
                            <span class="material-icons icon-button" id="dislike">
                                thumb_down
                            </span>
                            <span class="material-icons playlist icon-button" id="fav-icon">favorite</span>



                        </div>
                    </div>





                    <div class="clearfix"> </div>
                    <div class="published">

                        <script>
                            $(document).ready(function () {
                                size_li = $("#myList li").size();
                                x = 1;
                                $('#myList li:lt(' + x + ')').show();
                                $('#loadMore').click(function () {
                                    x = (x + 1 <= size_li) ? x + 1 : size_li;
                                    $('#myList li:lt(' + x + ')').show();
                                });
                                $('#showLess').click(function () {
                                    x = (x - 1 < 0) ? 1 : x - 1;
                                    $('#myList li').not(':lt(' + x + ')').hide();
                                });
                            });
                        </script>
                        <div class="load_more">	
                            <ul id="myList">
                                <li>
                                    <h4>Published on <%=rs.getString("date")%></h4>
                                    <p><%=rs.getString("description")%></p>
                                </li>
                                <li>
                                    <p>Nullam fringilla sagittis tortor ut rhoncus. Nam vel ultricies erat, vel sodales leo. Maecenas pellentesque, est suscipit laoreet tincidunt, ipsum tortor vestibulum leo, ac dignissim diam velit id tellus. Morbi luctus velit quis semper egestas. Nam condimentum sem eget ex iaculis bibendum. Nam tortor felis, commodo faucibus sollicitudin ac, luctus a turpis. Donec congue pretium nisl, sed fringilla tellus tempus in.</p>
                                    <p>Nullam fringilla sagittis tortor ut rhoncus. Nam vel ultricies erat, vel sodales leo. Maecenas pellentesque, est suscipit laoreet tincidunt, ipsum tortor vestibulum leo, ac dignissim diam velit id tellus. Morbi luctus velit quis semper egestas. Nam condimentum sem eget ex iaculis bibendum. Nam tortor felis, commodo faucibus sollicitudin ac, luctus a turpis. Donec congue pretium nisl, sed fringilla tellus tempus in.</p>
                                    <div class="load-grids">
                                        <div class="load-grid">
                                            <p>Category</p>
                                        </div>
                                        <div class="load-grid">
                                            <a href="movies.html">Entertainment</a>
                                        </div>
                                        <div class="clearfix"> </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="row" >
                        <div class="col-lg-2"><img class="channel-img" src="upload/<%=rs.getString("usercode")%>.jpg" width="70px" height="70px" alt="Hello"/></div>
                        <div class="col-lg-7">
                            <div><h3 class="channel-name"><%=channelName%></h3><span class="material-icons check-icon check-icon-bigger">check_circle</span></div>
                            <div><h5><%=subs%> subscribers</h5>
                            </div>



                        </div>

                        <div class="col-lg-3">



                            <button class="btn sub-button" id="subscribe">Subscribe</button>





                        </div>

                    </div>



                    <%
                        }

                    %>









                    <div class="all-comments">
                        <div class="all-comments-info">
                            <a href="#">All Comments (8,657)</a>
                            <div class="box">
                                <form method="post">


                                    <textarea placeholder="Message" name="comment" id="commentMessage" required=" "></textarea>
                                    <input type="submit" value="SEND" id="commentForm">
                                    <div class="clearfix"> </div>
                                </form>



                            </div>
                            <div class="all-comments-buttons">
                                <ul>
                                    <li><a href="#" class="top">Top Comments</a></li>
                                    <li><a href="#" class="top newest">Newest First</a></li>
                                    <li><a href="#" class="top my-comment">My Comments</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="media-grids">

                            <div class="media comment-div">

                            </div>










                        </div>
                    </div>
                </div>
                <div class="col-md-4 single-right">
                    <h3>Up Next</h3>
                    <div class="single-grid-right">

                        <%                            ResultSet getUpNext = st.executeQuery("select * from uploaded_videos limit 8");
                            while (getUpNext.next()) {


                        %>


                        <div class="single-right-grids">
                            <div class="col-md-4 single-right-grid-left">
                                <a href="single.jsp?vcode=<%=getUpNext.getString("vcode")%>"><img src="thumbnail/<%=getUpNext.getString("vcode")%>.jpg" alt="" /></a>
                            </div>
                            <div class="col-md-8 single-right-grid-right">
                                <a href="single.jsp?vcode=<%=getUpNext.getString("vcode")%>" class="title"><%=getUpNext.getString("title")%></a>
                                <p class="author"><a href="#" class="author"></a></p>
                                <p class="views"><%=getUpNext.getInt("views")%> views</p>
                            </div>
                            <div class="clearfix"> </div>
                        </div>
                        <%

                            }

                        %>





                    </div>
                </div>
                <div class="clearfix"> </div>
            </div>
            <!-- pop-up-box -->
            <script type="text/javascript" src="js/modernizr.custom.min.js"></script>    
            <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
            <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
            <!--//pop-up-box -->



            <a href="#small-dialog-login" id="automatic" style="display:none;" class="popup-with-zoom-anim"></a>

            <div id="small-dialog-login" class="mfp-hide">
                <h2>Login</h2>
                <div class="delete-message">
                    <p class="login-msg">You need to login to get full functionality</p>
                    <p class="login-msg">Do you want to login??</p>
                    <a href="login.jsp"><button class="btn btn-primary popup-button">Login</button></a>
                    <button class="btn btn-dark close-popup popup-button">Cancel</button>

                </div>

                <div class="clearfix"> </div>
            </div>


            <script>
                            $(document).ready(function () {
                                // Getting all the comments
                                var vcode = "<%=vcode%>";
                                function loadComment() {

                                    $.post(
                                            "comment.jsp",
                                            {vcode: vcode, status: "getComment"},
                                            function (data) {

                                                $(".comment-div").html(data);
                                            }
                                    );
                                }
                                loadComment();


                                var isLogin = <%=isLogin%>;
                                
                                if (isLogin) {
                                    $(window).load(function () {
                                        console.log(isLogin);
                                        $.post("history_update.jsp",{vcode: "<%=vcode%>", chcode: "<%=chCode%>", chName:"<%=channelName%>"},function(data){
                                            console.log(data);
                                            });
                                                
                                    });

                                }

                                // Script for adding event on the favourite icon
                                if (<%=isFav%>) {
                                    $("#fav-icon").addClass("fav-active");
                                }

                                $("#fav-icon").click(function () {
                                    if (isLogin) {
                                        var channel = "<%=chCode%>";
                                        var isFav = <%=isFav%>;
                                        var vcode = "<%=vcode%>";
                                        $("#fav-icon").toggleClass("fav-active");
                                        $.ajax({
                                            url: "favourite_process.jsp",
                                            type: 'POST',
                                            data: {chcode: channel, status: isFav, vcode: vcode},
                                            success: function (data) {
                                                console.log(data);
                                            }
                                        });

                                    } else {
                                        $("#automatic").trigger("click");
                                    }
                                });

                                // Script for Subscribe button
                                if (<%=isSubscribed%>) {
                                    $("#subscribe").addClass("subscribed");
                                    $("#subscribe").text("Subscribed");
                                }
                                $("#subscribe").click(function () {
                                    if (isLogin) {


                                        $(this).toggleClass("subscribed");
                                        var text = $("#subscribe").text();

                                        if (text === "Subscribe") {
                                            var isSubscribe = "true";
                                            $(this).text("Subscribed");
                                        } else {
                                            isSubscribe = "false";
                                            $(this).text("Subscribe");
                                        }
                                        var channel = "<%=chCode%>";
                                        $.ajax({
                                            url: "subscribe.jsp",
                                            type: 'POST',
                                            data: {chcode: channel, status: isSubscribe},
                                            success: function (data) {
                                                console.log(data);
                                            }
                                        });

                                    } else {
                                        $("#automatic").trigger("click");
                                    }
                                });






                                // Script for comment form
                                $("#commentForm").click(function (e) {
                                    if (isLogin) {



                                        e.preventDefault();
                                        $.ajax({
                                            url: "comment.jsp",
                                            type: "POST",
                                            data: {vcode: vcode, message: $("#commentMessage").val(), status: "add"},
                                            success: function (data) {
                                                console.log(data);
                                                loadComment();
                                            }
                                        });
                                        $("#commentMessage").val("");

                                    } else {

                                        $("#automatic").trigger("click");

                                    }
                                    $("#commentMessage").val("");
                                    e.preventDefault();

                                });



                                // Script for like and dislike button
                                var isLiked = <%=isLiked%>;
                                var isDisliked = <%=isDisliked%>;
                                if (isLiked) {
                                    $("#like").addClass("like-active");
                                } else if (isDisliked) {
                                    $("#dislike").addClass("like-active");
                                }



                                $("#like").click(function () {
                                    if (isLogin) {
                                        $("#dislike").removeClass("like-active");
                                        $("#like").toggleClass("like-active");
                                        console.log("like is there");
                                        $.ajax({
                                            url: "like_process.jsp",
                                            type: 'POST',
                                            data: {status: "1", vcode: "<%=vcode%>", isLiked: isLiked},
                                            success: function (data) {
                                                console.log(data);
                                            }
                                        });
                                    } else {
                                        $("#automatic").trigger("click");
                                    }
                                });
                                $("#dislike").click(function () {
                                    if (isLogin) {
                                        $("#like").removeClass("like-active");
                                        $("#dislike").toggleClass("like-active");
                                        $.ajax({
                                            url: "like_process.jsp",
                                            type: 'POST',
                                            data: {status: "0", vcode: "<%=vcode%>", isDisliked: isDisliked},
                                            success: function (data) {
                                                console.log(data);
                                            }
                                        });
                                    } else {
                                        $("#automatic").trigger("click");
                                    }
                                });

                                // Edit and delete comment
                                $(document).on("click", ".edit-comment-icon", function () {

                                    var value = $(".comment-msg").text();
                                    console.log(value);
                                    $(".media-body").html("<input class='comment-input' type=text value='" + value + "' /><button class='comment-update'>Submit</button>");

                                });
                                $(document).on("click", ".comment-update", function (e) {
                                    e.preventDefault();
                                    $.post("comment.jsp", {status: "update", comment: $(".comment-input").val(), code: $(".edit-comment-icon").attr("val")}, function (data) {
                                        console.log(data);
                                        loadComment();

                                    });


                                });

                                // Deleting comments
                                $(document).on("click", ".delete-comment-icon", function () {
                                    $.post("comment.jsp", {status: "delete", code: $(this).attr("val")}, function (data) {

                                        loadComment();

                                    });


                                });

                                // Popup code
                                $('.popup-with-zoom-anim').magnificPopup({
                                    type: 'inline',
                                    fixedContentPos: false,
                                    fixedBgPos: true,
                                    overflowY: 'auto',
                                    closeBtnInside: true,
                                    preloader: false,
                                    midClick: true,
                                    removalDelay: 300,
                                    mainClass: 'my-mfp-zoom-in'
                                });
                                $(".close-popup").click(function () {

                                    $(".mfp-close").trigger("click");
                                });
                            });
            </script>



            <%

                } catch (Exception er) {
                    out.println(er.getMessage());
                }

            %>





            <!-- footer -->
            <div class="footer">
                <div class="footer-grids">
                    <div class="footer-top">
                        <div class="footer-top-nav">
                            <ul>
                                <li><a href="about.html">About</a></li>
                                <li><a href="press.html">Press</a></li>
                                <li><a href="copyright.html">Copyright</a></li>
                                <li><a href="creators.html">Creators</a></li>
                                <li><a href="#">Advertise</a></li>
                                <li><a href="developers.html">Developers</a></li>
                            </ul>
                        </div>
                        <div class="footer-bottom-nav">
                            <ul>
                                <li><a href="terms.html">Terms</a></li>
                                <li><a href="privacy.html">Privacy</a></li>
                                <li><a href="#small-dialog4" class="play-icon popup-with-zoom-anim">Send feedback</a></li>
                                <li><a href="privacy.html">Policy & Safety </a></li>
                                <li><a href="try.html">Try something new!</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <ul>
                            <li class="languages">
                                <select class="form-control bfh-countries" data-country="US">
                                    <option value="">Select Language</option>
                                    <option>Spanish</option>
                                    <option>French</option>
                                    <option>German</option>
                                    <option>Italian</option>
                                    <option>Chinese</option>
                                    <option>Tagalog</option>
                                    <option>Polish</option>
                                    <option>Korean</option>
                                    <option>Vietnamese</option>
                                    <option>Portuguese</option>
                                    <option>Japanese</option>
                                    <option>Greek</option>
                                    <option>Arabic</option>
                                    <option>Hindi (urdu)</option>
                                    <option>Russian</option>
                                    <option>Yiddish</option>
                                    <option>Thai (laotian)</option>
                                    <option>Persian</option>
                                    <option>French Creole</option>
                                    <option>Armenian</option>
                                    <option>Navaho</option>
                                    <option>Hungarian</option>
                                    <option>Hebrew</option>
                                    <option>Dutch</option>
                                    <option>Mon-khmer (cambodian)</option>
                                    <option>Gujarathi</option>
                                    <option>Ukrainian</option>
                                    <option>Czech</option>
                                    <option>Pennsylvania Dutch</option>
                                    <option>Miao (hmong)</option>
                                    <option>Norwegian</option>
                                    <option>Slovak</option>
                                    <option>Swedish</option>
                                    <option>Serbocroatian</option>
                                    <option>Kru</option>
                                    <option>Rumanian</option>
                                    <option>Lithuanian</option>
                                    <option>Finnish</option>
                                    <option>Panjabi</option>
                                    <option>Formosan</option>
                                    <option>Croatian</option>
                                    <option>Turkish</option>
                                    <option>Ilocano</option>
                                    <option>Bengali</option>
                                    <option>Danish</option>
                                    <option>Syriac</option>
                                    <option>Samoan</option>
                                    <option>Malayalam</option>
                                    <option>Cajun</option>
                                    <option>Amharic</option>
                                </select>
                            </li>
                            <li class="languages">
                                <select class="form-control bfh-countries">
                                    <option value="">Select Country</option>
                                    <option value="AFG">Afghanistan</option>
                                    <option value="ALA">Åland Islands</option>
                                    <option value="ALB">Albania</option>
                                    <option value="DZA">Algeria</option>
                                    <option value="ASM">American Samoa</option>
                                    <option value="AND">Andorra</option>
                                    <option value="AGO">Angola</option>
                                    <option value="AIA">Anguilla</option>
                                    <option value="ATA">Antarctica</option>
                                    <option value="ATG">Antigua and Barbuda</option>
                                    <option value="ARG">Argentina</option>
                                    <option value="ARM">Armenia</option>
                                    <option value="ABW">Aruba</option>
                                    <option value="AUS">Australia</option>
                                    <option value="AUT">Austria</option>
                                    <option value="AZE">Azerbaijan</option>
                                    <option value="BHS">Bahamas</option>
                                    <option value="BHR">Bahrain</option>
                                    <option value="BGD">Bangladesh</option>
                                    <option value="BRB">Barbados</option>
                                    <option value="BLR">Belarus</option>
                                    <option value="BEL">Belgium</option>
                                    <option value="BLZ">Belize</option>
                                    <option value="BEN">Benin</option>
                                    <option value="BMU">Bermuda</option>
                                    <option value="BTN">Bhutan</option>
                                    <option value="BOL">Bolivia, Plurinational State of</option>
                                    <option value="BES">Bonaire, Sint Eustatius and Saba</option>
                                    <option value="BIH">Bosnia and Herzegovina</option>
                                    <option value="BWA">Botswana</option>
                                    <option value="BVT">Bouvet Island</option>
                                    <option value="BRA">Brazil</option>
                                    <option value="IOT">British Indian Ocean Territory</option>
                                    <option value="BRN">Brunei Darussalam</option>
                                    <option value="BGR">Bulgaria</option>
                                    <option value="BFA">Burkina Faso</option>
                                    <option value="BDI">Burundi</option>
                                    <option value="KHM">Cambodia</option>
                                    <option value="CMR">Cameroon</option>
                                    <option value="CAN">Canada</option>
                                    <option value="CPV">Cape Verde</option>
                                    <option value="CYM">Cayman Islands</option>
                                    <option value="CAF">Central African Republic</option>
                                    <option value="TCD">Chad</option>
                                    <option value="CHL">Chile</option>
                                    <option value="CHN">China</option>
                                    <option value="CXR">Christmas Island</option>
                                    <option value="CCK">Cocos (Keeling) Islands</option>
                                    <option value="COL">Colombia</option>
                                    <option value="COM">Comoros</option>
                                    <option value="COG">Congo</option>
                                    <option value="COD">Congo, the Democratic Republic of the</option>
                                    <option value="COK">Cook Islands</option>
                                    <option value="CRI">Costa Rica</option>
                                    <option value="CIV">Côte d'Ivoire</option>
                                    <option value="HRV">Croatia</option>
                                    <option value="CUB">Cuba</option>
                                    <option value="CUW">Curaçao</option>
                                    <option value="CYP">Cyprus</option>
                                    <option value="CZE">Czech Republic</option>
                                    <option value="DNK">Denmark</option>
                                    <option value="DJI">Djibouti</option>
                                    <option value="DMA">Dominica</option>
                                    <option value="DOM">Dominican Republic</option>
                                    <option value="ECU">Ecuador</option>
                                    <option value="EGY">Egypt</option>
                                    <option value="SLV">El Salvador</option>
                                    <option value="GNQ">Equatorial Guinea</option>
                                    <option value="ERI">Eritrea</option>
                                    <option value="EST">Estonia</option>
                                    <option value="ETH">Ethiopia</option>
                                    <option value="FLK">Falkland Islands (Malvinas)</option>
                                    <option value="FRO">Faroe Islands</option>
                                    <option value="FJI">Fiji</option>
                                    <option value="FIN">Finland</option>
                                    <option value="FRA">France</option>
                                    <option value="GUF">French Guiana</option>
                                    <option value="PYF">French Polynesia</option>
                                    <option value="ATF">French Southern Territories</option>
                                    <option value="GAB">Gabon</option>
                                    <option value="GMB">Gambia</option>
                                    <option value="GEO">Georgia</option>
                                    <option value="DEU">Germany</option>
                                    <option value="GHA">Ghana</option>
                                    <option value="GIB">Gibraltar</option>
                                    <option value="GRC">Greece</option>
                                    <option value="GRL">Greenland</option>
                                    <option value="GRD">Grenada</option>
                                    <option value="GLP">Guadeloupe</option>
                                    <option value="GUM">Guam</option>
                                    <option value="GTM">Guatemala</option>
                                    <option value="GGY">Guernsey</option>
                                    <option value="GIN">Guinea</option>
                                    <option value="GNB">Guinea-Bissau</option>
                                    <option value="GUY">Guyana</option>
                                    <option value="HTI">Haiti</option>
                                    <option value="HMD">Heard Island and McDonald Islands</option>
                                    <option value="VAT">Holy See (Vatican City State)</option>
                                    <option value="HND">Honduras</option>
                                    <option value="HKG">Hong Kong</option>
                                    <option value="HUN">Hungary</option>
                                    <option value="ISL">Iceland</option>
                                    <option value="IND">India</option>
                                    <option value="IDN">Indonesia</option>
                                    <option value="IRN">Iran, Islamic Republic of</option>
                                    <option value="IRQ">Iraq</option>
                                    <option value="IRL">Ireland</option>
                                    <option value="IMN">Isle of Man</option>
                                    <option value="ISR">Israel</option>
                                    <option value="ITA">Italy</option>
                                    <option value="JAM">Jamaica</option>
                                    <option value="JPN">Japan</option>
                                    <option value="JEY">Jersey</option>
                                    <option value="JOR">Jordan</option>
                                    <option value="KAZ">Kazakhstan</option>
                                    <option value="KEN">Kenya</option>
                                    <option value="KIR">Kiribati</option>
                                    <option value="PRK">Korea, Democratic People's Republic of</option>
                                    <option value="KOR">Korea, Republic of</option>
                                    <option value="KWT">Kuwait</option>
                                    <option value="KGZ">Kyrgyzstan</option>
                                    <option value="LAO">Lao People's Democratic Republic</option>
                                    <option value="LVA">Latvia</option>
                                    <option value="LBN">Lebanon</option>
                                    <option value="LSO">Lesotho</option>
                                    <option value="LBR">Liberia</option>
                                    <option value="LBY">Libya</option>
                                    <option value="LIE">Liechtenstein</option>
                                    <option value="LTU">Lithuania</option>
                                    <option value="LUX">Luxembourg</option>
                                    <option value="MAC">Macao</option>
                                    <option value="MKD">Macedonia, the former Yugoslav Republic of</option>
                                    <option value="MDG">Madagascar</option>
                                    <option value="MWI">Malawi</option>
                                    <option value="MYS">Malaysia</option>
                                    <option value="MDV">Maldives</option>
                                    <option value="MLI">Mali</option>
                                    <option value="MLT">Malta</option>
                                    <option value="MHL">Marshall Islands</option>
                                    <option value="MTQ">Martinique</option>
                                    <option value="MRT">Mauritania</option>
                                    <option value="MUS">Mauritius</option>
                                    <option value="MYT">Mayotte</option>
                                    <option value="MEX">Mexico</option>
                                    <option value="FSM">Micronesia, Federated States of</option>
                                    <option value="MDA">Moldova, Republic of</option>
                                    <option value="MCO">Monaco</option>
                                    <option value="MNG">Mongolia</option>
                                    <option value="MNE">Montenegro</option>
                                    <option value="MSR">Montserrat</option>
                                    <option value="MAR">Morocco</option>
                                    <option value="MOZ">Mozambique</option>
                                    <option value="MMR">Myanmar</option>
                                    <option value="NAM">Namibia</option>
                                    <option value="NRU">Nauru</option>
                                    <option value="NPL">Nepal</option>
                                    <option value="NLD">Netherlands</option>
                                    <option value="NCL">New Caledonia</option>
                                    <option value="NZL">New Zealand</option>
                                    <option value="NIC">Nicaragua</option>
                                    <option value="NER">Niger</option>
                                    <option value="NGA">Nigeria</option>
                                    <option value="NIU">Niue</option>
                                    <option value="NFK">Norfolk Island</option>
                                    <option value="MNP">Northern Mariana Islands</option>
                                    <option value="NOR">Norway</option>
                                    <option value="OMN">Oman</option>
                                    <option value="PAK">Pakistan</option>
                                    <option value="PLW">Palau</option>
                                    <option value="PSE">Palestinian Territory, Occupied</option>
                                    <option value="PAN">Panama</option>
                                    <option value="PNG">Papua New Guinea</option>
                                    <option value="PRY">Paraguay</option>
                                    <option value="PER">Peru</option>
                                    <option value="PHL">Philippines</option>
                                    <option value="PCN">Pitcairn</option>
                                    <option value="POL">Poland</option>
                                    <option value="PRT">Portugal</option>
                                    <option value="PRI">Puerto Rico</option>
                                    <option value="QAT">Qatar</option>
                                    <option value="REU">Réunion</option>
                                    <option value="ROU">Romania</option>
                                    <option value="RUS">Russian Federation</option>
                                    <option value="RWA">Rwanda</option>
                                    <option value="BLM">Saint Barthélemy</option>
                                    <option value="SHN">Saint Helena, Ascension and Tristan da Cunha</option>
                                    <option value="KNA">Saint Kitts and Nevis</option>
                                    <option value="LCA">Saint Lucia</option>
                                    <option value="MAF">Saint Martin (French part)</option>
                                    <option value="SPM">Saint Pierre and Miquelon</option>
                                    <option value="VCT">Saint Vincent and the Grenadines</option>
                                    <option value="WSM">Samoa</option>
                                    <option value="SMR">San Marino</option>
                                    <option value="STP">Sao Tome and Principe</option>
                                    <option value="SAU">Saudi Arabia</option>
                                    <option value="SEN">Senegal</option>
                                    <option value="SRB">Serbia</option>
                                    <option value="SYC">Seychelles</option>
                                    <option value="SLE">Sierra Leone</option>
                                    <option value="SGP">Singapore</option>
                                    <option value="SXM">Sint Maarten (Dutch part)</option>
                                    <option value="SVK">Slovakia</option>
                                    <option value="SVN">Slovenia</option>
                                    <option value="SLB">Solomon Islands</option>
                                    <option value="SOM">Somalia</option>
                                    <option value="ZAF">South Africa</option>
                                    <option value="SGS">South Georgia and the South Sandwich Islands</option>
                                    <option value="SSD">South Sudan</option>
                                    <option value="ESP">Spain</option>
                                    <option value="LKA">Sri Lanka</option>
                                    <option value="SDN">Sudan</option>
                                    <option value="SUR">Suriname</option>
                                    <option value="SJM">Svalbard and Jan Mayen</option>
                                    <option value="SWZ">Swaziland</option>
                                    <option value="SWE">Sweden</option>
                                    <option value="CHE">Switzerland</option>
                                    <option value="SYR">Syrian Arab Republic</option>
                                    <option value="TWN">Taiwan, Province of China</option>
                                    <option value="TJK">Tajikistan</option>
                                    <option value="TZA">Tanzania, United Republic of</option>
                                    <option value="THA">Thailand</option>
                                    <option value="TLS">Timor-Leste</option>
                                    <option value="TGO">Togo</option>
                                    <option value="TKL">Tokelau</option>
                                    <option value="TON">Tonga</option>
                                    <option value="TTO">Trinidad and Tobago</option>
                                    <option value="TUN">Tunisia</option>
                                    <option value="TUR">Turkey</option>
                                    <option value="TKM">Turkmenistan</option>
                                    <option value="TCA">Turks and Caicos Islands</option>
                                    <option value="TUV">Tuvalu</option>
                                    <option value="UGA">Uganda</option>
                                    <option value="UKR">Ukraine</option>
                                    <option value="ARE">United Arab Emirates</option>
                                    <option value="GBR">United Kingdom</option>
                                    <option value="USA">United States</option>
                                    <option value="UMI">United States Minor Outlying Islands</option>
                                    <option value="URY">Uruguay</option>
                                    <option value="UZB">Uzbekistan</option>
                                    <option value="VUT">Vanuatu</option>
                                    <option value="VEN">Venezuela, Bolivarian Republic of</option>
                                    <option value="VNM">Viet Nam</option>
                                    <option value="VGB">Virgin Islands, British</option>
                                    <option value="VIR">Virgin Islands, U.S.</option>
                                    <option value="WLF">Wallis and Futuna</option>
                                    <option value="ESH">Western Sahara</option>
                                    <option value="YEM">Yemen</option>
                                    <option value="ZMB">Zambia</option>
                                    <option value="ZWE">Zimbabwe</option>
                                </select>
                            </li>
                            <li class="languages">
                                <select class="form-control bfh-countries" data-country="US">
                                    <option value="">Safety Off</option>
                                    <option value="">Safety On</option>
                                </select>
                            </li>
                            <li><a href="history.jsp" class="f-history">History</a></li>
                            <li><a href="#small-dialog5" class="play-icon popup-with-zoom-anim f-history f-help">Help</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- //footer -->
        </div>
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
