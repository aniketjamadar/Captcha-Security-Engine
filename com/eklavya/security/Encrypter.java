package com.eklavya.security;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;

/**
 * <b>The following code implements a class for encrypting and decrypting
 * strings using several Cipher algorithms. The class is created with a key and
 * can be used repeatedly to encrypt and decrypt strings using that key. Some of
 * the more popular algorithms are:
 * <li>Blowfish
 * <li>DES
 * <li>DESede
 * <li>PBEWithMD5AndDES
 * <li>PBEWithMD5AndTripleDES
 * <li>TripleDES </b>
 */
public class Encrypter
{

	private static final String PASS_CODE = Config.getProperty(Config.PASS_CODE);

	Cipher _ecipher;
	Cipher _dcipher;

	/**
	 * Constructor used to create this object Pass code used PASS_CODE
	 */
	public Encrypter()
	{
		// 8-bytes Salt
		byte[] salt = { (byte) 0xAA, (byte) 0x9B, (byte) 0xC8, (byte) 0x32, (byte) 0x56, (byte) 0x11, (byte) 0xE3,
				(byte) 0x03 };

		// Iteration count
		int iterationCount = 19;

		try
		{

			KeySpec keySpec = new PBEKeySpec(PASS_CODE.toCharArray(), salt, iterationCount);
			SecretKey key = SecretKeyFactory.getInstance(Config.getProperty(Config.ALGORITHM)).generateSecret(keySpec);

			_ecipher = Cipher.getInstance(key.getAlgorithm());
			_dcipher = Cipher.getInstance(key.getAlgorithm());

			// Prepare the parameters to the cipthers
			AlgorithmParameterSpec paramSpec = new PBEParameterSpec(salt, iterationCount);

			_ecipher.init(Cipher.ENCRYPT_MODE, key, paramSpec);
			_dcipher.init(Cipher.DECRYPT_MODE, key, paramSpec);

		}
		catch (InvalidAlgorithmParameterException e)
		{
			System.err.println("EXCEPTION: InvalidAlgorithmParameterException");
		}
		catch (InvalidKeySpecException e)
		{
			System.err.println("EXCEPTION: InvalidKeySpecException");
		}
		catch (NoSuchPaddingException e)
		{
			System.err.println("EXCEPTION: NoSuchPaddingException");
		}
		catch (NoSuchAlgorithmException e)
		{
			System.err.println("EXCEPTION: NoSuchAlgorithmException");
		}
		catch (InvalidKeyException e)
		{
			System.err.println("EXCEPTION: InvalidKeyException");
		}
	}

	/**
	 * Constructor used to create this object. Responsible for setting and
	 * initializing this object's encrypter and decrypter Chipher instances
	 * given a Secret Key and algorithm.
	 * 
	 * @param key
	 *            Secret Key used to initialize both the encrypter and decrypter
	 *            instances.
	 * @param algorithm
	 *            Which algorithm to use for creating the encrypter and
	 *            decrypter instances.
	 */
	public Encrypter(SecretKey key, String algorithm)
	{
		try
		{
			_ecipher = Cipher.getInstance(algorithm);
			_dcipher = Cipher.getInstance(algorithm);
			_ecipher.init(Cipher.ENCRYPT_MODE, key);
			_dcipher.init(Cipher.DECRYPT_MODE, key);
		}
		catch (NoSuchPaddingException e)
		{
			System.err.println("EXCEPTION: NoSuchPaddingException");
		}
		catch (NoSuchAlgorithmException e)
		{
			System.err.println("EXCEPTION: NoSuchAlgorithmException");
		}
		catch (InvalidKeyException e)
		{
			System.err.println("EXCEPTION: InvalidKeyException");
		}
	}

	/**
	 * Takes a encrypted String as an argument, decrypts and returns the
	 * decrypted String.
	 * 
	 * @param str
	 *            Encrypted String to be decrypted
	 * @return <code>String</code> Decrypted version of the provided String
	 */
	public String decrypt(String str)
	{

		try
		{
			// Decode base64 to get bytes
			byte[] dec = new sun.misc.BASE64Decoder().decodeBuffer(str);

			// Decrypt
			byte[] utf8 = _dcipher.doFinal(dec);

			// Decode using utf-8
			return new String(utf8, "UTF8");

		}
		catch (BadPaddingException e)
		{
		}
		catch (IllegalBlockSizeException e)
		{
		}
		catch (UnsupportedEncodingException e)
		{
		}
		catch (IOException e)
		{
		}
		return null;
	}

	/**
	 * Takes a single String as an argument and returns an Encrypted version of
	 * that String.
	 * 
	 * @param str
	 *            String to be encrypted
	 * @return <code>String</code> Encrypted version of the provided String
	 */
	public String encrypt(String str)
	{
		try
		{
			// Encode the string into bytes using utf-8
			byte[] utf8 = str.getBytes("UTF8");

			// Encrypt
			byte[] enc = _ecipher.doFinal(utf8);

			// Encode bytes to base64 to get a string
			return new sun.misc.BASE64Encoder().encode(enc);
		}
		catch (BadPaddingException e)
		{
		}
		catch (IllegalBlockSizeException e)
		{
		}
		catch (UnsupportedEncodingException e)
		{
		}
		catch (Exception e)
		{
		}
		return null;
	}
}
