package com.eklavya.security;

import java.io.InputStream;
import java.util.Properties;

/**
 * <b>Configuration file, reads the /security/skewpassimage.properties for
 * configuration values</b>
 */
public class Config
{

	static public final String MAX_NUMBER = "skewpassimage.passimage.max_number";
	static public final String LTR_WIDTH = "skewpassimage.passimage.letter_width";
	static public final String IMAGE_HEIGHT = "skewpassimage.passimage.height";
	static public final String PASS_CODE = "skewpassimage.encoding.passcode";
	static public final String ALGORITHM = "skewpassimage.encoding.algorithm";
	static public final String SKEW = "skewpassimage.passimage.skew";
	static public final String DRAW_LINES = "skewpassimage.passimage.draw_lines";
	static public final String DRAW_BOXES = "skewpassimage.passimage.draw_boxes";
	static public final String SKEW_PROCESSOR_CLASS = "skewpassimage.passimage.processor_class";

	static public final String CONFIG_FILE_CLASSPATH = "/com/eklavya/security/skewpassimage.properties";

	static Properties _properties = null;
	static boolean isDebugOn = true;

	private static Properties getProperties()
	{
		if (_properties == null)
		{
			try
			{
				_properties = new Properties();
				InputStream stream = Config.class.getClassLoader().getResourceAsStream(CONFIG_FILE_CLASSPATH);
				_properties.load(stream);
				if (stream == null)
					System.err.println(CONFIG_FILE_CLASSPATH + " not loaded");
				if (isDebugOn)
				{
					//
				}
			}
			catch (Exception ex)
			{
				System.err.println(ex);
			}
		}
		return _properties;
	}

	public static String getProperty(String propName)
	{
		return getProperties().getProperty(propName);
	}

	public static boolean getPropertyBoolean(String propName)
	{
		return new Boolean(getProperties().getProperty(propName)).booleanValue();
	}

	public static double getPropertyDouble(String propName)
	{
		return new Double(getProperties().getProperty(propName)).doubleValue();
	}

	public static int getPropertyInt(String propName)
	{
		return new Long(getProperties().getProperty(propName)).intValue();
	}

	public static long getPropertyLong(String propName)
	{
		return new Long(getProperties().getProperty(propName)).longValue();
	}
}
