using System.Collections.Generic;
using UnityEngine;

namespace Prime31
{
	public class FlurryAnalytics
	{
		private static AndroidJavaClass _flurryAgent;

		private static AndroidJavaObject _plugin;

		static FlurryAnalytics()
		{
			return;
		}

		public static void startSession(string apiKey, bool enableLogging = false)
		{
		}

		public static void onEndSession()
		{
		}

		public static void addUserCookie(string key, string value)
		{
		}

		public static void clearUserCookies()
		{
		}

		public static void setContinueSessionMillis(long milliseconds)
		{
		}

		public static void logEvent(string eventName)
		{
			logEvent(eventName, false);
		}

		public static void logEvent(string eventName, bool isTimed)
		{
		}

		public static void logEvent(string eventName, Dictionary<string, string> parameters)
		{
			logEvent(eventName, parameters, false);
		}

		public static void logEvent(string eventName, Dictionary<string, string> parameters, bool isTimed)
		{
		}

		public static void endTimedEvent(string eventName)
		{
		}

		public static void endTimedEvent(string eventName, Dictionary<string, string> parameters)
		{
		}

		public static void onPageView()
		{
		}

		public static void onError(string errorId, string message, string errorClass)
		{
		}

		public static void setUserID(string userId)
		{
		}

		public static void setAge(int age)
		{
		}

		public static void setGender(FlurryGender gender)
		{
		}

		public static void setLogEnabled(bool enable)
		{
		}
	}
}
