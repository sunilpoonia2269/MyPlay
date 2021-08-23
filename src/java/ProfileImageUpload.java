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
import java.text.SimpleDateFormat;
import java.util.Date;
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
@WebServlet(urlPatterns = {"/ProfileImageUpload"})
@MultipartConfig
public class ProfileImageUpload extends HttpServlet {

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
        }
        
        else{
            try{
                
                Part part= request.getPart("image");
               
                
                String usercode="";
                
               
                
              
                
                
                // Database Connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone","root","");
                Statement st = cn.createStatement();
                
                ResultSet userCode = st.executeQuery("select usercode from user_login where email='"+email+"'");
                if(userCode.next()){
                    usercode= userCode.getString("usercode");
                }
                               
                
                
                
                String saveImage= usercode+".jpg";
                InputStream isImage =part.getInputStream();
                byte []dataImage = new byte[isImage.available()];
                isImage.read(dataImage);



                String imagePath = request.getRealPath("/");
                out.print(imagePath);
                FileOutputStream fileImage = new FileOutputStream(imagePath+"upload"+File.separator+saveImage);
                fileImage.write(dataImage);
                     
                     
                     
                     
                     
                     
                     
                     fileImage.close();
                     
                     out.println("done");
                     cn.close();
                     response.sendRedirect("profile.jsp?sucess=1");
                     

             } 
            catch(IOException er){
                out.println(er.getMessage());

            } catch (ClassNotFoundException er) {
                out.println(er.getMessage());
            } catch (SQLException er) {
                out.println(er.getMessage());
            } catch (ServletException er) {
                out.println(er.getMessage());
            }
                }
            }
        }

      
        
    
       
        

   
