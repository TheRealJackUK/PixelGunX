using System;
using UnityEngine;

public class AmazonIAP
{
	public const AmazonLogging.AmazonLoggingLevel errorLevel = AmazonLogging.AmazonLoggingLevel.Verbose;

	private const string serviceName = "Amazon Insights";

	private static AndroidJavaObject _plugin;

	static AmazonIAP()
	{
		return;
	}

	public static void initiateItemDataRequest(string[] items)
	{
	}

	public static void initiatePurchaseRequest(string sku)
	{
	}

	public static void initiateGetUserIdRequest()
	{
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
