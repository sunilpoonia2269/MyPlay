<%-- 
    Document   : account_create
    Created on : 25-May-2021, 12:55:32 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.util.*"%>
<%

    String name = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("pass");
    String repass = request.getParameter("repass");
    int sn = 1;
    String code = "";
    LinkedList l = new LinkedList();
    for (char c = 'A'; c <= 'Z'; c++) {
        l.add(c + "");
    }
    for (char c = 'a'; c <= 'z'; c++) {
        l.add(c + "");
    }
    for (int i = 1; i <= 9; i++) {
        l.add(new Integer(i));
    }
    Collections.shuffle(l);
    for (int i = 0; i <= 6; i++) {
        code = code + l.get(i);
    }
    code = code + "_" + sn;

    if (!password.equals(repass)) {
        response.sendRedirect("index.jsp?re_pass_error=1");

    } else {

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery("select MAX(sn) as sn from user_login");
            if (rs.next()) {
                sn = rs.getInt("sn");
                sn++;

            }
            PreparedStatement ps = cn.prepareStatement("insert into user_login values (?,?,?,?,?)");

            ps.setInt(1, sn);

            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, code);
            ps.executeUpdate();
            ps.close();

            cn.close();
            Cookie c = new Cookie("login", email);
            c.setMaxAge(300);
            response.addCookie(c);

            session.setAttribute(email, password);
            session.setMaxInactiveInterval(200);

            response.sendRedirect("index.jsp?acc_success=1");

        } catch (Exception er) {
            out.println(er);
        }
    }


%>
