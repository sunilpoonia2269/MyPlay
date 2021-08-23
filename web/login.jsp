<%-- 
    Document   : login
    Created on : 25-May-2021, 2:42:31 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | Youtube</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
              integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous">
        </script>
        <link rel="stylesheet" href="style.css">
        <style>
            .form-container {
                background-color: #fff;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 0 10px 0;
                text-align: left;
                margin: 30% auto;

            }

            .logo {
                padding: 20px;
                text-align: center;
                margin-bottom: 2%;

            }

            .logo img {
                height: 49px;
                width: 153px;
            }
            .button{
                text-align: center;
            }

            .login-button {
                padding: 8px 20px;
                background: #21DEEF;
                color: #FFF;
                font-size: 14px;
                text-decoration: none;
                -webkit-transition: 0.5s all;
                cursor: pointer;
                line-height: 1.42857143;
                border: none;
                border-radius: 3px;
                width: 40%;
            }
            .login-button:hover{
                color: #21DEEF;
                background: #F7F7F7;
            }
            
        </style>
    </head>

    <body>

        <section class="container-fluid">
            <section class="row justify-content-center">
                <section class="col-lg-4 col-sm-6 col-md-3 form">
                    <div class="form-container">
                        <div class="logo">
                            <img src="images/logo.png" alt="" />
                        </div>
                        <form method="post" action="login_check.jsp">
                            <div class="form-group">
                                <label for="email" class="col-lg-4">Email : </label>
                                <input type="email" class="col-lg-7" id="email" placeholder="Enter Email" name="email" />

                            </div>
                            <div class="form-group">
                                <label for="password" class="col-lg-4">Password : </label>
                                <input type="password" class="col-lg-7" id="password" name="password"
                                       placeholder="Enter Password">
                            </div>
                            
                            <div class="button">
                                <button type="submit" class="login-button">Login</button>
                            </div>
                        </form>


                    </div>

                </section>
            </section>
        </section>

    </body>

</html>