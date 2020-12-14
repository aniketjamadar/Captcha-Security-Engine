package com.eklavya.security.image;

import java.awt.image.BufferedImage;

/**
 * <b>Interface class for skewing security string</b>
 */
public interface ISkewImage
{

	/**
	 * The implementation method should draw the securityChars on the image and
	 * skew it for security purpose. The return value is the finished image
	 * object
	 * 
	 * @param securityChars
	 * @return - BufferedImage finished skewed image
	 */
	public BufferedImage skewImage(String securityChars);
}
