/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.LinkedList;
import java.util.Collections;
import java.sql.*;
import java.io.*;
import java.text.SimpleDateFormat;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import java.util.Date;
import javax.servlet.http.Part;


/**
 *
 * @author MARCOS
 */
@WebServlet(urlPatterns = {"/upload_process"})
@MultipartConfig 
public class upload_process extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        String vcode="";
        int sn=1;
        
         LinkedList l = new LinkedList();
          for(char ch='A';ch<='Z';ch++){
              l.add(ch+"");
          }
          for(char ch='a';ch<='z';ch++){
              l.add(ch+"");
          }
          for(int i=1;i<=9;i++){
              l.add(new Integer(i));
          }
          Collections.shuffle(l);
          for(int i=0;i<=6;i++){
              vcode=vcode+l.get(i);
          }
          vcode=vcode+"_"+sn;

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
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                String category = request.getParameter("category");
                Date uploadDate = new Date();
                SimpleDateFormat ft = new SimpleDateFormat("dd-MM-yyyy");
                String fDate = ft.format(uploadDate);
                Part part= request.getPart("image");
                Part part1 = request.getPart("uploadVideo");
                
                String chcode="";
                String usercode="";
                String saveImage= vcode+".jpg";
                String saveVideo= vcode+".mp4";
                int videoCount = 0;
                
                out.println(saveImage);
                out.println(saveVideo);
                
                
                // Database Connection
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
                ResultSet chCode = st.executeQuery("select * from channel where usercode='"+usercode+"'");
                if(chCode.next()){
                    chcode= chCode.getString("chcode");
                    videoCount = Integer.parseInt(chCode.getString("videoCount"));
                }
                
                PreparedStatement ps = cn.prepareStatement("insert into uploaded_videos values (?,?,?,?,?,?,?,?,?,?,?)");
                ps.setInt(1,sn);
                ps.setString(2,vcode);
                ps.setString(3,chcode);
                ps.setString(4,usercode);
                ps.setString(5,title);
                ps.setString(6,description);
                ps.setString(7,category);
                ps.setString(8,fDate);
                ps.setInt(9,0);
                ps.setInt(10,0);
                ps.setInt(11,0);
                ps.executeUpdate();
                ps.close();
                
                videoCount++;
                PreparedStatement updateChannel = cn.prepareStatement("update channel set videoCount=? where chcode='"+chcode+"'");
                updateChannel.setInt(1, videoCount);
                updateChannel.executeUpdate();
                updateChannel.close();
                
                
                InputStream isImage =part.getInputStream();
                     byte []dataImage = new byte[isImage.available()];
                     isImage.read(dataImage);
                     
                     
                     
                     String imagePath = request.getRealPath("/");
                     out.print(imagePath);
                     FileOutputStream fileImage = new FileOutputStream(imagePath+"thumbnail"+File.separator+saveImage);
                     fileImage.write(dataImage);
                     
                     out.print(imagePath+"thumbnail"+File.separator+saveImage);
                     
                     
                     InputStream isVideo =part1.getInputStream();                     
                     byte []dataVideo = new byte[isVideo.available()];
                     isVideo.read(dataVideo);
                     
                     String videoPath = request.getRealPath("/");
                     out.println(videoPath);
                     FileOutputStream fileVideo = new FileOutputStream(videoPath+"uploadVideo"+File.separator+saveVideo);
                     fileVideo.write(dataVideo);
                     
                     
                     fileImage.close();
                     fileVideo.close();
                     out.println("done");
                     cn.close();
                     response.sendRedirect("profile.jsp?chcode="+chcode);
                     

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

      
        
    

   