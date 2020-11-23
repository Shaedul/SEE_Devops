<%--
    Document   : index
    Created on : Sep 16, 2017, 9:19:42 PM //last updated Feb 22, 2018, 23:07:00 PM
    Author     : Dharmesh
--%>

<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert</title>
    </head>
    <body>
    
        <form action="uploadServlet" method="post" enctype="multipart/form-data">
            <table width="400px" align="center" border=2>
            
            
 <!--              <tr>
                    <td align="center" colspan="2">Form Details</td>
                </tr>
                <tr>
                    <td>Id </td>
                    <td><input type="number" name="id" /></td>
                </tr>
                <tr>
                    <td>First Name </td>
                    <td>
                        <input type="text" name="firstname">
                    </td>
                </tr>
                <tr>
                    <td>Last Name </td>
                    <td>
                        <input type="text" name="lastname">
                    </td>
                </tr>
                <tr>
                    <td>Image Link: </td>
                    <td>
                        <input type="file" name="file">
                    </td>
                </tr> -->
            
            
            
            
            
            
            
            
                <tr>
                    <td align="center" colspan="2">Image Details</td>
                </tr>
      
                <tr>
                    <td>Image title</td>
                    <td>
                        <input type="text" name="title">
                    </td>
                </tr>
                <tr>
                    <td>Details </td>
                    <td>
                        <input type="text" name="details">
                    </td>
                </tr>
                <tr>
                    <td>Image : </td>
                    <td>
                        <input type="file" name="image">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="Submit"></td>
                </tr>
            </table>

        </form><br>
    <center><a href="viewAll.jsp">View All </a></center>
</body>
</html>