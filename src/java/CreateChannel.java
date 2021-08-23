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
import javax.servlet.http.Part;

/**
 *
 * @author MARCOS
 */
@WebServlet(urlPatterns = {"/CreateChannel"})
@MultipartConfig
public class CreateChannel extends HttpServlet {

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
        
         Cookie cookie[] = request.getCookies();

        String email = null;
        for (Cookie cookie1 : cookie) {
            if (cookie1.getName().equals("login")) {
                email = cookie1.getValue();
            }
        }
        if (email == null) {
            response.sendRedirect("login.jsp");
        }else {
            
            String channelName = request.getParameter("channel");
            Part part = request.getPart("template");
            String usercode = "";
            int videoCount = 0;
            
        

        int sn = 1;
        String chcode = "";
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
            chcode = chcode + l.get(i);
        }
        chcode = chcode + "_" + sn;

       

         

            

            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select usercode from user_login where email='" + email + "'");
                if (rs.next()) {
                    usercode = rs.getString(1);
                }
                ResultSet rss = st.executeQuery("select MAX(sn) as sn from channel");
                if (rss.next()) {
                    sn = rss.getInt("sn");
                    sn++;

                }
                PreparedStatement ps = cn.prepareStatement("insert into channel values (?,?,?,?,?,?)");
                ps.setInt(1, sn);
                ps.setString(2, chcode);
                ps.setString(3, usercode);

                ps.setString(4, channelName);

                ps.setInt(5, videoCount);
                ps.setInt(6, 0);

                ps.executeUpdate();
                ps.close();
                
                String saveImage= chcode+".jpg";
                InputStream isImage =part.getInputStream();
                byte []dataImage = new byte[isImage.available()];
                isImage.read(dataImage);



                String imagePath = request.getRealPath("/");
                out.print(imagePath);
                FileOutputStream fileImage = new FileOutputStream(imagePath+"channelTemplate"+File.separator+saveImage);
                fileImage.write(dataImage);
                     fileImage.close();
                     

                cn.close();
                response.sendRedirect("profile.jsp?chcode="+chcode);

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

