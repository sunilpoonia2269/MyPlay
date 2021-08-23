<%-- 
    Document   : edit_channel
    Created on : 21 Jul, 2021, 5:28:12 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<%
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

            ResultSet rs = st.executeQuery("select * from user_login where email='" + email + "'");
            if (rs.next()) {


%>
<h3>Edit Account Details</h3>

<div class="video-edit">
    <form id="login-form" method="POST" action="EditUser" enctype="multipart/form-data">
        <div class="input-div">
            <label for="name" class="form-label">Name :</label>
            <input type="text" name="name" class="email" value="<%=rs.getString("name")%>" id="name" />  
        </div>


        <div class="input-div">
            <label class="form-label">Gender :</label> 
            <div class="radio-input-div">
                <input type="radio" name="gender" id="male"  value="Male" <%=(rs.getString("gender").equals("Male") ? "checked": null)%>/>
                <label for="male" class="form-label">Male</label> 
            </div>
            <div class="radio-input-div">
                <input type="radio" name="gender" id="female"  value="Female" <%=(rs.getString("gender").equals("Female") ? "checked": null)%>/> 
                <label for="female" class="form-label">Female</label> 
            </div>
        </div>
        <div class="input-div">
            <label class="form-label" for="file-upload"> Image : </label>
            <input id="file-upload" name="image" type="file" /> 
        </div>



                <div class="form-button">
                    <button type="submit" value="submit" class="update-button">Update</button>
                  
                </div>
                
    </form>
               
</div>

<%                            }

        } catch (Exception er) {
            out.println(er.getMessage());
        }
    }


%>
