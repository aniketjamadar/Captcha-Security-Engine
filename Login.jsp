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
            <h1>WELCOME TO LOGIN PAGE</h1>
              <ul>
                <li><a href="Login.jsp">LOGIN</a> </li>
                <li><a href="Register.jsp">REGISTER</a> </li>
              </ul>
              
              </div>
                <div id="sidebar_bottom"></div>
          </div>
            <div id="text">
            <div id="text_top">
            	<div id="text_top_left"></div>
                <div id="text_top_right"></div>
            </div>
            <div id="text_body">
              <h1><span>PROVIDE UR LOGIN CREDENTIALS</span></h1>
                <p><strong>
				<%@ page import="com.eklavya.security.Base64Coder"%>
<%@ page import="com.eklavya.security.Encrypter"%>
<%@ page import="com.eklavya.security.Config"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="true"%>


	<%
	String passline = request.getParameter("passline");
	String passlineEncoded = request.getParameter("passline_enc");
	String errorMsg = request.getParameter("error");
	Encrypter stringEncrypter = new Encrypter();
	boolean securityLettersPass = true;
	
	 %>
		<div align="center">
			
			

			<br>
		</div>
		&nbsp;
		<br>
		<div align="center">
			<form action="LoginCheck.jsp" method="post" name="auth_form">
				<table width="450" border="0" cellpadding="5" cellspacing="0">
					<tr>
						<td align="center">

							<%
								String randomLetters = new String("");
								for (int i = 0; i < Config.getPropertyInt(Config.MAX_NUMBER); i++) {
									randomLetters += (char) (65 + (Math.random() * 24));

								}
								randomLetters = randomLetters.replaceAll("I", "X");
								randomLetters = randomLetters.replaceAll("Q", "Z");

								String passlineNormal = randomLetters + "."
										+ request.getSession().getId();
								String passlineValueEncoded = stringEncrypter
										.encrypt(passlineNormal);
								passlineValueEncoded = Base64Coder.encode(passlineValueEncoded);
							%>
							<table
								style="font-family: verdana; font-size: 11px; color: white;">
								
								<tr>
								<td>Enter UNAME</td>
								<td><input type="text" name="username"/></td>
								</tr>
								<tr>
								<td>Enter PASSWORD</td>
								<td><input type="password" name="password"/></td>
								</tr>
								<tr>
								<td>Enter the CAPTCHA code</td>
								<td><input type="text" name="capcode"/></td>
								</tr>
								
								
								
								<tr>
									<td colspan="2" align="center">
										<input type="submit" name="LOGIN" value="LOGIN">
									</td>
								</tr>
								<%
									if (errorMsg != null) {
								%>
								<tr>
									<td colspan="2" align="center"
										style="color: yellow; font-size: 14px;" bgcolor="red">
										<b><%=errorMsg%> </b>
									</td>
								</tr>
								<%
									}
								%>
							</table>
							
							<input type="hidden" name="passline_enc"
								value="<%=passlineValueEncoded%>">
						</td>
					</tr>
				</table>
			</form>
		</div>
	

				
				
				 

				</strong>                            










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
    <div id="left_footer">&copy;CopyRights Reserved, Hucon Solutions(I)Pvt Ltd </div>
    
    </div>
    <!-- end footer -->


</body>
</html>
