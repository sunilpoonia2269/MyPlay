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
@WebServlet(urlPatterns = {"/EditUser"})
@MultipartConfig 
public class EditUser extends HttpServlet {

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
        
        if(email == null){
            response.sendRedirect("login.jsp");
        }else{
            try{
                String name = request.getParameter("name");
                String gender = request.getParameter("gender");
                Part part= request.getPart("image");
                String usercode = "";
                
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone", "root", "");
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery("select usercode from user_login where email='" + email + "'");
                    if (rs.next()) {
                        out.print(rs.getString(1));

                    }
                
                PreparedStatement ps = cn.prepareStatement("update user_login set name=?, gender=? where email='" + email +"'");

                    ps.setString(1, name);
                    ps.setString(2, gender);
                    ps.executeUpdate();
                    ps.close();
                    
                    if (part != null) {
                        InputStream isImage = part.getInputStream();
                        byte[] dataImage = new byte[isImage.available()];
                        isImage.read(dataImage);

                        String saveImage = usercode+ ".jpg";
                        String imagePath = request.getRealPath("/");
                        out.print(imagePath);
                        FileOutputStream fileImage = new FileOutputStream(imagePath + "upload" + File.separator + saveImage);
                        fileImage.write(dataImage);
                        fileImage.close();
                    }
                    
                    cn.close();
                    response.sendRedirect("user_profile.jsp");
                
            }catch(IOException e){
                out.println(e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println(e.getMessage());
            } catch (SQLException e) {
                out.println(e.getMessage());
            } catch (ServletException e) {
                out.println(e.getMessage());
            }

        }
        
    }

   
}
