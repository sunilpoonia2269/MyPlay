<%-- 
    Document   : subscribe
    Created on : 22-Jun-2021, 12:34:18 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>

<%
    
    Cookie c[] = request.getCookies();
        
        String email = null;
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("login")){
                email = c[i].getValue();
            }
        }
        
        if(email == null){
            response.sendRedirect("login.jsp");
            
            
        }else{
           
       
        String chCode = request.getParameter("chcode");
        String status = request.getParameter("status");
        
        int subs=0;
        int sn=0;
        
            try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone","root","");
            Statement st = cn.createStatement();
            
            ResultSet getChannel = st.executeQuery("select * from channel where chcode='"+chCode+"'");
                    if(getChannel.next()){                       
                        subs = getChannel.getInt("subs");                      
                   }
            ResultSet rs=st.executeQuery("select Max(sn) as sn from sub_channel");
                    if(rs.next()){
                        sn=rs.getInt("sn");
                        sn++;
                        }
           
            
            if(status.equals("true")){
            PreparedStatement updateSub = cn.prepareStatement("insert into sub_channel values(?,?,?)");

                    updateSub.setInt(1, sn);
                    updateSub.setString(2, chCode);
                    updateSub.setString(3, email);
                    updateSub.executeUpdate();
                    updateSub.close();
            subs++;        
            PreparedStatement updateSubs = cn.prepareStatement("Update channel set subs=? where chcode='"+chCode+"'");
                
                updateSubs.setInt(1, subs);
                updateSubs.executeUpdate();
                updateSubs.close();
                    
           
        }else{
             int updateSub = st.executeUpdate("delete from sub_channel where email='"+email+"'");
             subs--;
            PreparedStatement updateSubs = cn.prepareStatement("Update channel set subs=? where chcode='"+chCode+"'");                                 
            updateSubs.setInt(1, subs);
            updateSubs.executeUpdate();
            updateSubs.close();
                
            }
        
             }catch(Exception e){
                out.println(e.getMessage());
            }
        
        
        
        
        
        
        
//        String chCode = request.getParameter("chcode");
//        String isSub = request.getParameter("isSub");
//        String vcode = request.getParameter("vcode");
//        
//        int subs=0;
//        if(email == null){
//            response.sendRedirect("login.jsp");
//        }
//        else{
//    try{
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone","root","");
//            
//        
//        
//        
//        
//        if(isSub.equals("1")){
//            
//            
//          
//            int updateSub = st.executeUpdate("delete from sub_channel where email='"+email+"'");
//
//
//
//
//           subs--;
//            PreparedStatement updateSubs = cn.prepareStatement("Update channel set subs=? where chcode='"+chCode+"'");                                 
//            updateSubs.setInt(1, subs);
//            updateSubs.executeUpdate();
//            updateSubs.close();
//            
//            response.sendRedirect("single.jsp?vcode="+vcode);
//
//
//
//             }
//        
//             if(isSub.equals("0")){
//                
//
//
//
//
//                    PreparedStatement updateSub = cn.prepareStatement("insert into sub_channel values(?,?,?)");
//
//                    updateSub.setInt(1, 1);
//                    updateSub.setString(2, chCode);
//                    updateSub.setString(3, email);
//                    updateSub.executeUpdate();
//                    updateSub.close();
//                    subs++;
//                    PreparedStatement updateSubs = cn.prepareStatement("Update channel set subs=? where chcode='"+chCode+"'");
//
//                    updateSubs.setInt(1, subs);
//                    updateSubs.executeUpdate();
//                    updateSubs.close();
//                    
//                    response.sendRedirect("single.jsp?vcode="+vcode);
//
//
//                                                                       
//             }
//    }catch(Exception er){
//        out.print(er.getMessage());
//    }
//    
//        }
//        
//
//
//

    }

%>