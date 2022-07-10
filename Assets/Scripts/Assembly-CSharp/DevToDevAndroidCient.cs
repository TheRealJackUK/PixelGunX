using UnityEngine;

internal class DevToDevAndroidCient
{
	private static DevToDevAndroidCient _instance;

	private AndroidJavaClass cls_jni = new AndroidJavaClass("com.devtodev.core.DevToDev");

	public static DevToDevAndroidCient Instance
	{
		get
		{
			if (_instance == null)
			{
				_instance = new DevToDevAndroidCient();
			}
			return _instance;
		}
	}

	public string UserUdid
	{
		get
		{
			return cls_jni.CallStatic<string>("getUserUdid", new object[0]);
		}
		set
		{
			cls_jni.CallStatic("setUserUdid", value);
		}
	}

	public string OpenUdid
	{
		get
		{
			return cls_jni.CallStatic<string>("getOpenUdid", new object[0]);
		}
	}

	public string Odin1
	{
		get
		{
			return cls_jni.CallStatic<string>("getOdin1", new object[0]);
		}
	}

	public void Dispose()
	{
		cls_jni.Dispose();
	}

	public void Initialize(string appKey, string appSecret)
	{
		AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
		AndroidJavaObject @static = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
		AndroidJavaObject context = @static.Call<AndroidJavaObject>("getApplicationContext", new object[0]);
		@static.Call("runOnUiThread", (AndroidJavaRunnable)delegate
		{
			cls_jni.CallStatic("init", context, appKey, appSecret);
		});
	}

	public void StartSession()
	{
		using (AndroidJavaObject androidJavaObject = new AndroidJavaClass("com.devtodev.core.data.consts.StartSessionEvent").GetStatic<AndroidJavaObject>("New"))
		{
			cls_jni.CallStatic("startSession", androidJavaObject);
		}
	}

	public void EndSession()
	{
		using (AndroidJavaObject androidJavaObject = new AndroidJavaClass("com.devtodev.core.data.consts.EndSessionEvent").GetStatic<AndroidJavaObject>("Closed"))
		{
			cls_jni.CallStatic("endSession", androidJavaObject);
		}
	}

	public void Tutorial(DevToDevTutorial state)
	{
		AndroidJavaObject androidJavaObject = ((state == DevToDevTutorial.Completed || state != DevToDevTutorial.Skipped) ? new AndroidJavaClass("com.devtodev.core.data.consts.TutorialState").GetStatic<AndroidJavaObject>("Completed") : new AndroidJavaClass("com.devtodev.core.data.consts.TutorialState").GetStatic<AndroidJavaObject>("Skipped"));
		cls_jni.CallStatic("tutorialCompleted", androidJavaObject);
		androidJavaObject.Dispose();
	}

	public void Level(int level)
	{
		cls_jni.CallStatic("levelUp", level);
	}

	public void RealPayment(string orderId, float inAppPrice, string inAppName, string inAppCurrencyISOCode)
	{
		cls_jni.CallStatic("realPayment", orderId, inAppPrice, inAppName, inAppCurrencyISOCode);
	}

	public void SocialNetworkConnect(DevToDevSocialNetwork toDevSocialNetwork)
	{
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.devtodev.core.data.consts.SocialNetwork"))
		{
			using (AndroidJavaObject androidJavaObject = androidJavaClass.CallStatic<AndroidJavaObject>("Custom", new object[1] { toDevSocialNetwork.ToString() }))
			{
				cls_jni.CallStatic("socialNetworkConnect", androidJavaObject);
			}
		}
	}

	public void SocialNetworkPost(DevToDevSocialNetwork toDevSocialNetwork, DevToDevSocialNetworkPostReason reason)
	{
		using (AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.devtodev.core.data.consts.SocialNetwork"))
		{
			using (AndroidJavaObject androidJavaObject = androidJavaClass.CallStatic<AndroidJavaObject>("Custom", new object[1] { toDevSocialNetwork.ToString() }))
			{
				cls_jni.CallStatic("socialNetworkPost", androidJavaObject, reason.ToString());
			}
		}
	}

	public void InGamePurchase(string purchaseId, string purchaseType, int purchaseAmount, float purchasePrice, string purchaseCurrency)
	{
		cls_jni.CallStatic("inGamePurchase", purchaseId, purchaseType, purchaseAmount, purchasePrice, purchaseCurrency);
	}

	public void Age(int age)
	{
		cls_jni.CallStatic("age", age);
	}

	public void Cheater(bool isCheater)
	{
		cls_jni.CallStatic("cheater", isCheater);
	}

	public void Gender(DevToDevGender toDevGender)
	{
		AndroidJavaObject @static;
		switch (toDevGender)
		{
		case DevToDevGender.Female:
			@static = new AndroidJavaClass("com.devtodev.core.data.consts.Gender").GetStatic<AndroidJavaObject>("Female");
			break;
		case DevToDevGender.Male:
			@static = new AndroidJavaClass("com.devtodev.core.data.consts.Gender").GetStatic<AndroidJavaObject>("Male");
			break;
		default:
			@static = new AndroidJavaClass("com.devtodev.core.data.consts.Gender").GetStatic<AndroidJavaObject>("Unknown");
			break;
		}
		cls_jni.CallStatic("gender", @static);
		@static.Dispose();
	}

	public void Location(double latitude, double longitude)
	{
		cls_jni.CallStatic("location", latitude, longitude);
	}

	public void SetActiveLog(bool isActive)
	{
		AndroidJavaObject androidJavaObject = ((!isActive) ? new AndroidJavaClass("com.devtodev.core.utils.log.LogLevel").GetStatic<AndroidJavaObject>("No") : new AndroidJavaClass("com.devtodev.core.utils.log.LogLevel").GetStatic<AndroidJavaObject>("Assert"));
		cls_jni.CallStatic("setLogLevel", androidJavaObject);
		androidJavaObject.Dispose();
	}

	public void CustomEvent(string eventName)
	{
		cls_jni.CallStatic("customEvent", eventName);
	}

	public void CustomEvent(string eventName, DevToDevCustomEventParams eventParams)
	{
		cls_jni.CallStatic("customEvent", eventName, eventParams.JavaEventParams);
	}
}
