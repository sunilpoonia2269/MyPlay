<%-- 
    Document   : user_profile
    Created on : 19 Jul, 2021, 5:43:55 PM
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
    boolean hasChannel = false;

    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }

    if (email == null && session.getAttribute(email) == null) {
        response.sendRedirect("login.jsp");
    } else {
        String chCode = "";
        String channelName = "";
        String videoCount = "";
        String subs = "";
        String userName = "";
        String gender = "";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();
            Statement st1 = cn.createStatement();

            ResultSet getImage = st.executeQuery("select usercode, name, gender from user_login where email='" + email + "'");
            if (getImage.next()) {
                dp_name = getImage.getString(1);
                userName = getImage.getString(2);
                gender = getImage.getString(3);

            }
            ResultSet getChannel = st.executeQuery("select * from channel where usercode='" + dp_name + "'");
            if (getChannel.next()) {
                chCode = getChannel.getString("chcode");
                channelName = getChannel.getString("name");
                videoCount = getChannel.getString("videoCount");
                subs = getChannel.getString("subs");
                hasChannel = true;

            }


%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Home Page | YouTube</title>
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
                        <% if (hasChannel) { %>
                        <div class="profile-div">
                            <button class="upload-btn"><a href="upload.html">Upload</a></button> 
                        </div>

                        <%} else {%>
                        <div class="upload-btn-div">
                            <a href="create_channel.jsp"><button class="upload-btn">Create Channel</button></a>
                        </div>
                        <%}%>





                        <div class="profile-icon">
                            <button class="profile-button" onclick="myFunction()"><img class="profile-img" src="upload/<%=dp_name%>.jpg"alt="Hello"/></button>
                            <div id="myDropdown" class="dropdown-content">
                                <%if (hasChannel) {%>
                                <a href="profile.jsp?chcode=<%=chCode%>">My Channel</a>
                                <%}%>
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
                    <li class="active"><a href="index.html" class="home-icon"><span class="glyphicon glyphicon-home" aria-hidden="true"></span>Home</a></li>
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
                        <p>Copyright ?? 2015 My Play. All Rights Reserved | Design by <a href="http://w3layouts.com/">W3layouts</a></p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">


            <div class="top-section">
                <div class="card">




                    <div class="top-info-card">
                        <span class="material-icons">sports_esports</span> 
                        <p class="title">Channel</p>
                    </div>
                    <h1><%=channelName%></h1>
                    <p><a href="profile.jsp?chcode=<%=chCode%>"><button class="dashboard-button">Dashboard</button></a></p>
                </div> 
                <div class="card">
                    <div class="top-info-card">
                        <span class="material-icons">video_library</span> 
                        <p class="title">Total Videos</p>
                    </div>
                    <h1><%=videoCount%></h1>
                    <p><a href="profile.jsp?chcode=<%=chCode%>"><button class="dashboard-button">Dashboard</button></a></p>
                </div>  
                <div class="card">
                    <div class="top-info-card">
                        <span class="material-icons">groups</span> 
                        <p class="title">Subscribers</p>
                    </div>

                    <h1><%=subs%></h1>
                    <p><a href="profile.jsp?chcode=<%=chCode%>"><button class="dashboard-button">Dashboard</button></a></p>
                </div>  


            </div>
            <div class="profile-section">
                <div class="info-section">
                    <div class="details-heading"><span class="material-icons">person</span><h1>Account Details</h1></div>
                    <div class="details-table">
                        <table class="table table-bordered">
                            <tr>
                                <th width="30%">Usercode</th>
                                <td width="2%">:</td>
                                <td><%=dp_name%></td>
                            </tr>
                            <tr>
                                <th width="30%">Email </th>
                                <td width="2%">:</td>
                                <td><%=email%></td>
                            </tr>
                            <tr>
                                <th width="30%">Name</th>
                                <td width="2%">:</td>
                                <td><%=userName%></td>
                            </tr>
                            <tr>
                                <th width="30%">Gender</th>
                                <td width="2%">:</td>
                                <td><%=gender%></td>
                            </tr>
                            <tr>
                                <th width="30%">Date of Birth</th>
                                <td width="2%">:</td>
                                <td>19-04-2001</td>

                            </tr>
                        </table>
                    </div>



                </div>
                <div class="image-section">
                    <div class="image-div">
                        <img src="upload/<%=dp_name%>.jpg" alt="Profile-Avatar">

                    </div>


                    <button class="edit-account">Edit Details</button>
                    <button class="delete-account">Delete Account</button>
                </div>
            </div>

            <!--Popup Boxes script file-->
            <!-- pop-up-box -->
            <script type="text/javascript" src="js/modernizr.custom.min.js"></script>    
            <link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
            <script src="js/jquery.magnific-popup.js" type="text/javascript"></script>
            <!--//pop-up-box -->



            <!--Popup boxes-->
            <a href="#small-dialog" id="automatic" style="display:none;" class="author popup-with-zoom-anim"></a>
            <div id="small-dialog" class="mfp-hide">

                <div class="clearfix"> </div>
            </div>

            <script>
                    $(document).ready(function () {
                        $(".edit-account").click(function () {
                            $.get("edit_channel.jsp", function (data) {
                                console.log(data);
                                $("#small-dialog").html(data);
                            });

                            $("#automatic").trigger("click");
                        });



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


                    if (!<%=hasChannel%>) {
                        $(".dashboard-button").prop('disabled', true);


                    } else {
                        $(".dashboard-button").prop('disabled', false);


                    }
            </script>

            <%

                    } catch (Exception er) {
                        out.println(er.getMessage());
                    }

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
                                    <option value="ALA">??land Islands</option>
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
                                    <option value="CIV">C??te d'Ivoire</option>
                                    <option value="HRV">Croatia</option>
                                    <option value="CUB">Cuba</option>
                                    <option value="CUW">Cura??ao</option>
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
                                    <option value="REU">R??union</option>
                                    <option value="ROU">Romania</option>
                                    <option value="RUS">Russian Federation</option>
                                    <option value="RWA">Rwanda</option>
                                    <option value="BLM">Saint Barth??lemy</option>
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
                            <li><a href="history.html" class="f-history">History</a></li>
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
