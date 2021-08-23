<%-- 
    Document   : image_upload
    Created on : 26-May-2021, 7:21:36 PM
    Author     : MARCOS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Choose Profile Pic | YouTube</title>
    </head>
    <body>
        <form method="post" ACTION="ProfileImageUpload" name="uploadForm" ENCTYPE='multipart/form-data'>
<table align="center" width="50%" height="25%">
<tbody>
<tr>
<th>File Upload:</th>
<td><input type="file" name="image" size="40" style="border:1px solid black;"></td>
</tr>
<tr align="center">
<td colspan="2">
<input type="submit" name="Submit" style="border:1px solid black;" value="Submit">
          
<input type="reset" name="Reset" style="border:1px solid black;" value="Reset">
</td>
</tr>
</tbody>
</table>
</form> 
    </body>
</html>
