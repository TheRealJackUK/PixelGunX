public static class DevToDevSDK
{
	public static string UserUdid
	{
		get
		{
			return DevToDevAndroidCient.Instance.UserUdid;
		}
		set
		{
			DevToDevAndroidCient.Instance.UserUdid = value;
		}
	}

	public static string OpenUdid
	{
		get
		{
			return DevToDevAndroidCient.Instance.OpenUdid;
		}
	}

	public static string Odin1
	{
		get
		{
			return DevToDevAndroidCient.Instance.Odin1;
		}
	}

	public static void Initialize(string appKey, string appSecret)
	{
		DevToDevAndroidCient.Instance.Initialize(appKey, appSecret);
	}

	public static void StartSession()
	{
		DevToDevAndroidCient.Instance.StartSession();
	}

	public static void EndSession()
	{
		DevToDevAndroidCient.Instance.EndSession();
	}

	public static void InGamePurchase(string purchaseId, string purchaseType, int purchaseAmount, float purchasePrice, string purchaseCurrency)
	{
		DevToDevAndroidCient.Instance.InGamePurchase(purchaseId, purchaseType, purchaseAmount, purchasePrice, purchaseCurrency);
	}

	public static void Tutorial(DevToDevTutorial state)
	{
		DevToDevAndroidCient.Instance.Tutorial(state);
	}

	public static void Level(int newLevel)
	{
		DevToDevAndroidCient.Instance.Level(newLevel);
	}

	public static void RealPayment(string transactionId, float inAppPrice, string inAppName, string inAppCurrencyISOCode)
	{
		DevToDevAndroidCient.Instance.RealPayment(transactionId, inAppPrice, inAppName, inAppCurrencyISOCode);
	}

	public static void SocialNetworkConnect(DevToDevSocialNetwork network)
	{
		DevToDevAndroidCient.Instance.SocialNetworkConnect(network);
	}

	public static void SocialNetworkPost(DevToDevSocialNetwork network, DevToDevSocialNetworkPostReason reason)
	{
		DevToDevAndroidCient.Instance.SocialNetworkPost(network, reason);
	}

	public static void Age(int age)
	{
		DevToDevAndroidCient.Instance.Age(age);
	}

	public static void Gender(DevToDevGender toDevGender)
	{
		DevToDevAndroidCient.Instance.Gender(toDevGender);
	}

	public static void Cheater(bool isCheater)
	{
		DevToDevAndroidCient.Instance.Cheater(isCheater);
	}

	public static void Location(double latitude, double longitude)
	{
		DevToDevAndroidCient.Instance.Location(latitude, longitude);
	}

	public static void CustomEvent(string eventName)
	{
		DevToDevAndroidCient.Instance.CustomEvent(eventName);
	}

	public static void CustomEvent(string eventName, DevToDevCustomEventParams eventParams)
	{
		DevToDevAndroidCient.Instance.CustomEvent(eventName, eventParams);
	}

	public static void SetActiveLog(bool isEnabled)
	{
		DevToDevAndroidCient.Instance.SetActiveLog(isEnabled);
	}
}
