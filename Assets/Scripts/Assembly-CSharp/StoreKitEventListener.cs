using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

public sealed class StoreKitEventListener : MonoBehaviour
{
	internal sealed class StoreKitEventListenerState
	{
		public string Mode { get; set; }

		public string PurchaseKey { get; set; }

		public IDictionary<string, string> Parameters { get; private set; }

		public StoreKitEventListenerState()
		{
			Mode = string.Empty;
			PurchaseKey = string.Empty;
			Parameters = new Dictionary<string, string>();
		}
	}

	public const string coin1 = "coin1";

	public const string coin2 = "coin2";

	public const string coin3 = "coin3.";

	public const string coin4 = "coin4";

	public const string coin5 = "coin5";

	public const string coin7 = "coin7";

	public const string coin8 = "coin8";

	private const int ConsumeFailureCountMax = 3;

	public const string bigAmmoPackID = "bigammopack";

	public const string crystalswordID = "crystalsword";

	public const string fullHealthID = "Fullhealth";

	public const string minerWeaponID = "MinerWeapon";

	[NonSerialized]
	internal readonly ICollection<IMarketProduct> _products = new List<IMarketProduct>();

	[NonSerialized]
	public readonly ICollection<GoogleSkuInfo> _skinProducts = new GoogleSkuInfo[0];

	[NonSerialized]
	public static bool billingSupported;

	[NonSerialized]
	public static readonly string[] coinIds;

	private static string[] _productIds;

	private HashSet<string> _productsToConsume = new HashSet<string>();

	private IDisposable _purchaseFailedSubscription = new ActionDisposable(null);

	private static string gem1;

	private static string gem2;

	private static string gem3;

	private static string gem4;

	private static string gem5;

	private static string gem6;

	private static string gem7;

	private static string starterPack2;

	private static string starterPack4;

	private static string starterPack6;

	private static string starterPack3;

	private static string starterPack5;

	private static string starterPack7;

	private static string starterPack8;

	public static readonly string[] gemsIds;

	public static readonly string[] starterPackIds;

	public static string elixirSettName;

	public static bool purchaseInProcess;

	public static bool restoreInProcess;

	public static GameObject purchaseActivityInd;

	public static string elixirID;

	public static string endmanskin;

	public static string chief;

	public static string spaceengineer;

	public static string nanosoldier;

	public static string steelman;

	public static string CaptainSkin;

	public static string HawkSkin;

	public static string GreenGuySkin;

	public static string TunderGodSkin;

	public static string GordonSkin;

	public static string animeGirl;

	public static string EMOGirl;

	public static string Nurse;

	public static string magicGirl;

	public static string braveGirl;

	public static string glamDoll;

	public static string kittyGirl;

	public static string famosBoy;

	public static string skin810_1;

	public static string skin810_2;

	public static string skin810_3;

	public static string skin810_4;

	public static string skin810_5;

	public static string skin810_6;

	public static string skin931_1;

	public static string skin931_2;

	public static string skin931_3;

	public static string fullVersion;

	public static string armor;

	public static string armor2;

	public static string armor3;

	public static readonly string[] skinIDs;

	public static readonly string[] idsForSingle;

	public static readonly string[] idsForMulti;

	public static readonly string[] idsForFull;

	public static readonly string[][] categoriesSingle;

	public static readonly string[][] categoriesMulti;

	public GameObject messagePrefab;

	public static string[] categoryNames;

	public AudioClip onEarnCoinsSound;

	public AudioClip onEarnGemsSound;

	[NonSerialized]
	public static List<string> buyStarterPack;

	private static readonly StoreKitEventListenerState _state;

	internal ICollection<IMarketProduct> Products
	{
		get
		{
			return _products;
		}
	}

	private static string starterPack1
	{
		get
		{
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
			{
				return "starterpack1andr";
			}
			return "starterpack1";
		}
	}

	internal static StoreKitEventListenerState State
	{
		get
		{
			return _state;
		}
	}

	static StoreKitEventListener()
	{
		gem1 = "gem1";
		gem2 = "gem2";
		gem3 = "gem3";
		gem4 = "gem4";
		gem5 = "gem5";
		gem6 = "gem6";
		gem7 = "gem7";
		starterPack2 = "starterpack2";
		starterPack4 = "starterpack4";
		starterPack6 = "starterpack6";
		starterPack3 = "starterpack3";
		starterPack5 = "starterpack5";
		starterPack7 = "starterpack7";
		starterPack8 = "starterpack8";
		gemsIds = new string[7] { gem1, gem2, gem3, gem4, gem5, gem6, gem7 };
		starterPackIds = new string[8] { starterPack1, starterPack2, starterPack3, starterPack4, starterPack5, starterPack6, starterPack7, starterPack8 };
		elixirSettName = Defs.NumberOfElixirsSett;
		purchaseInProcess = false;
		restoreInProcess = false;
		elixirID = ((!GlobalGameController.isFullVersion) ? "elixirlite" : "elixir");
		endmanskin = ((!GlobalGameController.isFullVersion) ? "endmanskinlite" : "endmanskin");
		chief = ((!GlobalGameController.isFullVersion) ? "chiefskinlite" : "chief");
		spaceengineer = ((!GlobalGameController.isFullVersion) ? "spaceengineerskinlite" : "spaceengineer");
		nanosoldier = ((!GlobalGameController.isFullVersion) ? "nanosoldierlite" : "nanosoldier");
		steelman = ((!GlobalGameController.isFullVersion) ? "steelmanlite" : "steelman");
		CaptainSkin = "captainskin";
		HawkSkin = "hawkskin";
		GreenGuySkin = "greenguyskin";
		TunderGodSkin = "thundergodskin";
		GordonSkin = "gordonskin";
		animeGirl = "animeGirl";
		EMOGirl = "EMOGirl";
		Nurse = "Nurse";
		magicGirl = "magicGirl";
		braveGirl = "braveGirl";
		glamDoll = "glamDoll";
		kittyGirl = "kittyGirl";
		famosBoy = "famosBoy";
		skin810_1 = "skin810_1";
		skin810_2 = "skin810_2";
		skin810_3 = "skin810_3";
		skin810_4 = "skin810_4";
		skin810_5 = "skin810_5";
		skin810_6 = "skin810_6";
		skin931_1 = "skin931_1";
		skin931_2 = "skin931_2";
		skin931_3 = "skin931_3";
		fullVersion = "extendedversion";
		armor = "armor";
		armor2 = "armor2";
		armor3 = "armor3";
		categoryNames = new string[5] { "Armory", "Guns", "Melee", "Special", "Gear" };
		buyStarterPack = new List<string>();
		_state = new StoreKitEventListenerState();
		billingSupported = false;
		coinIds = new string[8] { "coin1", "coin7", "coin2", "coin3.", "coin4", "coin5", "coin8", "coin9" };
		_productIds = new string[5] { "bigammopack", "Fullhealth", "crystalsword", "MinerWeapon", elixirID };
		skinIDs = new string[18]
		{
			endmanskin, chief, spaceengineer, nanosoldier, steelman, CaptainSkin, HawkSkin, GreenGuySkin, TunderGodSkin, GordonSkin,
			animeGirl, EMOGirl, Nurse, magicGirl, braveGirl, glamDoll, kittyGirl, famosBoy
		};
		List<string> list = new List<string>();
		string[] array = skinIDs;
		foreach (string item in array)
		{
			list.Add(item);
		}
		int j;
		for (j = 0; j < 11; j++)
		{
			list.Add("newskin_" + j);
		}
		for (; j < 19; j++)
		{
			list.Add("newskin_" + j);
		}
		list.Add(skin810_1);
		list.Add(skin810_2);
		list.Add(skin810_3);
		list.Add(skin810_4);
		list.Add(skin810_5);
		list.Add(skin810_6);
		list.Add(skin931_1);
		list.Add(skin931_2);
		list.Add(skin931_3);
		skinIDs = list.ToArray();
		idsForSingle = new string[11]
		{
			"bigammopack", "Fullhealth", "ironSword", "MinerWeapon", "steelAxe", "spas", elixirID, "glock", "chainsaw", "scythe",
			"shovel"
		};
		idsForMulti = new string[10]
		{
			idsForSingle[2],
			idsForSingle[3],
			"steelAxe",
			"woodenBow",
			"combatrifle",
			"spas",
			"goldeneagle",
			idsForSingle[7],
			idsForSingle[8],
			"famas"
		};
		idsForFull = new string[1] { fullVersion };
		categoriesMulti = new string[2][]
		{
			new string[5]
			{
				idsForSingle[0],
				idsForSingle[1],
				armor,
				armor2,
				armor3
			},
			PotionsController.potions
		};
		categoriesSingle = categoriesMulti;
	}

	private void Start()
	{
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			if (Application.isEditor && !_products.Any())
			{
				Dictionary<string, string> dictionary = new Dictionary<string, string>();
				dictionary.Add("description", "Test coin product for editor in Amazon edition");
				dictionary.Add("type", "Not defined");
				dictionary.Add("price", "33\u00a0руб.");
				dictionary.Add("sku", "coin1");
				dictionary.Add("smallIconUrl", "http://example.com");
				dictionary.Add("title", "Small pack of coins");
				Dictionary<string, string> d = dictionary;
				_products.Add(new AmazonMarketProduct(new AmazonItem(new Hashtable(d))));
				dictionary = new Dictionary<string, string>();
				dictionary.Add("description", "Test gem product for editor in Amazon edition");
				dictionary.Add("type", "Not defined");
				dictionary.Add("price", "99\u00a0руб.");
				dictionary.Add("sku", "gem7");
				dictionary.Add("smallIconUrl", "http://example.com");
				dictionary.Add("title", "Small pack of gems");
				Dictionary<string, string> d2 = dictionary;
				_products.Add(new AmazonMarketProduct(new AmazonItem(new Hashtable(d2))));
				dictionary = new Dictionary<string, string>();
				dictionary.Add("description", "Test starter pack product for editor in Amazon edition");
				dictionary.Add("type", "Not defined");
				dictionary.Add("price", "33 руб.");
				dictionary.Add("sku", starterPack1);
				dictionary.Add("smallIconUrl", "http://example.com");
				dictionary.Add("title", "First starter pack(amazon)");
				Dictionary<string, string> d3 = dictionary;
				_products.Add(new AmazonMarketProduct(new AmazonItem(new Hashtable(d3))));
			}
			else
			{
				string[] items = coinIds.Concat(gemsIds).ToArray();
				AmazonIAP.initiateItemDataRequest(items);
			}
		}
		else if (Application.isEditor)
		{
			Dictionary<string, object> dictionary2 = new Dictionary<string, object>();
			dictionary2.Add("description", "Test coin product for editor in Google edition");
			dictionary2.Add("type", "Not defined");
			dictionary2.Add("price", "99\u00a0руб.");
			dictionary2.Add("productId", "coin7");
			dictionary2.Add("title", "Average pack of coins");
			Dictionary<string, object> dict = dictionary2;
			_products.Add(new GoogleMarketProduct(new GoogleSkuInfo(dict)));
			dictionary2 = new Dictionary<string, object>();
			dictionary2.Add("description", "Test gem product for editor in Google edition");
			dictionary2.Add("type", "Not defined");
			dictionary2.Add("price", "33\u00a0руб.");
			dictionary2.Add("productId", "gem1");
			dictionary2.Add("title", "Average pack of gems");
			Dictionary<string, object> dict2 = dictionary2;
			_products.Add(new GoogleMarketProduct(new GoogleSkuInfo(dict2)));
			dictionary2 = new Dictionary<string, object>();
			dictionary2.Add("description", "Test starter pack product for editor in Google edition");
			dictionary2.Add("type", "Not defined");
			dictionary2.Add("price", "33 руб.");
			dictionary2.Add("productId", starterPack1);
			dictionary2.Add("title", "First starter pack(android)");
			Dictionary<string, object> dict3 = dictionary2;
			_products.Add(new GoogleMarketProduct(new GoogleSkuInfo(dict3)));
		}
		else
		{
			string publicKey = ((Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro) ? "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA36U+uKQAwvf9Rwntheiv1rnqKHUSwNzDv3RNyN/Ya33dARVYLRUY4ZSicC4GPnF0Z7EmE0uqh3TMBWJVpdhwH1LNLVijn12uXALUOp7vqgMSoRBVPSuA+2hmRzgqtSQgthMHLmIjxGgcOEhE95mgczGZvd9an9dXOeQ//bDlHBwNy81TiZA+6Gm6IxXJeaMQpPW7H7gvX7h07bNoLouOsTf1ZExS1r+QX6N3G52Wctfvkz+1QKtVuoyAWs9sfD0UXBKw3nfAlvjDQNte8DUa/ofGBVysz5RxhZcKP6fOmyxNLeDIpplbBJn1FdrmY7Eys9sK8mzS1CXKocWT25uD7QIDAQAB" : ((Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GoogleLite) ? string.Empty : "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoTzMTaqsFhaywvCFKawFwL5KM+djLJfOCT/rbGQRfHmHYmOY2sBMgDWsA/67Szx6EVTZPVlFzHMgkAq1TwdL/A5aYGpGzaCX7o96cyp8R6wSF+xCuj++LAkTaDnLW0veI2bke3EVHu3At9xgM46e+VDucRUqQLvf6SQRb15nuflY5i08xKnewgX7I4U2H0RvAZDyoip+qZPmI4ZvaufAfc0jwZbw7XGiV41zibY3LU0N57mYKk51Wx+tOaJ7Tkc9Rl1qVCTjb+bwXshTqhVXVP6r4kabLWw/8OJUh0Sm69lbps6amP7vPy571XjscCTMLfXQan1959rHbNgkb2mLLQIDAQAB"));
			GoogleIAB.init(publicKey);
			GoogleIAB.setAutoVerifySignatures(false);
			if (Defs.IsDeveloperBuild)
			{
				GoogleIAB.enableLogging(true);
			}
		}
	}

	private void OnEnable()
	{
		_purchaseFailedSubscription.Dispose();
		Action<string> purchaseFailedHandler = delegate(string error)
		{
			purchaseInProcess = false;
			Debug.LogWarning("purchaseFailedHandler: " + error);
		};
		Action<string, int> googlePurchaseFailedHandler = delegate(string error, int response)
		{
			purchaseInProcess = false;
			Debug.LogWarning(string.Format("googlePurchaseFailedHandler({0}): {1}", response, error));
		};
		_purchaseFailedSubscription = new ActionDisposable(delegate
		{
			AmazonIAPManager.purchaseFailedEvent -= purchaseFailedHandler;
			GoogleIABManager.purchaseFailedEvent -= googlePurchaseFailedHandler;
		});
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.onSdkAvailableEvent += HandleAmazonSdkAvailableEvent;
			AmazonIAPManager.onGetUserIdResponseEvent += HandleGetUserIdResponseEvent;
			AmazonIAPManager.itemDataRequestFinishedEvent += HandleItemDataRequestFinishedEvent;
			AmazonIAPManager.itemDataRequestFailedEvent += HandleItemDataRequestFailedEvent;
			AmazonIAPManager.purchaseSuccessfulEvent += HandlePurchaseSuccessfulEvent;
			AmazonIAPManager.purchaseFailedEvent += purchaseFailedHandler;
			AmazonIAPManager.purchaseUpdatesRequestSuccessfulEvent += HandlePurchaseUpdatesRequestSuccessfulEvent;
			AmazonIAPManager.purchaseUpdatesRequestFailedEvent += HandlePurchaseUpdatesRequestFailedEvent;
		}
		else
		{
			GoogleIABManager.billingSupportedEvent += billingSupportedEvent;
			GoogleIABManager.billingNotSupportedEvent += billingNotSupportedEvent;
			GoogleIABManager.queryInventorySucceededEvent += queryInventorySucceededEvent;
			GoogleIABManager.queryInventoryFailedEvent += queryInventoryFailedEvent;
			GoogleIABManager.purchaseCompleteAwaitingVerificationEvent += purchaseCompleteAwaitingVerificationEvent;
			GoogleIABManager.purchaseSucceededEvent += HandleGooglePurchaseSucceeded;
			GoogleIABManager.purchaseFailedEvent += googlePurchaseFailedHandler;
			GoogleIABManager.consumePurchaseSucceededEvent += consumePurchaseSucceededEvent;
			GoogleIABManager.consumePurchaseFailedEvent += consumePurchaseFailedEvent;
		}
	}

	private void OnDisable()
	{
		_purchaseFailedSubscription.Dispose();
		if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			AmazonIAPManager.onSdkAvailableEvent -= HandleAmazonSdkAvailableEvent;
			AmazonIAPManager.onGetUserIdResponseEvent -= HandleGetUserIdResponseEvent;
			AmazonIAPManager.itemDataRequestFinishedEvent -= HandleItemDataRequestFinishedEvent;
			AmazonIAPManager.itemDataRequestFailedEvent -= HandleItemDataRequestFailedEvent;
			AmazonIAPManager.purchaseSuccessfulEvent -= HandlePurchaseSuccessfulEvent;
			AmazonIAPManager.purchaseUpdatesRequestSuccessfulEvent -= HandlePurchaseUpdatesRequestSuccessfulEvent;
			AmazonIAPManager.purchaseUpdatesRequestFailedEvent -= HandlePurchaseUpdatesRequestFailedEvent;
		}
		else
		{
			GoogleIABManager.billingSupportedEvent -= billingSupportedEvent;
			GoogleIABManager.billingNotSupportedEvent -= billingNotSupportedEvent;
			GoogleIABManager.queryInventorySucceededEvent -= queryInventorySucceededEvent;
			GoogleIABManager.queryInventoryFailedEvent -= queryInventoryFailedEvent;
			GoogleIABManager.purchaseCompleteAwaitingVerificationEvent -= purchaseCompleteAwaitingVerificationEvent;
			GoogleIABManager.purchaseSucceededEvent -= HandleGooglePurchaseSucceeded;
			GoogleIABManager.consumePurchaseSucceededEvent -= consumePurchaseSucceededEvent;
			GoogleIABManager.consumePurchaseFailedEvent -= consumePurchaseFailedEvent;
		}
	}

	private void billingSupportedEvent()
	{
		billingSupported = true;
		Debug.Log("billingSupportedEvent");
		RefreshProducts();
	}

	public static void RefreshProducts()
	{
		if (billingSupported || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			string[] array = _productIds.Concat(coinIds).Concat(gemsIds).Concat(starterPackIds)
				.ToArray();
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AmazonIAP.initiateItemDataRequest(array);
			}
			else
			{
				GoogleIAB.queryInventory(array);
			}
		}
	}

	private void billingNotSupportedEvent(string error)
	{
		billingSupported = false;
		Debug.LogWarning("billingNotSupportedEvent: " + error);
	}

	private void HandleAmazonSdkAvailableEvent(bool isSandboxMode)
	{
		Debug.Log("Amazon SDK available in sandbox mode: " + isSandboxMode);
		AmazonIAPManager.onSdkAvailableEvent -= HandleAmazonSdkAvailableEvent;
		billingSupported = true;
		RefreshProducts();
	}

	private void HandleGetUserIdResponseEvent(string id)
	{
	}

	private void queryInventorySucceededEvent(List<GooglePurchase> purchases, List<GoogleSkuInfo> skus)
	{
		_products.Clear();
		_productsToConsume.Clear();
		try
		{
			if (skus.Any((GoogleSkuInfo s) => s.productId == "skinsmaker"))
			{
				return;
			}
			string[] productIds = skus.Select((GoogleSkuInfo sku) => sku.productId).ToArray();
			string arg = string.Join(", ", productIds);
			string[] value = purchases.Select((GooglePurchase p) => string.Format("<{0}, {1}>", p.productId, p.purchaseState)).ToArray();
			string arg2 = string.Join(", ", value);
			string message = string.Format("Google billing. Query inventory succeeded, purchases: [{0}], skus: [{1}]", arg2, arg);
			Debug.Log(message);
			IEnumerable<GoogleSkuInfo> enumerable = skus.Where((GoogleSkuInfo s) => coinIds.Contains(s.productId) || gemsIds.Contains(s.productId));
			IEnumerable<GoogleMarketProduct> enumerable2 = skus.Where((GoogleSkuInfo s) => productIds.Contains(s.productId)).Select(MarketProductFactory.CreateGoogleMarketProduct);
			foreach (GoogleMarketProduct item in enumerable2)
			{
				if (item.Price.Contains("$0.0"))
				{
					Debug.LogWarning(string.Format("Unexpected price “{0}”: “{1}” “{2}”", item.Price, item.Id, item.Title));
					coinsShop.HasTamperedProducts = true;
				}
				if (!_products.Contains(item))
				{
					_products.Add(item);
				}
			}
			foreach (GooglePurchase purchase in purchases)
			{
				if (purchase.productId == "MinerWeapon" || purchase.productId == "MinerWeapon".ToLower())
				{
					GameObject gameObject = GameObject.FindGameObjectWithTag("WeaponManager");
					if ((bool)gameObject)
					{
						gameObject.SendMessage("AddMinerWeaponToInventoryAndSaveInApp");
					}
				}
				else if (purchase.productId == "crystalsword")
				{
					GameObject gameObject2 = GameObject.FindGameObjectWithTag("WeaponManager");
					if ((bool)gameObject2)
					{
						gameObject2.SendMessage("AddSwordToInventoryAndSaveInApp");
					}
				}
				else if (starterPackIds.Contains(purchase.productId))
				{
					StarterPackController.Get.AddBuyAndroidStarterPack(purchase.productId);
					StarterPackController.Get.TryRestoreStarterPack(purchase.productId);
				}
				else
				{
					_productsToConsume.Add(purchase.productId);
				}
			}
			string text = _productsToConsume.FirstOrDefault(TryAddVirtualCrrency);
			if (!string.IsNullOrEmpty(text))
			{
				Debug.Log("StoreKitEventListener.queryInventorySucceededEvent(): Consuming Goole product " + text);
				GoogleIAB.consumeProduct(text);
			}
		}
		finally
		{
			purchaseInProcess = false;
			restoreInProcess = false;
		}
	}

	private void queryInventoryFailedEvent(string error)
	{
		Debug.LogWarning("Google: queryInventoryFailedEvent: " + error);
		StartCoroutine(WaitAndQueryInventory());
	}

	private IEnumerator WaitAndQueryInventory()
	{
		Debug.LogWarning(string.Format("Waiting {0}s before requering inventory...", 10f));
		yield return new WaitForSeconds(10f);
		Debug.LogWarning(string.Format("Trying to repeat query inventory..."));
		string[] products = _productIds.Concat(coinIds).Concat(gemsIds).Concat(starterPackIds)
			.ToArray();
		GoogleIAB.queryInventory(products);
	}

	private void HandleItemDataRequestFinishedEvent(List<string> unavailableSkus, List<AmazonItem> availableItems)
	{
		_products.Clear();
		try
		{
			string[] value = availableItems.Select((AmazonItem item) => item.sku).ToArray();
			string arg = string.Join(", ", value);
			string arg2 = string.Join(", ", unavailableSkus.ToArray());
			string message = string.Format("Item data request finished;    Unavailable skus: [{0}], Available skus: [{1}]", arg2, arg);
			Debug.Log(message);
			IEnumerable<AmazonItem> enumerable = availableItems.Where((AmazonItem item) => coinIds.Contains(item.sku) || gemsIds.Contains(item.sku));
			IEnumerable<AmazonMarketProduct> enumerable2 = availableItems.Select(MarketProductFactory.CreateAmazonMarketProduct);
			foreach (AmazonMarketProduct item in enumerable2)
			{
				if (!_products.Contains(item))
				{
					_products.Add(item);
				}
			}
		}
		finally
		{
			purchaseInProcess = false;
			restoreInProcess = false;
		}
	}

	private void HandleItemDataRequestFailedEvent()
	{
		Debug.LogWarning("Amamzon: Item data request failed.");
	}

	private void purchaseCompleteAwaitingVerificationEvent(string purchaseData, string signature)
	{
		Debug.Log("purchaseCompleteAwaitingVerificationEvent. purchaseData: " + purchaseData + ", signature: " + signature);
	}

	private bool TryAddVirtualCrrency(string productId)
	{
		return true;
	}

	private bool TryAddStarterPackItem(string productId)
	{
		if (starterPackIds.Contains(productId))
		{
			bool flag = StarterPackController.Get.TryTakePurchasesForCurrentPack(productId);
			if (flag)
			{
				FlurryEvents.PaymentTime = Time.realtimeSinceStartup;
				SetLastPaymentTime();
				CheckIfFirstTimePayment();
			}
			FriendsController.sharedController.SendOurData(false);
			return flag;
		}
		return false;
	}

	private void HandleGooglePurchaseSucceeded(GooglePurchase purchase)
	{
		Debug.Log("HandleGooglePurchaseSucceeded: " + purchase);
		if (coinsShop.IsCheater)
		{
			Debug.LogError("Cheating attempt.");
			return;
		}
		if (!coinsShop.CheckHostsTimestamp())
		{
			Debug.LogError("Hosts tampering attempt.");
			return;
		}
		try
		{
			if (TryAddVirtualCrrency(purchase.productId))
			{
				Debug.Log("StoreKitEventListener.HandleGooglePurchaseSucceeded(): Consuming Goole product " + purchase.productId);
				GoogleIAB.consumeProduct(purchase.productId);
			}
			TryAddStarterPackItem(purchase.productId);
		}
		finally
		{
			purchaseInProcess = false;
			restoreInProcess = false;
		}
	}

	private void HandlePurchaseSuccessfulEvent(AmazonReceipt receipt)
	{
		Debug.Log("Amazon: purchaseSuccessfulEvent: " + receipt);
		try
		{
			int num = Array.IndexOf(coinIds, receipt.sku);
			if (num >= coinIds.GetLowerBound(0))
			{
				int num2 = Mathf.RoundToInt((float)VirtualCurrencyHelper.GetCoinInappsQuantity(num) * PremiumAccountController.VirtualCurrencyMultiplier);
				string message = string.Format("Process purchase {0}, VirtualCurrencyHelper.GetCoinInappsQuantity({1})", receipt.sku, num);
				Debug.Log(message);
				int val = Storager.getInt("Coins", false) + num2;
				Storager.setInt("Coins", val, false);
				ChestBonusController.TryTakeChestBonus(false, num);
				FlurryEvents.PaymentTime = Time.realtimeSinceStartup;
				SetLastPaymentTime();
				LogVirtualCurrencyPurchased(receipt.sku, num2, false);
				CheckIfFirstTimePayment();
			}
			num = Array.IndexOf(gemsIds, receipt.sku);
			if (num >= gemsIds.GetLowerBound(0))
			{
				int num3 = Mathf.RoundToInt((float)VirtualCurrencyHelper.GetGemsInappsQuantity(num) * PremiumAccountController.VirtualCurrencyMultiplier);
				string message2 = string.Format("Process purchase {0}, VirtualCurrencyHelper.GetGemsInappsQuantity({1})", receipt.sku, num);
				Debug.Log(message2);
				int val2 = Storager.getInt("GemsCurrency", false) + num3;
				Storager.setInt("GemsCurrency", val2, false);
				ChestBonusController.TryTakeChestBonus(true, num);
				FlurryEvents.PaymentTime = Time.realtimeSinceStartup;
				SetLastPaymentTime();
				LogVirtualCurrencyPurchased(receipt.sku, num3, true);
				CheckIfFirstTimePayment();
			}
			if (TryAddStarterPackItem(receipt.sku))
			{
				string message3 = string.Format("Process purchase {0}. Starter pack.", receipt.sku, num);
				Debug.Log(message3);
			}
			FriendsController.sharedController.SendOurData(false);
		}
		finally
		{
			purchaseInProcess = false;
			restoreInProcess = false;
		}
	}

	private void consumePurchaseSucceededEvent(GooglePurchase purchase)
	{
		Debug.Log("consumePurchaseSucceededEvent: " + purchase);
		_productsToConsume.Remove(purchase.productId);
		string text = _productsToConsume.FirstOrDefault(TryAddVirtualCrrency);
		if (!string.IsNullOrEmpty(text))
		{
			Debug.Log("StoreKitEventListener.consumePurchaseSucceededEvent(): Consuming Goole product " + text);
			GoogleIAB.consumeProduct(text);
		}
	}

	private void consumePurchaseFailedEvent(string error)
	{
		Debug.LogWarning("consumePurchaseFailedEvent: " + error);
	}

	private void HandlePurchaseUpdatesRequestSuccessfulEvent(List<string> revokedSkus, List<AmazonReceipt> receipts)
	{
		for (int i = 0; i < receipts.Count; i++)
		{
			if (starterPackIds.Contains(receipts[i].sku))
			{
				StarterPackController.Get.AddBuyAndroidStarterPack(receipts[i].sku);
				StarterPackController.Get.TryRestoreStarterPack(receipts[i].sku);
			}
		}
	}

	private void HandlePurchaseUpdatesRequestFailedEvent()
	{
		Debug.LogWarning("Amazon: Purchase updates request failed.");
	}

	public void ProvideContent()
	{
	}

	internal static void CheckIfFirstTimePayment()
	{
		if (!Storager.hasKey("PayingUser") || Storager.getInt("PayingUser", true) != 1)
		{
			Storager.setInt("PayingUser", 1, true);
			FlurryPluginWrapper.LogEvent("USER FirstTimePayment");
		}
	}

	public static int GetDollarsSpent()
	{
		return PlayerPrefs.GetInt("ALLCoins", 0) + PlayerPrefs.GetInt("ALLGems", 0);
	}

	internal static void SetLastPaymentTime()
	{
		string value = DateTime.UtcNow.ToString("s");
		PlayerPrefs.SetString("Last Payment Time", value);
		PlayerPrefs.SetString("Last Payment Time (Advertisement)", value);
	}

	public static void LogVirtualCurrencyPurchased(string purchaseId, int virtualCurrencyCount, bool isGems)
	{
		string deviceModel = SystemInfo.deviceModel;
		ShopNGUIController.AddBoughtCurrency((!isGems) ? "Coins" : "GemsCurrency", virtualCurrencyCount);
		string value = string.Format("{0} ({1})", purchaseId, virtualCurrencyCount);
		string value2 = PlayerPrefs.GetInt(Defs.SessionNumberKey, 1).ToString();
		string eventName = ((!isGems) ? "Coins Purchased Total" : "Gems Purchased Total");
		string value3 = ((!(ExperienceController.sharedController != null)) ? "Unknown" : ExperienceController.sharedController.currentLevel.ToString());
		string eventX3State = FlurryPluginWrapper.GetEventX3State();
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("Mode", State.Mode ?? string.Empty);
		dictionary.Add("Rank", value3);
		dictionary.Add("Session number", value2);
		dictionary.Add("SKU", value);
		dictionary.Add("Device model", deviceModel);
		dictionary.Add("X3", eventX3State);
		Dictionary<string, string> parameters = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
		string eventName2 = (((!isGems) ? "Coins Purchased " : "Gems Purchased ") + State.Mode) ?? string.Empty;
		dictionary = new Dictionary<string, string>(State.Parameters);
		dictionary.Add(State.PurchaseKey, purchaseId);
		dictionary.Add("Rank", value3);
		dictionary.Add("Session number", value2);
		dictionary.Add("SKU", value);
		dictionary.Add("Device model", deviceModel);
		Dictionary<string, string> parameters2 = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName2, parameters2);
		if (ExperienceController.sharedController != null)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			int num = (currentLevel - 1) / 9;
			string arg = string.Format("[{0}, {1})", num * 9 + 1, (num + 1) * 9 + 1);
			string eventName3 = string.Format((!isGems) ? "Coins Payment On Level {0}{1}" : "Gems Payment On Level {0}{1}", arg, string.Empty);
			dictionary = new Dictionary<string, string>();
			dictionary.Add("Level " + currentLevel, value);
			Dictionary<string, string> parameters3 = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName3, parameters3);
		}
		int ourTier = ExpController.GetOurTier();
		int currentLevel2 = ExperienceController.sharedController.currentLevel;
		dictionary = new Dictionary<string, string>();
		dictionary.Add("Lev" + currentLevel2, value);
		dictionary.Add("TOTAL", value);
		Dictionary<string, string> parameters4 = dictionary;
		string text = string.Format(" (Tier {0}){1}{2}", ourTier, FlurryPluginWrapper.GetPayingSuffix(), string.Empty);
		string eventName4 = ((!isGems) ? "Coins Purchase Total" : "Gems Purchase Total") + text;
		FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName4, parameters4);
		string eventName5 = "IAP Purchase Total" + text;
		FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName5, parameters4);
		int @int = PlayerPrefs.GetInt("CountPaying", 0);
		int num2 = Array.IndexOf(coinIds, purchaseId);
		bool flag = false;
		if (num2 == -1)
		{
			num2 = Array.IndexOf(gemsIds, purchaseId);
			if (num2 == -1)
			{
				num2 = Array.IndexOf(starterPackIds, purchaseId);
				flag = true;
			}
		}
		if (num2 == -1)
		{
			string message = string.Format("Could not find “{0}” value in coinIds array.", purchaseId);
			Debug.Log(message);
			return;
		}
		int num3 = 0;
		if (isGems)
		{
			num3 = PlayerPrefs.GetInt("ALLGems", 0);
			num3 += ((!flag) ? VirtualCurrencyHelper.gemsPriceIds[num2] : VirtualCurrencyHelper.starterPackFakePrice[num2]);
			PlayerPrefs.SetInt("ALLGems", num3);
		}
		else
		{
			num3 = PlayerPrefs.GetInt("ALLCoins", 0);
			num3 += ((!flag) ? VirtualCurrencyHelper.coinPriceIds[num2] : VirtualCurrencyHelper.starterPackFakePrice[num2]);
			PlayerPrefs.SetInt("ALLCoins", num3);
		}
		if (!flag)
		{
			Storager.setInt(Defs.AllCurrencyBought + ((!isGems) ? "Coins" : "GemsCurrency"), Storager.getInt(Defs.AllCurrencyBought + ((!isGems) ? "Coins" : "GemsCurrency"), false) + virtualCurrencyCount, false);
		}
		@int++;
		PlayerPrefs.SetInt("CountPaying", @int);
		if (@int >= 1 && PlayerPrefs.GetInt("Paying_User", 0) == 0)
		{
			PlayerPrefs.SetInt("Paying_User", 1);
			FacebookController.LogEvent("Paying_User");
			Debug.Log("Paying_User detected.");
		}
		if (@int > 1 && PlayerPrefs.GetInt("Paying_User_Dolphin", 0) == 0)
		{
			PlayerPrefs.SetInt("Paying_User_Dolphin", 1);
			FacebookController.LogEvent("Paying_User_Dolphin");
			Debug.Log("Paying_User_Dolphin detected.");
		}
		if (@int > 3 && PlayerPrefs.GetInt("Paying_User_Whale", 0) == 0)
		{
			PlayerPrefs.SetInt("Paying_User_Whale", 1);
			FacebookController.LogEvent("Paying_User_Whale");
			Debug.Log("Paying_User_Whale detected.");
		}
		if (num3 >= 100 && PlayerPrefs.GetInt("SendKit", 0) == 0)
		{
			PlayerPrefs.SetInt("SendKit", 1);
			FacebookController.LogEvent("Whale_detected");
			Debug.Log("Whale detected.");
		}
		if (PlayerPrefs.GetInt("confirmed_1st_time", 0) == 0)
		{
			PlayerPrefs.SetInt("confirmed_1st_time", 1);
			FacebookController.LogEvent("Purchase_confirmed_1st_time");
			Debug.Log("Purchase confirmed first time.");
		}
		if (PlayerPrefs.GetInt("Active_loyal_users_payed_send", 0) == 0 && PlayerPrefs.GetInt("PostFacebookCount", 0) > 2 && PlayerPrefs.GetInt("PostVideo", 0) > 0)
		{
			FacebookController.LogEvent("Active_loyal_users_payed");
			PlayerPrefs.SetInt("Active_loyal_users_payed_send", 1);
		}
	}
}
