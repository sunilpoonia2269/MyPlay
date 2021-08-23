<%-- 
    Document   : upload_thumbnil
    Created on : 30-Jun-2021, 4:59:39 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.* , java.sql.*"%>
<%
  
    
    
String contentType = request.getContentType();

String imageSave=null;
byte dataBytes[]=null;
String saveFile=null;
if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0))
{
DataInputStream in = new DataInputStream(request.getInputStream());
int formDataLength = request.getContentLength();
dataBytes = new byte[formDataLength];
int byteRead = 0;
int totalBytesRead = 0;
while (totalBytesRead < formDataLength)
{
byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
totalBytesRead += byteRead;
}
String vcode=request.getParameter("vcode");
int sn=1;



   Cookie c[] = request.getCookies();
        
        String email = null;
        for(int i=0; i<c.length; i++){
            if(c[i].getName().equals("login")){
                email = c[i].getValue();
            }
        }
        
        if(email == null){
            response.sendRedirect("login.jsp");
        }
        
        else{
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/youtube_clone","root","");
    Statement st = cn.createStatement();
    ResultSet rs=st.executeQuery("select Max(sn) as sn from uploaded_videos");
        if(rs.next()){
            sn=rs.getInt("sn");
            sn++;
            }

     } 
    catch(Exception er){
        out.println(er.getMessage());
    
    }

      

String file = new String(dataBytes);
/*saveFile = file.substring(file.indexOf("filename=\"") + 10);
saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));*/
 saveFile = vcode+".jpg";
// out.print(dataBytes);
int lastIndex = contentType.lastIndexOf("=");
String boundary = contentType.substring(lastIndex + 1, contentType.length());
// out.println(boundary);
int pos;
pos = file.indexOf("filename=\"");
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
int boundaryLocation = file.indexOf(boundary, pos) - 4;
int startPos = ((file.substring(0, pos)).getBytes()).length;
int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
try
{
FileOutputStream fileOut = new FileOutputStream("C:/swing_java/youtube_clone/web/thumbnail/"+saveFile);

// fileOut.write(dataBytes);
fileOut.write(dataBytes, startPos, (endPos - startPos));
fileOut.flush();
fileOut.close();
imageSave="Success";
response.sendRedirect("profile.jsp");
}catch (Exception e)
{

imageSave="Failure";
}
}
}
%>
