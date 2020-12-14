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
<%
	String usernamesession=(String)session.getAttribute("usernamesession");
	%>
	<!-- header -->
    <div id="logo"><a href="#"><h3>CAPTCHA</h3> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;COMPLETELY AUTOMATED PUBLIC TURING TEST TO TELL COMPUTERS AND HUMANS APART</a></div>
    <div id="header">
    	<div id="left_header"></div>
        <div id="right_header"></div>
  </div> 
  <div id="menu">
        	<ul>
              <li><a href="index.html">Home</a></li>
              <li><a href="Contacts.html">Contacts</a></li>
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
            <h1>UPDATE UR PROFILE</h1>
              
              </div>
                <div id="sidebar_bottom"></div>
          </div>
            <div id="text">
            <div id="text_top">
            	<div id="text_top_left"></div>
                <div id="text_top_right"></div>
            </div>
            <div id="text_body">
              <h1><span>Enter Into The World Of CAPTCHA</span></h1>
			
	Welcome <%=usernamesession%> 
<form action="UserUpdateProfileConfirm.jsp" method="post">
	<%! Connection con=null;
Statement st=null;
ResultSet rs;
%>

<%
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
     con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","captcha","captcha");
	st=con.createStatement();
	rs=st.executeQuery("select * from signupdetails where uname='"+usernamesession+"' ");
	while(rs.next())
	{
		System.out.println("in the sent itms box");
		String captcode=rs.getString(9);
		System.out.println("captchacode is "+ captcode);
		session.setAttribute("captchacode",captcode);

	%>
			
			<table border="2">
			<tr>
			<th>UserName</th>
			<td><input type="text" name="u" value="<%=rs.getString(1)%>" disabled></td>
			</tr>
			<tr>
			<th>Password</th>
			<td><input type="text" name="p" value="<%=rs.getString(2)%>"></td>
			</tr>
			<tr>
			<th>Age</th>
			<td><input type="text" name="a" value="<%=rs.getString(3)%>"></td>
			</tr>
			<tr>
			<th>Sex</th>
			<td><input type="text" name="s" value="<%=rs.getString(4)%>"></td>
			</tr>
			<tr>
			<th>City</th>
			<td><input type="text" name="c" value="<%=rs.getString(5)%>"></td>
			</tr>
			<tr>
			<th>State</th>
			<td><input type="text" name="st" value="<%=rs.getString(6)%>"></td>
			</tr>
			<tr>
			<th>Pin</th>
			<td><input type="text" name="p" value="<%=rs.getString(7)%>"></td>
			</tr>
			<tr>
			<th>Country</th>
			<td><input type="text" name="cou" value="<%=rs.getString(8)%>"></td>
			</tr>
			<tr>
			<th>CaptchaCode</th>
			<td><input type="text" name="cc" value="<%=captcode%>" disabled></td>
			</tr>



			</table>
			<input type="submit" value="update" name="update">
			<%
	}
}
catch(Exception e)
{
e.printStackTrace();
}



%>

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
    <div id="left_footer">&copy;CopyRights Reserved,  </div>
    
    </div>
    <!-- end footer -->


</body>
</html>
