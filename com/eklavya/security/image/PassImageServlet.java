package com.eklavya.security.image;

import java.awt.image.BufferedImage;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.eklavya.security.Base64Coder;
import com.eklavya.security.Config;
import com.eklavya.security.Encrypter;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * <b>Servlet which generates a JPG image and sends it back as content type:
 * image/jpeg</b>
 */
public class PassImageServlet extends HttpServlet
{

	private static Encrypter _stringEncrypter = new Encrypter();

	private static final String SKEW_PROCESSOR_CLASS = Config.getProperty(Config.SKEW_PROCESSOR_CLASS);

	/**
	 * Calls the ISkewImage class to process and returns the image into response
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException
	{
		try
		{
			String passedKeyStr = request.getPathInfo();
			if (passedKeyStr == null)
			{
				ServletException se = new ServletException("passedKeyStr is invalid");
				throw se;
			}
			if (passedKeyStr.length() < Config.getPropertyInt(Config.MAX_NUMBER))
			{
				ServletException se = new ServletException("passedKeyStr is invalid");
				throw se;
			}
			passedKeyStr = passedKeyStr.substring(1, passedKeyStr.length());
			String passstring = Base64Coder.decode(passedKeyStr);

			passedKeyStr = _stringEncrypter.decrypt(passstring);
			response.setContentType("image/jpeg");
			ClassLoader cl = Thread.currentThread().getContextClassLoader();
			String[] sprocessorClasses = SKEW_PROCESSOR_CLASS.split(":");
			ISkewImage skewImage = (ISkewImage) cl.loadClass(
				sprocessorClasses[(int) (Math.random() * sprocessorClasses.length)]).newInstance();
			BufferedImage bufferedImage = skewImage.skewImage(passedKeyStr.substring(0, passedKeyStr.indexOf(".")));
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(response.getOutputStream());
			encoder.encode(bufferedImage);
		}
		catch (ClassNotFoundException cnf)
		{
			cnf.printStackTrace();
			try
			{
				response.sendError(HttpServletResponse.SC_FORBIDDEN);
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		catch (Exception ex)
		{
			try
			{
				response.sendError(HttpServletResponse.SC_FORBIDDEN);
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
	}

	/**
	 * Redirects the request and response to doGet
	 * 
	 * @param request
	 * @param response
	 * @throws ServletException
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException
	{
		doGet(request, response);
	}
}
