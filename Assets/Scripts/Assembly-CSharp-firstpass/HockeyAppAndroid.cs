using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;
using UnityEngine;

public class HockeyAppAndroid : MonoBehaviour
{
	protected const string HOCKEYAPP_BASEURL = "https://rink.hockeyapp.net/";

	protected const string HOCKEYAPP_CRASHESPATH = "api/2/apps/[APPID]/crashes/upload";

	protected const int MAX_CHARS = 199800;

	protected const string LOG_FILE_DIR = "/logs/";

	public string appID = "your-hockey-app-id";

	public string packageID = "your-package-identifier";

	public string serverURL = "your-custom-server-url";

	public bool exceptionLogging;

	public bool autoUpload;

	public bool updateManager;

	private void Awake()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private void OnEnable()
	{
		if (exceptionLogging)
		{
			AppDomain.CurrentDomain.UnhandledException += OnHandleUnresolvedException;
			Application.RegisterLogCallback(OnHandleLogCallback);
		}
	}

	private void OnDisable()
	{
		Application.RegisterLogCallback(null);
	}

	private void OnDestroy()
	{
		Application.RegisterLogCallback(null);
	}

	protected void StartCrashManager(string urlString, string appID, bool updateManagerEnabled, bool autoSendEnabled)
	{
		AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
		AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
		AndroidJavaClass androidJavaClass2 = new AndroidJavaClass("net.hockeyapp.unity.HockeyUnityPlugin");
		androidJavaClass2.CallStatic("startHockeyAppManager", @static, urlString, appID, updateManagerEnabled, autoSendEnabled);
	}

	protected string GetVersion()
	{
		string text = null;
		AndroidJavaClass androidJavaClass = new AndroidJavaClass("net.hockeyapp.unity.HockeyUnityPlugin");
		return androidJavaClass.CallStatic<string>("getAppVersion", new object[0]);
	}

	protected virtual List<string> GetLogHeaders()
	{
		List<string> list = new List<string>();
		list.Add("Package: " + packageID);
		string version = GetVersion();
		list.Add("Version: " + version);
		string[] array = SystemInfo.operatingSystem.Split('/');
		string item = "Android: " + array[0].Replace("Android OS ", string.Empty);
		list.Add(item);
		list.Add("Model: " + SystemInfo.deviceModel);
		list.Add("Date: " + DateTime.UtcNow.ToString("ddd MMM dd HH:mm:ss {}zzzz yyyy").Replace("{}", "GMT"));
		return list;
	}

	protected virtual WWWForm CreateForm(string log)
	{
		WWWForm wWWForm = new WWWForm();
		byte[] array = null;
		using (FileStream fileStream = File.OpenRead(log))
		{
			if (fileStream.Length > 199800)
			{
				string text = null;
				using (StreamReader streamReader = new StreamReader(fileStream))
				{
					streamReader.BaseStream.Seek(fileStream.Length - 199800, SeekOrigin.Begin);
					text = streamReader.ReadToEnd();
				}
				List<string> logHeaders = GetLogHeaders();
				string text2 = string.Empty;
				foreach (string item in logHeaders)
				{
					text2 = text2 + item + "\n";
				}
				text = text2 + "\n[...]" + text;
				try
				{
					array = Encoding.Default.GetBytes(text);
				}
				catch (ArgumentException ex)
				{
					if (Debug.isDebugBuild)
					{
						Debug.Log("Failed to read bytes of log file: " + ex);
					}
				}
			}
			else
			{
				try
				{
					array = File.ReadAllBytes(log);
				}
				catch (SystemException ex2)
				{
					if (Debug.isDebugBuild)
					{
						Debug.Log("Failed to read bytes of log file: " + ex2);
					}
				}
			}
		}
		if (array != null)
		{
			wWWForm.AddBinaryData("log", array, log, "text/plain");
		}
		return wWWForm;
	}

	protected virtual List<string> GetLogFiles()
	{
		List<string> list = new List<string>();
		string path = Application.persistentDataPath + "/logs/";
		try
		{
			if (!Directory.Exists(path))
			{
				Directory.CreateDirectory(path);
			}
			DirectoryInfo directoryInfo = new DirectoryInfo(path);
			FileInfo[] files = directoryInfo.GetFiles();
			if (files.Length > 0)
			{
				FileInfo[] array = files;
				foreach (FileInfo fileInfo in array)
				{
					if (fileInfo.Extension == ".log")
					{
						list.Add(fileInfo.FullName);
					}
					else
					{
						File.Delete(fileInfo.FullName);
					}
				}
				return list;
			}
			return list;
		}
		catch (Exception ex)
		{
			if (Debug.isDebugBuild)
			{
				Debug.Log("Failed to write exception log to file: " + ex);
				return list;
			}
			return list;
		}
	}

	protected virtual IEnumerator SendLogs(List<string> logs)
	{
		string crashPath = "api/2/apps/[APPID]/crashes/upload";
		string url = GetBaseURL() + crashPath.Replace("[APPID]", appID);
		foreach (string log in logs)
		{
			WWWForm postForm = CreateForm(log);
			string lContent2 = postForm.headers["Content-Type"].ToString();
			lContent2 = lContent2.Replace("\"", string.Empty);
			WWW www = new WWW(headers: new Hashtable { { "Content-Type", lContent2 } }, url: url, postData: postForm.data);
			yield return www;
			if (!string.IsNullOrEmpty(www.error))
			{
				continue;
			}
			try
			{
				File.Delete(log);
			}
			catch (Exception ex)
			{
				Exception e = ex;
				if (Debug.isDebugBuild)
				{
					Debug.Log("Failed to delete exception log: " + e);
				}
			}
		}
	}

	protected virtual void WriteLogToDisk(string logString, string stackTrace)
	{
		string text = DateTime.Now.ToString("yyyy-MM-dd-HH_mm_ss_fff");
		string text2 = logString.Replace("\n", " ");
		string[] array = stackTrace.Split('\n');
		text2 = "\n" + text2 + "\n";
		string[] array2 = array;
		foreach (string text3 in array2)
		{
			if (text3.Length > 0)
			{
				text2 = text2 + "  at " + text3 + "\n";
			}
		}
		List<string> logHeaders = GetLogHeaders();
		using (StreamWriter streamWriter = new StreamWriter(Application.persistentDataPath + "/logs/LogFile_" + text + ".log", true))
		{
			foreach (string item in logHeaders)
			{
				streamWriter.WriteLine(item);
			}
			streamWriter.WriteLine(text2);
		}
	}

	protected virtual string GetBaseURL()
	{
		string empty = string.Empty;
		string text = serverURL.Trim();
		if (text.Length > 0)
		{
			empty = text;
			if (!empty[empty.Length - 1].Equals("/"))
			{
				empty += "/";
			}
		}
		else
		{
			empty = "https://rink.hockeyapp.net/";
		}
		return empty;
	}

	protected virtual bool IsConnected()
	{
		bool result = false;
		if (Application.internetReachability == NetworkReachability.ReachableViaLocalAreaNetwork || Application.internetReachability == NetworkReachability.ReachableViaCarrierDataNetwork)
		{
			result = true;
		}
		return result;
	}

	protected virtual void HandleException(string logString, string stackTrace)
	{
		WriteLogToDisk(logString, stackTrace);
	}

	public void OnHandleLogCallback(string logString, string stackTrace, LogType type)
	{
		if (type == LogType.Assert || type == LogType.Exception)
		{
			HandleException(logString, stackTrace);
		}
	}

	public void OnHandleUnresolvedException(object sender, UnhandledExceptionEventArgs args)
	{
		if (args != null && args.ExceptionObject != null && args.ExceptionObject.GetType() == typeof(Exception))
		{
			Exception ex = (Exception)args.ExceptionObject;
			HandleException(ex.Source, ex.StackTrace);
		}
	}

	private void UpdateSettings()
	{
		appID = Defs.HockeyAppID;
		packageID = Defs.GetIntendedAndroidPackageName(Defs.AndroidEdition);
	}
}
