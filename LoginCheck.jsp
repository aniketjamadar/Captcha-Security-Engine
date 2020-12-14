<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<html>
<head>
<title>
Login check on the credentials
</title>
</head>
<body>
<%!Connection con=null;
Statement st=null;
ResultSet rs=null;
%>
<%
String username=request.getParameter("username");
session.setAttribute("usernamesession",username);
String pwd=request.getParameter("password");
String capcode=request.getParameter("capcode");
Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","captcha","captcha");
st=con.createStatement();
rs=st.executeQuery("select * from signupdetails where uname='"+username+"' and passwd='"+pwd+"'");
while(rs.next())
{
	String captcha=rs.getString(9);
	if(capcode.equalsIgnoreCase(captcha))
	{
		response.sendRedirect("MailPage.jsp");
	}
	else
	{
		out.println("incorrect captcha code");
		response.sendRedirect("Login.jsp");
	}	

}
rs.close();
st.close();
con.close();




%>



</body>






</html>