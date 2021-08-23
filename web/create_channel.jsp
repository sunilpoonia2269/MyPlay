<%-- 
    Document   : create_channel
    Created on : 27-May-2021, 3:58:07 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Channel | My Play</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
        integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="style.css">
    <link href="css/custom.css" rel="stylesheet">

</head>

<body>

    <section class="container-fluid">
        <section class="row justify-content-center">
            <section class="col-lg-4 col-sm-6 col-md-3 form">
                <div class="form-container">
                    <div class="logo">
                        <img src="images/logo.png" alt="" />
                    </div>
<!--                    <form method="post" action="CreateChannel" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="channel" class="col-lg-4">Name : </label>
                            <input type="text" class="col-lg-7" id="channel" placeholder="Enter Channel Name" name="channel" />

                        </div>

                        <div class="form-group">
                                <label class="form-label" class="col-lg-4"> Channel Template : </label>
                                    Upload Channel Template
                                </label>
                                <input name="template" type="file"/>
                            </div>
                      
                        <div class="button">
                            <button type="submit" class="btn btn-outline-primary col-lg-11">Create Channel</button>
                        </div>
                    </form>-->
                    
                    <div class="video-edit">
                            <form method="post" action="CreateChannel" enctype="multipart/form-data">
                                
                                <label for="chname" class="form-label">Channel Name :</label> 
                                <input type="text" name="channel" class="email" value="" id="chname"  placeholder="Channel-Name" required="required" />
                                <!--<input type="text" class="email" name="description" id="video-desc"  placeholder="Description"   />-->

                                <label class="form-label"> Template : </label>
                                <input id="temp-upload" name="template" type="file"/>

                                <input type="submit"  value="Submit"/>
                            </form>

                        </div>


                </div>

            </section>
        </section>
    </section>

</body>

</html>