using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

public static class CryptoPlayerPrefs
{
	private static Dictionary<string, string> keyHashs;

	private static Dictionary<string, int> xorOperands;

	private static Dictionary<string, SymmetricAlgorithm> rijndaelDict;

	private static int salt = int.MaxValue;

	private static bool _useRijndael = true;

	private static bool _useXor = true;

	public static bool HasKey(string key)
	{
		string key2 = hashedKey(key);
		return PlayerPrefs.HasKey(key2);
	}

	public static void DeleteKey(string key)
	{
		string key2 = hashedKey(key);
		PlayerPrefs.DeleteKey(key2);
	}

	public static void DeleteAll()
	{
		Debug.LogError("Deleting all data");
		PlayerPrefs.DeleteAll();
	}

	public static void Save()
	{
		PlayerPrefs.Save();
	}

	public static void SetInt(string key, int val)
	{
		string text = hashedKey(key);
		int num = val;
		if (_useXor)
		{
			int num2 = computeXorOperand(key, text);
			int num3 = computePlusOperand(num2);
			num = (val + num3) ^ num2;
		}
		if (_useRijndael)
		{
			PlayerPrefs.SetString(text, encrypt(text, string.Empty + num));
		}
		else
		{
			PlayerPrefs.SetInt(text, num);
		}
	}

	public static void SetLong(string key, long val)
	{
		SetString(key, val.ToString());
	}

	public static void SetString(string key, string val)
	{
		string text = hashedKey(key);
		string text2 = val;
		if (_useXor)
		{
			int num = computeXorOperand(key, text);
			int num2 = computePlusOperand(num);
			text2 = string.Empty;
			foreach (char c in val)
			{
				char c2 = (char)((c + num2) ^ num);
				text2 += c2;
			}
		}
		if (_useRijndael)
		{
			PlayerPrefs.SetString(text, encrypt(text, text2));
		}
		else
		{
			PlayerPrefs.SetString(text, text2);
		}
	}

	public static void SetFloat(string key, float val)
	{
		SetString(key, val.ToString());
	}

	public static int GetInt(string key, int defaultValue = 0)
	{
		string text = hashedKey(key);
		if (!PlayerPrefs.HasKey(text))
		{
			return defaultValue;
		}
		int num = ((!_useRijndael) ? PlayerPrefs.GetInt(text) : int.Parse(decrypt(text)));
		int result = num;
		if (_useXor)
		{
			int num2 = computeXorOperand(key, text);
			int num3 = computePlusOperand(num2);
			result = (num2 ^ num) - num3;
		}
		return result;
	}

	public static long GetLong(string key, long defaultValue = 0)
	{
		return long.Parse(GetString(key, defaultValue.ToString()));
	}

	public static string GetString(string key, string defaultValue = "")
	{
		string text = hashedKey(key);
		if (!PlayerPrefs.HasKey(text))
		{
			return defaultValue;
		}
		string text2 = ((!_useRijndael) ? PlayerPrefs.GetString(text) : decrypt(text));
		string text3 = text2;
		if (_useXor)
		{
			int num = computeXorOperand(key, text);
			int num2 = computePlusOperand(num);
			text3 = string.Empty;
			string text4 = text2;
			foreach (char c in text4)
			{
				char c2 = (char)((num ^ c) - num2);
				text3 += c2;
			}
		}
		return text3;
	}

	public static float GetFloat(string key, float defaultValue = 0f)
	{
		return float.Parse(GetString(key, defaultValue.ToString()));
	}

	private static string encrypt(string cKey, string data)
	{
		return EncryptString(data, getEncryptionPassword(cKey));
	}

	private static string decrypt(string cKey)
	{
		return DecryptString(PlayerPrefs.GetString(cKey), getEncryptionPassword(cKey));
	}

	private static string hashedKey(string key)
	{
		if (keyHashs == null)
		{
			keyHashs = new Dictionary<string, string>();
		}
		if (keyHashs.ContainsKey(key))
		{
			return keyHashs[key];
		}
		string text = Md5Sum(key);
		keyHashs.Add(key, text);
		return text;
	}

	private static int computeXorOperand(string key, string cryptedKey)
	{
		if (xorOperands == null)
		{
			xorOperands = new Dictionary<string, int>();
		}
		if (xorOperands.ContainsKey(key))
		{
			return xorOperands[key];
		}
		int num = 0;
		foreach (char c in cryptedKey)
		{
			num += c;
		}
		num += salt;
		xorOperands.Add(key, num);
		return num;
	}

	private static int computePlusOperand(int xor)
	{
		return xor & (xor << 1);
	}

	public static string Md5Sum(string strToEncrypt)
	{
		UTF8Encoding uTF8Encoding = new UTF8Encoding();
		byte[] bytes = uTF8Encoding.GetBytes(strToEncrypt);
		HashAlgorithm hashAlgorithm = new MD5CryptoServiceProvider();
		byte[] array = hashAlgorithm.ComputeHash(bytes);
		string text = string.Empty;
		for (int i = 0; i < array.Length; i++)
		{
			text += Convert.ToString(array[i], 16).PadLeft(2, '0');
		}
		return text.PadLeft(32, '0');
	}

	private static byte[] EncryptString(byte[] clearText, SymmetricAlgorithm alg)
	{
		MemoryStream memoryStream = new MemoryStream();
		CryptoStream cryptoStream = new CryptoStream(memoryStream, alg.CreateEncryptor(), CryptoStreamMode.Write);
		cryptoStream.Write(clearText, 0, clearText.Length);
		cryptoStream.Close();
		return memoryStream.ToArray();
	}

	private static string EncryptString(string clearText, string Password)
	{
		SymmetricAlgorithm rijndaelForKey = getRijndaelForKey(Password);
		byte[] bytes = Encoding.Unicode.GetBytes(clearText);
		byte[] inArray = EncryptString(bytes, rijndaelForKey);
		return Convert.ToBase64String(inArray);
	}

	private static byte[] DecryptString(byte[] cipherData, SymmetricAlgorithm alg)
	{
		MemoryStream memoryStream = new MemoryStream();
		CryptoStream cryptoStream = new CryptoStream(memoryStream, alg.CreateDecryptor(), CryptoStreamMode.Write);
		cryptoStream.Write(cipherData, 0, cipherData.Length);
		cryptoStream.Close();
		return memoryStream.ToArray();
	}

	private static string DecryptString(string cipherText, string Password)
	{
		if (rijndaelDict == null)
		{
			rijndaelDict = new Dictionary<string, SymmetricAlgorithm>();
		}
		byte[] cipherData = Convert.FromBase64String(cipherText);
		SymmetricAlgorithm rijndaelForKey = getRijndaelForKey(Password);
		byte[] array = DecryptString(cipherData, rijndaelForKey);
		return Encoding.Unicode.GetString(array, 0, array.Length);
	}

	private static SymmetricAlgorithm getRijndaelForKey(string key)
	{
		if (rijndaelDict == null)
		{
			rijndaelDict = new Dictionary<string, SymmetricAlgorithm>();
		}
		SymmetricAlgorithm symmetricAlgorithm;
		if (rijndaelDict.ContainsKey(key))
		{
			symmetricAlgorithm = rijndaelDict[key];
		}
		else
		{
			Rfc2898DeriveBytes rfc2898DeriveBytes = new Rfc2898DeriveBytes(key, new byte[13]
			{
				73, 97, 110, 32, 77, 100, 118, 101, 101, 100,
				101, 118, 118
			});
			symmetricAlgorithm = Rijndael.Create();
			symmetricAlgorithm.Key = rfc2898DeriveBytes.GetBytes(32);
			symmetricAlgorithm.IV = rfc2898DeriveBytes.GetBytes(16);
			rijndaelDict.Add(key, symmetricAlgorithm);
		}
		return symmetricAlgorithm;
	}

	private static string getEncryptionPassword(string pw)
	{
		return Md5Sum(pw + salt);
	}

	private static bool test(bool use_Rijndael, bool use_Xor)
	{
		bool flag = true;
		bool use = _useRijndael;
		bool use2 = _useXor;
		useRijndael(use_Rijndael);
		useXor(use_Xor);
		int num = 0;
		string text = "cryptotest_int";
		string text2 = hashedKey(text);
		SetInt(text, num);
		int @int = GetInt(text);
		bool flag2 = num == @int;
		flag = flag && flag2;
		Debug.Log("INT Bordertest Zero: " + ((!flag2) ? "fail" : "ok"));
		Debug.Log("(Key: " + text + "; Crypted Key: " + text2 + "; Input value: " + num + "; Saved value: " + PlayerPrefs.GetString(text2) + "; Return value: " + @int + ")");
		num = int.MaxValue;
		text = "cryptotest_intmax";
		text2 = hashedKey(text);
		SetInt(text, num);
		@int = GetInt(text);
		flag2 = num == @int;
		flag = flag && flag2;
		Debug.Log("INT Bordertest Max: " + ((!flag2) ? "fail" : "ok"));
		Debug.Log("(Key: " + text + "; Crypted Key: " + text2 + "; Input value: " + num + "; Saved value: " + PlayerPrefs.GetString(text2) + "; Return value: " + @int + ")");
		num = int.MinValue;
		text = "cryptotest_intmin";
		text2 = hashedKey(text);
		SetInt(text, num);
		@int = GetInt(text);
		flag2 = num == @int;
		flag = flag && flag2;
		Debug.Log("INT Bordertest Min: " + ((!flag2) ? "fail" : "ok"));
		Debug.Log("(Key: " + text + "; Crypted Key: " + text2 + "; Input value: " + num + "; Saved value: " + PlayerPrefs.GetString(text2) + "; Return value: " + @int + ")");
		text = "cryptotest_intrand";
		text2 = hashedKey(text);
		bool flag3 = true;
		for (int i = 0; i < 100; i++)
		{
			int num2 = UnityEngine.Random.Range(int.MinValue, int.MaxValue);
			num = num2;
			SetInt(text, num);
			@int = GetInt(text);
			flag2 = num == @int;
			flag3 = flag3 && flag2;
			flag = flag && flag2;
		}
		Debug.Log("INT Test Random: " + ((!flag3) ? "fail" : "ok"));
		float num3 = 0f;
		text = "cryptotest_float";
		text2 = hashedKey(text);
		SetFloat(text, num3);
		float @float = GetFloat(text, 0f);
		flag2 = num3.ToString().Equals(@float.ToString());
		flag = flag && flag2;
		Debug.Log("FLOAT Bordertest Zero: " + ((!flag2) ? "fail" : "ok"));
		Debug.Log("(Key: " + text + "; Crypted Key: " + text2 + "; Input value: " + num3 + "; Saved value: " + PlayerPrefs.GetString(text2) + "; Return value: " + @float + ")");
		num3 = float.MaxValue;
		text = "cryptotest_floatmax";
		text2 = hashedKey(text);
		SetFloat(text, num3);
		@float = GetFloat(text, 0f);
		flag2 = num3.ToString().Equals(@float.ToString());
		flag = flag && flag2;
		Debug.Log("FLOAT Bordertest Max: " + ((!flag2) ? "fail" : "ok"));
		Debug.Log("(Key: " + text + "; Crypted Key: " + text2 + "; Input value: " + num3 + "; Saved value: " + PlayerPrefs.GetString(text2) + "; Return value: " + @float + ")");
		num3 = float.MinValue;
		text = "cryptotest_floatmin";
		text2 = hashedKey(text);
		SetFloat(text, num3);
		@float = GetFloat(text, 0f);
		flag2 = num3.ToString().Equals(@float.ToString());
		flag = flag && flag2;
		Debug.Log("FLOAT Bordertest Min: " + ((!flag2) ? "fail" : "ok"));
		Debug.Log("(Key: " + text + "; Crypted Key: " + text2 + "; Input value: " + num3 + "; Saved value: " + PlayerPrefs.GetString(text2) + "; Return value: " + @float + ")");
		text = "cryptotest_floatrand";
		text2 = hashedKey(text);
		flag3 = true;
		for (int j = 0; j < 100; j++)
		{
			float num4 = (float)UnityEngine.Random.Range(int.MinValue, int.MaxValue) * UnityEngine.Random.value;
			num3 = num4;
			SetFloat(text, num3);
			@float = GetFloat(text, 0f);
			flag2 = num3.ToString().Equals(@float.ToString());
			flag3 = flag3 && flag2;
			flag = flag && flag2;
		}
		Debug.Log("FLOAT Test Random: " + ((!flag3) ? "fail" : "ok"));
		DeleteKey("cryptotest_int");
		DeleteKey("cryptotest_intmax");
		DeleteKey("cryptotest_intmin");
		DeleteKey("cryptotest_intrandom");
		DeleteKey("cryptotest_float");
		DeleteKey("cryptotest_floatmax");
		DeleteKey("cryptotest_floatmin");
		DeleteKey("cryptotest_floatrandom");
		useRijndael(use);
		useXor(use2);
		return flag;
	}

	public static bool test()
	{
		bool flag = test(true, true);
		bool flag2 = test(true, false);
		bool flag3 = test(false, true);
		bool flag4 = test(false, false);
		return flag && flag2 && flag3 && flag4;
	}

	public static void setSalt(int s)
	{
		salt = s;
	}

	public static void useRijndael(bool use)
	{
		_useRijndael = use;
	}

	public static void useXor(bool use)
	{
		_useXor = use;
	}
}
