using System;
using UnityEngine;

namespace Rilisoft
{
	internal sealed class AndroidSystem
	{
		private WeakReference _currentActivity;

		private static readonly Lazy<AndroidSystem> _instance = new Lazy<AndroidSystem>(() => new AndroidSystem());

		public static AndroidSystem Instance
		{
			get
			{
				return _instance.Value;
			}
		}

		/*public AndroidJavaObject CurrentActivity
		{
			get
			{
				//Discarded unreachable code: IL_0070, IL_008d
				try
				{
					if (_currentActivity != null && _currentActivity.IsAlive)
					{
						return _currentActivity.Target as AndroidJavaObject;
					}
/				AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
					AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
					if (@static == null)
					{
						_currentActivity = null;
						return null;
					}
					_currentActivity = new WeakReference(@static, false);
					return @static;
				}
				catch (Exception exception)
				{
					Debug.LogWarning("Exception occured while getting Android current activity. See next log entry for details.");
					Debug.LogException(exception);
					return null;
				}
			}
		}*/

		private AndroidSystem()
		{
		}

		public string GetAdvertisingId()
		{
			return string.Empty;
		}
	}
}
