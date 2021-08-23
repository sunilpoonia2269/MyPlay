/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.LinkedList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author MARCOS
 */
@WebServlet(urlPatterns = {"/AccountCreate"})
@MultipartConfig
public class AccountCreate extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        int sn = 1;
        Part part= request.getPart("image");
        String saveImage= "";

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

                PreparedStatement ps = cn.prepareStatement("insert into user_login values (?,?,?,?,?,?,?)");

                ps.setInt(1, sn);

                ps.setString(2, name);
                ps.setString(3, email);
                ps.setString(4, password);
                ps.setString(5, code);
                ps.setString(6,gender);
                ps.setString(7,dob);
                ps.executeUpdate();
                ps.close();

                cn.close();
                Cookie c = new Cookie("login", email);
                c.setMaxAge(3000);
                response.addCookie(c);

                HttpSession session = request.getSession();
                session.setAttribute(email, password);

                session.setMaxInactiveInterval(2000);
                if(part != null){
                    InputStream isImage =part.getInputStream();
                     byte []dataImage = new byte[isImage.available()];
                     isImage.read(dataImage);
                     
                     
                     saveImage=code+".jpg";
                     String imagePath = request.getRealPath("/");
                     out.print(imagePath);
                     FileOutputStream fileImage = new FileOutputStream(imagePath+"upload"+File.separator+saveImage);
                     fileImage.write(dataImage);
                }

                response.sendRedirect("index.jsp?acc_success=1");
                
                

            } catch (IOException er) {
                out.println(er);
            } catch (ClassNotFoundException er) {
                out.println(er);
            } catch (SQLException er) {
                out.println(er);
            }
        }

    }

}
