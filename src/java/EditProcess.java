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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
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
@WebServlet(urlPatterns = {"/EditProcess"})
@MultipartConfig
public class EditProcess extends HttpServlet {

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

        Cookie c[] = request.getCookies();

        String email = null;
        for (Cookie c1 : c) {
            if (c1.getName().equals("login")) {
                email = c1.getValue();
            }
        }

        if (email == null) {
            response.sendRedirect("login.jsp");
        } else {
            try {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                Part part = request.getPart("image");
                String vcode = request.getParameter("vcode");
                String chCode = request.getParameter("chcode");

                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
                Statement st = cn.createStatement();
                
                 PreparedStatement ps = cn.prepareStatement("update uploaded_videos set title=?, description=? where vcode='"+vcode+"'");
                 
                ps.setString(1,title);
                ps.setString(2,description);
                ps.executeUpdate();
                ps.close();
                
                if(part != null){
                    InputStream isImage =part.getInputStream();
                     byte []dataImage = new byte[isImage.available()];
                     isImage.read(dataImage);
                     
                     String saveImage = vcode+".jpg";
                     String imagePath = request.getRealPath("/");
                     out.print(imagePath);
                     FileOutputStream fileImage = new FileOutputStream(imagePath+"thumbnail"+File.separator+saveImage);
                     fileImage.write(dataImage);
                     fileImage.close();
                }
                cn.close();
                
                response.sendRedirect("profile.jsp?chcode="+chCode);

            } catch (ClassNotFoundException ex) {
                Logger.getLogger(EditProcess.class.getName()).log(Level.SEVERE, null, ex);
            } catch (SQLException ex) {
                Logger.getLogger(EditProcess.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }
}



