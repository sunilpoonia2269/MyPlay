<%-- 
    Document   : video_details
    Created on : 31-May-2021, 10:59:09 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.Date"%>
<%
    String today = (new Date()).toString();
    
String vcode = request.getParameter("vcode");
    
    
    
    %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Video description | YouTube</title>
        <link href="css/inputcss.css" rel='stylesheet' type='text/css' media="all" />
    </head>
    <body>
        <header>
            <div class="header-div">
                <h1>Enter Video Details</h1>
                <h1><%=today%></h1>

            </div>
        </header>
        <section class="form-section">
            <div class="form-div">
                <form id="dform" method="post" action="video_details_process.jsp?vcode=<%=vcode%>" >
                    <div class="form-item">
                        <label for="title">Title : </label>
                        <input type="text" name="title" id="title" required="required" placeholder="Enter Video Title"/>
                    </div>
                     <div class="form-item">
                        <label for="desc">Description : </label>
                        <textarea row="3" cols="50" name="description" id="desc" placeholder="Enter Video description"></textarea>
                    </div>
                     <div class="form-item">
                        <label for="category">Category : </label>
                        <select name="category" id="category">
                            <option value="Entertainment">Entertainment</option>
                            <option value="Education">Education</option>
                            <option value="Comedy">Comedy</option>
                            <option value="People&Blog">People&Blog</option>
                            <option value="Gaming">Gaming</option>
                            <option value="Others">Others</option>
                        </select>
                        
                    </div>
                    <div class="form-button">
                        <button form="dform">Save Details</button>
                        
                    </div>
                    
                    
                </form>
            </div>
            
        </section>
    </body>
</html>
