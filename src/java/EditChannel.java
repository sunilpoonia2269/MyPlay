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
@WebServlet(urlPatterns = {"/EditChannel"})
@MultipartConfig
public class EditChannel extends HttpServlet {

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
        } else {

            String status = request.getParameter("status");
            String chCode = request.getParameter("chcode");
            String newName = request.getParameter("chname");
            
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
                Statement st = cn.createStatement();

                if (status.equals("getData")) {
                    ResultSet rs = st.executeQuery("select name from channel where chcode='" + chCode + "'");
                    if (rs.next()) {
                        out.print(rs.getString(1));

                    }
                }
                if(status.equals("updateChannel")){
                
                    
                    
                    Part part = request.getPart("template");

                    PreparedStatement ps = cn.prepareStatement("update channel set name=? where chcode='" + chCode +"'");

                    ps.setString(1, newName);
                    ps.executeUpdate();
                    ps.close();

                    if (part != null) {
                        InputStream isImage = part.getInputStream();
                        byte[] dataImage = new byte[isImage.available()];
                        isImage.read(dataImage);

                        String saveImage = chCode + ".jpg";
                        String imagePath = request.getRealPath("/");
                        out.print(imagePath);
                        FileOutputStream fileImage = new FileOutputStream(imagePath + "channelTemplate" + File.separator + saveImage);
                        fileImage.write(dataImage);
                        fileImage.close();
                    }
                                    response.sendRedirect("profile.jsp?chcode="+chCode);

                }
                cn.close();


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
