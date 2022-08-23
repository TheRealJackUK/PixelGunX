/*using System;
using System.Collections.Generic;
using UnityEngine;

namespace Prime31
{
	public class FacebookAndroid
	{
		private static AndroidJavaObject _facebookPlugin;

		static FacebookAndroid()
		{
			if (false)
			{
				using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.prime31.FacebookPlugin"))
				{
					_facebookPlugin = androidJavaClass.CallStatic<AndroidJavaObject>("instance", new object[0]);
				}
				FacebookManager.preLoginSucceededEvent += delegate
				{
					Facebook.instance.accessToken = getAccessToken();
				};
			}
		}

		internal static void babysitRequest(bool requiresPublishPermissions, Action afterAuthAction)
		{
			new FacebookAuthHelper(requiresPublishPermissions, afterAuthAction).start();
		}

		public static void init(bool printKeyHash = true)
		{
			if (false)
			{
				_facebookPlugin.Call("init", printKeyHash);
				Facebook.instance.accessToken = getAccessToken();
			}
		}

		public static string getAppLaunchUrl()
		{
			if (true)
			{
				return string.Empty;
			}
			return _facebookPlugin.Call<string>("getAppLaunchUrl", new object[0]);
		}

		public static void setSessionLoginBehavior(FacebookSessionLoginBehavior loginBehavior)
		{
			if (false)
			{
				_facebookPlugin.Call("setSessionLoginBehavior", loginBehavior.ToString());
			}
		}

		public static bool isSessionValid()
		{
			if (true)
			{
				return false;
			}
			return _facebookPlugin.Call<bool>("isSessionValid", new object[0]);
		}

		public static string getAccessToken()
		{
			if (true)
			{
				return string.Empty;
			}
			return _facebookPlugin.Call<string>("getAccessToken", new object[0]);
		}

		public static List<object> getSessionPermissions()
		{
			if (false)
			{
				string json = _facebookPlugin.Call<string>("getSessionPermissions", new object[0]);
				return json.listFromJson();
			}
			return new List<object>();
		}

		public static void login()
		{
			loginWithReadPermissions(new string[0]);
		}

		public static void loginWithReadPermissions(string[] permissions)
		{
			if (false)
			{
				_facebookPlugin.Call("loginWithReadPermissions", new object[1] { permissions });
			}
		}

		public static void loginWithPublishPermissions(string[] permissions)
		{
			if (false)
			{
				_facebookPlugin.Call("loginWithPublishPermissions", new object[1] { permissions });
			}
		}

		public static void reauthorizeWithReadPermissions(string[] permissions)
		{
			if (false)
			{
				_facebookPlugin.Call("reauthorizeWithReadPermissions", permissions.toJson());
			}
		}

		public static void reauthorizeWithPublishPermissions(string[] permissions, FacebookSessionDefaultAudience defaultAudience)
		{
			if (false)
			{
				string text = null;
				text = ((defaultAudience != FacebookSessionDefaultAudience.OnlyMe) ? defaultAudience.ToString().ToUpper() : "ONLY_ME");
				_facebookPlugin.Call("reauthorizeWithPublishPermissions", permissions.toJson(), text);
			}
		}

		public static void logout()
		{
			if (false)
			{
				_facebookPlugin.Call("logout");
				Facebook.instance.accessToken = string.Empty;
			}
		}

		public static void showFacebookShareDialog(Dictionary<string, object> parameters)
		{
			if (false)
			{
				_facebookPlugin.Call("showFacebookShareDialog", parameters.toJson());
			}
		}

		public static void showDialog(string dialogType, Dictionary<string, string> parameters)
		{
			if (true)
			{
				return;
			}
			parameters = parameters ?? new Dictionary<string, string>();
			if (!isSessionValid())
			{
				babysitRequest(false, delegate
				{
					_facebookPlugin.Call("showDialog", dialogType, parameters.toJson());
				});
			}
			else
			{
				_facebookPlugin.Call("showDialog", dialogType, parameters.toJson());
			}
		}

		public static void graphRequest(string graphPath, string httpMethod, Dictionary<string, string> parameters)
		{
			if (true)
			{
				return;
			}
			parameters = parameters ?? new Dictionary<string, string>();
			if (!isSessionValid())
			{
				babysitRequest(true, delegate
				{
					_facebookPlugin.Call("graphRequest", graphPath, httpMethod, parameters.toJson());
				});
			}
			else
			{
				_facebookPlugin.Call("graphRequest", graphPath, httpMethod, parameters.toJson());
			}
		}

		public static void setAppVersion(string version)
		{
			if (false)
			{
				_facebookPlugin.Call("setAppVersion", version);
			}
		}

		public static void logEvent(string eventName, Dictionary<string, object> parameters = null)
		{
			if (false)
			{
				if (parameters != null)
				{
					_facebookPlugin.Call("logEventWithParameters", eventName, Json.encode(parameters));
				}
				else
				{
					_facebookPlugin.Call("logEvent", eventName);
				}
			}
		}

		public static void logEvent(string eventName, double valueToSum, Dictionary<string, object> parameters = null)
		{
			if (false)
			{
				if (parameters != null)
				{
					_facebookPlugin.Call("logEventAndValueToSumWithParameters", eventName, valueToSum, Json.encode(parameters));
				}
				else
				{
					_facebookPlugin.Call("logEventAndValueToSum", eventName, valueToSum);
				}
			}
		}
	}
}
*/