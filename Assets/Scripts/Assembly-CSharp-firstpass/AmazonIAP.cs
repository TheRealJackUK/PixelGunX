using System;
using UnityEngine;

public class AmazonIAP
{
	public const AmazonLogging.AmazonLoggingLevel errorLevel = AmazonLogging.AmazonLoggingLevel.Verbose;

	private const string serviceName = "Amazon Insights";

	private static AndroidJavaObject _plugin;

	static AmazonIAP()
	{
		if (Application.platform != RuntimePlatform.Android)
		{
			return;
		}
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.amazon.AmazonIAPPlugin"))
		{
			_plugin = androidJavaClass.CallStatic<AndroidJavaObject>("instance", new object[0]);
		}
	}

	public static void initiateItemDataRequest(string[] items)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			IntPtr methodID = AndroidJNI.GetMethodID(_plugin.GetRawClass(), "initiateItemDataRequest", "([Ljava/lang/String;)V");
			AndroidJNI.CallVoidMethod(_plugin.GetRawObject(), methodID, AndroidJNIHelper.CreateJNIArgArray(new object[1] { items }));
		}
	}

	public static void initiatePurchaseRequest(string sku)
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			_plugin.Call("initiatePurchaseRequest", sku);
		}
	}

	public static void initiateGetUserIdRequest()
	{
		if (Application.platform == RuntimePlatform.Android)
		{
			_plugin.Call("initiateGetUserIdRequest");
		}
	}

	public static void LogError(string errorMessage)
	{
		AmazonLogging.LogError(AmazonLogging.AmazonLoggingLevel.Verbose, "Amazon Insights", errorMessage);
	}

	public static void LogWarning(string errorMessage)
	{
		AmazonLogging.LogWarning(AmazonLogging.AmazonLoggingLevel.Verbose, "Amazon Insights", errorMessage);
	}

	public static void Log(string message)
	{
		AmazonLogging.Log(AmazonLogging.AmazonLoggingLevel.Verbose, "Amazon Insights", message);
	}
}
