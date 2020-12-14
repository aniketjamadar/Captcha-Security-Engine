<%@page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
Author: Java Team
Website: http://www.realitysoftware.ca
Note: This is a free template released under the Creative Commons Attribution 3.0 license, 
which means you can use it in any way you want provided you keep the link to the author intact.
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="style.css" rel="stylesheet" type="text/css" /></head>
<body>
	<!-- header -->
    <div id="logo"><a href="#"><h3>CAPTCHA</h3> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPLETELY AUTOMATED PUBLIC TURING TEST TO TELL COMPUTERS AND HUMANS APART</a></div>
    <div id="header">
    	<div id="left_header"></div>
        <div id="right_header"></div>
  </div> 
  <div id="menu">
        	<ul>
              <li><a href="index.html">Home</a></li>
              <li><a href="">Contacts</a></li>
  			  <li><a href="Logout.jsp">Logout</a></li>

          </ul>
      </div>
    <!--end header -->
    <!-- main -->
    <div id="content">
    	<div id="content_top">
        	<div id="content_top_left"></div>
            <div id="content_top_right"></div>
        </div>
      <div id="content_body">
       	  <div id="sidebar">
            <div id="sidebar_top"></div>
            <div id="sidebar_body">
            <h1>UPDATE PROFILE PAGE</h1>
              
              </div>
                <div id="sidebar_bottom"></div>
          </div>
            <div id="text">
            <div id="text_top">
            	<div id="text_top_left"></div>
                <div id="text_top_right"></div>
            </div>
            <div id="text_body">
              <h1><span>Enter Into The World Of CAPTCHA</span></h1><br>
			   <%
			  String usernamesession=(String)session.getAttribute("usernamesession");
			  String captchacode=(String)session.getAttribute("captchacode");
			  %>
                Welcome <%=usernamesession%>
				<%! Connection con=null;
Statement stmt=null;
ResultSet rsupdate;
%>

<%
String p=request.getParameter("p");
String a=request.getParameter("a");
int ag=Integer.parseInt(a);
String s=request.getParameter("s");
String c=request.getParameter("c");
String st=request.getParameter("st");
String pin=request.getParameter("p");
String cou=request.getParameter("cou");
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
     con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","captcha","captcha");
	stmt=con.createStatement();
int n=stmt.executeUpdate("Update signupdetails set uname='"+usernamesession+"',passwd='"+p+"',age="+ag+",sex='"+s+"',city='"+c+"',state='"+st+"',pin='"+pin+"',country='"+cou+"',captchacode='"+captchacode+"' where uname='"+usernamesession+"'");
if(n>0)
{
System.out.println("ur values are updated...thnku");
}
else
System.out.println("sorry could perform update operation");
}
catch(Exception e)
{
e.printStackTrace();
}
%>
<a href="MailPage.jsp">Go to mail page</a>
</form>








            </div>
                <div id="text_bottom">
                	<div id="text_bottom_left"></div>
                    <div id="text_bottom_right"></div>
                </div>
          </div>
      </div>
        <div id="content_bottom">
        	<div id="content_bottom_left"></div>
            <div id="content_bottom_right"></div>
        </div>
    </div>
    <!-- end main -->
    <!-- footer -->
    <div id="footer">
    <div id="left_footer">&copy;CopyRights Reserved, MYGO INFORMATICS </div>
    
    </div>
    <!-- end footer -->


</body>
</html>
