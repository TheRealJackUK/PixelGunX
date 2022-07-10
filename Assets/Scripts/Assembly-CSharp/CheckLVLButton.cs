using System;
using System.Collections.Generic;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;

public class CheckLVLButton : MonoBehaviour
{
	public TextAsset ServiceBinder;

	private string m_PublicKey_Modulus_Base64 = "AKE8zE2qrBYWssLwhSmsBcC+SjPnYyyXzgk/62xkEXx5h2JjmNrATIA1rAP+u0s8ehFU2T1ZRcxzIJAKtU8HS/wOWmBqRs2gl+6PenMqfEesEhfsQro/viwJE2g5y1tL3iNm5HtxFR7twLfcYDOOnvlQ7nEVKkC73+kkEW9eZ7n5WOYtPMSp3sIF+yOFNh9EbwGQ8qIqfqmT5iOGb2rnwH3NI8GW8O1xoleNc4m2Ny1NDee5mCpOdVsfrTmie05HPUZdalQk42/m8F7IU6oVV1T+q+JGmy1sP/DiVIdEpuvZW6bOmpj+7z8ue9V47HAkzC310Gp9fefax2zYJG9piy0=";

	private string m_PublicKey_Exponent_Base64 = "AQAB";

	private RSAParameters m_PublicKey = default(RSAParameters);

	private bool m_RunningOnAndroid;

	private AndroidJavaObject m_Activity;

	private AndroidJavaObject m_LVLCheckType;

	private AndroidJavaObject m_LVLCheck;

	private string m_ButtonMessage = "Invalid LVL key!\nCheck the source...";

	private bool m_ButtonEnabled = true;

	private string m_PackageName;

	private int m_Nonce;

	private bool m_LVL_Received;

	private string m_ResponseCode_Received;

	private string m_PackageName_Received;

	private int m_Nonce_Received;

	private int m_VersionCode_Received;

	private string m_UserID_Received;

	private string m_Timestamp_Received;

	private int m_MaxRetry_Received;

	private string m_LicenceValidityTimestamp_Received;

	private string m_GracePeriodTimestamp_Received;

	private string m_UpdateTimestamp_Received;

	private string m_FileURL1_Received = string.Empty;

	private string m_FileURL2_Received = string.Empty;

	private string m_FileName1_Received;

	private string m_FileName2_Received;

	private int m_FileSize1_Received;

	private int m_FileSize2_Received;

	private void Start()
	{
		Debug.Log("private string m_PublicKey_Modulus_Base64 = \"" + m_PublicKey_Modulus_Base64 + "\";");
		Debug.Log("private string m_PublicKey_Exponent_Base64 = \"" + m_PublicKey_Exponent_Base64 + "\";");
		m_PublicKey.Modulus = Convert.FromBase64String(m_PublicKey_Modulus_Base64);
		m_PublicKey.Exponent = Convert.FromBase64String(m_PublicKey_Exponent_Base64);
		m_RunningOnAndroid = new AndroidJavaClass("android.os.Build").GetRawClass() != IntPtr.Zero;
		if (m_RunningOnAndroid)
		{
			LoadServiceBinder();
			new SHA1CryptoServiceProvider();
			m_ButtonMessage = "Check LVL";
		}
	}

	private void LoadServiceBinder()
	{
		byte[] bytes = ServiceBinder.bytes;
		m_Activity = new AndroidJavaClass("com.unity3d.player.UnityPlayer").GetStatic<AndroidJavaObject>("currentActivity");
		m_PackageName = m_Activity.Call<string>("getPackageName", new object[0]);
		string text = Path.Combine(m_Activity.Call<AndroidJavaObject>("getCacheDir", new object[0]).Call<string>("getPath", new object[0]), m_PackageName);
		Directory.CreateDirectory(text);
		File.WriteAllBytes(text + "/classes.jar", bytes);
		Directory.CreateDirectory(text + "/odex");
		AndroidJavaObject androidJavaObject = new AndroidJavaObject("dalvik.system.DexClassLoader", text + "/classes.jar", text + "/odex", null, m_Activity.Call<AndroidJavaObject>("getClassLoader", new object[0]));
		m_LVLCheckType = androidJavaObject.Call<AndroidJavaObject>("findClass", new object[1] { "com.unity3d.plugin.lvl.ServiceBinder" });
		Directory.Delete(text, true);
	}

	private void OnGUI()
	{
		if (!m_RunningOnAndroid)
		{
			GUI.Label(new Rect(10f, 10f, Screen.width - 10, 20f), "Use LVL checks only on the Android device!");
			return;
		}
		GUI.enabled = m_ButtonEnabled;
		if (GUI.Button(new Rect(10f, 10f, 450f, 300f), m_ButtonMessage))
		{
			m_Nonce = new System.Random().Next();
			object[] args = new object[1] { new AndroidJavaObject[1] { m_Activity } };
			AndroidJavaObject[] array = m_LVLCheckType.Call<AndroidJavaObject[]>("getConstructors", new object[0]);
			m_LVLCheck = array[0].Call<AndroidJavaObject>("newInstance", args);
			m_LVLCheck.Call("create", m_Nonce, new AndroidJavaRunnable(Process));
			m_ButtonMessage = "Checking...";
			m_ButtonEnabled = false;
		}
		GUI.enabled = true;
		if (m_LVLCheck != null || m_LVL_Received)
		{
			GUI.Label(new Rect(10f, 320f, 450f, 20f), "Requesting LVL response:");
			GUI.Label(new Rect(20f, 340f, 450f, 20f), "Package name  = " + m_PackageName);
			GUI.Label(new Rect(20f, 360f, 450f, 20f), "Request nonce = 0x" + m_Nonce.ToString("X"));
		}
		if (m_LVLCheck == null && m_LVL_Received)
		{
			GUI.Label(new Rect(10f, 420f, 450f, 20f), "Received LVL response:");
			GUI.Label(new Rect(20f, 440f, 450f, 20f), "Response code  = " + m_ResponseCode_Received);
			GUI.Label(new Rect(20f, 460f, 450f, 20f), "Package name   = " + m_PackageName_Received);
			GUI.Label(new Rect(20f, 480f, 450f, 20f), "Received nonce = 0x" + m_Nonce_Received.ToString("X"));
			GUI.Label(new Rect(20f, 500f, 450f, 20f), "Version code = " + m_VersionCode_Received);
			GUI.Label(new Rect(20f, 520f, 450f, 20f), "User ID   = " + m_UserID_Received);
			GUI.Label(new Rect(20f, 540f, 450f, 20f), "Timestamp = " + m_Timestamp_Received);
			GUI.Label(new Rect(20f, 560f, 450f, 20f), "Max Retry = " + m_MaxRetry_Received);
			GUI.Label(new Rect(20f, 580f, 450f, 20f), "License Validity = " + m_LicenceValidityTimestamp_Received);
			GUI.Label(new Rect(20f, 600f, 450f, 20f), "Grace Period = " + m_GracePeriodTimestamp_Received);
			GUI.Label(new Rect(20f, 620f, 450f, 20f), "Update Since = " + m_UpdateTimestamp_Received);
			GUI.Label(new Rect(20f, 640f, 450f, 20f), "Main OBB URL = " + m_FileURL1_Received.Substring(0, Mathf.Min(m_FileURL1_Received.Length, 50)) + "...");
			GUI.Label(new Rect(20f, 660f, 450f, 20f), "Main OBB Name = " + m_FileName1_Received);
			GUI.Label(new Rect(20f, 680f, 450f, 20f), "Main OBB Size = " + m_FileSize1_Received);
			GUI.Label(new Rect(20f, 700f, 450f, 20f), "Patch OBB URL = " + m_FileURL2_Received.Substring(0, Mathf.Min(m_FileURL2_Received.Length, 50)) + "...");
			GUI.Label(new Rect(20f, 720f, 450f, 20f), "Patch OBB Name = " + m_FileName2_Received);
			GUI.Label(new Rect(20f, 740f, 450f, 20f), "Patch OBB Size = " + m_FileSize2_Received);
		}
	}

	internal static Dictionary<string, string> DecodeExtras(string query)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		if (query.Length == 0)
		{
			return dictionary;
		}
		int length = query.Length;
		int num = 0;
		bool flag = true;
		while (num <= length)
		{
			int num2 = -1;
			int num3 = -1;
			for (int i = num; i < length; i++)
			{
				if (num2 == -1 && query[i] == '=')
				{
					num2 = i + 1;
				}
				else if (query[i] == '&')
				{
					num3 = i;
					break;
				}
			}
			if (flag)
			{
				flag = false;
				if (query[num] == '?')
				{
					num++;
				}
			}
			string key;
			if (num2 == -1)
			{
				key = null;
				num2 = num;
			}
			else
			{
				key = WWW.UnEscapeURL(query.Substring(num, num2 - num - 1));
			}
			if (num3 < 0)
			{
				num = -1;
				num3 = query.Length;
			}
			else
			{
				num = num3 + 1;
			}
			string value = WWW.UnEscapeURL(query.Substring(num2, num3 - num2));
			dictionary.Add(key, value);
			if (num == -1)
			{
				break;
			}
		}
		return dictionary;
	}

	private long ConvertEpochSecondsToTicks(long secs)
	{
		DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
		long num = 10000L;
		long num2 = (DateTime.MaxValue.Ticks - dateTime.Ticks) / num;
		if (secs < 0)
		{
			secs = 0L;
		}
		if (secs > num2)
		{
			secs = num2;
		}
		return dateTime.Ticks + secs * num;
	}

	private void Process()
	{
		m_LVL_Received = true;
		m_ButtonMessage = "Check LVL";
		m_ButtonEnabled = true;
		if (m_LVLCheck == null)
		{
			return;
		}
		int num = m_LVLCheck.Get<int>("_arg0");
		string text = m_LVLCheck.Get<string>("_arg1");
		string text2 = m_LVLCheck.Get<string>("_arg2");
		m_LVLCheck = null;
		m_ResponseCode_Received = num.ToString();
		if (num < 0 || string.IsNullOrEmpty(text) || string.IsNullOrEmpty(text2))
		{
			m_PackageName_Received = "<Failed>";
			return;
		}
		byte[] bytes = Encoding.UTF8.GetBytes(text);
		byte[] rgbSignature = Convert.FromBase64String(text2);
		RSACryptoServiceProvider rSACryptoServiceProvider = new RSACryptoServiceProvider();
		rSACryptoServiceProvider.ImportParameters(m_PublicKey);
		SHA1Managed sHA1Managed = new SHA1Managed();
		if (!rSACryptoServiceProvider.VerifyHash(sHA1Managed.ComputeHash(bytes), CryptoConfig.MapNameToOID("SHA1"), rgbSignature))
		{
			m_ResponseCode_Received = "<Failed>";
			m_PackageName_Received = "<Invalid Signature>";
			return;
		}
		int num2 = text.IndexOf(':');
		string text3;
		string text4;
		if (num2 == -1)
		{
			text3 = text;
			text4 = string.Empty;
		}
		else
		{
			text3 = text.Substring(0, num2);
			text4 = ((num2 < text.Length) ? text.Substring(num2 + 1) : string.Empty);
		}
		string[] array = text3.Split('|');
		if (array[0].CompareTo(num.ToString()) != 0)
		{
			m_ResponseCode_Received = "<Failed>";
			m_PackageName_Received = "<Response Mismatch>";
			return;
		}
		m_ResponseCode_Received = array[0];
		m_Nonce_Received = Convert.ToInt32(array[1]);
		m_PackageName_Received = array[2];
		m_VersionCode_Received = Convert.ToInt32(array[3]);
		m_UserID_Received = array[4];
		long ticks = ConvertEpochSecondsToTicks(Convert.ToInt64(array[5]));
		m_Timestamp_Received = new DateTime(ticks).ToLocalTime().ToString();
		if (!string.IsNullOrEmpty(text4))
		{
			Dictionary<string, string> dictionary = DecodeExtras(text4);
			if (dictionary.ContainsKey("GR"))
			{
				m_MaxRetry_Received = Convert.ToInt32(dictionary["GR"]);
			}
			else
			{
				m_MaxRetry_Received = 0;
			}
			if (dictionary.ContainsKey("VT"))
			{
				ticks = ConvertEpochSecondsToTicks(Convert.ToInt64(dictionary["VT"]));
				m_LicenceValidityTimestamp_Received = new DateTime(ticks).ToLocalTime().ToString();
			}
			else
			{
				m_LicenceValidityTimestamp_Received = null;
			}
			if (dictionary.ContainsKey("GT"))
			{
				ticks = ConvertEpochSecondsToTicks(Convert.ToInt64(dictionary["GT"]));
				m_GracePeriodTimestamp_Received = new DateTime(ticks).ToLocalTime().ToString();
			}
			else
			{
				m_GracePeriodTimestamp_Received = null;
			}
			if (dictionary.ContainsKey("UT"))
			{
				ticks = ConvertEpochSecondsToTicks(Convert.ToInt64(dictionary["UT"]));
				m_UpdateTimestamp_Received = new DateTime(ticks).ToLocalTime().ToString();
			}
			else
			{
				m_UpdateTimestamp_Received = null;
			}
			if (dictionary.ContainsKey("FILE_URL1"))
			{
				m_FileURL1_Received = dictionary["FILE_URL1"];
			}
			else
			{
				m_FileURL1_Received = string.Empty;
			}
			if (dictionary.ContainsKey("FILE_URL2"))
			{
				m_FileURL2_Received = dictionary["FILE_URL2"];
			}
			else
			{
				m_FileURL2_Received = string.Empty;
			}
			if (dictionary.ContainsKey("FILE_NAME1"))
			{
				m_FileName1_Received = dictionary["FILE_NAME1"];
			}
			else
			{
				m_FileName1_Received = null;
			}
			if (dictionary.ContainsKey("FILE_NAME2"))
			{
				m_FileName2_Received = dictionary["FILE_NAME2"];
			}
			else
			{
				m_FileName2_Received = null;
			}
			if (dictionary.ContainsKey("FILE_SIZE1"))
			{
				m_FileSize1_Received = Convert.ToInt32(dictionary["FILE_SIZE1"]);
			}
			else
			{
				m_FileSize1_Received = 0;
			}
			if (dictionary.ContainsKey("FILE_SIZE2"))
			{
				m_FileSize2_Received = Convert.ToInt32(dictionary["FILE_SIZE2"]);
			}
			else
			{
				m_FileSize2_Received = 0;
			}
		}
	}
}
