<%-- 
    Document   : profile
    Created on : 26-May-2021, 11:40:34 AM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    String dp_name = "";
    String channelName = "";
    int subs = 0;
    int videoCount = 0;
    boolean isChannel = false;
    String chCode = request.getParameter("chcode");
    boolean isOwner = false;
    String channelOwnerCode = "";
    boolean isLogin = false;
    boolean isSubscribed = false;

    Cookie c[] = request.getCookies();

    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }
    try {

        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
        Statement st = cn.createStatement();
        Statement st1 = cn.createStatement();

        if (email != null && session.getAttribute(email) != null) {

            ResultSet rs = st.executeQuery("select usercode from user_login where email='" + email + "'");
            if (rs.next()) {
                dp_name = rs.getString(1);
                isLogin = true;

            }
            ResultSet getSubscription = st.executeQuery("select chcode from sub_channel where email='" + email + "'");
            while (getSubscription.next()) {
                if (chCode.equals(getSubscription.getString("chcode"))) {
                    isSubscribed = true;
                }
            }

        }

        ResultSet getVideoCount = st.executeQuery("select * from uploaded_videos where chcode='" + chCode + "'");
        while (getVideoCount.next()) {
            videoCount++;

        }
        ResultSet rss = st.executeQuery("select * from channel where chcode='" + chCode + "'");
        if (rss.next()) {
            channelName = rss.getString("name");
            subs = rss.getInt("subs");
            isChannel = true;
            channelOwnerCode = rss.getString("usercode");
            if (channelOwnerCode.equals(dp_name)) {
                isOwner = true;
            }
        }


%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile | YouTube</title>
        <!-- bootstrap -->
        <link href="css/bootstrap.min.css" rel='stylesheet' type='text/css' media="all" />
        <!-- //bootstrap -->
        <link href="css/dashboard.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!-- Custom Theme files -->
        <link href="css/style.css" rel='stylesheet' type='text/css' media="all" />
        <script src="js/jquery-1.11.1.min.js"></script>
        <link href="css/custom.css" rel="stylesheet">
        <!--start-smoth-scrolling-->
        <style>
            .main{
                margin-top: 1.5rem;
            }

            .template{
                min-height: 200px;
                max-height: 300px;
                position: relative;
            }
            .template img{
                max-height: 300px;
                width: 100%;
            }

            .channel-details{
                padding: 2rem;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100%;
            }
            .channel-img{
                width: auto;
                height: auto;
                padding-right: 20px;
                text-align: left;

            }
            .channel-img img{
                width: 80px;
                height: 80px;
                border-radius: 100%;
                background-color: grey;
            }
            .channel-name{
                flex-grow: 3;
                text-align: left;

            }
            .channel-title{
                font-size: 2.4rem;
                color: #030303;

            }
            .channel-title h1{
                margin-bottom: 0;
                display: inline;
            }
            .channel-title span{
                width: 16px;
                height: 16px;
                color: #21DEEF;
            }
            .channel-subs{
                font-size: 1.4rem;
                color: #606060;
            }

            .sub-button{
                flex-grow:  1;
                text-align: left;
            }
            .sub-button button{
                color: #fff;
                font-size: 1.4rem;
                text-transform: uppercase;
                letter-spacing: .5px;
                font-weight: 500;
                white-space: nowrap;
                padding: 10px 16px;
                background-color: #21DEEF;
                border: none;
                transition: background-color 150ms;
                border-radius: 8px;
            }
            .sub-button button:hover{
                color:#272C2E;
                background-color: #F7F7F7;
            }
            .hide{display: none}

            .subscribed{
                color:#272C2E !important;
                background-color: #F7F7F7 !important; 
            }


            hr{
                margin: 0;
            }

            .click-button{
                border: none;
                background-color: transparent;
                border-radius: 10px;
                color: red;

            }
            .click-button:hover{
                color: white;
                background-color: red;
            }





            .create-channel {
                margin: 5px;
            }

            .create-channel a {
                text-decoration: none;
                color: #fff;
            }


            .uploaded-video {
                margin: 3% 14% 3% 18%;
                text-align: left;

            }
            .profile-img{
                width:50px;
                height: 50px;
                border-radius: 50%;
                vertical-align: middle;
            }

            .main{
                padding-top: 20px;
            }
            .flex-class{
                display: flex;
                flex-wrap: wrap;
            }

            .video-edit{
                border:none;
                width: 100%;
                text-align: left;
                position: relative;
                padding: 2em 0 0 6em;

            }
            .video-edit input.email[type="text"], .video-edit input[type="password"] {
                width: 100%;
                padding: 10px;
                background: #FFF;
                margin: 10px 0;
                font-size: 14px;
                outline: none;
                color: #817F7F;
                border: solid 1px #817F7F;
            }

            .video-edit input[type="submit"]:hover {
                background: #C7C7C7;

                transition: all 0.5s ease-in-out;
            }

            .video-edit input[type="submit"] {
                display: block;
                border: 0px;
                padding: .5em 2em;
                background: #21DEEF;
                margin: 1em 0 0 0;
                outline: none;
                font-size: 16px;
                color: #fff;
                text-transform: uppercase;

                position: relative;
                border-radius: 3px;

            }

            .description{
                width: 100%;
                padding: 10px;
                background: #FFF;
                margin: 10px 0;
                font-size: 14px;
                outline: none;
                color: #817F7F;
                border: solid 1px #817F7F;
            }
            input[type="file"] {
                display: none;
            }
            .custom-file-upload {                
                display: inline-block;                
                cursor: pointer;               
                padding: 10px;
                background: #FFF;
                margin: 10px 0;
                font-size: 14px;
                outline: none;
                color: #817F7F;
                border: solid 1px #817F7F;

            }
            .form-label{
                font-size: 14px;
                font-weight: bold;
                padding: 5px;
            }
            #category{
                padding: 10px;
                background: #FFF;
                margin: 10px 0;
                font-size: 14px;
                outline: none;
                color: #817F7F;
                border: solid 1px #817F7F; 
            }


            #small-dialog-login, #small-dialog-delete{
                width: 30%;
                min-height: 200px;
            }
            .delete-message button{
                margin: 10px;                
            }

            .image-class{
                max-height: 140px;
            }
            .random-class{
                margin-bottom: 15px;
            }



            /*    .background{
                    background-image: url(images/c.jpg);
                }*/
        </style>
    </head>

    <body>
        <!-- Navbar Section -->

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
                            <!-- pop-up-box -->
                            <script type="text/javascript" src="js/modernizr.custom.min.js"></script>    
                            <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
                            <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
                            <!--//pop-up-box -->

                            <div id="small-dialog3" class="mfp-hide">
                                <h3>Create Account</h3> 

                                <div class="signup">
                                    <form method="POST" action="AccountCreate" enctype="multipart/form-data">
                                        <div class="input-div">
                                            <label class="form-label">Name : </label>
                                            <input type="text" class="email" name="username" placeholder="Your Name" required="required" />
                                        </div>
                                        <div class="input-div">
                                            <label class="form-label">DOB : </label>
                                            <input type="date" class="email" name="dob" min="1960-01-01" max="2021-01-01" required pattern="\d{4}-\d{2}-\d{2}"/>
                                        </div>
                                        <div class="input-div">
                                            <label class="form-label">Email : </label>
                                            <input type="text" class="email" name="email" placeholder="Email" required="required" pattern="([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?" title="Enter a valid email"/>
                                        </div>
                                        <div class="input-div">
                                            <label class="form-label">Gender :</label> 
                                            <div class="radio-input-div">
                                                <input type="radio" name="gender" id="male"  value="Male"/>
                                                <label for="male" class="form-label">Male</label> 
                                            </div>
                                            <div class="radio-input-div">
                                                <input type="radio" name="gender" id="female"  value="Female"/> 
                                                <label for="female" class="form-label">Female</label> 
                                            </div>
                                        </div>
                                        <div class="input-div">
                                            <label class="form-label">Password : </label>
                                            <input type="password" name="pass" placeholder="Password" required="required" pattern=".{6,}" title="Minimum 6 characters required" autocomplete="off" />
                                        </div>
                                        <div class="input-div">
                                            <label class="form-label">Re-Type Password</label>
                                            <input type="password" name="repass" placeholder="Re-Type Password" required="required" pattern=".{6,}" title="Minimum 6 characters required" autocomplete="off" />

                                        </div>
                                        <div class="input-div">
                                            <label class="form-label" for="profile-upload"> Image : </label>
                                            <input id="profile-upload" name="image" type="file" /> 
                                        </div>






                                        <input type="submit"  value="Sign Up"/>
                                    </form>
                                </div>
                                <div class="clearfix"> </div>
                            </div>	
                            <!--                            <div id="small-dialog7" class="mfp-hide">
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
                                                        </div>		-->
                            <!--                            <div id="small-dialog4" class="mfp-hide">
                                                            <h3>Feedback</h3> 
                                                            <div class="feedback-grids">
                                                                <div class="feedback-grid">
                                                                    <p>Suspendisse tristique magna ut urna pellentesque, ut egestas velit faucibus. Nullam mattis lectus ullamcorper dui dignissim, sit amet egestas orci ullamcorper.</p>
                                                                </div>
                                                                <div class="button-bottom">
                                                                    <p><a href="#small-dialog" class="play-icon popup-with-zoom-anim">Sign in</a> to get started.</p>
                                                                </div>
                                                            </div>
                                                        </div>-->
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
                            <!--                            					<a href="#small-dialog" class="play-icon popup-with-zoom-anim">Sign In</a>
                                                                                                <div id="small-dialog" class="mfp-hide">
                                                                                                        <h3>Sign In</h3>
                                                                                                        <div class="social-sits">
                                                                                                                <div class="facebook-button">
                                                                                                                        <a href="#">Connect with Facebook</a>
                                                                                                                </div>
                                                                                                                <div class="chrome-button">
                                                                                                                        <a href="#">Connect with Google</a>
                                                                                                                </div>
                                                                                                                <div class="button-bottom">
                                                                                                                        <p>New account? <a href="#small-dialog2" class="play-icon popup-with-zoom-anim">Signup</a></p>
                                                                                                                </div>
                                                                                                        </div>
                                                                                                        <div class="signup">
                                                                                                                <form id="login-form">
                                                                                                                        <input type="text" class="email" id="login-email" placeholder="Enter email / mobile" required="required" pattern="([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?"/>
                                                                                                                        <input type="password" name="password" id="login-password" placeholder="Password" required="required" pattern=".{6,}" title="Minimum 6 characters required" autocomplete="off" />
                                                                                                                        <input type="submit"  value="LOGIN"/>
                                                                                                                </form>
                                                                                                                <div class="forgot">
                                                                                                                        <a href="#">Forgot password ?</a>
                                                                                                                </div>
                                                                                                        </div>
                                                                                                        <div class="clearfix"> </div>
                                                                                                </div>                       -->
                        </div>



                        <%                                    } else {
                            isLogin = true;

                        %>

                          <div class="profile-div">
                        <button class="upload-btn"><a href="upload.html">Upload</a></button> 
                    </div>

                        <div class="profile-icon">
                            <button class="profile-button" onclick="myFunction()">
                                <img class="profile-img" src="upload/<%=dp_name%>.jpg"alt="Hello"/>
                            </button>
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
                    <li><a href="history.jsp" class="sub-icon"><span class="glyphicon glyphicon-home glyphicon-hourglass"
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
                    <li class="active"><a href="profile.jsp" class="home-icon"><span class="glyphicon glyphicon-home"
                                                                                     aria-hidden="true"></span>Profile</a></li>
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
                                href="#">MarcosOP</a></p>
                    </div>
                </div>
            </div>
        </div>




        <!-- Profile - Picture Section -->


        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="template">

                <img src="channelTemplate/<%=chCode%>.jpg" alt="any text">
            </div>

            <div class="channel-details">
                <div class="channel-img">
                    <img src="upload/<%=channelOwnerCode%>.jpg" alt="">
                </div>
                <div class="channel-name">
                    <div class="channel-title">
                        <h1><%=channelName%></h1>
                        <span class="material-icons">
                            check_circle
                        </span>
                    </div>
                    <div>
                        <p class="channel-subs"><%=subs%> subscribers</p>
                    </div>


                </div>
                <div class="sub-button">
                    <button id="subscribe-button">Subscribe</button>
                    <button id="edit-button">Edit Channel</button>

                </div>
            </div>
            <hr>

            <div class="main-grids">
                <div class="top-grids">
                    <div class="recommended-info">
                        <h3>Uploaded Videos(<%=videoCount%>)</h3>
                    </div>
                    <%

                        ResultSet rs = st.executeQuery("select * from uploaded_videos where chcode='" + chCode + "'");

                        while (rs.next()) {

                            ResultSet getChannel = st1.executeQuery("select name from channel where chcode='" + chCode + "'");

                            if (getChannel.next()) {


                    %>

                    <div class="col-md-3 resent-grid recommended-grid slider-first" id="<%=rs.getString("vcode")%>">
                        <div class="random-class">
                            <div class="resent-grid-img recommended-grid-img">
                                <div class="delete-icon">
                                    <a href="#small-dialog-delete" class="popup-with-zoom-anim">
                                        <span class="material-icons delete-popup" value="<%=rs.getString("vcode")%>">delete</span>

                                    </a> 
                                </div>

                                <div class="edit-icon">
                                    <span class="material-icons click-button" value="<%=rs.getString("vcode")%>">edit</span>
                                    <a href="#small-dialog" id="automatic" style="display:none;" class="author popup-with-zoom-anim"></a>

                                </div>

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

                        } catch (Exception er) {
                            out.println(er.getMessage());
                        }
                    %>

                    <!-- pop-up-box -->
                    <script type="text/javascript" src="js/modernizr.custom.min.js"></script>    
                    <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
                    <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
                    <!--//pop-up-box -->




                    <div id="small-dialog" class="mfp-hide">
                        <h3>Edit Video</h3>

                        <div class="video-edit">
                            <form id="login-form" method="POST" action="EditProcess?chcode=<%=chCode%>" enctype="multipart/form-data">
                                <label for="video-code" class="form-label">Vcode :</label>  <input type="text" name="vcode" class="email" value="" id="video-code"  readonly />
                                <label for="video-title" class="form-label">Title :</label> <input type="text" name="title" class="email" value="" id="video-title"  placeholder="Title" required="required" />
                                <!--<input type="text" class="email" name="description" id="video-desc"  placeholder="Description"   />-->
                                <label for="video-desc" class="form-label">Description :</label><textarea class="description" name="description" value=""  id="video-desc" rows="3"></textarea> 
                                <label class="form-label"> Thumbnail : </label><label for="file-upload" class="custom-file-upload">
                                    Upload New Thumbnail
                                </label>
                                <input id="file-upload" name="image" type="file"/>
                                <label class="form-label">Category :</label>
                                <select name="category" id="category">
                                    <option value="Entertainment">Entertainment</option>
                                    <option value="Education">Educational</option>
                                    <option value="Songs">Songs</option>
                                    <option value="Cricket">Cricket</option>
                                    <option value="Football">Football</option>
                                    <option value="Other Sports">Sports</option>
                                    <option value="Technology">Programming</option>
                                    <option value="Comedy">Comedy</option>
                                    <option value="Vlogs">Vlogs</option>
                                    <option value="Party-Songs">Party-Songs</option>
                                    <option value="Trailers">Trailers</option>
                                    <option value="Gaming">Gaming</option>
                                    <option value="Tennis">Tennis</option>
                                    <option value="Motivational">Motivational</option>
                                    <option value="Others">Others</option>

                                </select>

                                <input type="submit"  value="Update"/>
                            </form>

                        </div>
                        <div class="clearfix"> </div>
                    </div>   

                    <!-- popup for edit channel -->
                    <a href="#edit-channel-dialog" id="edit-popup" style="display:none;" class="popup-with-zoom-anim"></a>
                    <div id="edit-channel-dialog" class="mfp-hide">
                        <h3>Edit Channel</h3>


                        <div class="video-edit">
                            <form id="edit-form" method="POST" action="EditChannel?status=updateChannel"  enctype="multipart/form-data">
                                <label for="chcode" class="form-label">ChCode :</label>  <input type="text" name="chcode" class="email" value="<%=chCode%>" id="chcode"  readonly />
                                <label for="chname" class="form-label">Channel Name :</label> <input type="text" name="chname" class="email" value="" id="chname"  placeholder="Channel-Name" required="required" />
                                <!--<input type="text" class="email" name="description" id="video-desc"  placeholder="Description"   />-->

                                <label class="form-label"> Template : </label><label for="temp-upload" class="custom-file-upload">
                                    Upload New Template
                                </label>
                                <input id="temp-upload" name="template" type="file"/>

                                <input type="submit"  value="Update"/>
                            </form>

                        </div>
                        <div class="clearfix"> </div>
                    </div>   




                    <!-- Popup for deleting an video -->
                    <div id="small-dialog-delete" class="mfp-hide">
                        <h5>Delete Video</h5>
                        <div class="delete-message">
                            <p>You will not be able to restore this video once deleted</p>
                            <p>Do you really want to delete this video??</p>
                            <button class="btn btn-danger" id="delete-button">Delete</button>

                        </div>

                        <div class="clearfix"> </div>
                    </div>

                    <!-- Popup for login -->
                    <a href="#small-dialog-login" id="login-popup" style="display:none;" class="popup-with-zoom-anim"></a>
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


                        var isLogin = <%=isLogin%>;
                        if (<%=isOwner%>) {
                            $("#subscribe-button").addClass("hide");
                            $("#edit-button").removeClass("hide");
                        } else {
                            $("#subscribe-button").removeClass("hide");
                            $("#edit-button").addClass("hide");
                            $(".delete-icon").addClass("hide");
                            $(".edit-icon").addClass("hide");
                            $(".click-button").addClass("hide");

                            $(".upload-btn").addClass("hide");
                        }
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
                        var vcode = "";
                        $(".delete-popup").click(function () {
                            vcode = $(this).attr("value");

                        });

                        $("#delete-button").click(function () {
                            console.log(vcode);
                            $.ajax({
                                url: "edit_video.jsp?vcode=" + vcode + "&title=3&chcode=<%=chCode%>",
                                type: "GET",
                                success: function (data) {
                                    data = data.replace(/(?:(?:\r\n|\r|\n)\s*){2}/gm, "");
                                    if (data === "1") {
                                        $("#" + vcode).hide("slow", function () {
                                            $("#" + vcode).remove();
                                        });

                                    }

                                }
                            });
                            $(".mfp-close").trigger("click");


                        });

                        // Script for Subscribe button
                        if (<%=isSubscribed%>) {
                            $("#subscribe-button").addClass("subscribed");
                            $("#subscribe-button").text("Subscribed");
                        }
                        $("#subscribe-button").click(function () {
                            if (isLogin) {


                                $(this).toggleClass("subscribed");
                                var text = $("#subscribe-button").text();

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
                                $("#login-popup").trigger("click");
                            }
                        });
                        $(".close-popup").click(function () {
                            $(".mfp-close").trigger("click");
                        });

                        // Script for edit channel dialog box

                        $("#edit-button").click(function () {
                            $.post("EditChannel", {chcode: "<%=chCode%>", status: "getData"}, function (data) {
                                $("#chname").val(data);
                                console.log(data);
                            });

                            $("#edit-popup").trigger("click");
                        });





                    });


                    </script>




                    <script>



                        $(".click-button").click(function () {
                            var videoId = $(this).attr("value");

                            $("#video-code").val(videoId);

                            $.ajax({
                                url: "edit_video.jsp?vcode='" + videoId + "'&title=1",
                                type: "GET",
                                success: function (data) {
                                    console.log(data);
                                    $("#video-title").val(data);
                                }
                            });
                            $.ajax({
                                url: "edit_video.jsp?vcode='" + videoId + "'&title=2",
                                type: "GET",
                                success: function (data) {

                                    data = data.replace(/(?:(?:\r\n|\r|\n)\s*){2}/gm, "");
                                    console.log(data);
                                    $("#video-desc").val(data);
                                }
                            });
                            $("#automatic").trigger("click");



                        });


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


                    <div class="clearfix"> </div>                                    

                </div>
            </div>
        </div>








        <!-- Footer Section -->

    </body>

</html>