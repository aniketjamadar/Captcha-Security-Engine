package com.eklavya.security.image;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;

import com.eklavya.security.Config;

/**
 * This is a sample implementation of the <b>ISkewImage</b> class in order to
 * skew the secured chars passed encoded as a parameter
 */
public class SkewImageProba implements ISkewImage
{
	private static final int MAX_LETTER_COUNT = Config.getPropertyInt(Config.MAX_NUMBER);
	private static final int LETTER_WIDTH = Config.getPropertyInt(Config.LTR_WIDTH);
	private static final int IMAGE_HEIGHT = Config.getPropertyInt(Config.IMAGE_HEIGHT);
	private static final double SKEW = Config.getPropertyDouble(Config.SKEW);
	private static final int DRAW_LINES = Config.getPropertyInt(Config.DRAW_LINES);
	private static final int DRAW_BOXES = Config.getPropertyInt(Config.DRAW_BOXES);
	private static final int MAX_X = LETTER_WIDTH * MAX_LETTER_COUNT;
	private static final int MAX_Y = IMAGE_HEIGHT;

	private static final Color[] RANDOM_BG_COLORS = { Color.RED, Color.CYAN, Color.GREEN, Color.MAGENTA, Color.ORANGE,
			Color.PINK, Color.YELLOW };

	private static final Color[] RANDOM_FG_COLORS = { Color.BLACK, Color.BLUE, Color.DARK_GRAY };

	private int getRandomX()
	{
		return (int) (Math.random() * MAX_X);
	}

	private int getRandomY()
	{
		return (int) (Math.random() * MAX_Y);
	}

	private void paindBoxes(Graphics2D g2d)
	{
		int colorId = (int) (Math.random() * RANDOM_BG_COLORS.length);
		g2d.setColor(RANDOM_BG_COLORS[colorId]);
		g2d.fillRect(getRandomX(), getRandomY(), getRandomX(), getRandomY());
	}

	private void setRandomBGColor(Graphics2D g2d)
	{
		int colorId = (int) (Math.random() * RANDOM_BG_COLORS.length);
		g2d.setColor(RANDOM_BG_COLORS[colorId]);
	}

	private void setRandomFGColor(Graphics2D g2d)
	{
		int colorId = (int) (Math.random() * RANDOM_FG_COLORS.length);
		g2d.setColor(RANDOM_FG_COLORS[colorId]);
	}

	private void setRandomFont(Graphics2D g2d)
	{
		Font font = new Font("dialog", 1, 33);
		g2d.setFont(font);
	}

	public BufferedImage skewImage(String securityChars)
	{
		BufferedImage outImage = new BufferedImage(MAX_X, MAX_Y, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2d = outImage.createGraphics();
		g2d.setColor(java.awt.Color.WHITE);
		g2d.fillRect(0, 0, MAX_X, MAX_Y);
		for (int i = 0; i < DRAW_BOXES; i++)
		{
			paindBoxes(g2d);
		}

		Font font = new Font("dialog", 1, 33);
		g2d.setFont(font);

		g2d.setColor(Color.BLACK);
		g2d.drawRect(0, 0, (MAX_X) - 1, MAX_Y - 1);

		AffineTransform affineTransform = new AffineTransform();
		for (int i = 0; i < MAX_LETTER_COUNT; i++)
		{
			double angle = 0;
			if (Math.random() * 2 > 1)
			{
				angle = Math.random() * SKEW;
			}
			else
			{
				angle = Math.random() * -SKEW;
			}
			affineTransform.rotate(angle, (LETTER_WIDTH * i) + (LETTER_WIDTH / 2), MAX_Y / 2);
			// g2d.setTransform(affineTransform);
			// setRandomFont(g2d);
			// setRandomFGColor(g2d);
			g2d.drawString(securityChars.substring(i, i + 1), (i * LETTER_WIDTH) + 3, 28 + (int) (Math.random() * 6));

			affineTransform.rotate(-angle, (LETTER_WIDTH * i) + (LETTER_WIDTH / 2), MAX_Y / 2);
		}

		/*
		 * g2d.setXORMode(Color.RED); g2d.setStroke(new BasicStroke(10));
		 * g2d.drawLine(0,0,MAX_X, MAX_Y); g2d.setXORMode(Color.YELLOW);
		 * g2d.drawLine(0,MAX_Y,MAX_X, 0);
		 */

		g2d.setXORMode(RANDOM_BG_COLORS[(int) (Math.random() * RANDOM_BG_COLORS.length)]);
		g2d.setStroke(new BasicStroke(10));
		g2d.drawLine(0, MAX_Y / 2, MAX_X, MAX_Y / 2);
		g2d.setXORMode(RANDOM_BG_COLORS[(int) (Math.random() * RANDOM_BG_COLORS.length)]);
		g2d.drawLine(0, (MAX_Y / 2) - 10, MAX_X, (MAX_Y / 2) - 10);
		g2d.setXORMode(RANDOM_BG_COLORS[(int) (Math.random() * RANDOM_BG_COLORS.length)]);
		g2d.drawLine(0, (MAX_Y / 2) + 10, MAX_X, (MAX_Y / 2) + 10);

		/*
		 * for (int i = 0; i < DRAW_LINES; i++) { g2d.setXORMode(Color.RED); //
		 * setRandomBGColor(g2d); g2d.setStroke(new BasicStroke(4)); //
		 * affineTransform.rotate(0); int y1 = (int) (Math.random() * MAX_Y); //
		 * int y2 = (int) (Math.random() * MAX_Y); g2d.drawLine(0, y1, MAX_X,
		 * y1); }
		 */

		return outImage;
	}
}
