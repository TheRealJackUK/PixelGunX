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
		return;
	}

	public static bool RunningOnAndroid()
	{
		return false;
	}

	public static string GetExpansionFilePath()
	{
		return string.Empty;
	}

	public static string GetMainOBBPath(string expansionFilePath)
	{
		return string.Empty;
	}

	public static string GetPatchOBBPath(string expansionFilePath)
	{
		return string.Empty;
	}

	public static void FetchOBB()
	{
	}

	private static void populateOBBData()
	{
	}
}
