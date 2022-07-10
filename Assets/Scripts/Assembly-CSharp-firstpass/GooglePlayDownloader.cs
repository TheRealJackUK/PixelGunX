using System;
using System.IO;
using System.Reflection;
using UnityEngine;

[Obfuscation(Exclude = true)]
public class GooglePlayDownloader
{
	private const string Environment_MEDIA_MOUNTED = "mounted";

	private static AndroidJavaClass detectAndroidJNI;

	private static AndroidJavaClass Environment;

	private static string obb_package;

	private static int obb_version;

	static GooglePlayDownloader()
	{
		if (!RunningOnAndroid())
		{
			return;
		}
		Environment = new AndroidJavaClass("android.os.Environment");
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.plugin.downloader.UnityDownloaderService"))
		{
			androidJavaClass.SetStatic("BASE64_PUBLIC_KEY", "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoTzMTaqsFhaywvCFKawFwL5KM+djLJfOCT/rbGQRfHmHYmOY2sBMgDWsA/67Szx6EVTZPVlFzHMgkAq1TwdL/A5aYGpGzaCX7o96cyp8R6wSF+xCuj++LAkTaDnLW0veI2bke3EVHu3At9xgM46e+VDucRUqQLvf6SQRb15nuflY5i08xKnewgX7I4U2H0RvAZDyoip+qZPmI4ZvaufAfc0jwZbw7XGiV41zibY3LU0N57mYKk51Wx+tOaJ7Tkc9Rl1qVCTjb+bwXshTqhVXVP6r4kabLWw/8OJUh0Sm69lbps6amP7vPy571XjscCTMLfXQan1959rHbNgkb2mLLQIDAQAB");
			androidJavaClass.SetStatic("SALT", new byte[20]
			{
				1, 43, 244, 255, 54, 98, 156, 244, 43, 2,
				248, 252, 9, 5, 150, 148, 223, 45, 255, 84
			});
		}
	}

	public static bool RunningOnAndroid()
	{
		if (detectAndroidJNI == null)
		{
			detectAndroidJNI = new AndroidJavaClass("android.os.Build");
		}
		return detectAndroidJNI.GetRawClass() != IntPtr.Zero;
	}

	public static string GetExpansionFilePath()
	{
		//Discarded unreachable code: IL_006e
		populateOBBData();
		if (Environment.CallStatic<string>("getExternalStorageState", new object[0]) != "mounted")
		{
			return null;
		}
		using (AndroidJavaObject androidJavaObject = Environment.CallStatic<AndroidJavaObject>("getExternalStorageDirectory", new object[0]))
		{
			string arg = androidJavaObject.Call<string>("getPath", new object[0]);
			return string.Format("{0}/{1}/{2}", arg, "Android/obb", obb_package);
		}
	}

	public static string GetMainOBBPath(string expansionFilePath)
	{
		populateOBBData();
		if (expansionFilePath == null)
		{
			return null;
		}
		string text = string.Format("{0}/main.{1}.{2}.obb", expansionFilePath, obb_version, obb_package);
		if (!File.Exists(text))
		{
			return null;
		}
		return text;
	}

	public static string GetPatchOBBPath(string expansionFilePath)
	{
		populateOBBData();
		if (expansionFilePath == null)
		{
			return null;
		}
		string text = string.Format("{0}/patch.{1}.{2}.obb", expansionFilePath, obb_version, obb_package);
		if (!File.Exists(text))
		{
			return null;
		}
		return text;
	}

	public static void FetchOBB()
	{
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
		{
			AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
			AndroidJavaObject androidJavaObject = new AndroidJavaObject("android.content.Intent", @static, new AndroidJavaClass("com.unity3d.plugin.downloader.UnityDownloaderActivity"));
			int num = 65536;
			androidJavaObject.Call<AndroidJavaObject>("addFlags", new object[1] { num });
			androidJavaObject.Call<AndroidJavaObject>("putExtra", new object[2]
			{
				"unityplayer.Activity",
				@static.Call<AndroidJavaObject>("getClass", new object[0]).Call<string>("getName", new object[0])
			});
			@static.Call("startActivity", androidJavaObject);
			if (AndroidJNI.ExceptionOccurred() != IntPtr.Zero)
			{
				Debug.LogError("Exception occurred while attempting to start DownloaderActivity - is the AndroidManifest.xml incorrect?");
				AndroidJNI.ExceptionDescribe();
				AndroidJNI.ExceptionClear();
			}
		}
	}

	private static void populateOBBData()
	{
		if (obb_version != 0)
		{
			return;
		}
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer"))
		{
			AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
			obb_package = @static.Call<string>("getPackageName", new object[0]);
			AndroidJavaObject androidJavaObject = @static.Call<AndroidJavaObject>("getPackageManager", new object[0]).Call<AndroidJavaObject>("getPackageInfo", new object[2] { obb_package, 0 });
			obb_version = androidJavaObject.Get<int>("versionCode");
		}
	}
}
