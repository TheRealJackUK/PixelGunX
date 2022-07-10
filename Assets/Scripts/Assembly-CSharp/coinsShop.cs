using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using Rilisoft;
using UnityEngine;

internal sealed class coinsShop : MonoBehaviour
{
	public static coinsShop thisScript;

	public static bool showPlashkuPriExit = false;

	public Action onReturnAction;

	public GameObject _purchaseActivityIndicator;

	private bool productPurchased;

	private float _timeWhenPurchShown;

	private List<string> currenciesBought = new List<string>();

	private bool productsReceived;

	public Action onResumeFronNGUI;

	private bool itemBought;

	private static readonly HashSet<string> _loggedPackages = new HashSet<string>();

	private static DateTime? _etcFileTimestamp;

	private Action _drawInnerInterface;

	public string notEnoughCurrency { get; set; }

	public bool ProductPurchasedRecently
	{
		get
		{
			return productPurchased;
		}
	}

	public static bool IsStoreAvailable
	{
		get
		{
			return !IsCheater && !IsNoConnection;
		}
	}

	public static bool IsCheater
	{
		get
		{
			return CheckAndroidHostsTampering() || CheckLuckyPatcherInstalled() || CheckIosCrackersInstalled() || HasTamperedProducts;
		}
	}

	internal static bool HasTamperedProducts { private get; set; }

	public static bool IsBillingSupported
	{
		get
		{
			if (!Application.isEditor)
			{
				return StoreKitEventListener.billingSupported;
			}
			return true;
		}
	}

	public static bool IsNoConnection
	{
		get
		{
			if (thisScript != null)
			{
				return (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon) ? (!thisScript.productsReceived) : (!thisScript.productsReceived || !IsBillingSupported);
			}
			return true;
		}
	}

	private void HandleQueryInventorySucceededEvent(List<GooglePurchase> purchases, List<GoogleSkuInfo> skus)
	{
		if (!skus.Any((GoogleSkuInfo s) => s.productId == "skinsmaker"))
		{
			string[] value = skus.Select((GoogleSkuInfo sku) => sku.productId).ToArray();
			string arg = string.Join(", ", value);
			string message = string.Format("Google: Query inventory succeeded;\tPurchases count: {0}, Skus: [{1}]", purchases.Count, arg);
			Debug.Log(message);
			productsReceived = true;
		}
	}

	private void HandleItemDataRequestFinishedEvent(List<string> unavailableSkus, List<AmazonItem> availableItems)
	{
		productsReceived = true;
	}

	private void OnEnable()
	{
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.purchaseSuccessfulEvent += HandlePurchaseSuccessfulEvent;
		}
		else
		{
			GoogleIABManager.purchaseSucceededEvent += HandlePurchaseSucceededEvent;
		}
		_purchaseActivityIndicator = StoreKitEventListener.purchaseActivityInd;
		if (_purchaseActivityIndicator == null)
		{
			Debug.LogWarning("_purchaseActivityIndicator == null");
		}
		else if (Application.loadedLevelName != "Loading")
		{
			_purchaseActivityIndicator.SetActive(false);
		}
		itemBought = false;
		currenciesBought.Clear();
	}

	private void OnDisable()
	{
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.purchaseSuccessfulEvent -= HandlePurchaseSuccessfulEvent;
		}
		else
		{
			GoogleIABManager.purchaseSucceededEvent -= HandlePurchaseSucceededEvent;
		}
		if (_purchaseActivityIndicator != null)
		{
			_purchaseActivityIndicator.SetActive(false);
		}
		itemBought = false;
		currenciesBought.Clear();
	}

	private void Update()
	{
		if (Time.realtimeSinceStartup - _timeWhenPurchShown >= 1.25f)
		{
			productPurchased = false;
		}
	}

	private void OnDestroy()
	{
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.itemDataRequestFinishedEvent -= HandleItemDataRequestFinishedEvent;
		}
		else
		{
			GoogleIABManager.queryInventorySucceededEvent -= HandleQueryInventorySucceededEvent;
		}
	}

	private void HandlePurchaseSuccessfullCore()
	{
		try
		{
			if (itemBought)
			{
				itemBought = false;
				productPurchased = true;
				_timeWhenPurchShown = Time.realtimeSinceStartup;
			}
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
	}

	private void HandlePurchaseSucceededEvent(GooglePurchase purchase)
	{
		HandlePurchaseSuccessfullCore();
	}

	private void HandlePurchaseSuccessfulEvent(AmazonReceipt receipt)
	{
		HandlePurchaseSuccessfullCore();
	}

	private void Awake()
	{
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		notEnoughCurrency = null;
		if (Application.isEditor)
		{
			productsReceived = true;
		}
		thisScript = base.gameObject.GetComponent<coinsShop>();
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.itemDataRequestFinishedEvent += HandleItemDataRequestFinishedEvent;
		}
		else
		{
			GoogleIABManager.queryInventorySucceededEvent += HandleQueryInventorySucceededEvent;
		}
		RefreshProductsIfNeed(false);
	}

	public void HandlePurchaseButton(int i, string currency = "Coins")
	{
		ButtonClickSound.Instance.PlayClick();
		if ((currency.Equals("Coins") && (i >= StoreKitEventListener.coinIds.Length || i >= VirtualCurrencyHelper.coinInappsQuantity.Length)) || (currency.Equals("GemsCurrency") && (i >= StoreKitEventListener.gemsIds.Length || i >= VirtualCurrencyHelper.gemsInappsQuantity.Length)))
		{
			Debug.LogWarning("Index of purchase is out of range: " + i);
			return;
		}
		currenciesBought.Add(currency);
		itemBought = true;
		StoreKitEventListener.purchaseInProcess = true;
		string sku;
		if ("Coins".Equals(currency))
		{
			sku = StoreKitEventListener.coinIds[i];
		}
		else
		{
			if (!"GemsCurrency".Equals(currency))
			{
				Debug.LogError("Unknown currency: " + currency);
				return;
			}
			sku = StoreKitEventListener.gemsIds[i];
		}
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAP.initiatePurchaseRequest(sku);
		}
		else
		{
			_etcFileTimestamp = GetHostsTimestamp();
			GoogleIAB.purchaseProduct(sku);
		}
	}

	public static void showCoinsShop()
	{
		thisScript.enabled = true;
		coinsPlashka.hideButtonCoins = true;
		coinsPlashka.showPlashka();
	}

	public static void hideCoinsShop()
	{
		if (thisScript != null)
		{
			thisScript.enabled = false;
			thisScript.notEnoughCurrency = null;
			Resources.UnloadUnusedAssets();
		}
	}

	public static void ExitFromShop(bool performOnExitActs)
	{
		hideCoinsShop();
		if (showPlashkuPriExit)
		{
			coinsPlashka.hidePlashka();
		}
		coinsPlashka.hideButtonCoins = false;
		if (performOnExitActs)
		{
			if (thisScript.onReturnAction != null && thisScript.notEnoughCurrency != null && thisScript.currenciesBought.Contains(thisScript.notEnoughCurrency))
			{
				thisScript.currenciesBought.Clear();
				thisScript.onReturnAction();
			}
			else
			{
				thisScript.onReturnAction = null;
			}
			if (thisScript.onResumeFronNGUI != null)
			{
				thisScript.onResumeFronNGUI();
				thisScript.onResumeFronNGUI = null;
				coinsPlashka.hidePlashka();
			}
		}
	}

	internal static bool CheckAndroidHostsTampering()
	{
		//Discarded unreachable code: IL_008d, IL_00a0
		if (BuildSettings.BuildTarget != BuildTarget.Android)
		{
			return false;
		}
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
		{
			if (!File.Exists("/etc/hosts"))
			{
				return false;
			}
			try
			{
				string[] source = File.ReadAllLines("/etc/hosts");
				IEnumerable<string> source2 = source.Where((string l) => l.TrimStart().StartsWith("127."));
				return source2.Any((string l) => l.Contains("android.clients.google.com") || l.Contains("mtalk.google.com "));
			}
			catch (Exception message)
			{
				Debug.LogError(message);
				return false;
			}
		}
		return false;
	}

	internal static bool CheckLuckyPatcherInstalled()
	{
		if (BuildSettings.BuildTarget != BuildTarget.Android)
		{
			return false;
		}
		string[] source = new string[3] { "Y29tLmRpbW9udmlkZW8ubHVja3lwYXRjaGVy", "Y29tLmNoZWxwdXMubGFja3lwYXRjaA==", "Y29tLmZvcnBkYS5scA==" };
		IEnumerable<string> source2 = from bytes in source.Select(Convert.FromBase64String)
			where bytes != null
			select Encoding.UTF8.GetString(bytes, 0, bytes.Length);
		return source2.Any(PackageExists);
	}

	private static bool PackageExists(string packageName)
	{
		//Discarded unreachable code: IL_00a9
		if (packageName == null)
		{
			throw new ArgumentNullException("packageName");
		}
		if (Application.isEditor)
		{
			return false;
		}
		try
		{
			AndroidJavaObject currentActivity = AndroidSystem.Instance.CurrentActivity;
			if (currentActivity == null)
			{
				Debug.LogWarning("activity == null");
				return false;
			}
			AndroidJavaObject androidJavaObject = currentActivity.Call<AndroidJavaObject>("getPackageManager", new object[0]);
			if (androidJavaObject == null)
			{
				Debug.LogWarning("manager == null");
				return false;
			}
			AndroidJavaObject androidJavaObject2 = androidJavaObject.Call<AndroidJavaObject>("getPackageInfo", new object[2] { packageName, 0 });
			if (androidJavaObject2 == null)
			{
				Debug.LogWarning("packageInfo == null");
				return false;
			}
			return true;
		}
		catch (Exception arg)
		{
			if (_loggedPackages.Contains(packageName))
			{
				return false;
			}
			string message = string.Format("Error while retrieving Android package info:    {0}", arg);
			if (Defs.IsDeveloperBuild)
			{
				Debug.LogWarning(message);
				_loggedPackages.Add(packageName);
			}
		}
		return false;
	}

	private static string ConvertFromBase64(string s)
	{
		byte[] array = Convert.FromBase64String(s);
		return Encoding.UTF8.GetString(array, 0, array.Length);
	}

	internal static bool CheckIosCrackersInstalled()
	{
		if (BuildSettings.BuildTarget != BuildTarget.iPhone)
		{
			return false;
		}
		string path = ConvertFromBase64("L0xpYnJhcnkvTW9iaWxlU3Vic3RyYXRlL0R5bmFtaWNMaWJyYXJpZXM=");
		if (File.Exists(Path.Combine(path, ConvertFromBase64("TG9jYWxJQVBTdG9yZS5keWxpYg=="))) || File.Exists(Path.Combine(path, ConvertFromBase64("TG9jYWxsQVBTdG9yZS5keWxpYg=="))))
		{
			Debug.LogWarning("Anti-cheat protection: LocalIAPStore detected.");
			return true;
		}
		if (File.Exists(Path.Combine(path, ConvertFromBase64("aWFwLmR5bGli"))))
		{
			Debug.LogWarning("Anti-cheat protection: IAP Cracker detected.");
			return true;
		}
		if (File.Exists(Path.Combine(path, ConvertFromBase64("aWFwZnJlZS5jb3JlLmR5bGli"))) || File.Exists(Path.Combine(path, ConvertFromBase64("SUFQRnJlZVNlcnZpY2UuZHlsaWI="))))
		{
			Debug.LogWarning("Anti-cheat protection: IAP Free detected.");
			return true;
		}
		return false;
	}

	private static DateTime? GetHostsTimestamp()
	{
		//Discarded unreachable code: IL_0043, IL_005f
		try
		{
			Debug.Log("Trying to get /ets/hosts timestamp...");
			FileInfo fileInfo = new FileInfo("/etc/hosts");
			DateTime lastWriteTimeUtc = fileInfo.LastWriteTimeUtc;
			Debug.Log("/ets/hosts timestamp: " + lastWriteTimeUtc.ToString("s"));
			return lastWriteTimeUtc;
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
			return null;
		}
	}

	internal static bool CheckHostsTimestamp()
	{
		if (_etcFileTimestamp.HasValue)
		{
			DateTime? hostsTimestamp = GetHostsTimestamp();
			if (hostsTimestamp.HasValue && _etcFileTimestamp.Value != hostsTimestamp.Value)
			{
				Debug.LogError(string.Format("Timestamp check failed: {0:s} expcted, but actual value is {1:s}.", _etcFileTimestamp.Value, hostsTimestamp.Value));
				return false;
			}
		}
		return true;
	}

	public void RefreshProductsIfNeed(bool force = false)
	{
		if (!productsReceived || force)
		{
			StoreKitEventListener.RefreshProducts();
		}
	}

	private void OnApplicationPause(bool pause)
	{
		if (!pause)
		{
			RefreshProductsIfNeed(false);
		}
	}
}
