using UnityEngine;

public class GoogleIAB
{
	private static AndroidJavaObject _plugin;

	static GoogleIAB()
	{
		return;
	}

	public static void enableLogging(bool shouldEnable)
	{
		if (false)
		{
			if (shouldEnable)
			{
				Debug.LogWarning("YOU HAVE ENABLED HIGH DETAIL LOGS. DO NOT DISTRIBUTE THE GENERATED APK PUBLICLY. IT WILL DUMP SENSITIVE INFORMATION TO THE CONSOLE!");
			}
			_plugin.Call("enableLogging", shouldEnable);
		}
	}

	public static void setAutoVerifySignatures(bool shouldVerify)
	{
		if (false)
		{
			_plugin.Call("setAutoVerifySignatures", shouldVerify);
		}
	}

	public static void init(string publicKey)
	{
		if (false)
		{
			_plugin.Call("init", publicKey);
		}
	}

	public static void unbindService()
	{
		if (false)
		{
			_plugin.Call("unbindService");
		}
	}

	public static bool areSubscriptionsSupported()
	{
		if (Application.platform != RuntimePlatform.Android)
		{
			return false;
		}
		return _plugin.Call<bool>("areSubscriptionsSupported", new object[0]);
	}

	public static void queryInventory(string[] skus)
	{
		if (false)
		{
			_plugin.Call("queryInventory", new object[1] { skus });
		}
	}

	public static void purchaseProduct(string sku)
	{
		purchaseProduct(sku, string.Empty);
	}

	public static void purchaseProduct(string sku, string developerPayload)
	{
		if (false)
		{
			_plugin.Call("purchaseProduct", sku, developerPayload);
		}
	}

	public static void consumeProduct(string sku)
	{
		if (false)
		{
			_plugin.Call("consumeProduct", sku);
		}
	}

	public static void consumeProducts(string[] skus)
	{
		if (false)
		{
			_plugin.Call("consumeProducts", new object[1] { skus });
		}
	}
}
