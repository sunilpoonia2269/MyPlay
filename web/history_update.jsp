<%-- 
    Document   : history_update
    Created on : 03-Jul-2021, 6:16:07 PM
    Author     : MARCOS
--%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.util.Date"%>
<%
 Cookie c[] = request.getCookies();

    String email = null;
    for (int i = 0; i < c.length; i++) {
        if (c[i].getName().equals("login")) {
            email = c[i].getValue();
        }
    }
    
    if(email != null){
//         Date dNow = new Date( );
//         SimpleDateFormat ft = new SimpleDateFormat ("dd-MM-yyyy");
//         String fDate = ft.format(dNow);
        LocalDate today = LocalDate.now();
        String fDate = today.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
                
        int sn=0;
        String vcode = request.getParameter("vcode");
        String chcode = request.getParameter("chcode");
        String chName = request.getParameter("chName");
        
        try {
        
        Class.forName("com.mysql.jdbc.Driver");
        Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
        Statement st = cn.createStatement();
        
        ResultSet getsn = st.executeQuery("select Max(sn) as sn from history");
        if (getsn.next()) {
            sn = getsn.getInt(1);
            sn++;
        }
        
        PreparedStatement history = cn.prepareStatement("insert into history values(?,?,?,?,?,?)");
            history.setInt(1, sn);
            history.setString(2, email);
            history.setString(3, vcode);
            history.setString(4, chcode);
            history.setString(5, fDate);
            history.setString(6, chName);

            history.executeUpdate();
            history.close();
            
            

        
        
        
        
        }catch(Exception e){
        out.println(e.getMessage());
        }

    }
   
 


%>
