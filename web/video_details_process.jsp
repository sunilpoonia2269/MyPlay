<%-- 
    Document   : video_details_process
    Created on : 01-Jun-2021, 12:26:53 PM
    Author     : MARCOS
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.util.Date"%>
<%
    String vcode=request.getParameter("vcode");
    String title = request.getParameter("title");
    String description = request.getParameter("description");
    String category = request.getParameter("category");
    Date uploadDate = new Date();
    SimpleDateFormat ft = new SimpleDateFormat("dd-MM-yyyy");
    String fDate = ft.format(uploadDate);
    

    int sn=1;
    String chcode="";
    String usercode="";
    


     Cookie c[] = request.getCookies();
        
        String email = null;
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("login")){
                email = c[i].getValue();
            }
        }
        
        if(email == null){
            response.sendRedirect("login.jsp");
        }
        
        else{
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone","root","");
                Statement st = cn.createStatement();
                ResultSet rs=st.executeQuery("select Max(sn) as sn from uploaded_videos");
                    if(rs.next()){
                        sn=rs.getInt("sn");
                        sn++;
                        }
                ResultSet userCode = st.executeQuery("select usercode from user_login where email='"+email+"'");
                if(userCode.next()){
                    usercode= userCode.getString("usercode");
                }
                ResultSet chCode = st.executeQuery("select chcode from channel where usercode='"+usercode+"'");
                if(chCode.next()){
                    chcode= chCode.getString("chcode");
                }
                


                PreparedStatement ps = cn.prepareStatement("insert into uploaded_videos values (?,?,?,?,?,?,?,?,?)");
                ps.setInt(1,sn);
                ps.setString(2,vcode);
                ps.setString(3,chcode);
                ps.setString(4,usercode);
                ps.setString(5,title);
                ps.setString(6,description);
                ps.setString(7,category);
                ps.setString(8,fDate);
                ps.setInt(9,0);
                ps.executeUpdate();
                ps.close();
                
                cn.close();
                
                response.sendRedirect("thumbnail.jsp?vcode="+vcode);
                                

                 } 
                catch(Exception er){
                    out.println(er.getMessage());

                }
        }





%>
