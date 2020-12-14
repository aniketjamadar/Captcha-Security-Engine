<%@page import="java.sql.*"%>
<%@ page import="com.eklavya.security.Base64Coder"%>
<%@ page import="com.eklavya.security.Encrypter"%>
<%@ page import="com.eklavya.security.Config"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="true"%>
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
	<%!
	String passlineEncoded;
	String errorMsg;
	Encrypter stringEncrypter;
	boolean securityLettersPass;
	%>
	<%
	passlineEncoded = request.getParameter("passline_enc");
	errorMsg = request.getParameter("error");
	stringEncrypter = new Encrypter();
	securityLettersPass = true;
	 %>


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
            <h1>COMPOSE page</h1>
             
              
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
			  <form action="UserCompose.jsp" method="post">
                <p><strong> 
				<table>
 <tr><td>To:</td><td><input type="text" name="to"></td></tr>
<tr><td>Subject:</td><td><input type="text"  name="subject"><br></td></tr>
<tr><td>Message:</td><td><textarea rows=10 cols=20 name="message">
</textarea><br></td></tr>
<tr><td>&nbsp;</td><td colspan="2" align="center">
										<img src="PassImageServlet/<%=passlineValueEncoded%>"
											border="0">
									</td></tr>
<tr><td>Enter captcha code</td><td><input type="text" name="capcode"></td></tr>
<tr><td><input type="submit" name="COMPOSE" value="COMPOSE"></td>
<input type="hidden" name="passline_enc"
								value="<%=passlineValueEncoded%>">
</tr>
</table>

<%

	//String passline = request.getParameter("passline");
	String capcode=request.getParameter("capcode");
	 passlineEncoded = request.getParameter("passline_enc");
	errorMsg = request.getParameter("error");
	stringEncrypter = new Encrypter();
	securityLettersPass = true;
	boolean regcontinue=true;

	if ((capcode != null) || (passlineEncoded != null)) {

		String passlineDecoded = Base64Coder.decode(passlineEncoded);
		String passlineCheck = stringEncrypter.decrypt(passlineDecoded);
		String passlineString = passlineCheck;

		passlineCheck = passlineCheck.substring(0, Config
				.getPropertyInt(Config.MAX_NUMBER));

		String sessionId = passlineString.substring(passlineString
				.indexOf(".") + 1, passlineString.length());

		if (!sessionId.equals(request.getSession().getId())) {
			securityLettersPass = false;
			errorMsg = "Encripted session is incorrect";
		}
		if (!capcode.toUpperCase().equals(passlineCheck.toUpperCase())) {
			securityLettersPass = false;
			errorMsg = "Security code is incorrect";
			System.out.println("security code is incorrect" +capcode);
			regcontinue=false;
		}
		else 
		{
		securityLettersPass=true;
		errorMsg="Security code is correct";
		out.println("security code is correct" );
		response.sendRedirect("MailPage.jsp");
		regcontinue=true;
		}
		}
		else
		{
		System.out.println("security code is nstalled");
		}%>

<%! Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;
%>
<%
java.sql.Date date=new java.sql.Date(new java.util.Date().getTime());
String to=request.getParameter("to");
String sub=request.getParameter("subject");
String msg=request.getParameter("message");
try{
	Class.forName("oracle.jdbc.driver.OracleDriver");
     con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","captcha","captcha");
	ps=con.prepareStatement("insert into usercomposebox values(?,?,?,?,?,?)");
	ps.setString(1,usernamesession);
	ps.setString(2,to);
	ps.setString(3,sub);
	ps.setString(4,msg);
	ps.setDate(5,date);
	ps.setString(6,capcode);
	if(regcontinue)
	{
	int n=ps.executeUpdate();
	if(n>0)
	{
		System.out.println("Mail has been sent successfully");
		
	}
	else
	{
	out.println("something went wrong....check for the errors");
	
	}
	}
	else
	{
System.out.println("incorrect thing happening");
response.sendRedirect("Failure.jsp");
	}
	%>
<a href="MailPage.jsp"> Go to Main page</a>
<%}
catch(Exception e)
{
e.printStackTrace();
}

%>
			



			</form>
			
			<br><br><br><br><br><br>

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
    <div id="left_footer">&copy;CopyRights Reserved, MYGO INFORMATICS </div>
    
    </div>
    <!-- end footer -->


</body>
</html>
