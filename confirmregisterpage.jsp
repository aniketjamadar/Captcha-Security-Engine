<%@ page import="com.eklavya.security.Base64Coder"%>
<%@ page import="com.eklavya.security.Encrypter"%>
<%@ page import="com.eklavya.security.Config"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page session="true"%>

<%@page import="java.sql.*" %>
<%!Connection con=null;
Statement st=null;
%>

<%

	//String passline = request.getParameter("passline");
	String capcode=request.getParameter("register_capcode");
	String passlineEncoded = request.getParameter("passline_enc");
	String errorMsg = request.getParameter("error");
	Encrypter stringEncrypter = new Encrypter();
	boolean securityLettersPass = true;
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
			out.println("security code is incorrect" +capcode);
			response.sendRedirect("Register.jsp?error=Incorrect code entered, RETYPE");
			regcontinue=false;
		}
		else 
		{
		securityLettersPass=true;
		errorMsg="Security code is correct";
		out.println("security code is correct" );
		response.sendRedirect("Login.jsp");
		regcontinue=true;
		}
		}
		else
		{
		System.out.println("security code is nstalled");
		}

String user=request.getParameter("register_Uname");
String pwd=request.getParameter("register_pwd");
String age=request.getParameter("register_age");
int a=Integer.parseInt(age);
String sex=request.getParameter("register_sex");
String city=request.getParameter("register_city");
String state=request.getParameter("register_state");
String pin=request.getParameter("register_pin");
String country=request.getParameter("register_country");


Class.forName("oracle.jdbc.driver.OracleDriver");
con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","captcha","captcha");
st=con.createStatement();
if(regcontinue)
{
int n=st.executeUpdate("insert into signupdetails values('"+user+"','"+pwd+"',"+age+",'"+sex+"','"+city+"','"+state+"','"+pin+"','"+country+"','"+capcode+"')");
if(n>0)
{
out.println("inserted into the table");
}
else
out.println("not successful");

}
else
out.println("incorrect captcha code");


st.close();
con.close();

%>