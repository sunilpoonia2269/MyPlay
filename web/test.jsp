<%-- 
    Document   : test
    Created on : 02-Jul-2021, 4:48:23 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
<style>
   body {
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
      padding: 20px;
   }
   .fa {
      font-size: 50px;
      cursor: pointer;
      user-select: none;
   }
   .fa-thumbs-up {
      color: blue;
   }
   .fa-thumbs-down {
      color: red;
   }
   .fa:hover {
      transform: scale(1.2);
   }
</style>
</head>
<body>
<h1>Like dislike button example</h1>
<i class="fa fa-thumbs-up"></i>
<script>
   document.querySelector(".fa").addEventListener("click", function(event) {
      toggleLike(event);
   });
   function toggleLike(ele) {
      ele.target.classList.toggle("fa-thumbs-down");
   }
</script>
</body>
</html>
