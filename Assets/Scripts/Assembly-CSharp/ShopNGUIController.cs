using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Holoville.HOTween;
using Holoville.HOTween.Core;
using Holoville.HOTween.Plugins;
using Rilisoft;
using UnityEngine;

public class ShopNGUIController : MonoBehaviour
{
	public enum CategoryNames
	{
		PrimaryCategory,
		BackupCategory,
		MeleeCategory,
		SpecilCategory,
		PremiumCategory,
		HatsCategory,
		ArmorCategory,
		SkinsCategory,
		CapesCategory,
		BootsCategory,
		GearCategory
	}

	public delegate void Action6<T1, T2, T3, T4, T5, T6>(T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5, T6 arg6);

	public const string BoughtCurrencsySettingBase = "BoughtCurrency";

	public const string CustomSkinID = "CustomSkinID";

	private const string ShowArmorKey = "ShowArmorKeySetting";

	private const string ShowHatKey = "ShowHatKeySetting";

	public static ShopNGUIController sharedShop;

	public GameObject hatLock;

	public GameObject armorLock;

	public BoxCollider shopCarouselCollider;

	public ToggleButton showArmorButtonTempArmor;

	public ToggleButton showHatButtonTempHat;

	public GameObject prolongateRentText;

	public GameObject purchaseSuccessfulRent;

	public UILabel salePercRent;

	public GameObject saleRent;

	public GameObject limitedLabel;

	public GameObject upgradesLabel;

	public GameObject rentProperties;

	public GameObject notRented;

	public UILabel daysLeftLabel;

	public UILabel timeLeftLabel;

	public UILabel daysLeftValueLabel;

	public UILabel timeLeftValueLabel;

	public GameObject redBackForTime;

	public UIButton rent;

	public Transform rentScreenPoint;

	public ToggleButton showArmorButton;

	public ToggleButton showHatButton;

	public PropertyInfoScreenController infoScreen;

	public GameObject stub;

	public UIButton upgradeGear;

	public UISprite currencyImagePrice;

	public UISprite currencyImagePriceGear;

	public UISprite currencyImagePriceUpgradeGear;

	public UILabel price2Gear;

	public UILabel priceUpgradeGear;

	public GameObject wholePrice2Gear;

	public GameObject wholePriceUpgradeGear;

	public UIButton buyGear;

	public UISprite wholePriceBG2Gear;

	public UISprite wholePriceUpgradeBG2Gear;

	public UILabel fireRate;

	public UILabel fireRateMElee;

	public UILabel mobility;

	public UILabel mobilityMelee;

	public UILabel capacity;

	public UILabel damage;

	public UILabel damageMelee;

	public GameObject needTier;

	public UILabel needTierLabel;

	public GameObject purchaseSuccessful;

	public GameObject[] bystepCollider;

	public Transform trainingLAbels;

	public UISprite wholePriceBG;

	private bool trainBougt1;

	private bool trainBought2;

	private bool armorBougt1;

	private bool armorBought2;

	private int trainStep = -1;

	public List<Light> mylights;

	[Range(-200f, 200f)]
	public float firstOFfset = -50f;

	[Range(-200f, 200f)]
	public float secondOffset = 50f;

	public GameObject capeProperties;

	public GameObject hatsProperties;

	public GameObject bootsProperties;

	public GameObject armorProperties;

	public GameObject skinProperties;

	public GameObject gearProperties;

	public GameObject border;

	public Action OnBecomeActive;

	private string offerID;

	public CategoryNames offerCategory;

	public float scaleCoef = 0.5f;

	public Transform hatPoint;

	public Transform capePoint;

	public Transform bootsPoint;

	public Transform armorPoint;

	public GameObject mainPanel;

	public UIButton backButton;

	public UIButton coinShopButton;

	public UIPanel scrollViewPanel;

	public UIGrid wrapContent;

	public MyCenterOnChild carouselCenter;

	public GameObject body;

	public GameObject weaponPointShop;

	public Transform MainMenu_Pers;

	public string viewedId;

	public string chosenId;

	public Action resumeAction;

	public Action wearResumeAction;

	public Action<CategoryNames, string> wearUnequipAction;

	public Action<CategoryNames, string, string> wearEquipAction;

	public Action<string> buyAction;

	public Action<string> equipAction;

	public Action<string> activatePotionAction;

	public Action<string> onEquipSkinAction;

	private GameObject weapon;

	private AnimationClip profile;

	public bool EnableConfigurePos;

	public MultipleToggleButton category;

	public UIButton[] equips;

	public UISprite[] equippeds;

	public UIButton create;

	public UIButton buy;

	public UIButton upgrade;

	public UIButton unequip;

	public UIButton edit;

	public UIButton enable;

	public UIButton delete;

	public GameObject weaponProperties;

	public GameObject meleeProperties;

	public GameObject upgradesAnchor;

	public GameObject upgrade_1;

	public GameObject upgrade_2;

	public GameObject upgrade_3;

	public GameObject SpecialParams;

	public UILabel zoomLabel;

	public UILabel areaDamageLabel;

	public UILabel wallBreakLabel;

	[Header("AOE Label")]
	public UILabel AOELabel;

	public GameObject wholePrice;

	public GameObject sale;

	public UILabel price;

	public UILabel caption;

	public UILabel salePerc;

	private string chosenID;

	public CategoryNames currentCategory;

	private bool capeEditingEnabled;

	public bool inGame = true;

	private GameObject _purchaseActivityIndicator;

	public NickLabelController nick;

	public List<Camera> ourCameras;

	public UILabel onlyInThis;

	public AnimationCoroutineRunner animationCoroutineRunner;

	public GameObject ActiveObject;

	private List<GameObject> hats = new List<GameObject>();

	private List<GameObject> capes = new List<GameObject>();

	private List<GameObject> boots = new List<GameObject>();

	private List<GameObject> gear = new List<GameObject>();

	private List<GameObject> armor = new List<GameObject>();

	private GameObject pixlMan;

	private Transform highlightedCarouselObject;

	public int itemIndex = -1;

	private GameObject _lastSelectedItem;

	private GameObject[] _onPersArmorRefs;

	private static bool _ShowArmor = true;

	private static bool _ShowHat = true;

	private float timeToUpdateTempGunTime;

	private GameObject _label;

	public static string[] gearOrder = PotionsController.potions;

	private string _currentCape;

	private string _currentHat;

	private string _currentBoots;

	private string _currentArmor;

	public bool _goingToEditCape;

	private float lastTime;

	public static float IdleTimeoutPers = 5f;

	private float idleTimerLastTime;

	private float _timePurchaseSuccessfulShown;

	private float _timePurchaseRentSuccessfulShown;

	private bool _escapeRequested;

	private float timeOfEnteringShopForProtectFromPressingCoinsButton;

	private UISprite toBlink;

	private Color? _storedAmbientLight;

	private bool? _storedFogEnabled;

	private string _assignedWeaponTag = string.Empty;

	public bool WeaponCategory
	{
		get
		{
			return IsWeaponCategory(currentCategory);
		}
	}

	public static bool ShowArmor
	{
		get
		{
			return _ShowArmor;
		}
		private set
		{
			if (_ShowArmor != value)
			{
				_ShowArmor = value;
				Action showArmorChanged = ShopNGUIController.ShowArmorChanged;
				if (showArmorChanged != null)
				{
					showArmorChanged();
				}
			}
		}
	}

	public static bool ShowHat
	{
		get
		{
			return _ShowHat;
		}
		private set
		{
			if (_ShowHat != value)
			{
				_ShowHat = value;
				Action showArmorChanged = ShopNGUIController.ShowArmorChanged;
				if (showArmorChanged != null)
				{
					showArmorChanged();
				}
			}
		}
	}

	public bool WearCategory
	{
		get
		{
			return IsWearCategory(currentCategory);
		}
	}

	private string NextUpgradeIDForCurrentGear
	{
		get
		{
			if (viewedId == null)
			{
				return null;
			}
			return GearManager.UpgradeIDForGear(GearManager.HolderQuantityForID(viewedId), GearManager.CurrentNumberOfUphradesForGear(viewedId) + 1);
		}
	}

	private string IDForCurrentGear
	{
		get
		{
			if (viewedId == null)
			{
				return null;
			}
			return GearManager.HolderQuantityForID(viewedId);
		}
	}

	private string _CurrentEquippedSN
	{
		get
		{
			return SnForWearCategory(currentCategory);
		}
	}

	private string _CurrentNoneEquipped
	{
		get
		{
			return NoneEquippedForWearCategory(currentCategory);
		}
	}

	public string _CurrentEquippedWear
	{
		get
		{
			return WearForCat(currentCategory);
		}
		set
		{
			SetWearForCategory(currentCategory, value);
		}
	}

	public static bool GuiActive
	{
		get
		{
			return sharedShop != null && sharedShop.ActiveObject.activeInHierarchy;
		}
		set
		{
			if (ZombieCreator.sharedCreator != null)
			{
				ZombieCreator.sharedCreator.SuppressDrawingWaveMessage();
			}
			QualitySettings.antiAliasing = ((value && !Device.isWeakDevice) ? 4 : 0);
			FreeAwardShowHandler.CheckShowChest(value);
			if (!(sharedShop != null))
			{
				return;
			}
			NickLabelController.currentCamera = ((!value) ? Camera.main : sharedShop.ourCameras[1]);
			sharedShop.SetOtherCamerasEnabled(!value);
			if (value)
			{
				sharedShop.hatLock.SetActive(Defs.isHunger);
				sharedShop.armorLock.SetActive(Defs.isHunger);
				sharedShop.stub.SetActive(true);
				try
				{
					sharedShop._storedAmbientLight = RenderSettings.ambientLight;
					sharedShop._storedFogEnabled = RenderSettings.fog;
					RenderSettings.ambientLight = Defs.AmbientLightColorForShop();
					RenderSettings.fog = false;
					sharedShop.timeOfEnteringShopForProtectFromPressingCoinsButton = Time.realtimeSinceStartup;
					sharedShop.LoadCurrentWearToVars();
					sharedShop.UpdateIcons();
					CategoryNames cn = CategoryNames.PrimaryCategory;
					string text;
					if (sharedShop.offerID != null)
					{
						text = sharedShop.offerID;
						cn = sharedShop.offerCategory;
						sharedShop.offerID = null;
					}
					else
					{
						text = ((!Defs.IsTraining) ? TempGunOrHighestDPSGun(CategoryNames.PrimaryCategory, out cn) : WeaponTags.GrenadeLuancher_2Tag);
					}
					if (Defs.IsTraining)
					{
						cn = CategoryNames.PremiumCategory;
					}
					else
					{
						string text2 = WeaponManager.LastBoughtTag(text);
						if (text2 == null)
						{
							if (IsWearCategory(cn))
							{
								foreach (List<List<string>> value2 in Wear.wear.Values)
								{
									foreach (List<string> item in value2)
									{
										if (item.Contains(text))
										{
											text = item[0];
											break;
										}
									}
								}
							}
						}
						else
						{
							text = text2;
						}
					}
					sharedShop.CategoryChosen(cn, text, true);
					SetIconChosen(cn);
					sharedShop.MakeACtiveAfterDelay(text, cn);
				}
				catch (Exception)
				{
				}
				sharedShop.StartCoroutine(sharedShop.DisableStub());
				return;
			}
			Color? storedAmbientLight = sharedShop._storedAmbientLight;
			RenderSettings.ambientLight = ((!storedAmbientLight.HasValue) ? RenderSettings.ambientLight : storedAmbientLight.Value);
			bool? storedFogEnabled = sharedShop._storedFogEnabled;
			RenderSettings.fog = ((!storedFogEnabled.HasValue) ? RenderSettings.fog : storedFogEnabled.Value);
			if (Defs.IsTraining)
			{
				sharedShop.StopCoroutine("Blink");
				sharedShop.backButton.tweenTarget.GetComponent<UISprite>().spriteName = "yell_btn";
				foreach (Transform trainingLAbel in sharedShop.trainingLAbels)
				{
					trainingLAbel.gameObject.SetActive(trainingLAbel.gameObject.name.Equals(false));
				}
				CategoryNames cn2;
				string tg = TempGunOrHighestDPSGun(CategoryNames.PrimaryCategory, out cn2);
				tg = WeaponManager.FirstUnboughtTag(tg);
				sharedShop.CategoryChosen(cn2, tg, true);
			}
			MyCenterOnChild myCenterOnChild = sharedShop.carouselCenter;
			myCenterOnChild.onFinished = (SpringPanel.OnFinished)Delegate.Remove(myCenterOnChild.onFinished, new SpringPanel.OnFinished(sharedShop.HandleCarouselCentering));
			PromoActionsManager.ActionsUUpdated -= sharedShop.HandleActionsUUpdated;
			sharedShop.SetWeapon(null);
			sharedShop.ActiveObject.SetActive(false);
			sharedShop.carouselCenter.enabled = false;
			WeaponManager.sharedManager.ClearCachedInnerPrefabs();
		}
	}

	public static event Action ShowArmorChanged;

	public static event Action GunBought;

	public static void GoToShop(CategoryNames cat, string id)
	{
		sharedShop.SetOfferID(id);
		sharedShop.offerCategory = cat;
		if (GuiActive)
		{
			sharedShop.CategoryChosen(cat, id);
			SetIconChosen(cat);
		}
		else if (Application.loadedLevelName.Equals(Defs.MainMenuScene))
		{
			if (MainMenuController.sharedController != null)
			{
				MainMenuController.sharedController.HandleShopClicked(null, EventArgs.Empty);
			}
		}
		else
		{
			sharedShop.resumeAction = null;
			GuiActive = true;
		}
	}

	public static void AddBoughtCurrency(string currency, int count)
	{
		if (currency == null)
		{
			Debug.LogWarning("AddBoughtCurrency: currency == null");
			return;
		}
		if (Debug.isDebugBuild)
		{
			Debug.Log(string.Format("<color=#ff00ffff>AddBoughtCurrency {0} {1}</color>", currency, count));
		}
		Storager.setInt("BoughtCurrency" + currency, Storager.getInt("BoughtCurrency" + currency, false) + count, false);
	}

	public static void SpendBoughtCurrency(string currency, int count)
	{
		if (currency == null)
		{
			Debug.LogWarning("SpendBoughtCurrency: currency == null");
			return;
		}
		if (Debug.isDebugBuild)
		{
			Debug.Log(string.Format("<color=#ff00ffff>SpendBoughtCurrency {0} {1}</color>", currency, count));
		}
		Storager.setInt("BoughtCurrency" + currency, Math.Max(Storager.getInt("BoughtCurrency" + currency, false) - count, 0), false);
	}

	public static void TryToBuy(GameObject mainPanel, ItemPrice price, Action onSuccess, Action onFailure = null, Func<bool> successAdditionalCond = null, Action onReturnFromBank = null, Action onEnterCoinsShopAction = null, Action onExitCoinsShopAction = null)
	{
		Debug.Log("Trying to buy from ShopNGUIController...");
		if (BankController.Instance == null)
		{
			Debug.LogWarning("BankController.Instance == null");
			return;
		}
		if (price == null)
		{
			Debug.LogWarning("price == null");
			return;
		}
		EventHandler handleBackFromBank = null;
		handleBackFromBank = delegate
		{
			BankController.Instance.BackRequested -= handleBackFromBank;
			BankController.Instance.InterfaceEnabled = false;
			coinsShop.thisScript.notEnoughCurrency = null;
			mainPanel.SetActive(true);
			if (onReturnFromBank != null)
			{
				onReturnFromBank();
			}
			if (onExitCoinsShopAction != null)
			{
				onExitCoinsShopAction();
			}
		};
		EventHandler act = null;
		act = delegate
		{
			BankController.Instance.BackRequested -= act;
			mainPanel.SetActive(true);
			coinsShop.thisScript.notEnoughCurrency = null;
			coinsShop.thisScript.onReturnAction = null;
			int @int = Storager.getInt(price.Currency, false);
			int num = @int;
			num -= price.Price;
			bool flag = num >= 0;
			bool num2;
			if (successAdditionalCond != null)
			{
				if (successAdditionalCond())
				{
					goto IL_0088;
				}
				num2 = flag;
			}
			else
			{
				num2 = flag;
			}
			if (!num2)
			{
				if (onFailure != null)
				{
					onFailure();
				}
				coinsShop.thisScript.notEnoughCurrency = price.Currency;
				Debug.Log("Trying to display bank interface...");
				BankController.Instance.BackRequested += handleBackFromBank;
				BankController.Instance.InterfaceEnabled = true;
				mainPanel.SetActive(false);
				if (onEnterCoinsShopAction != null)
				{
					onEnterCoinsShopAction();
				}
				return;
			}
			goto IL_0088;
			IL_0088:
			if (!Defs.IsTraining)
			{
				Storager.setInt(price.Currency, num, false);
				SpendBoughtCurrency(price.Currency, price.Price);
				PlayerPrefs.Save();
			}
			if (onSuccess != null)
			{
				onSuccess();
			}
		};
		act(BankController.Instance, EventArgs.Empty);
	}

	public static string ReadablteNameForPromo(string str, int cat)
	{
		string result = string.Empty;
		try
		{
			switch (cat)
			{
			case 0:
			case 1:
			case 2:
			case 3:
			case 4:
			{
				UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
				for (int i = 0; i < weaponsInGame.Length; i++)
				{
					GameObject gameObject = (GameObject)weaponsInGame[i];
					if (gameObject.tag.Equals(str))
					{
						result = gameObject.GetComponent<WeaponSounds>().shopName;
						return result;
					}
				}
				return result;
			}
			case 5:
			case 6:
			case 8:
			case 9:
			case 10:
			{
				List<GameObject> list = sharedShop.armor;
				switch (cat)
				{
				case 5:
					list = sharedShop.hats;
					break;
				case 8:
					list = sharedShop.capes;
					break;
				case 9:
					list = sharedShop.boots;
					break;
				case 10:
					list = sharedShop.gear;
					break;
				}
				{
					foreach (GameObject item in list)
					{
						if (item.name.Equals(str))
						{
							result = item.GetComponent<ShopPositionParams>().shopName;
							return result;
						}
					}
					return result;
				}
			}
			default:
				return result;
			case 7:
				return result;
			}
		}
		catch (Exception ex)
		{
			Debug.Log("Exception in ReadableNameForPromo: " + ex);
			return result;
		}
	}

	private void FilterUpgrades(List<GameObject> modelsList, GameObject a, List<List<string>> ll, string visualDefName)
	{
		if (Defs.IsTraining)
		{
			if (!armorBougt1 && a.name.Equals(Wear.Armor_Army_1))
			{
				modelsList.Add(a);
			}
			if (armorBougt1 && !armorBought2 && (a.name.Equals(Wear.Armor_Army_1) || a.name.Equals(Wear.Armor_Army_2)))
			{
				modelsList.Add(a);
			}
			if (armorBougt1 && armorBought2 && (a.name.Equals(Wear.Armor_Army_2) || a.name.Equals(Wear.Armor_Army_3)))
			{
				modelsList.Add(a);
			}
			return;
		}
		if (a != null && TempItemsController.PriceCoefs.ContainsKey(a.name) && TempItemsController.sharedController != null)
		{
			if (TempItemsController.sharedController.ContainsItem(a.name))
			{
				modelsList.Add(a);
			}
			return;
		}
		string[] array = null;
		foreach (List<string> item in ll)
		{
			if (item.Contains(a.name))
			{
				array = item.ToArray();
				break;
			}
		}
		if (array == null)
		{
			return;
		}
		string value = ((!string.IsNullOrEmpty(visualDefName)) ? Storager.getString(visualDefName, false) : string.Empty);
		int num = Array.IndexOf(array, a.name);
		if (Storager.getInt(a.name, true) > 0)
		{
			if (num == array.Length - 1)
			{
				modelsList.Add(a);
			}
			else if (num >= 0 && num < array.Length - 1 && Storager.getInt(array[num + 1], true) == 0)
			{
				modelsList.Add(a);
			}
			return;
		}
		if (num == 0)
		{
			modelsList.Add(a);
		}
		if (num <= 0)
		{
			return;
		}
		if (Storager.getInt(array[num - 1], true) > 0)
		{
			if (!string.IsNullOrEmpty(value))
			{
				if (Array.IndexOf(array, value) <= num)
				{
					modelsList.Add(a);
				}
			}
			else
			{
				modelsList.Add(a);
			}
		}
		else if (!string.IsNullOrEmpty(value) && a.name.Equals(value))
		{
			modelsList.Add(a);
		}
	}

	public List<GameObject> FillModelsList(CategoryNames c)
	{
		Func<CategoryNames, Comparison<GameObject>> func = (CategoryNames cn) => delegate(GameObject lh, GameObject rh)
		{
			List<string> list2 = null;
			List<string> list3 = null;
			foreach (List<string> item in Wear.wear[cn])
			{
				if (item.Contains(lh.name))
				{
					list2 = item;
				}
				if (item.Contains(rh.name))
				{
					list3 = item;
				}
			}
			if (list2 == null || list3 == null)
			{
				return 0;
			}
			return (list2 == list3) ? (list2.IndexOf(lh.name) - list2.IndexOf(rh.name)) : (Wear.wear[cn].IndexOf(list2) - Wear.wear[cn].IndexOf(list3));
		};
		List<GameObject> list = new List<GameObject>();
		if (IsWeaponCategory(c))
		{
			list = WeaponManager.sharedManager._weaponsByCat[(int)c];
		}
		else
		{
			switch (c)
			{
			case CategoryNames.HatsCategory:
				foreach (GameObject hat in hats)
				{
					FilterUpgrades(list, hat, Wear.wear[CategoryNames.HatsCategory], Defs.VisualHatArmor);
				}
				list.Sort(func(CategoryNames.HatsCategory));
				break;
			case CategoryNames.ArmorCategory:
				foreach (GameObject item2 in armor)
				{
					FilterUpgrades(list, item2, Wear.wear[CategoryNames.ArmorCategory], Defs.VisualArmor);
				}
				list.Sort(func(CategoryNames.ArmorCategory));
				break;
			case CategoryNames.SkinsCategory:
				foreach (string key in SkinsController.skinsForPers.Keys)
				{
					list.Add(pixlMan);
				}
				list.Add(pixlMan);
				break;
			case CategoryNames.CapesCategory:
				foreach (GameObject cape in capes)
				{
					FilterUpgrades(list, cape, Wear.wear[CategoryNames.CapesCategory], string.Empty);
				}
				list.Sort(func(CategoryNames.CapesCategory));
				break;
			case CategoryNames.BootsCategory:
				foreach (GameObject boot in boots)
				{
					FilterUpgrades(list, boot, Wear.wear[CategoryNames.BootsCategory], string.Empty);
				}
				list.Sort(func(CategoryNames.BootsCategory));
				break;
			case CategoryNames.GearCategory:
			{
				string[] array = GearManager.Gear;
				foreach (string g in array)
				{
					GameObject gameObject = null;
					for (int i = GearManager.NumOfGearUpgrades; i >= 0; i--)
					{
						if (i == 0)
						{
							gameObject = gear.Find((GameObject go) => go.name.Equals(GearManager.UpgradeIDForGear(g, 0)));
							break;
						}
						if (GearManager.CurrentNumberOfUphradesForGear(g) >= i)
						{
							gameObject = gear.Find((GameObject go) => go.name.Equals(GearManager.UpgradeIDForGear(g, i)));
							break;
						}
					}
					if (gameObject != null)
					{
						list.Add(gameObject);
					}
					else
					{
						Debug.LogWarning("toAdd: object not found");
					}
				}
				break;
			}
			}
		}
		return list;
	}

	private static string ItemIDForPrefab(string name, CategoryNames c)
	{
		switch (c)
		{
		case CategoryNames.ArmorCategory:
		{
			string string2 = Storager.getString(Defs.VisualArmor, false);
			if (!string.IsNullOrEmpty(string2) && Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(name) >= 0 && Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(name) < Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(string2))
			{
				return string2;
			}
			break;
		}
		case CategoryNames.HatsCategory:
		{
			string @string = Storager.getString(Defs.VisualHatArmor, false);
			if (!string.IsNullOrEmpty(@string) && Wear.wear[CategoryNames.HatsCategory][0].IndexOf(name) >= 0 && Wear.wear[CategoryNames.HatsCategory][0].IndexOf(name) < Wear.wear[CategoryNames.HatsCategory][0].IndexOf(@string))
			{
				return @string;
			}
			break;
		}
		}
		return name;
	}

	private static string ItemIDForPrefabReverse(string name, CategoryNames c)
	{
		switch (c)
		{
		case CategoryNames.ArmorCategory:
		{
			string string2 = Storager.getString(Defs.VisualArmor, false);
			if (string.IsNullOrEmpty(string2) || !string2.Equals(name) || Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(name) < 0)
			{
				break;
			}
			for (int j = 1; j < Wear.wear[CategoryNames.ArmorCategory][0].Count; j++)
			{
				if (Storager.getInt(Wear.wear[CategoryNames.ArmorCategory][0][j], true) == 0)
				{
					return Wear.wear[CategoryNames.ArmorCategory][0][j];
				}
			}
			break;
		}
		case CategoryNames.HatsCategory:
		{
			string @string = Storager.getString(Defs.VisualHatArmor, false);
			if (string.IsNullOrEmpty(@string) || !@string.Equals(name) || Wear.wear[CategoryNames.HatsCategory][0].IndexOf(name) < 0)
			{
				break;
			}
			for (int i = 1; i < Wear.wear[CategoryNames.HatsCategory][0].Count; i++)
			{
				if (Storager.getInt(Wear.wear[CategoryNames.HatsCategory][0][i], true) == 0)
				{
					return Wear.wear[CategoryNames.HatsCategory][0][i];
				}
			}
			break;
		}
		}
		return name;
	}

	private static string GetWeaponStatText(int currentValue, int nextValue)
	{
		if (nextValue - currentValue == 0)
		{
			return currentValue.ToString();
		}
		if (nextValue - currentValue > 0)
		{
			return string.Format("{0}[00ff00]+{1}[-]", currentValue, nextValue - currentValue);
		}
		return string.Format("{0}[FACC2E]{1}[-]", currentValue, nextValue - currentValue);
	}

	public void SetCamera()
	{
		Transform mainMenu_Pers = MainMenu_Pers;
		HOTween.Kill(mainMenu_Pers);
		Vector3 vector = new Vector3(0f, 0f, 0f);
		Vector3 vector2 = new Vector3(0f, 0f, 0f);
		Vector3 vector3 = new Vector3(1f, 1f, 1f);
		switch (currentCategory)
		{
		case CategoryNames.CapesCategory:
			vector = new Vector3(0f, 0f, 0f);
			vector2 = new Vector3(0f, -130.76f, 0f);
			break;
		case CategoryNames.HatsCategory:
			vector = new Vector3(1.06f, -0.54f, 2.19f);
			vector2 = new Vector3(0f, -9.5f, 0f);
			break;
		default:
			vector = new Vector3(0f, 0f, 0f);
			vector2 = new Vector3(0f, 0f, 0f);
			break;
		}
		float p_duration = 0.5f;
		idleTimerLastTime = Time.realtimeSinceStartup;
		HOTween.To(mainMenu_Pers, p_duration, new TweenParms().Prop("localPosition", vector).Prop("localRotation", new PlugQuaternion(vector2)).UpdateType(UpdateType.TimeScaleIndependentUpdate)
			.Ease(EaseType.Linear)
			.OnComplete((TweenDelegate.TweenCallback)delegate
			{
				idleTimerLastTime = Time.realtimeSinceStartup;
			}));
	}

	private void LogPurchaseAfterPaymentAnalyticsEvent(string itemName)
	{
		if (!FlurryEvents.PaymentTime.HasValue)
		{
			return;
		}
		float? paymentTime = FlurryEvents.PaymentTime;
		float? num = ((!paymentTime.HasValue) ? null : new float?(Time.realtimeSinceStartup - paymentTime.Value));
		Dictionary<string, string> dictionary;
		if (num.HasValue && num.Value < 30f)
		{
			dictionary = new Dictionary<string, string>();
			dictionary.Add("0-30", itemName);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment", parameters);
		}
		else
		{
			float? paymentTime2 = FlurryEvents.PaymentTime;
			float? num2 = ((!paymentTime2.HasValue) ? null : new float?(Time.realtimeSinceStartup - paymentTime2.Value));
			if (num2.HasValue && num2.Value < 60f)
			{
				dictionary = new Dictionary<string, string>();
				dictionary.Add("30-60", itemName);
				Dictionary<string, string> parameters2 = dictionary;
				FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment", parameters2);
			}
			else
			{
				float? paymentTime3 = FlurryEvents.PaymentTime;
				float? num3 = ((!paymentTime3.HasValue) ? null : new float?(Time.realtimeSinceStartup - paymentTime3.Value));
				if (num3.HasValue && num3.Value < 90f)
				{
					dictionary = new Dictionary<string, string>();
					dictionary.Add("60-90", itemName);
					Dictionary<string, string> parameters3 = dictionary;
					FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment", parameters3);
				}
				else
				{
					dictionary = new Dictionary<string, string>();
					dictionary.Add("90+", itemName);
					Dictionary<string, string> parameters4 = dictionary;
					FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment", parameters4);
				}
			}
		}
		float? paymentTime4 = FlurryEvents.PaymentTime;
		float? num4 = ((!paymentTime4.HasValue) ? null : new float?(Time.realtimeSinceStartup - paymentTime4.Value));
		if (num4.HasValue && num4.Value < 30f)
		{
			dictionary = new Dictionary<string, string>();
			dictionary.Add("0-30", itemName);
			Dictionary<string, string> parameters5 = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment Cumulative", parameters5);
		}
		float? paymentTime5 = FlurryEvents.PaymentTime;
		float? num5 = ((!paymentTime5.HasValue) ? null : new float?(Time.realtimeSinceStartup - paymentTime5.Value));
		if (num5.HasValue && num5.Value < 60f)
		{
			dictionary = new Dictionary<string, string>();
			dictionary.Add("0-60", itemName);
			Dictionary<string, string> parameters6 = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment Cumulative", parameters6);
		}
		float? paymentTime6 = FlurryEvents.PaymentTime;
		float? num6 = ((!paymentTime6.HasValue) ? null : new float?(Time.realtimeSinceStartup - paymentTime6.Value));
		if (num6.HasValue && num6.Value < 90f)
		{
			dictionary = new Dictionary<string, string>();
			dictionary.Add("0-90", itemName);
			Dictionary<string, string> parameters7 = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment Cumulative", parameters7);
		}
		dictionary = new Dictionary<string, string>();
		dictionary.Add("All", itemName);
		Dictionary<string, string> parameters8 = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Purchase After Payment Cumulative", parameters8);
	}

	public void PlayWeaponAnimation()
	{
		if (profile != null && weapon != null)
		{
			Animation animation = weapon.GetComponent<WeaponSounds>().animationObject.GetComponent<Animation>();
			if (Time.timeScale != 0f)
			{
				if (animation.GetClip("Profile") == null)
				{
					animation.AddClip(profile, "Profile");
				}
				animation.Play("Profile");
			}
			else
			{
				animationCoroutineRunner.StopAllCoroutines();
				if (animation.GetClip("Profile") == null)
				{
					animation.AddClip(profile, "Profile");
				}
				if (animationCoroutineRunner.gameObject.activeInHierarchy)
				{
					animationCoroutineRunner.StartPlay(animation, "Profile", false, null);
				}
				else
				{
					Debug.LogWarning("Coroutine couldn't be started because the the game object 'AnimationCoroutineRunner' is inactive!");
				}
			}
		}
		MainMenu_Pers.GetComponent<Animation>().Stop();
		MainMenu_Pers.GetComponent<Animation>().Play("Idle");
	}

	public static Texture TextureForCat(int cc)
	{
		string text = (IsWeaponCategory((CategoryNames)cc) ? sharedShop._CurrentWeaponSetIDs()[cc] : ((!IsWearCategory((CategoryNames)cc)) ? "potion" : sharedShop.WearForCat((CategoryNames)cc)));
		if (text == null)
		{
			return null;
		}
		text = ItemIDForPrefab(text, (CategoryNames)cc);
		int num = 1;
		if (IsWeaponCategory((CategoryNames)cc))
		{
			ItemRecord byTag = ItemDb.GetByTag(text);
			if ((byTag == null || !byTag.UseImagesFromFirstUpgrade) && (byTag == null || !byTag.TemporaryGun))
			{
				bool maxUpgrade;
				num = _CurrentNumberOfUpgrades(text, out maxUpgrade, (CategoryNames)cc);
			}
		}
		string text2 = ((!IsWeaponCategory((CategoryNames)cc)) ? text : (_TagForId(text) ?? string.Empty)) + "_icon" + num;
		string text3 = text2 + "_big";
		Texture texture = Resources.Load<Texture>("OfferIcons/" + text3);
		if (texture == null)
		{
			texture = Resources.Load<Texture>("ShopIcons/" + text2);
		}
		return texture;
	}

	public void SetIconModelsPositions(Transform t, CategoryNames c)
	{
		switch (c)
		{
		case CategoryNames.ArmorCategory:
		{
			t.transform.localPosition = new Vector3(0f, 0f, 0f);
			t.transform.localRotation = Quaternion.Euler(new Vector3(0f, 0f, 0f));
			float num6 = 1f;
			t.transform.localScale = new Vector3(num6, num6, num6);
			break;
		}
		case CategoryNames.BootsCategory:
		{
			t.transform.localPosition = new Vector3(-0.4f, -0.1f, 0f);
			t.transform.localRotation = Quaternion.Euler(new Vector3(13f, 149f, 0f));
			float num5 = 75f;
			t.transform.localScale = new Vector3(num5, num5, num5);
			break;
		}
		case CategoryNames.CapesCategory:
		{
			t.transform.localPosition = new Vector3(-0.720093f, -0.00859833f, 0f);
			t.transform.localRotation = Quaternion.Euler(new Vector3(0f, 30f, -15f));
			float num4 = 50f;
			t.transform.localScale = new Vector3(num4, num4, num4);
			break;
		}
		case CategoryNames.SkinsCategory:
		{
			t.transform.localPosition = new Vector3(1.398438f, 0.2295647f, 0f);
			t.transform.localRotation = Quaternion.Euler(new Vector3(6.837349f, 164.8903f, -1.841095f));
			float num3 = 30.1665f;
			t.transform.localScale = new Vector3(num3, num3, num3);
			break;
		}
		case CategoryNames.GearCategory:
		{
			t.transform.localPosition = new Vector3(4.648193f, 2.444565f, 0f);
			t.transform.localRotation = Quaternion.Euler(new Vector3(0f, 30f, -30f));
			float num2 = 319.3023f;
			t.transform.localScale = new Vector3(num2, num2, num2);
			break;
		}
		case CategoryNames.HatsCategory:
		{
			t.transform.localPosition = new Vector3(-0.62f, -0.04f, 0f);
			t.transform.localRotation = Quaternion.Euler(new Vector3(-75f, -165f, -90f));
			float num = 82.5f;
			t.transform.localScale = new Vector3(num, num, num);
			break;
		}
		}
	}

	public GameObject GetModelForCurrentEquippedt(CategoryNames c, List<GameObject> modelsList)
	{
		if (IsWeaponCategory(c))
		{
			UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
			for (int i = 0; i < weaponsInGame.Length; i++)
			{
				GameObject gameObject = (GameObject)weaponsInGame[i];
				if (_CurrentWeaponSetIDs()[(int)c] != null && gameObject.tag.Equals(_CurrentWeaponSetIDs()[(int)c]))
				{
					return gameObject;
				}
			}
			return null;
		}
		switch (c)
		{
		case CategoryNames.SkinsCategory:
			return modelsList[0];
		case CategoryNames.GearCategory:
			return modelsList[0];
		default:
		{
			string key = Defs.HatEquppedSN;
			if (c == CategoryNames.ArmorCategory)
			{
				key = Defs.ArmorNewEquppedSN;
			}
			if (c == CategoryNames.CapesCategory)
			{
				key = Defs.CapeEquppedSN;
			}
			if (c == CategoryNames.BootsCategory)
			{
				key = Defs.BootsEquppedSN;
			}
			string @string = Storager.getString(key, false);
			foreach (GameObject models in modelsList)
			{
				if (models.name.Equals(@string))
				{
					return models;
				}
			}
			return null;
		}
		}
	}

	private void DisableGunflashes(GameObject root)
	{
		if (root == null)
		{
			return;
		}
		if (root.name.Equals("GunFlash"))
		{
			root.SetActive(false);
		}
		foreach (Transform item in root.transform)
		{
			if (!(null == item))
			{
				DisableGunflashes(item.gameObject);
			}
		}
	}

	public void UpdateIcons()
	{
		for (int i = 0; i < category.buttons.Length; i++)
		{
			UpdateIcon((CategoryNames)i);
		}
	}

	public void UpdateIcon(CategoryNames c, bool animateModel = false)
	{
		ToggleButton tb = category.buttons[(int)c];
		List<GameObject> toDestroy = new List<GameObject>();
		Player_move_c.PerformActionRecurs(tb.gameObject, delegate(Transform ch)
		{
			if (!(ch.gameObject == tb.gameObject) && !(ch.gameObject == tb.onButton.gameObject) && !(ch.gameObject == tb.offButton.gameObject) && !ch.gameObject.name.Equals("Label") && !ch.gameObject.name.Equals("ShopIcon"))
			{
				if (ch.gameObject.name.Equals("Sprite"))
				{
					ch.gameObject.SetActive(false);
				}
				else
				{
					toDestroy.Add(ch.gameObject);
				}
			}
		});
		foreach (GameObject item in toDestroy)
		{
			UnityEngine.Object.Destroy(item);
		}
		if (c == CategoryNames.SkinsCategory || (c == CategoryNames.CapesCategory && _currentCape.Equals(Wear.cape_Custom)))
		{
			List<GameObject> modelsList = FillModelsList(c);
			GameObject modelForCurrentEquippedt = GetModelForCurrentEquippedt(c, modelsList);
			if (modelForCurrentEquippedt != null)
			{
				AddModel(modelForCurrentEquippedt, delegate(GameObject manipulateObject, Vector3 positionShop, Vector3 rotationShop, string readableName, float sc, int _)
				{
					manipulateObject.transform.parent = tb.transform;
					if (c == CategoryNames.SkinsCategory)
					{
						Player_move_c.SetTextureRecursivelyFrom(manipulateObject, SkinsController.currentSkinForPers, new GameObject[0]);
					}
					float num = 0.5f;
					Transform transform = manipulateObject.transform;
					transform.localPosition = tb.onButton.transform.localPosition + positionShop * num;
					transform.localPosition = new Vector3(transform.localPosition.x, transform.localPosition.y, 0f);
					transform.Rotate(rotationShop, Space.World);
					transform.localScale = new Vector3(sc * num, sc * num, sc * num);
					if (c == CategoryNames.CapesCategory && _currentCape.Equals(Wear.cape_Custom) && SkinsController.capeUserTexture != null)
					{
						Player_move_c.SetTextureRecursivelyFrom(manipulateObject, SkinsController.capeUserTexture, new GameObject[0]);
					}
					SetIconModelsPositions(transform, c);
					if (animateModel)
					{
						Vector3 localScale = transform.localScale;
						transform.localScale *= 1.25f;
						HOTween.To(transform, 0.25f, new TweenParms().Prop("localScale", localScale).UpdateType(UpdateType.TimeScaleIndependentUpdate).Ease(EaseType.Linear)
							.OnComplete((TweenDelegate.TweenCallback)delegate
							{
							}));
					}
				}, c);
			}
			else
			{
				Player_move_c.PerformActionRecurs(tb.gameObject, delegate(Transform ch)
				{
					if (ch.gameObject.name.Equals("Sprite"))
					{
						ch.gameObject.SetActive(true);
					}
				});
			}
			Player_move_c.PerformActionRecurs(tb.gameObject, delegate(Transform ch)
			{
				if (ch.gameObject.name.Equals("ShopIcon"))
				{
					ch.GetComponent<UITexture>().mainTexture = null;
				}
			});
			return;
		}
		Texture texture = TextureForCat((int)c);
		if (texture != null)
		{
			Player_move_c.PerformActionRecurs(tb.gameObject, delegate(Transform ch)
			{
				if (ch.gameObject.name.Equals("Sprite"))
				{
					ch.gameObject.SetActive(false);
				}
				else if (ch.gameObject.name.Equals("ShopIcon"))
				{
					UITexture component = ch.GetComponent<UITexture>();
					if (component.mainTexture == null || !component.mainTexture.name.Equals(texture.name) || HOTween.IsTweening(ch))
					{
						HOTween.Kill(ch);
						ch.localScale = new Vector3(1.25f, 1.25f, 1.25f);
						HOTween.To(ch, 0.25f, new TweenParms().Prop("localScale", new Vector3(1f, 1f, 1f)).UpdateType(UpdateType.TimeScaleIndependentUpdate).Ease(EaseType.Linear)
							.OnComplete((TweenDelegate.TweenCallback)delegate
							{
							}));
					}
					component.mainTexture = texture;
				}
			});
			return;
		}
		Player_move_c.PerformActionRecurs(tb.gameObject, delegate(Transform ch)
		{
			if (ch.gameObject.name.Equals("Sprite"))
			{
				ch.gameObject.SetActive(true);
			}
			else if (ch.gameObject.name.Equals("ShopIcon"))
			{
				ch.GetComponent<UITexture>().mainTexture = null;
			}
		});
	}

	private static string _TagForId(string id)
	{
		foreach (List<string> upgrade in WeaponUpgrades.upgrades)
		{
			if (upgrade.Contains(id))
			{
				return upgrade[0];
			}
		}
		return id;
	}

	public void EquipWear(string tg)
	{
		EquipWearInCategory(tg, currentCategory, inGame);
	}

	public static void EquipWearInCategoryIfNotEquiped(string tg, CategoryNames cat, bool inGameLocal)
	{
		if (!Storager.hasKey(SnForWearCategory(cat)))
		{
			Storager.setString(SnForWearCategory(cat), NoneEquippedForWearCategory(cat), false);
		}
		if (!Storager.getString(SnForWearCategory(cat), false).Equals(tg))
		{
			EquipWearInCategory(tg, cat, inGameLocal);
		}
	}

	private static void EquipWearInCategory(string tg, CategoryNames cat, bool inGameLocal)
	{
		bool flag = !Defs.isMulti;
		string @string = Storager.getString(SnForWearCategory(cat), false);
		Player_move_c player_move_c = null;
		if (inGameLocal)
		{
			if (flag)
			{
				if (!Application.loadedLevelName.Equals("LevelComplete") && !Application.loadedLevelName.Equals("ChooseLevel"))
				{
					player_move_c = GameObject.FindGameObjectWithTag("Player").GetComponent<SkinName>().playerMoveC;
				}
			}
			else if (WeaponManager.sharedManager.myPlayer != null)
			{
				player_move_c = WeaponManager.sharedManager.myPlayerMoveC;
			}
		}
		SetAsEquippedAndSendToServer(tg, cat);
		sharedShop.SetWearForCategory(cat, tg);
		if (sharedShop.wearEquipAction != null)
		{
			sharedShop.wearEquipAction(cat, @string ?? NoneEquippedForWearCategory(cat), sharedShop.WearForCat(cat));
		}
		if (cat == CategoryNames.BootsCategory && inGameLocal && player_move_c != null)
		{
			if (!@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.bootsMethods.ContainsKey(@string))
			{
				Wear.bootsMethods[@string].Value(player_move_c, new Dictionary<string, object>());
			}
			if (Wear.bootsMethods.ContainsKey(tg))
			{
				Wear.bootsMethods[tg].Key(player_move_c, new Dictionary<string, object>());
			}
		}
		if (cat == CategoryNames.CapesCategory && inGameLocal && player_move_c != null)
		{
			if (!@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.capesMethods.ContainsKey(@string))
			{
				Wear.capesMethods[@string].Value(player_move_c, new Dictionary<string, object>());
			}
			if (Wear.capesMethods.ContainsKey(tg))
			{
				Wear.capesMethods[tg].Key(player_move_c, new Dictionary<string, object>());
			}
		}
		if (cat == CategoryNames.HatsCategory && inGameLocal && player_move_c != null)
		{
			if (!@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.hatsMethods.ContainsKey(@string))
			{
				Wear.hatsMethods[@string].Value(player_move_c, new Dictionary<string, object>());
			}
			if (Wear.hatsMethods.ContainsKey(tg))
			{
				Wear.hatsMethods[tg].Key(player_move_c, new Dictionary<string, object>());
			}
		}
		if (cat == CategoryNames.ArmorCategory && inGameLocal && player_move_c != null)
		{
			if (!@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.armorMethods.ContainsKey(@string))
			{
				Wear.armorMethods[@string].Value(player_move_c, new Dictionary<string, object>());
			}
			if (Wear.armorMethods.ContainsKey(tg))
			{
				Wear.armorMethods[tg].Key(player_move_c, new Dictionary<string, object>());
			}
		}
		if (GuiActive)
		{
			sharedShop.UpdateButtons();
			sharedShop.UpdateIcon(cat, true);
		}
	}

	public static void UnequipCurrentWearInCategory(CategoryNames cat, bool inGameLocal)
	{
		bool flag = !Defs.isMulti;
		string @string = Storager.getString(SnForWearCategory(cat), false);
		Player_move_c player_move_c = null;
		if (inGameLocal)
		{
			if (flag)
			{
				if (!Application.loadedLevelName.Equals("LevelComplete") && !Application.loadedLevelName.Equals("ChooseLevel"))
				{
					player_move_c = GameObject.FindGameObjectWithTag("Player").GetComponent<SkinName>().playerMoveC;
				}
			}
			else if (WeaponManager.sharedManager.myPlayer != null)
			{
				player_move_c = WeaponManager.sharedManager.myPlayerMoveC;
			}
		}
		Storager.setString(SnForWearCategory(cat), NoneEquippedForWearCategory(cat), false);
		switch (cat)
		{
		case CategoryNames.CapesCategory:
			FriendsController.sharedController.capeName = NoneEquippedForWearCategory(cat);
			break;
		case CategoryNames.HatsCategory:
			FriendsController.sharedController.hatName = NoneEquippedForWearCategory(cat);
			break;
		case CategoryNames.BootsCategory:
			FriendsController.sharedController.bootsName = NoneEquippedForWearCategory(cat);
			break;
		case CategoryNames.ArmorCategory:
			FriendsController.sharedController.armorName = NoneEquippedForWearCategory(cat);
			break;
		}
		FriendsController.sharedController.SendOurData(false);
		sharedShop.SetWearForCategory(cat, NoneEquippedForWearCategory(cat));
		if (sharedShop.wearEquipAction != null)
		{
			sharedShop.wearEquipAction(cat, @string ?? NoneEquippedForWearCategory(cat), NoneEquippedForWearCategory(cat));
		}
		if (cat == CategoryNames.BootsCategory && inGameLocal && player_move_c != null && !@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.bootsMethods.ContainsKey(@string))
		{
			Wear.bootsMethods[@string].Value(player_move_c, new Dictionary<string, object>());
		}
		if (cat == CategoryNames.CapesCategory && inGameLocal && player_move_c != null && !@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.capesMethods.ContainsKey(@string))
		{
			Wear.capesMethods[@string].Value(player_move_c, new Dictionary<string, object>());
		}
		if (cat == CategoryNames.HatsCategory && inGameLocal && player_move_c != null && !@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.hatsMethods.ContainsKey(@string))
		{
			Wear.hatsMethods[@string].Value(player_move_c, new Dictionary<string, object>());
		}
		if (cat == CategoryNames.ArmorCategory && inGameLocal && player_move_c != null && !@string.Equals(NoneEquippedForWearCategory(cat)) && Wear.armorMethods.ContainsKey(@string))
		{
			Wear.armorMethods[@string].Value(player_move_c, new Dictionary<string, object>());
		}
		if (sharedShop.wearUnequipAction != null)
		{
			sharedShop.wearUnequipAction(cat, @string ?? NoneEquippedForWearCategory(cat));
		}
		if (GuiActive)
		{
			sharedShop.UpdateIcon(cat);
		}
	}

	public static void ShowTempItemExpiredIfPossible(Transform point, string layer, Action<string> onPurchase = null, Action onEnterCoinsShopAdditional = null, Action onExitoinsShopAdditional = null, Action<string> customEquipWearAction = null)
	{
		List<string> list = new List<string>();
		foreach (string expiredItem in TempItemsController.sharedController.ExpiredItems)
		{
			if (TempItemsController.sharedController.CanShowExpiredBannerForTag(expiredItem))
			{
				ShowRentScreen(expiredItem, point, layer, LocalizationStore.Get("Key_1156"), LocalizationStore.Get("Key_1157"), onPurchase, onEnterCoinsShopAdditional, onExitoinsShopAdditional, customEquipWearAction);
				list.Add(expiredItem);
				break;
			}
		}
		foreach (string item in list)
		{
			TempItemsController.sharedController.ExpiredItems.Remove(item);
		}
	}

	public static bool ShowPremimAccountExpiredIfPossible(Transform point, string layer, string header = "", bool showOnlyIfExpired = true)
	{
		if (showOnlyIfExpired && (!PremiumAccountController.AccountHasExpired || !Defs.CanShowPremiumAccountExpiredWindow))
		{
			return false;
		}
		if (point != null)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(Resources.Load<GameObject>("PremiumAccount")) as GameObject;
			gameObject.transform.parent = point;
			Player_move_c.SetLayerRecursively(gameObject, LayerMask.NameToLayer(layer ?? "Default"));
			gameObject.transform.localPosition = new Vector3(0f, 0f, -130f);
			gameObject.transform.localRotation = Quaternion.identity;
			gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
			PremiumAccountScreenController component = gameObject.GetComponent<PremiumAccountScreenController>();
			component.Header = header;
			PremiumAccountController.AccountHasExpired = false;
			return true;
		}
		return false;
	}

	public void SetOfferID(string oid)
	{
		offerID = oid;
	}

	public void HandleProfileButton()
	{
		GameObject nicknameLabel = nick.gameObject;
		if (nicknameLabel != null)
		{
			nicknameLabel.SetActive(false);
		}
		GameObject mainMenu = GameObject.Find("MainMenuNGUI");
		if ((bool)mainMenu)
		{
			mainMenu.SetActive(false);
		}
		GameObject inGameGui = GameObject.FindWithTag("InGameGUI");
		if ((bool)inGameGui)
		{
			inGameGui.SetActive(false);
		}
		GameObject networkTable = GameObject.FindWithTag("NetworkStartTableNGUI");
		if ((bool)networkTable)
		{
			networkTable.SetActive(false);
		}
		GuiActive = false;
		Action action = delegate
		{
		};
		ProfileController.Instance.DesiredWeaponTag = _assignedWeaponTag;
		ProfileController.Instance.ShowInterface(action, delegate
		{
			GuiActive = true;
			if ((bool)mainMenu)
			{
				mainMenu.SetActive(true);
			}
			if ((bool)nicknameLabel)
			{
				nicknameLabel.SetActive(true);
				NickLabelController component = nicknameLabel.GetComponent<NickLabelController>();
				if (component != null)
				{
					component.UpdaeData();
				}
				else if (Application.isEditor)
				{
					Debug.LogWarning("nickLabelController == null");
				}
			}
			if ((bool)inGameGui)
			{
				inGameGui.SetActive(true);
			}
			if ((bool)networkTable)
			{
				networkTable.SetActive(true);
			}
		});
	}

	public static bool IsWeaponCategory(CategoryNames c)
	{
		return c < CategoryNames.HatsCategory;
	}

	public static bool IsWearCategory(CategoryNames c)
	{
		return c == CategoryNames.CapesCategory || c == CategoryNames.BootsCategory || c == CategoryNames.HatsCategory || c == CategoryNames.ArmorCategory;
	}

	private string[] _CurrentWeaponSetIDs()
	{
		string[] array = new string[5];
		WeaponManager sharedManager = WeaponManager.sharedManager;
		int num = 0;
		for (int i = 0; i < array.Length; i++)
		{
			if (num >= sharedManager.playerWeapons.Count)
			{
				array[i] = null;
				continue;
			}
			Weapon weapon = sharedManager.playerWeapons[num] as Weapon;
			if (weapon.weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1 == i)
			{
				num++;
				array[i] = weapon.weaponPrefab.tag;
			}
			else
			{
				array[i] = null;
			}
		}
		return array;
	}

	public static void ShowRentScreen(string itemTag, Transform point, string lr, string hdr, string rentText, Action<string> onPurchase = null, Action onEnterCoinsShopAdditional = null, Action onExitCoinsShopAdditional = null, Action<string> customEquipWearAction = null)
	{
		GameObject original = Resources.Load<GameObject>("RentScreen");
		GameObject gameObject = UnityEngine.Object.Instantiate(original) as GameObject;
		RentScreenController component = gameObject.GetComponent<RentScreenController>();
		Player_move_c.SetLayerRecursively(component.gameObject, LayerMask.NameToLayer(lr));
		component.transform.parent = point;
		component.transform.localPosition = new Vector3(0f, 0f, -130f);
		component.transform.localScale = new Vector3(1f, 1f, 1f);
		component.ItemTag = itemTag;
		component.Header = hdr;
		component.RentFor = rentText;
		component.onPurchaseCustomAction = onPurchase;
		component.onEnterCoinsShopAdditionalAction = onEnterCoinsShopAdditional;
		component.onExitCoinsShopAdditionalAction = onExitCoinsShopAdditional;
		component.customEquipWearAction = customEquipWearAction;
	}

	public void HandleRentButton()
	{
		if (Defs.isSoundFX)
		{
			ButtonClickSound.Instance.PlayClick();
		}
		bool hasBefore = TempItemsController.sharedController != null && TempItemsController.sharedController.ContainsItem(viewedId);
		CategoryNames c = currentCategory;
		ShowRentScreen(viewedId, rentScreenPoint, "NGUIShop", LocalizationStore.Get("Key_1149"), LocalizationStore.Get("Key_1150"), delegate
		{
			chosenId = WeaponManager.LastBoughtTag(viewedId);
			viewedId = ((currentCategory != CategoryNames.GearCategory) ? chosenId : GearManager.NameForUpgrade(GearManager.HolderQuantityForID(viewedId), GearManager.CurrentNumberOfUphradesForGear(GearManager.HolderQuantityForID(viewedId))));
			UpdateButtons();
			UpdateIcon(c);
			if (hasBefore)
			{
				purchaseSuccessfulRent.SetActive(true);
				_timePurchaseRentSuccessfulShown = Time.realtimeSinceStartup;
			}
			else
			{
				purchaseSuccessful.SetActive(true);
				_timePurchaseSuccessfulShown = Time.realtimeSinceStartup;
			}
		}, delegate
		{
			SetBankCamerasEnabled();
		}, delegate
		{
			SetOtherCamerasEnabled(false);
		}, delegate(string tg)
		{
			if (tg != null)
			{
				EquipWearInCategoryIfNotEquiped(tg, c, inGame);
			}
		});
	}

	public void HandlePropertiesInfoButton()
	{
		if (WeaponCategory)
		{
			if (Defs.isSoundFX)
			{
				ButtonClickSound.Instance.PlayClick();
			}
			infoScreen.Show(currentCategory == CategoryNames.MeleeCategory);
		}
	}

	private void ReloadCarousel(string idToChoose = null)
	{
		ShopCarouselElement[] componentsInChildren = wrapContent.GetComponentsInChildren<ShopCarouselElement>(true);
		ShopCarouselElement[] array = componentsInChildren;
		foreach (ShopCarouselElement shopCarouselElement in array)
		{
			UnityEngine.Object.Destroy(shopCarouselElement.gameObject);
			shopCarouselElement.transform.parent = null;
		}
		wrapContent.Reposition();
		List<GameObject> list = FillModelsList(currentCategory);
		string[] array2 = new string[SkinsController.skinsForPers.Keys.Count + 1];
		List<string> list2 = SkinsController.skinsForPers.Keys.ToList();
		list2.Sort(delegate(string kvp1, string kvp2)
		{
			//Discarded unreachable code: IL_001a, IL_0027
			try
			{
				return int.Parse(kvp1).CompareTo(int.Parse(kvp2));
			}
			catch (Exception)
			{
				return 0;
			}
		});
		int num = list2.FindIndex(delegate(string kvp)
		{
			//Discarded unreachable code: IL_0016, IL_0023
			try
			{
				return int.Parse(kvp) >= 1000;
			}
			catch (Exception)
			{
				return false;
			}
		});
		int num2 = 0;
		if (num >= 0 && num < list2.Count)
		{
			List<string> list3 = new List<string>();
			list3.AddRange(list2.GetRange(num, list2.Count - num));
			list3.Reverse();
			list3.CopyTo(array2);
			num2 = list3.Count;
			array2[num2] = "CustomSkinID";
			num2++;
			list2.CopyTo(0, array2, num2, num);
		}
		else
		{
			array2[0] = "CustomSkinID";
			num2++;
			list2.CopyTo(array2, 1);
		}
		if (EnableConfigurePos)
		{
			List<string> list4 = new List<string>();
			List<GameObject> list5 = new List<GameObject>();
			for (int j = 0; j < list.Count; j++)
			{
				List<string> list6 = null;
				foreach (List<string> upgrade in WeaponUpgrades.upgrades)
				{
					if (upgrade.Contains(list[j].tag))
					{
						list6 = upgrade;
						break;
					}
				}
				if (list6 == null)
				{
					list5.Add(list[j]);
					continue;
				}
				for (int k = 0; k < list6.Count; k++)
				{
					UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
					for (int l = 0; l < weaponsInGame.Length; l++)
					{
						GameObject gameObject = (GameObject)weaponsInGame[l];
						if (gameObject.tag.Equals(list6[k]))
						{
							list5.Add(gameObject);
							break;
						}
					}
				}
			}
			list = list5;
		}
		for (int m = 0; m < list.Count; m++)
		{
			GameObject original = Resources.Load<GameObject>("ShopCarouselElement");
			GameObject gameObject2 = UnityEngine.Object.Instantiate(original) as GameObject;
			gameObject2.transform.parent = wrapContent.transform;
			gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
			GameObject gameObject3 = list[m];
			gameObject2.name = m.ToString("D7");
			if (WeaponCategory)
			{
				gameObject2.name = gameObject2.name + "_" + int.Parse(gameObject3.name.Substring("Weapon".Length)).ToString("D5");
			}
			ShopCarouselElement sce = gameObject2.GetComponent<ShopCarouselElement>();
			string itenID = ((!WeaponCategory) ? ((currentCategory != CategoryNames.SkinsCategory) ? ItemIDForPrefabReverse(gameObject3.name, currentCategory) : array2[m]) : gameObject3.tag);
			AddModel((!WeaponCategory) ? gameObject3 : WeaponManager.InnerPrefabForWeapon(gameObject3), delegate(GameObject manipulateObject, Vector3 positionShop, Vector3 rotationShop, string readableName, float scaleCoefShop, int tier)
			{
				manipulateObject.transform.parent = sce.transform;
				sce.itemID = itenID;
				sce.baseScale = new Vector3(scaleCoefShop, scaleCoefShop, scaleCoefShop);
				sce.model = manipulateObject.transform;
				sce.ourPosition = positionShop;
				sce.SetPos((!EnableConfigurePos) ? 0f : 1f, 0f);
				sce.model.Rotate(rotationShop, Space.World);
				sce.readableName = readableName ?? string.Empty;
				if (currentCategory == CategoryNames.GearCategory)
				{
					sce.showQuantity = true;
					sce.SetQuantity();
				}
				if (!Defs.IsTraining && ExpController.Instance != null && ExpController.Instance.OurTier < tier && tier < 100 && ((WeaponCategory && sce.itemID.Equals(WeaponManager.FirstUnboughtOrForOurTier(sce.itemID))) || (WearCategory && sce.itemID.Equals(WeaponManager.FirstUnboughtTag(sce.itemID)) && sce.itemID != Wear.cape_Custom && sce.itemID != Wear.boots_tabi)) && sce.locked != null)
				{
					sce.locked.SetActive(true);
				}
				if ((!Defs.IsTraining && ((WeaponCategory && !sce.itemID.Equals(WeaponManager.FirstUnboughtOrForOurTier(sce.itemID)) && tier < 100) || (WearCategory && !sce.itemID.Equals(WeaponManager.FirstUnboughtTag(sce.itemID))))) || (Defs.IsTraining && (((trainStep == 0 || trainStep == 1) && itenID.Equals(WeaponTags.GrenadeLuancher_2Tag)) || (trainStep == 1 && trainBought2 && itenID.Equals(WeaponTags.grenade_launcher_3_Tag)) || ((trainStep == 4 || (trainStep == 3 && armorBougt1)) && itenID.Equals(Wear.Armor_Army_1)) || (trainStep == 4 && armorBought2 && itenID.Equals(Wear.Armor_Army_2)))))
				{
					if (sce.arrow != null)
					{
						sce.arrow.gameObject.SetActive(true);
					}
					if (currentCategory == CategoryNames.HatsCategory)
					{
						sce.arrnoInitialPos = new Vector3(85f, sce.arrnoInitialPos.y, sce.arrnoInitialPos.z);
					}
					if (currentCategory == CategoryNames.ArmorCategory)
					{
						sce.arrnoInitialPos = new Vector3(105f, sce.arrnoInitialPos.y, sce.arrnoInitialPos.z);
					}
					if (currentCategory == CategoryNames.CapesCategory)
					{
						sce.arrnoInitialPos = new Vector3(75f, sce.arrnoInitialPos.y, sce.arrnoInitialPos.z);
					}
					if (currentCategory == CategoryNames.BootsCategory)
					{
						sce.arrnoInitialPos = new Vector3(81f, sce.arrnoInitialPos.y, sce.arrnoInitialPos.z);
					}
				}
				if (currentCategory == CategoryNames.SkinsCategory)
				{
					sce.readableName = (itenID.Equals("CustomSkinID") ? LocalizationStore.Get("Key_1090") : ((!SkinsController.skinsNamesForPers.ContainsKey(itenID)) ? string.Empty : SkinsController.skinsNamesForPers[itenID]));
					Player_move_c.SetTextureRecursivelyFrom(manipulateObject, (!itenID.Equals("CustomSkinID")) ? SkinsController.skinsForPers[itenID] : (Resources.Load("Skin_Start") as Texture), new GameObject[0]);
					bool flag = false;
					bool flag2 = false;
					if (itenID != null && SkinsController.shopKeyFromNameSkin.ContainsKey(itenID))
					{
						string value = SkinsController.shopKeyFromNameSkin[itenID];
						if (Array.IndexOf(StoreKitEventListener.skinIDs, value) >= 0)
						{
							foreach (KeyValuePair<string, string> value2 in InAppData.inAppData.Values)
							{
								if (value2.Key != null && value2.Key.Equals(value))
								{
									flag2 = Storager.getInt(value2.Value, true) > 0;
									break;
								}
							}
						}
					}
				}
				if (PromoActionsManager.sharedManager.topSellers.Contains(itenID))
				{
					sce.showTS = true;
				}
				if (PromoActionsManager.sharedManager.news.Contains(itenID))
				{
					sce.showNew = true;
				}
				if (itenID.Equals(Wear.cape_Custom) && SkinsController.capeUserTexture != null)
				{
					Player_move_c.SetTextureRecursivelyFrom(manipulateObject, SkinsController.capeUserTexture, new GameObject[0]);
				}
			}, currentCategory, false, (!WeaponCategory) ? null : gameObject3.GetComponent<WeaponSounds>());
		}
		wrapContent.Reposition();
		ChooseCarouselItem(idToChoose ?? viewedId, true);
	}

	public static void AddModel(GameObject pref, Action6<GameObject, Vector3, Vector3, string, float, int> act, CategoryNames c, bool isButtonInGameGui = false, WeaponSounds wsForPos = null)
	{
		float arg = 150f;
		Vector3 arg2 = Vector3.zero;
		Vector3 arg3 = Vector3.zero;
		GameObject gameObject = null;
		int arg4 = 0;
		string arg5 = null;
		if (IsWeaponCategory(c))
		{
			arg = wsForPos.scaleShop;
			arg2 = wsForPos.positionShop;
			arg3 = wsForPos.rotationShop;
			gameObject = pref.GetComponent<InnerWeaponPars>().bonusPrefab;
			arg5 = wsForPos.shopName;
			arg4 = wsForPos.tier;
		}
		else
		{
			switch (c)
			{
			case CategoryNames.SkinsCategory:
			{
				gameObject = UnityEngine.Object.Instantiate(pref) as GameObject;
				ShopPositionParams component2 = pref.GetComponent<ShopPositionParams>();
				arg3 = component2.rotationShop;
				arg = component2.scaleShop;
				arg2 = component2.positionShop;
				arg4 = component2.tier;
				break;
			}
			case CategoryNames.HatsCategory:
			case CategoryNames.ArmorCategory:
			case CategoryNames.CapesCategory:
			case CategoryNames.BootsCategory:
			case CategoryNames.GearCategory:
			{
				gameObject = pref.transform.GetChild(0).gameObject;
				ShopPositionParams component = pref.GetComponent<ShopPositionParams>();
				arg3 = component.rotationShop;
				arg = component.scaleShop;
				arg2 = component.positionShop;
				arg5 = component.shopName;
				arg4 = component.tier;
				break;
			}
			}
		}
		Vector3 localPosition = Vector3.zero;
		GameObject gameObject2 = null;
		if (c == CategoryNames.SkinsCategory)
		{
			gameObject2 = gameObject;
			localPosition = new Vector3(0f, -1f, 0f);
		}
		else if (gameObject != null)
		{
			Material[] array = null;
			Mesh mesh = null;
			SkinnedMeshRenderer skinnedMeshRenderer = gameObject.GetComponent<SkinnedMeshRenderer>();
			if (skinnedMeshRenderer == null)
			{
				SkinnedMeshRenderer[] componentsInChildren = gameObject.GetComponentsInChildren<SkinnedMeshRenderer>(true);
				if (componentsInChildren != null && componentsInChildren.Length > 0)
				{
					skinnedMeshRenderer = componentsInChildren[0];
				}
			}
			if (skinnedMeshRenderer != null)
			{
				array = skinnedMeshRenderer.sharedMaterials;
				mesh = skinnedMeshRenderer.sharedMesh;
			}
			else
			{
				MeshFilter component3 = gameObject.GetComponent<MeshFilter>();
				MeshRenderer component4 = gameObject.GetComponent<MeshRenderer>();
				if (component3 != null)
				{
					mesh = component3.sharedMesh;
				}
				if (component4 != null)
				{
					array = component4.sharedMaterials;
				}
			}
			if (array != null && mesh != null)
			{
				gameObject2 = new GameObject();
				gameObject2.AddComponent<MeshFilter>().sharedMesh = mesh;
				MeshRenderer meshRenderer = gameObject2.AddComponent<MeshRenderer>();
				meshRenderer.materials = array;
				localPosition = -meshRenderer.bounds.center;
			}
		}
		GameObject gameObject3 = new GameObject();
		gameObject3.name = gameObject2.name;
		gameObject2.transform.localPosition = localPosition;
		gameObject2.transform.parent = gameObject3.transform;
		Player_move_c.SetLayerRecursively(gameObject3, LayerMask.NameToLayer("NGUIShop"));
		if (act != null)
		{
			act(gameObject3, arg2, arg3, arg5, arg, arg4);
		}
	}

	public void ChooseCarouselItem(string itemID, bool moveCarousel = false, bool setManuallyToChosen = false)
	{
		if (itemID == null)
		{
			if (WeaponCategory)
			{
				UpdatePersWithNewItem();
			}
			return;
		}
		ShopCarouselElement[] array = wrapContent.GetComponentsInChildren<ShopCarouselElement>(true);
		if (array == null)
		{
			array = new ShopCarouselElement[0];
		}
		ShopCarouselElement[] array2 = array;
		foreach (ShopCarouselElement shopCarouselElement in array2)
		{
			if (!shopCarouselElement.itemID.Equals(itemID))
			{
				continue;
			}
			if (moveCarousel || setManuallyToChosen)
			{
				SpringPanel component = scrollViewPanel.GetComponent<SpringPanel>();
				if (component != null)
				{
					UnityEngine.Object.Destroy(component);
				}
				if (scrollViewPanel.gameObject.activeInHierarchy)
				{
					scrollViewPanel.GetComponent<UIScrollView>().MoveRelative(new Vector3(0f - shopCarouselElement.transform.localPosition.x - scrollViewPanel.transform.localPosition.x, scrollViewPanel.transform.localPosition.y, scrollViewPanel.transform.localPosition.z));
				}
				wrapContent.Reposition();
			}
			viewedId = itemID;
			UpdatePersWithNewItem();
			UpdateButtons();
			UpdateItemParameters();
			caption.text = shopCarouselElement.readableName ?? string.Empty;
			caption.applyGradient = TempItemsController.PriceCoefs.ContainsKey(itemID);
			SetLabelsForElem(shopCarouselElement);
			break;
		}
	}

	private int TierForWear(string v, CategoryNames c)
	{
		if (v == null)
		{
			return 0;
		}
		List<string> list = null;
		foreach (List<string> item in Wear.wear[c])
		{
			if (item.Contains(v))
			{
				list = item;
				break;
			}
		}
		if (list == null)
		{
			return 0;
		}
		List<GameObject> list2 = null;
		switch (c)
		{
		case CategoryNames.HatsCategory:
			list2 = hats;
			break;
		case CategoryNames.ArmorCategory:
			list2 = armor;
			break;
		case CategoryNames.CapesCategory:
			list2 = capes;
			break;
		case CategoryNames.BootsCategory:
			list2 = boots;
			break;
		}
		foreach (GameObject item2 in list2)
		{
			if (item2.name.Equals(v))
			{
				return item2.GetComponent<ShopPositionParams>().tier;
			}
		}
		return 0;
	}

	private void SetUpUpgradesAndTiers(bool bought, ref bool buyActive, ref bool upgradeActive, ref bool saleActive, ref bool needTierActive, ref bool rentActive, ref bool saleRentActive)
	{
		bool flag = TempItemsController.PriceCoefs.ContainsKey(viewedId);
		bool maxUpgrade = false;
		int num = ((viewedId == null) ? (-1) : _CurrentNumberOfWearUpgrades(viewedId, out maxUpgrade, currentCategory));
		bool flag2 = maxUpgrade;
		if (Defs.IsTraining)
		{
			buyActive = viewedId != null && viewedId.Equals(Wear.Armor_Army_1) && Defs.IsTraining;
			upgradeActive = viewedId != null && (viewedId.Equals(Wear.Armor_Army_2) || viewedId.Equals(Wear.Armor_Army_3)) && Defs.IsTraining;
		}
		else
		{
			buyActive = viewedId != null && !flag2 && num == 0 && !viewedId.Equals(Wear.cape_Custom) && !flag;
			upgradeActive = viewedId != null && !flag2 && num != 0 && !flag;
			rentActive = false;
		}
		if (!flag2)
		{
			int num2 = TierForWear(WeaponManager.FirstUnboughtTag(viewedId), currentCategory);
			needTierActive = !Defs.IsTraining && upgradeActive && ExpController.Instance != null && ExpController.Instance.OurTier < num2 && !flag;
			if (needTierActive)
			{
				int num3 = ((num2 < 0 || num2 >= ExpController.LevelsForTiers.Length) ? ExpController.LevelsForTiers[ExpController.LevelsForTiers.Length - 1] : ExpController.LevelsForTiers[num2]);
				string text = string.Format("{0} {1} {2}", LocalizationStore.Key_0226, num3, LocalizationStore.Get("Key_1022"));
				needTierLabel.text = text;
			}
			upgrade.isEnabled = (Defs.IsTraining || !upgradeActive || !(ExpController.Instance != null) || ExpController.Instance.OurTier >= num2) && !flag;
		}
		string text2 = WeaponManager.FirstUnboughtTag(viewedId);
		if (!flag2 && !flag && !needTierActive && PromoActionsManager.sharedManager.discounts.ContainsKey(text2) && PromoActionsManager.sharedManager.discounts[text2].Count > 0 && (text2 == null || !text2.Equals(Wear.cape_Custom) || !inGame))
		{
			saleActive = !Defs.IsTraining;
			salePerc.text = PromoActionsManager.sharedManager.discounts[text2][0] + "%";
		}
		else
		{
			saleActive = false;
		}
		saleRentActive = false;
	}

	private void UpdateButtons()
	{
		bool flag = false;
		bool flag2 = false;
		bool flag3 = false;
		bool flag4 = false;
		bool flag5 = false;
		bool flag6 = false;
		bool buyActive = false;
		bool rentActive = false;
		bool flag7 = false;
		wholePrice2Gear.SetActive(false);
		bool upgradeActive = false;
		bool[] array = new bool[2];
		bool saleActive = false;
		bool flag8 = false;
		bool needTierActive = false;
		bool isTempItem = viewedId != null && TempItemsController.PriceCoefs.ContainsKey(viewedId);
		rentProperties.SetActive(viewedId != null && TempItemsController.IsCategoryContainsTempItems(currentCategory) && TempItemsController.PriceCoefs.ContainsKey(viewedId));
		prolongateRentText.SetActive(viewedId != null && TempItemsController.PriceCoefs.ContainsKey(viewedId) && TempItemsController.sharedController != null && TempItemsController.sharedController.ContainsItem(viewedId));
		bool saleRentActive = false;
		upgrade.isEnabled = true;
		upgradeGear.isEnabled = true;
		if (WeaponCategory)
		{
			WeaponSounds weaponSounds = null;
			WeaponSounds weaponSounds2 = null;
			string text = null;
			string text2 = null;
			if (viewedId != null)
			{
				text = WeaponManager.FirstUnboughtTag(viewedId) ?? viewedId;
				string text3 = WeaponManager.FirstTagForOurTier(viewedId);
				List<string> list = WeaponUpgrades.ChainForTag(viewedId);
				if (text3 != null && list != null && list.IndexOf(text3) > list.IndexOf(text))
				{
					text = text3;
				}
				text2 = WeaponManager.LastBoughtTag(viewedId);
				UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
				for (int i = 0; i < weaponsInGame.Length; i++)
				{
					GameObject gameObject = (GameObject)weaponsInGame[i];
					if (!gameObject.tag.Equals(text2 ?? viewedId))
					{
						continue;
					}
					weaponSounds = gameObject.GetComponent<WeaponSounds>();
					UnityEngine.Object[] weaponsInGame2 = WeaponManager.sharedManager.weaponsInGame;
					for (int j = 0; j < weaponsInGame2.Length; j++)
					{
						GameObject gameObject2 = (GameObject)weaponsInGame2[j];
						if (gameObject2.tag.Equals(text))
						{
							weaponSounds2 = gameObject2.GetComponent<WeaponSounds>();
							break;
						}
					}
					break;
				}
			}
			bool flag9 = false;
			bool maxUpgrade = false;
			int num = ((viewedId == null) ? (-1) : _CurrentNumberOfUpgrades(viewedId, out maxUpgrade, currentCategory));
			flag9 = maxUpgrade;
			buyActive = viewedId != null && !flag9 && num == 0 && !isTempItem;
			upgradeActive = viewedId != null && !flag9 && num != 0 && weaponSounds2.tier < 100 && !isTempItem;
			rentActive = false;
			needTierActive = !Defs.IsTraining && upgradeActive && weaponSounds2 != null && ExpController.Instance != null && ExpController.Instance.OurTier < weaponSounds2.tier && !isTempItem;
			if (needTierActive)
			{
				int num2 = ((weaponSounds2.tier < 0 || weaponSounds2.tier >= ExpController.LevelsForTiers.Length) ? ExpController.LevelsForTiers[ExpController.LevelsForTiers.Length - 1] : ExpController.LevelsForTiers[weaponSounds2.tier]);
				string text4 = string.Format("{0} {1} {2}", LocalizationStore.Key_0226, num2, LocalizationStore.Get("Key_1022"));
				needTierLabel.text = text4;
			}
			upgrade.isEnabled = Defs.IsTraining || !upgradeActive || !(weaponSounds2 != null) || !(ExpController.Instance != null) || ExpController.Instance.OurTier >= weaponSounds2.tier;
			string text5 = null;
			if (viewedId != null)
			{
				text5 = WeaponManager.LastBoughtTag(viewedId);
			}
			bool flag10 = text5 != null && viewedId != null && (chosenId == null || !chosenId.Equals(text5)) && num > 0 && viewedId != null;
			bool flag11 = !string.IsNullOrEmpty(viewedId) && _CurrentWeaponSetIDs()[(int)currentCategory] != null && _CurrentWeaponSetIDs()[(int)currentCategory].Equals(WeaponManager.LastBoughtTag(viewedId) ?? string.Empty);
			if ((upgradeActive || isTempItem) && viewedId != null && text != null && (isTempItem || !text.Equals(viewedId)) && flag10)
			{
				flag4 = !Defs.IsTraining;
				flag5 = false;
			}
			if ((upgradeActive || isTempItem) && viewedId != null && text != null && (isTempItem || !text.Equals(viewedId)) && flag11)
			{
				array[0] = true;
				array[1] = false;
			}
			if (!upgradeActive && !isTempItem && !buyActive && flag10)
			{
				flag4 = false;
				flag5 = !Defs.IsTraining;
			}
			if (!upgradeActive && !isTempItem && !buyActive && flag11)
			{
				array[0] = false;
				array[1] = true;
			}
			if (!flag9 && !isTempItem && weaponSounds != null && weaponSounds.tier < 100 && !needTierActive && PromoActionsManager.sharedManager.discounts.ContainsKey(text) && PromoActionsManager.sharedManager.discounts[text].Count > 0)
			{
				saleActive = !Defs.IsTraining;
				salePerc.text = PromoActionsManager.sharedManager.discounts[text][0] + "%";
			}
			else
			{
				saleActive = false;
			}
			saleRentActive = false;
			if (text != null)
			{
				int num3 = 1;
				int num4 = 0;
				if (num3 == 1 && text2 != null && text.Equals(text2))
				{
					num4 = 1;
				}
				foreach (List<string> upgrade in WeaponUpgrades.upgrades)
				{
					if (!upgrade.Contains(text))
					{
						continue;
					}
					num3 = upgrade.Count;
					if (text2 != null)
					{
						num4 = upgrade.IndexOf(text2) + 1;
						break;
					}
					string text6 = WeaponManager.FirstTagForOurTier(text);
					if (text6 != null && upgrade.IndexOf(text6) > 0)
					{
						num4 = upgrade.IndexOf(text6);
					}
					break;
				}
				bool flag12 = !weaponSounds.isMelee && viewedId != null;
				if (weaponProperties.activeSelf != flag12)
				{
					weaponProperties.SetActive(flag12);
				}
				bool flag13 = weaponSounds.isMelee && viewedId != null;
				if (meleeProperties.activeSelf != flag13)
				{
					meleeProperties.SetActive(flag13);
				}
				if (upgradesAnchor.activeSelf != (viewedId != null && !isTempItem))
				{
					upgradesAnchor.SetActive(viewedId != null && !isTempItem);
				}
				bool flag14 = num3 == 1 && !isTempItem;
				if (upgrade_1.activeSelf != flag14)
				{
					upgrade_1.SetActive(flag14);
				}
				bool flag15 = num3 == 2 && !isTempItem;
				if (upgrade_2.activeSelf != flag15)
				{
					upgrade_2.SetActive(flag15);
				}
				bool flag16 = num3 == 3 && !isTempItem;
				if (upgrade_3.activeSelf != flag16)
				{
					upgrade_3.SetActive(flag16);
				}
				if (num3 > 0)
				{
					GameObject obj;
					switch (num3)
					{
					case 3:
						obj = upgrade_3;
						break;
					case 2:
						obj = upgrade_2;
						break;
					default:
						obj = upgrade_1;
						break;
					}
					GameObject gameObject3 = obj;
					UISprite[] array2 = gameObject3.GetComponentsInChildren<UISprite>(true);
					if (array2 == null)
					{
						array2 = new UISprite[0];
					}
					Array.Sort(array2, (UISprite sp1, UISprite sp2) => Defs.CompareAlphaNumerically(sp1.gameObject.name, sp2.gameObject.name));
					for (int k = 0; k < array2.Length; k++)
					{
						array2[k].spriteName = ((num4 <= k) ? "shop_stat_yellow" : "shop_stat_green");
					}
				}
				UpdateTempItemTime();
				if (weaponSounds2 == null)
				{
					weaponSounds2 = weaponSounds;
				}
				int[] array3 = null;
				array3 = ((!weaponSounds.isMelee) ? new int[4]
				{
					(!isTempItem) ? weaponSounds.damageShop : ((int)weaponSounds.DPS),
					weaponSounds.fireRateShop,
					weaponSounds.CapacityShop,
					weaponSounds.mobilityShop
				} : new int[3]
				{
					(!isTempItem) ? weaponSounds.damageShop : ((int)weaponSounds.DPS),
					weaponSounds.fireRateShop,
					weaponSounds.mobilityShop
				});
				int[] array4 = null;
				array4 = ((!weaponSounds.isMelee) ? new int[4]
				{
					(!isTempItem) ? weaponSounds2.damageShop : ((int)weaponSounds2.DPS),
					weaponSounds2.fireRateShop,
					weaponSounds2.CapacityShop,
					weaponSounds2.mobilityShop
				} : new int[3]
				{
					(!isTempItem) ? weaponSounds2.damageShop : ((int)weaponSounds2.DPS),
					weaponSounds2.fireRateShop,
					weaponSounds2.mobilityShop
				});
				int[] array5 = ((text2 == null || text == null || !(text2 != text) || viewedId == null || !(text2 == viewedId)) ? array4 : array3);
				if (weaponSounds.isMelee)
				{
					damageMelee.text = GetWeaponStatText(array3[0], array5[0]);
					fireRateMElee.text = GetWeaponStatText(array3[1], array5[1]);
					mobilityMelee.text = GetWeaponStatText(array3[2], array5[2]);
				}
				else
				{
					damage.text = GetWeaponStatText(array3[0], array5[0]);
					fireRate.text = GetWeaponStatText(array3[1], array5[1]);
					capacity.text = GetWeaponStatText(array3[2], array5[2]);
					mobility.text = GetWeaponStatText(array3[3], array5[3]);
				}
				if (!SpecialParams.activeSelf)
				{
					SpecialParams.SetActive(true);
				}
				float y = 0.81500006f;
				if (weaponSounds2 == null)
				{
					weaponSounds2 = weaponSounds;
				}
				if (weaponSounds2 != null)
				{
					int num5 = 0;
					num5 = ((weaponSounds2.zoomShop > 0) ? 1 : 0) + (weaponSounds2.AreaDamageShop ? 1 : 0) + (weaponSounds2.WallsBreakShop ? 1 : 0) + (weaponSounds2.AOE ? 1 : 0);
					if (num5 < 3)
					{
						bool flag17 = weaponSounds2.zoomShop > 0;
						if (zoomLabel.gameObject.activeSelf != flag17)
						{
							zoomLabel.gameObject.SetActive(flag17);
						}
						zoomLabel.text = string.Format("{0}X {1}", weaponSounds2.zoomShop.ToString(), LocalizationStore.Get("Key_0404"));
						bool areaDamageShop = weaponSounds2.AreaDamageShop;
						if (areaDamageLabel.gameObject.activeSelf != areaDamageShop)
						{
							areaDamageLabel.gameObject.SetActive(areaDamageShop);
						}
						if (AOELabel.gameObject.activeSelf != weaponSounds2.AOE)
						{
							AOELabel.gameObject.SetActive(weaponSounds2.AOE);
							if (weaponSounds2.AOE)
							{
								AOELabel.text = LocalizationStore.Get(weaponSounds2.AOEText);
							}
						}
						if (wallBreakLabel.gameObject.activeSelf != weaponSounds2.WallsBreakShop)
						{
							wallBreakLabel.gameObject.SetActive(weaponSounds2.WallsBreakShop);
						}
						if (num5 == 2)
						{
							if (weaponSounds2.zoomShop > 0)
							{
								zoomLabel.transform.localPosition = new Vector3(zoomLabel.transform.localPosition.x, 14.33f, zoomLabel.transform.localPosition.z);
								if (weaponSounds2.AreaDamageShop)
								{
									areaDamageLabel.transform.localPosition = new Vector3(areaDamageLabel.transform.localPosition.x, -12.7f, areaDamageLabel.transform.localPosition.z);
								}
								else if (weaponSounds2.AOE)
								{
									AOELabel.transform.localPosition = new Vector3(AOELabel.transform.localPosition.x, -12.7f, AOELabel.transform.localPosition.z);
								}
								else
								{
									wallBreakLabel.transform.localPosition = new Vector3(wallBreakLabel.transform.localPosition.x, -12.7f, wallBreakLabel.transform.localPosition.z);
								}
							}
							else
							{
								if (weaponSounds2.AreaDamageShop)
								{
									areaDamageLabel.transform.localPosition = new Vector3(areaDamageLabel.transform.localPosition.x, 14.33f, areaDamageLabel.transform.localPosition.z);
								}
								else
								{
									AOELabel.transform.localPosition = new Vector3(AOELabel.transform.localPosition.x, 14.33f, AOELabel.transform.localPosition.z);
								}
								wallBreakLabel.transform.localPosition = new Vector3(wallBreakLabel.transform.localPosition.x, -12.7f, wallBreakLabel.transform.localPosition.z);
							}
						}
						else
						{
							Transform transform = ((weaponSounds2.zoomShop > 0) ? zoomLabel.transform : (weaponSounds2.AreaDamageShop ? areaDamageLabel.transform : (weaponSounds2.WallsBreakShop ? wallBreakLabel.transform : ((!weaponSounds2.AOE) ? null : AOELabel.transform))));
							if (transform != null)
							{
								transform.localPosition = new Vector3(transform.localPosition.x, y, transform.localPosition.z);
							}
						}
					}
				}
			}
		}
		else
		{
			if (weaponProperties.activeSelf)
			{
				weaponProperties.SetActive(false);
			}
			if (meleeProperties.activeSelf)
			{
				meleeProperties.SetActive(false);
			}
			if (upgradesAnchor.activeSelf)
			{
				upgradesAnchor.SetActive(false);
			}
			if (SpecialParams.activeSelf)
			{
				SpecialParams.SetActive(false);
			}
			switch (currentCategory)
			{
			case CategoryNames.HatsCategory:
			case CategoryNames.ArmorCategory:
			case CategoryNames.CapesCategory:
			case CategoryNames.BootsCategory:
			{
				string text8 = WeaponManager.LastBoughtTag(viewedId);
				bool flag24 = text8 != null;
				bool flag25 = flag24 && _CurrentEquippedWear.Equals(text8);
				string text9 = WeaponManager.FirstUnboughtTag(viewedId);
				SetUpUpgradesAndTiers(flag24, ref buyActive, ref upgradeActive, ref saleActive, ref needTierActive, ref rentActive, ref saleRentActive);
				bool flag26 = flag24 && !flag25 && text8 != null && text8.Equals(viewedId);
				flag6 = flag24 && flag25 && !Defs.IsTraining && text8 != null && text8.Equals(viewedId);
				bool flag27 = text8 != null && _CurrentEquippedWear.Equals(text8) && !upgradeActive && !isTempItem;
				if (!flag24 && viewedId != null && viewedId.Equals(Wear.cape_Custom))
				{
					flag = !inGame && !Defs.IsTraining;
				}
				if (!inGame && flag24 && viewedId != null && viewedId.Equals(Wear.cape_Custom))
				{
					flag2 = !Defs.IsTraining;
				}
				if (upgradeActive || isTempItem)
				{
					flag4 = flag26 && (isTempItem || (!Defs.IsTraining && viewedId != null && text9 != null && (text8 == null || text8.Equals(text9) || !text9.Equals(viewedId))));
					flag5 = false;
				}
				else
				{
					flag4 = false;
					flag5 = flag26 && !Defs.IsTraining && viewedId != null && text9 != null && (text8 == null || text8.Equals(text9) || !text9.Equals(viewedId));
				}
				if (viewedId != null && viewedId.Equals(Wear.cape_Custom) && flag24)
				{
					array[1] = flag27 && !Defs.IsTraining;
					array[0] = false;
				}
				else
				{
					array[(!upgradeActive) ? 1 : 0] = flag27 && (isTempItem || (!Defs.IsTraining && viewedId != null && text9 != null && (text8 == null || text8.Equals(text9) || !text9.Equals(viewedId))));
					array[upgradeActive ? 1 : 0] = false;
				}
				Action<Transform> action = delegate(Transform propertiesTransform)
				{
					foreach (Transform item in propertiesTransform)
					{
						bool flag28 = viewedId != null && item.gameObject.name.Equals(viewedId);
						item.gameObject.SetActive(flag28);
						if (flag28 && isTempItem && Wear.armorNumTemp.ContainsKey(viewedId) && ExpController.Instance != null && Wear.armorNumTemp[viewedId].Count > ExpController.Instance.OurTier)
						{
							Player_move_c.PerformActionRecurs(item.gameObject, delegate(Transform tt)
							{
								if (tt.name.Equals("ArmorNumLabel"))
								{
									UILabel component = tt.GetComponent<UILabel>();
									if (component != null)
									{
										component.text = Wear.armorNumTemp[viewedId][ExpController.Instance.OurTier].ToString();
									}
								}
							});
						}
					}
				};
				if (currentCategory == CategoryNames.CapesCategory)
				{
					action(capeProperties.transform);
				}
				if (currentCategory == CategoryNames.HatsCategory)
				{
					action(hatsProperties.transform);
				}
				if (currentCategory == CategoryNames.BootsCategory)
				{
					action(bootsProperties.transform);
				}
				if (currentCategory == CategoryNames.ArmorCategory)
				{
					action(armorProperties.transform);
				}
				UpdateTempItemTime();
				break;
			}
			case CategoryNames.SkinsCategory:
			{
				flag = false;
				bool flag18 = false;
				bool flag19 = false;
				bool flag20 = false;
				if (!viewedId.Equals("CustomSkinID"))
				{
					bool flag21 = false;
					bool flag22 = false;
					if (viewedId != null && SkinsController.shopKeyFromNameSkin.ContainsKey(viewedId))
					{
						string value = SkinsController.shopKeyFromNameSkin[viewedId];
						flag21 = Array.IndexOf(StoreKitEventListener.skinIDs, value) >= 0;
						if (flag21)
						{
							foreach (KeyValuePair<string, string> value2 in InAppData.inAppData.Values)
							{
								if (value2.Key != null && value2.Key.Equals(value))
								{
									flag22 = Storager.getInt(value2.Value, true) > 0;
									break;
								}
							}
						}
					}
					buyActive = flag21 && !flag22;
					upgradeActive = false;
					flag19 = (!flag21 || flag22) && !viewedId.Equals(SkinsController.currentSkinNameForPers);
					flag6 = false;
					flag18 = (!flag21 || flag22) && viewedId.Equals(SkinsController.currentSkinNameForPers);
					bool flag23 = false;
					int result;
					flag23 = int.TryParse(viewedId, out result) && result >= 1000;
					flag2 = !inGame && flag23;
					flag3 = flag23;
					if (!flag22 && !needTierActive && PromoActionsManager.sharedManager.discounts.ContainsKey(viewedId) && PromoActionsManager.sharedManager.discounts[viewedId].Count > 0)
					{
						saleActive = true;
						salePerc.text = PromoActionsManager.sharedManager.discounts[viewedId][0] + "%";
					}
					else
					{
						saleActive = false;
					}
				}
				else
				{
					flag20 = Storager.getInt(Defs.SkinsMakerInProfileBought, true) > 0;
					flag = !inGame && !flag20;
					flag2 = false;
					flag8 = !inGame && flag20;
					if (!flag20 && !needTierActive && PromoActionsManager.sharedManager.discounts.ContainsKey(viewedId) && PromoActionsManager.sharedManager.discounts[viewedId].Count > 0 && (viewedId == null || !viewedId.Equals("CustomSkinID") || !inGame))
					{
						saleActive = true;
						salePerc.text = PromoActionsManager.sharedManager.discounts[viewedId][0] + "%";
					}
					else
					{
						saleActive = false;
					}
				}
				flag4 = false;
				flag5 = flag19;
				array[0] = false;
				array[1] = flag18;
				if (currentCategory != CategoryNames.SkinsCategory)
				{
					break;
				}
				foreach (Transform item2 in skinProperties.transform)
				{
					if (viewedId != null && viewedId.Equals("CustomSkinID"))
					{
						if (!flag20)
						{
							item2.gameObject.SetActive(item2.gameObject.name.Equals("Custom_Skin"));
						}
						else
						{
							item2.gameObject.SetActive(item2.gameObject.name.Equals("Custom1_Skin"));
						}
					}
					else
					{
						item2.gameObject.SetActive(item2.gameObject.name.Equals("Usual_Skin"));
					}
				}
				break;
			}
			case CategoryNames.GearCategory:
			{
				flag2 = false;
				upgradeActive = false;
				array[0] = false;
				array[1] = false;
				flag6 = false;
				flag4 = false;
				flag5 = false;
				flag = false;
				flag7 = Storager.getInt(GearManager.HolderQuantityForID(viewedId), false) < GearManager.MaxCountForGear(GearManager.HolderQuantityForID(viewedId));
				ShopPositionParams shopPositionParams = null;
				GameObject gameObject4 = gear.Find((GameObject g) => g.name.Equals(GearManager.NameForUpgrade(GearManager.HolderQuantityForID(viewedId), GearManager.CurrentNumberOfUphradesForGear(GearManager.HolderQuantityForID(viewedId)) + 1)));
				if (gameObject4 != null)
				{
					shopPositionParams = gameObject4.GetComponent<ShopPositionParams>();
				}
				if (shopPositionParams != null && upgradeGear.gameObject.activeInHierarchy)
				{
					needTierActive = !Defs.IsTraining && upgradeGear.gameObject.activeSelf && ExpController.Instance != null && ExpController.Instance.OurTier < shopPositionParams.tier;
					if (needTierActive)
					{
						int num6 = ((shopPositionParams.tier < 0 || shopPositionParams.tier >= ExpController.LevelsForTiers.Length) ? ExpController.LevelsForTiers[ExpController.LevelsForTiers.Length - 1] : ExpController.LevelsForTiers[shopPositionParams.tier]);
						string text7 = string.Format("{0} {1} {2}", LocalizationStore.Key_0226, num6, LocalizationStore.Get("Key_1022"));
						needTierLabel.text = text7;
					}
					upgradeGear.isEnabled = viewedId != null && ExpController.Instance.OurTier >= shopPositionParams.tier;
				}
				foreach (Transform item3 in gearProperties.transform)
				{
					item3.gameObject.SetActive(viewedId != null && item3.gameObject.name.Equals(viewedId));
				}
				break;
			}
			}
		}
		if (edit != null && edit.gameObject.activeSelf != flag2)
		{
			edit.gameObject.SetActive(flag2);
		}
		if (enable != null && enable.gameObject.activeSelf != flag)
		{
			enable.gameObject.SetActive(flag);
		}
		if (delete.gameObject.activeSelf != flag3)
		{
			delete.gameObject.SetActive(flag3);
		}
		if (buy.gameObject.activeSelf != buyActive)
		{
			buy.gameObject.SetActive(buyActive);
		}
		if (rent.gameObject.activeSelf != rentActive)
		{
			rent.gameObject.SetActive(rentActive);
		}
		if (equips[0].gameObject.activeSelf != flag4)
		{
			equips[0].gameObject.SetActive(flag4);
		}
		if (equips[1].gameObject.activeSelf != flag5)
		{
			equips[1].gameObject.SetActive(flag5);
		}
		if (unequip.gameObject.activeSelf != flag6)
		{
			unequip.gameObject.SetActive(flag6);
		}
		if (buyGear.gameObject.activeSelf != flag7)
		{
			buyGear.gameObject.SetActive(flag7);
		}
		if (this.upgrade.gameObject.activeSelf != upgradeActive)
		{
			this.upgrade.gameObject.SetActive(upgradeActive);
		}
		if (equippeds[0].gameObject.activeSelf != array[0])
		{
			equippeds[0].gameObject.SetActive(array[0]);
		}
		if (equippeds[1].gameObject.activeSelf != array[1])
		{
			equippeds[1].gameObject.SetActive(array[1]);
		}
		if (sale.gameObject.activeSelf != saleActive)
		{
			sale.gameObject.SetActive(saleActive);
		}
		if (saleRent.gameObject.activeSelf != saleRentActive)
		{
			saleRent.gameObject.SetActive(saleRentActive);
		}
		if (create.gameObject.activeSelf != flag8)
		{
			create.gameObject.SetActive(flag8);
		}
		if (needTier.gameObject.activeSelf != needTierActive)
		{
			needTier.gameObject.SetActive(needTierActive);
		}
	}

	private void UpdateTempItemTime()
	{
		if (TempItemsController.sharedController != null)
		{
			bool flag = TempItemsController.PriceCoefs.ContainsKey(viewedId) && !TempItemsController.sharedController.ContainsItem(viewedId);
			if (notRented.activeInHierarchy != flag)
			{
				notRented.SetActive(flag);
			}
			string text = TempItemsController.sharedController.TimeRemainingForItemString(viewedId);
			bool flag2 = TempItemsController.sharedController.ContainsItem(viewedId) && text.Length < 5;
			if (daysLeftLabel.gameObject.activeInHierarchy != flag2)
			{
				daysLeftLabel.gameObject.SetActive(flag2);
			}
			if (daysLeftValueLabel.gameObject.activeInHierarchy != flag2)
			{
				daysLeftValueLabel.gameObject.SetActive(flag2);
			}
			if (flag2)
			{
				daysLeftValueLabel.text = text;
			}
			bool flag3 = TempItemsController.sharedController.ContainsItem(viewedId) && text.Length >= 5;
			if (timeLeftLabel.gameObject.activeInHierarchy != flag3)
			{
				timeLeftLabel.gameObject.SetActive(flag3);
			}
			if (timeLeftValueLabel.gameObject.activeInHierarchy != flag3)
			{
				timeLeftValueLabel.gameObject.SetActive(flag3);
			}
			if (flag3)
			{
				timeLeftValueLabel.text = text;
			}
			bool flag4 = flag3 && TempItemsController.sharedController.TimeRemainingForItems(viewedId) <= 3600;
			if (redBackForTime.activeInHierarchy != flag4)
			{
				redBackForTime.SetActive(flag4);
			}
		}
	}

	public static ItemPrice currentPrice(string viewedId, CategoryNames currentCategory, bool upgradeNotBuy = false)
	{
		string text = viewedId;
		string text2 = text;
		if (text2 == null)
		{
			return new ItemPrice(0, "Coins");
		}
		if (text2 != null && WeaponManager.tagToStoreIDMapping.ContainsKey(text2))
		{
			text = WeaponManager.tagToStoreIDMapping[WeaponManager.FirstUnboughtOrForOurTier(text2)];
		}
		if (currentCategory == CategoryNames.SkinsCategory && SkinsController.shopKeyFromNameSkin.ContainsKey(text))
		{
			text = SkinsController.shopKeyFromNameSkin[text];
		}
		if (currentCategory == CategoryNames.GearCategory)
		{
			text = ((!upgradeNotBuy) ? GearManager.OneItemIDForGear(GearManager.HolderQuantityForID(text), GearManager.CurrentNumberOfUphradesForGear(text)) : GearManager.UpgradeIDForGear(GearManager.HolderQuantityForID(text), GearManager.CurrentNumberOfUphradesForGear(text) + 1));
		}
		if (IsWearCategory(currentCategory))
		{
			text = WeaponManager.FirstUnboughtTag(text);
		}
		ItemPrice itemPrice = ItemDb.GetPriceByShopId(text) ?? new ItemPrice(10, "Coins");
		int num = itemPrice.Price;
		if (!Defs.IsTraining && viewedId != null)
		{
			string key = ((!IsWeaponCategory(currentCategory) && !IsWearCategory(currentCategory)) ? viewedId : WeaponManager.FirstUnboughtOrForOurTier(viewedId));
			if (PromoActionsManager.sharedManager.discounts.ContainsKey(key) && PromoActionsManager.sharedManager.discounts[key].Count > 1)
			{
				num = Math.Max((int)((float)num * 0.05f), PromoActionsManager.sharedManager.discounts[key][1]);
			}
		}
		if (currentCategory == CategoryNames.GearCategory && !upgradeNotBuy)
		{
			num *= GearManager.ItemsInPackForGear(GearManager.HolderQuantityForID(text));
		}
		return new ItemPrice(num, itemPrice.Currency);
	}

	private void UpdateItemParameters()
	{
		wholePrice.gameObject.SetActive(buy.gameObject.activeInHierarchy || upgrade.gameObject.activeInHierarchy || enable.gameObject.activeInHierarchy);
		wholePriceUpgradeGear.gameObject.SetActive(false);
		wholePrice2Gear.gameObject.SetActive(buyGear.gameObject.activeInHierarchy);
		wholePriceBG.spriteName = ((Defs.IsTraining || viewedId == null || !PromoActionsManager.sharedManager.discounts.ContainsKey(WeaponManager.FirstUnboughtOrForOurTier(viewedId))) ? "sett_box_dark" : "item_bg");
		wholePriceBG2Gear.spriteName = ((Defs.IsTraining || viewedId == null || !PromoActionsManager.sharedManager.discounts.ContainsKey(viewedId)) ? "sett_box_dark" : "item_bg");
		wholePriceUpgradeBG2Gear.spriteName = ((Defs.IsTraining || viewedId == null || !PromoActionsManager.sharedManager.discounts.ContainsKey(viewedId)) ? "sett_box_dark" : "item_bg");
		if (viewedId != null)
		{
			ItemPrice itemPrice = currentPrice(viewedId, currentCategory, currentCategory == CategoryNames.GearCategory);
			if (currentCategory == CategoryNames.GearCategory)
			{
				priceUpgradeGear.text = itemPrice.Price.ToString();
				currencyImagePriceUpgradeGear.spriteName = ((!itemPrice.Currency.Equals("Coins")) ? "gem_znachek" : "ingame_coin");
				currencyImagePriceUpgradeGear.width = ((!itemPrice.Currency.Equals("Coins")) ? 34 : 30);
				currencyImagePriceUpgradeGear.height = ((!itemPrice.Currency.Equals("Coins")) ? 24 : 30);
			}
			else
			{
				price.text = itemPrice.Price.ToString();
				currencyImagePrice.spriteName = ((!itemPrice.Currency.Equals("Coins")) ? "gem_znachek" : "ingame_coin");
				currencyImagePrice.width = ((!itemPrice.Currency.Equals("Coins")) ? 34 : 30);
				currencyImagePrice.height = ((!itemPrice.Currency.Equals("Coins")) ? 24 : 30);
			}
			if (currentCategory == CategoryNames.GearCategory)
			{
				ItemPrice itemPrice2 = currentPrice(viewedId, currentCategory);
				price2Gear.text = itemPrice2.Price.ToString();
				currencyImagePriceGear.spriteName = ((!itemPrice2.Currency.Equals("Coins")) ? "gem_znachek" : "ingame_coin");
				currencyImagePriceGear.width = ((!itemPrice.Currency.Equals("Coins")) ? 34 : 30);
				currencyImagePriceGear.height = ((!itemPrice.Currency.Equals("Coins")) ? 24 : 30);
			}
		}
	}

	private static int _CurrentNumberOfWearUpgrades(string id, out bool maxUpgrade, CategoryNames c)
	{
		List<string> list = null;
		foreach (List<string> item in Wear.wear[c])
		{
			if (item.Contains(id))
			{
				list = item;
				break;
			}
		}
		if (list == null)
		{
			maxUpgrade = false;
			return 0;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (Storager.getInt(list[i], true) == 0)
			{
				maxUpgrade = false;
				return i;
			}
		}
		maxUpgrade = true;
		return list.Count;
	}

	public static int _CurrentNumberOfUpgrades(string id, out bool maxUpgrade, CategoryNames c)
	{
		List<string> list = new List<string>();
		int num = 0;
		if (IsWeaponCategory(c))
		{
			list.Add(id);
			foreach (List<string> upgrade in WeaponUpgrades.upgrades)
			{
				if (upgrade.Contains(id))
				{
					list = upgrade;
					break;
				}
			}
			num = list.Count;
			if (WeaponManager.tagToStoreIDMapping.ContainsKey(id))
			{
				int num2 = list.Count - 1;
				while (num2 >= 0)
				{
					string key = list[num2];
					string defName = id;
					bool flag = ItemDb.IsTemporaryGun(id);
					if (!flag)
					{
						defName = WeaponManager.storeIDtoDefsSNMapping[WeaponManager.tagToStoreIDMapping[key]];
					}
					if (_HasntBoughtGood(defName, flag))
					{
						num--;
						num2--;
						continue;
					}
					break;
				}
			}
		}
		else if (IsWearCategory(c))
		{
			num = ((!_HasntBoughtGood(id, TempItemsController.PriceCoefs.ContainsKey(id))) ? 1 : 0);
		}
		if (id.Equals(StoreKitEventListener.elixirID) && Defs.NumberOfElixirs > 0)
		{
			num++;
		}
		maxUpgrade = num == ((list.Count <= 0) ? 1 : list.Count);
		return num;
	}

	private static bool _HasntBoughtGood(string defName, bool tempGun = false)
	{
		if (Defs.IsTraining)
		{
			return (!defName.Equals(Defs.GrenadeLnch_2SN) || !sharedShop.trainBougt1) && (!defName.Equals(Defs.grenade_launcher_3) || !sharedShop.trainBought2) && (!defName.Equals(Wear.Armor_Army_1) || !sharedShop.armorBougt1) && (!defName.Equals(Wear.Armor_Army_2) || !sharedShop.armorBought2);
		}
		return (!tempGun) ? (Storager.getInt(defName, true) == 0) : (!TempItemsController.sharedController.ContainsItem(defName));
	}

	public void UpdatePersWithNewItem()
	{
		if (WeaponCategory)
		{
			string text = viewedId;
			if (text == null && WeaponManager.sharedManager.playerWeapons.Count > 0)
			{
				text = (WeaponManager.sharedManager.playerWeapons[0] as Weapon).weaponPrefab.tag;
			}
			SetWeapon(text);
			return;
		}
		switch (currentCategory)
		{
		case CategoryNames.HatsCategory:
			UpdatePersHat(viewedId);
			break;
		case CategoryNames.SkinsCategory:
			if (!viewedId.Equals("CustomSkinID"))
			{
				UpdatePersSkin(viewedId);
			}
			break;
		case CategoryNames.CapesCategory:
			UpdatePersCape(viewedId);
			break;
		case CategoryNames.BootsCategory:
			UpdatePersBoots(viewedId);
			break;
		case CategoryNames.ArmorCategory:
			if (!Defs.IsTraining || trainStep > 2)
			{
				UpdatePersArmor(viewedId);
			}
			break;
		}
	}

	public void UpdatePersHat(string hat)
	{
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < hatPoint.transform.childCount; i++)
		{
			list.Add(hatPoint.transform.GetChild(i));
		}
		foreach (Transform item in list)
		{
			item.parent = null;
			item.position = new Vector3(0f, -10000f, 0f);
			UnityEngine.Object.Destroy(item.gameObject);
		}
		if (!hat.Equals(Defs.HatNoneEqupped))
		{
			string @string = Storager.getString(Defs.VisualHatArmor, false);
			if (!string.IsNullOrEmpty(@string) && Wear.wear[CategoryNames.HatsCategory][0].IndexOf(hat) >= 0 && Wear.wear[CategoryNames.HatsCategory][0].IndexOf(hat) < Wear.wear[CategoryNames.HatsCategory][0].IndexOf(@string))
			{
				hat = @string;
			}
			GameObject gameObject = Resources.Load("Hats/" + hat) as GameObject;
			if (!(gameObject == null))
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
				DisableLightProbesRecursively(gameObject2);
				gameObject2.transform.parent = hatPoint.transform;
				gameObject2.transform.localPosition = Vector3.zero;
				gameObject2.transform.localRotation = Quaternion.identity;
				gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
				Player_move_c.SetLayerRecursively(gameObject2, LayerMask.NameToLayer("NGUIShop"));
				SetPersHatVisible(hatPoint);
			}
		}
	}

	public void UpdatePersArmor(string armor)
	{
		if (armorPoint.childCount > 0)
		{
			Transform child = armorPoint.GetChild(0);
			ArmorRefs component = child.GetChild(0).GetComponent<ArmorRefs>();
			if (component != null)
			{
				if (component.leftBone != null)
				{
					component.leftBone.parent = child.GetChild(0);
				}
				if (component.rightBone != null)
				{
					component.rightBone.parent = child.GetChild(0);
				}
				child.parent = null;
				child.position = new Vector3(0f, -10000f, 0f);
				UnityEngine.Object.Destroy(child.gameObject);
			}
		}
		if (armor.Equals(Defs.ArmorNewNoneEqupped))
		{
			return;
		}
		string @string = Storager.getString(Defs.VisualArmor, false);
		if (!string.IsNullOrEmpty(@string) && Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(armor) >= 0 && Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(armor) < Wear.wear[CategoryNames.ArmorCategory][0].IndexOf(@string))
		{
			armor = @string;
		}
		GameObject gameObject = Resources.Load("Armor_Shop/" + armor) as GameObject;
		if (gameObject == null)
		{
			return;
		}
		GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
		DisableLightProbesRecursively(gameObject2);
		ArmorRefs component2 = gameObject2.transform.GetChild(0).GetComponent<ArmorRefs>();
		if (component2 != null && weapon != null)
		{
			WeaponSounds component3 = weapon.GetComponent<WeaponSounds>();
			gameObject2.transform.parent = armorPoint.transform;
			gameObject2.transform.localPosition = Vector3.zero;
			gameObject2.transform.localRotation = Quaternion.identity;
			gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
			Player_move_c.SetLayerRecursively(gameObject2, LayerMask.NameToLayer("NGUIShop"));
			if (component2.leftBone != null && component3.LeftArmorHand != null)
			{
				component2.leftBone.parent = component3.LeftArmorHand;
				component2.leftBone.localPosition = Vector3.zero;
				component2.leftBone.localRotation = Quaternion.identity;
				component2.leftBone.localScale = new Vector3(1f, 1f, 1f);
			}
			if (component2.rightBone != null && component3.RightArmorHand != null)
			{
				component2.rightBone.parent = component3.RightArmorHand;
				component2.rightBone.localPosition = Vector3.zero;
				component2.rightBone.localRotation = Quaternion.identity;
				component2.rightBone.localScale = new Vector3(1f, 1f, 1f);
			}
		}
		SetPersArmorVisible(armorPoint);
	}

	public void UpdatePersCape(string cape)
	{
		for (int i = 0; i < capePoint.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(capePoint.transform.GetChild(i).gameObject);
		}
		if (!cape.Equals(Defs.CapeNoneEqupped))
		{
			GameObject gameObject = Resources.Load("Capes/" + cape) as GameObject;
			if (!(gameObject == null))
			{
				GameObject gameObject2 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
				DisableLightProbesRecursively(gameObject2);
				gameObject2.transform.parent = capePoint.transform;
				gameObject2.transform.localPosition = new Vector3(0f, -0.8f, 0f);
				gameObject2.transform.localRotation = Quaternion.identity;
				gameObject2.transform.localScale = new Vector3(1f, 1f, 1f);
				Player_move_c.SetLayerRecursively(gameObject2, LayerMask.NameToLayer("NGUIShop"));
			}
		}
	}

	public void UpdatePersSkin(string skinID)
	{
		SetSkinOnPers(SkinsController.skinsForPers[skinID]);
	}

	public void SetSkinOnPers(Texture skin)
	{
		GameObject gameObject = ((body.transform.childCount <= 0) ? null : body.transform.GetChild(0).GetComponent<WeaponSounds>().bonusPrefab);
		GameObject gameObject2 = null;
		GameObject gameObject3 = null;
		if (gameObject != null)
		{
			Transform leftArmorHand = body.transform.GetChild(0).GetComponent<WeaponSounds>().LeftArmorHand;
			Transform rightArmorHand = body.transform.GetChild(0).GetComponent<WeaponSounds>().RightArmorHand;
			if (leftArmorHand != null)
			{
				gameObject2 = leftArmorHand.gameObject;
			}
			if (rightArmorHand != null)
			{
				gameObject3 = rightArmorHand.gameObject;
			}
		}
		List<GameObject> list = new List<GameObject>();
		list.Add(capePoint.gameObject);
		list.Add(hatPoint.gameObject);
		list.Add(bootsPoint.gameObject);
		list.Add(armorPoint.gameObject);
		List<GameObject> list2 = list;
		if (gameObject != null)
		{
			list2.Add(gameObject);
		}
		if (gameObject2 != null)
		{
			list2.Add(gameObject2);
		}
		if (gameObject3 != null)
		{
			list2.Add(gameObject3);
		}
		Player_move_c.SetTextureRecursivelyFrom(MainMenu_Pers.gameObject, skin, list2.ToArray());
	}

	public void UpdatePersBoots(string bs)
	{
		foreach (Transform item in bootsPoint.transform)
		{
			if (item.gameObject.name.Equals(bs))
			{
				item.gameObject.SetActive(true);
			}
			else
			{
				item.gameObject.SetActive(false);
			}
		}
	}

	public void ReloadCategoryTempItemsRemoved(List<string> expired)
	{
		if (currentCategory != CategoryNames.HatsCategory && expired.Contains(Wear.hat_Adamant_3))
		{
			UpdatePersHat(Defs.HatNoneEqupped);
		}
		if (currentCategory != CategoryNames.ArmorCategory && expired.Contains(Wear.Armor_Adamant_3))
		{
			UpdatePersArmor(Defs.ArmorNewNoneEqupped);
		}
		if (GuiActive && TempItemsController.IsCategoryContainsTempItems(currentCategory) && !Defs.IsTraining)
		{
			CategoryChosen(currentCategory, (expired.Count <= 0 || !TempItemsController.GunsMappingFromTempToConst.ContainsKey(expired[0])) ? viewedId : TempItemsController.GunsMappingFromTempToConst[expired[0]]);
			UpdateIcons();
		}
	}

	public void SimulateCategoryChoose(int num)
	{
		if (num >= 0 && num < category.buttons.Length && num != 0)
		{
			category.buttons[0].IsChecked = false;
			category.buttons[num].IsChecked = true;
		}
	}

	public void CategoryChosen(CategoryNames i, string idToSet = null, bool initial = false)
	{
		WeaponManager.sharedManager.PrepareForShopWeaponCategory((int)i);
		if (!initial)
		{
			switch (currentCategory)
			{
			case CategoryNames.HatsCategory:
				viewedId = _CurrentEquippedWear;
				break;
			case CategoryNames.ArmorCategory:
				viewedId = _CurrentEquippedWear;
				break;
			case CategoryNames.SkinsCategory:
				if (SkinsController.currentSkinNameForPers != null)
				{
					viewedId = SkinsController.currentSkinNameForPers;
				}
				else
				{
					if (SkinsController.skinsForPers == null || SkinsController.skinsForPers.Keys.Count <= 0)
					{
						break;
					}
					using (Dictionary<string, Texture2D>.KeyCollection.Enumerator enumerator = SkinsController.skinsForPers.Keys.GetEnumerator())
					{
						if (enumerator.MoveNext())
						{
							string text = (viewedId = enumerator.Current);
						}
					}
				}
				break;
			case CategoryNames.CapesCategory:
				viewedId = _CurrentEquippedWear;
				break;
			case CategoryNames.BootsCategory:
				viewedId = _CurrentEquippedWear;
				break;
			}
			if (WearCategory || currentCategory == CategoryNames.SkinsCategory)
			{
				UpdatePersWithNewItem();
			}
		}
		currentCategory = i;
		if (highlightedCarouselObject != null)
		{
		}
		highlightedCarouselObject = null;
		if (WeaponCategory)
		{
			chosenId = _CurrentWeaponSetIDs()[(int)i];
			viewedId = idToSet;
			if (viewedId != null && chosenId != null && viewedId.Equals(chosenId) && WeaponManager.sharedManager != null && WeaponManager.sharedManager._weaponsByCat.Count > (int)i && !WeaponManager.sharedManager._weaponsByCat[(int)i].Find((GameObject go) => go.name.Equals(viewedId)))
			{
				viewedId = null;
			}
			if (viewedId == null)
			{
				CategoryNames cn;
				string text2 = TempGunOrHighestDPSGun(i, out cn);
				if (i == cn)
				{
					viewedId = text2;
				}
				else
				{
					viewedId = TemppOrHighestDPSGunInCategory((int)i);
				}
			}
		}
		else
		{
			switch (currentCategory)
			{
			case CategoryNames.HatsCategory:
			{
				string fu = WeaponManager.FirstUnboughtTag(Wear.wear[CategoryNames.HatsCategory][0][0]);
				int num3 = hats.FindIndex((GameObject go) => go.name.Equals(fu));
				viewedId = ((_CurrentEquippedWear == null || _CurrentNoneEquipped == null || _CurrentEquippedWear.Equals(_CurrentNoneEquipped) || WeaponManager.LastBoughtTag(_CurrentEquippedWear) == null || !WeaponManager.LastBoughtTag(_CurrentEquippedWear).Equals(_CurrentEquippedWear)) ? hats[(num3 <= -1) ? (hats.Count - 1) : num3].name : _CurrentEquippedWear);
				break;
			}
			case CategoryNames.ArmorCategory:
				viewedId = (Defs.IsTraining ? Wear.Armor_Army_1 : ((_CurrentEquippedWear == null || _CurrentNoneEquipped == null || _CurrentEquippedWear.Equals(_CurrentNoneEquipped) || WeaponManager.LastBoughtTag(_CurrentEquippedWear) == null || !WeaponManager.LastBoughtTag(_CurrentEquippedWear).Equals(_CurrentEquippedWear)) ? WeaponManager.FirstUnboughtTag(Wear.wear[CategoryNames.ArmorCategory][0][0]) : _CurrentEquippedWear));
				scrollViewPanel.transform.localPosition = Vector3.zero;
				scrollViewPanel.clipOffset = new Vector2(0f, 0f);
				break;
			case CategoryNames.SkinsCategory:
				if (SkinsController.currentSkinNameForPers != null)
				{
					viewedId = SkinsController.currentSkinNameForPers;
				}
				else
				{
					if (SkinsController.skinsForPers == null || SkinsController.skinsForPers.Keys.Count <= 0)
					{
						break;
					}
					using (Dictionary<string, Texture2D>.KeyCollection.Enumerator enumerator2 = SkinsController.skinsForPers.Keys.GetEnumerator())
					{
						if (enumerator2.MoveNext())
						{
							string text3 = (viewedId = enumerator2.Current);
						}
					}
				}
				break;
			case CategoryNames.CapesCategory:
				viewedId = ((_CurrentEquippedWear == null || _CurrentNoneEquipped == null || _CurrentEquippedWear.Equals(_CurrentNoneEquipped) || WeaponManager.LastBoughtTag(_CurrentEquippedWear) == null || !WeaponManager.LastBoughtTag(_CurrentEquippedWear).Equals(_CurrentEquippedWear)) ? (WeaponManager.LastBoughtTag(capes[0].name) ?? capes[0].name) : _CurrentEquippedWear);
				break;
			case CategoryNames.BootsCategory:
				viewedId = ((_CurrentEquippedWear == null || _CurrentNoneEquipped == null || _CurrentEquippedWear.Equals(_CurrentNoneEquipped) || WeaponManager.LastBoughtTag(_CurrentEquippedWear) == null || !WeaponManager.LastBoughtTag(_CurrentEquippedWear).Equals(_CurrentEquippedWear)) ? (WeaponManager.LastBoughtTag(boots[0].name) ?? boots[0].name) : _CurrentEquippedWear);
				break;
			case CategoryNames.GearCategory:
			{
				int num = GearManager.CurrentNumberOfUphradesForGear(GearManager.InvisibilityPotion);
				int num2 = ((num >= GearManager.NumOfGearUpgrades) ? num : num);
				viewedId = GearManager.NameForUpgrade(GearManager.InvisibilityPotion, num2);
				break;
			}
			}
		}
		capeProperties.SetActive(currentCategory == CategoryNames.CapesCategory);
		hatsProperties.SetActive(currentCategory == CategoryNames.HatsCategory);
		armorProperties.SetActive(currentCategory == CategoryNames.ArmorCategory);
		bootsProperties.SetActive(currentCategory == CategoryNames.BootsCategory);
		gearProperties.SetActive(currentCategory == CategoryNames.GearCategory);
		skinProperties.SetActive(currentCategory == CategoryNames.SkinsCategory);
		border.SetActive(currentCategory != CategoryNames.SkinsCategory);
		ReloadCarousel(idToSet);
		SetCamera();
		if (!IsWeaponCategory(i) && weapon == null)
		{
			SetWeapon(_CurrentWeaponSetIDs()[0] ?? WeaponManager._initialWeaponName);
		}
		if (currentCategory == CategoryNames.SkinsCategory)
		{
			shopCarouselCollider.center = new Vector3(0f, -40f, 0f);
			shopCarouselCollider.size = new Vector3(shopCarouselCollider.size.x, 363f, shopCarouselCollider.size.z);
		}
		else
		{
			shopCarouselCollider.center = new Vector3(0f, 0f, 0f);
			shopCarouselCollider.size = new Vector3(shopCarouselCollider.size.x, 252f, shopCarouselCollider.size.z);
		}
	}

	private void HandleCarouselCentering()
	{
		HandleCarouselCentering(carouselCenter.centeredObject);
	}

	private void HandleCarouselCentering(GameObject centeredObj)
	{
		if (centeredObj != null && centeredObj != _lastSelectedItem)
		{
			_lastSelectedItem = centeredObj;
			if (highlightedCarouselObject != null)
			{
			}
			highlightedCarouselObject = centeredObj.transform;
			if (highlightedCarouselObject != null)
			{
			}
			ShopCarouselElement component = centeredObj.GetComponent<ShopCarouselElement>();
			SetLabelsForElem(component);
			ChooseCarouselItem(component.itemID);
		}
		if (EnableConfigurePos && centeredObj != null)
		{
			centeredObj.GetComponent<ShopCarouselElement>().SetPos(1f, 0f);
		}
	}

	private void CheckCenterItemChanging()
	{
		if (!scrollViewPanel.cachedGameObject.activeInHierarchy)
		{
			return;
		}
		Transform cachedTransform = scrollViewPanel.cachedTransform;
		itemIndex = -1;
		int num = (int)wrapContent.cellWidth;
		int childCount = wrapContent.transform.childCount;
		if (cachedTransform.localPosition.x > 0f)
		{
			itemIndex = 0;
		}
		else if (cachedTransform.localPosition.x < (float)(-1 * num * childCount))
		{
			itemIndex = childCount - 1;
		}
		else
		{
			itemIndex = -1 * Mathf.RoundToInt((cachedTransform.localPosition.x - (float)(Mathf.CeilToInt(cachedTransform.localPosition.x / (float)num / (float)childCount) * num * childCount)) / (float)num);
		}
		itemIndex = Mathf.Clamp(itemIndex, 0, childCount - 1);
		if (itemIndex >= 0 && itemIndex < wrapContent.transform.childCount)
		{
			GameObject centeredObj = wrapContent.transform.GetChild(itemIndex).gameObject;
			if (!EnableConfigurePos)
			{
				HandleCarouselCentering(centeredObj);
			}
		}
	}

	private void SetLabelsForElem(ShopCarouselElement sce)
	{
	}

	public static void SetPersArmorVisible(Transform armorPoint)
	{
		SetRenderersVisibleFromPoint(armorPoint, ShowArmor);
		if (armorPoint.childCount <= 0)
		{
			return;
		}
		Transform child = armorPoint.GetChild(0);
		ArmorRefs component = child.GetChild(0).GetComponent<ArmorRefs>();
		if (component != null)
		{
			if (component.leftBone != null)
			{
				SetRenderersVisibleFromPoint(component.leftBone, ShowArmor);
			}
			if (component.rightBone != null)
			{
				SetRenderersVisibleFromPoint(component.rightBone, ShowArmor);
			}
		}
	}

	public static void SetPersHatVisible(Transform hatPoint)
	{
		string showHatTag = ((hatPoint.transform.childCount <= 0) ? "none" : hatPoint.transform.GetChild(0).gameObject.tag);
		bool showArmor = ShowHat || Wear.NonArmorHat(showHatTag);
		SetRenderersVisibleFromPoint(hatPoint, showArmor);
	}

	public static void SetRenderersVisibleFromPoint(Transform pt, bool showArmor)
	{
		Player_move_c.PerformActionRecurs(pt.gameObject, delegate(Transform t)
		{
			Renderer renderer = t.GetComponent<Renderer>();
			if (renderer != null)
			{
				renderer.material.shader = Shader.Find((!showArmor) ? "Mobile/Transparent-Shop" : "Mobile/Diffuse");
			}
		});
	}

	private void SaveShowArmorHatToPrefs()
	{
		PlayerPrefs.SetInt("ShowArmorKeySetting", ShowArmor ? 1 : 0);
		PlayerPrefs.SetInt("ShowHatKeySetting", ShowHat ? 1 : 0);
	}

	private void Awake()
	{
		_ShowArmor = PlayerPrefs.GetInt("ShowArmorKeySetting", 1) == 1;
		_ShowHat = PlayerPrefs.GetInt("ShowHatKeySetting", 1) == 1;
		HOTween.Init(true, true, true);
		HOTween.EnableOverwriteManager(true);
		timeToUpdateTempGunTime = Time.realtimeSinceStartup;
		if (category != null)
		{
			category.Clicked += delegate(object sender, MultipleToggleEventArgs e)
			{
				if (e != null)
				{
					if (Defs.isSoundFX && category.buttons != null && category.buttons.Length > e.Num)
					{
						category.buttons[e.Num].offButton.GetComponent<UIPlaySound>().Play();
					}
					if (e.Num == 6 && Defs.IsTraining)
					{
						TrainingUpdate();
					}
					CategoryChosen((CategoryNames)e.Num);
				}
			};
		}
		if (buy != null)
		{
			buy.GetComponent<ButtonHandler>().Clicked += delegate
			{
				if (!Defs.IsTraining || trainStep == 0 || trainStep == 3)
				{
					BuyOrUpgradeWeapon(false);
				}
			};
		}
		if (buyGear != null)
		{
			buyGear.GetComponent<ButtonHandler>().Clicked += delegate
			{
				BuyOrUpgradeWeapon(false);
			};
		}
		if (upgrade != null)
		{
			upgrade.GetComponent<ButtonHandler>().Clicked += delegate
			{
				if (!Defs.IsTraining || trainStep == 1 || trainStep == 4)
				{
					BuyOrUpgradeWeapon(true);
				}
			};
		}
		if (upgradeGear != null)
		{
			upgradeGear.GetComponent<ButtonHandler>().Clicked += delegate
			{
				BuyOrUpgradeWeapon(true);
			};
		}
		showArmorButton.IsChecked = !ShowArmor;
		showHatButton.IsChecked = !ShowHat;
		showArmorButtonTempArmor.IsChecked = !ShowArmor;
		showHatButtonTempHat.IsChecked = !ShowHat;
		Action toggleShowArmor = delegate
		{
			ShowArmor = !ShowArmor;
			SetPersArmorVisible(armorPoint);
		};
		Action toggleShowHat = delegate
		{
			ShowHat = !ShowHat;
			SetPersHatVisible(hatPoint);
		};
		showArmorButton.Clicked += delegate
		{
			toggleShowArmor();
			showArmorButtonTempArmor.SetCheckedWithoutEvent(!ShowArmor);
		};
		showHatButton.Clicked += delegate
		{
			toggleShowHat();
			showHatButtonTempHat.SetCheckedWithoutEvent(!ShowHat);
		};
		showArmorButtonTempArmor.Clicked += delegate
		{
			toggleShowArmor();
			showArmorButton.SetCheckedWithoutEvent(!ShowArmor);
		};
		showHatButtonTempHat.Clicked += delegate
		{
			toggleShowHat();
			showHatButton.SetCheckedWithoutEvent(!ShowHat);
		};
		sharedShop = this;
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		ActiveObject.SetActive(false);
		if (coinShopButton != null)
		{
			coinShopButton.GetComponent<ButtonHandler>().Clicked += delegate
			{
				if (!(Time.realtimeSinceStartup - timeOfEnteringShopForProtectFromPressingCoinsButton < 0.5f) && BankController.Instance != null)
				{
					if (BankController.Instance.InterfaceEnabledCoroutineLocked)
					{
						Debug.LogWarning("InterfaceEnabledCoroutineLocked");
					}
					else
					{
						EventHandler handleBackFromBank = null;
						handleBackFromBank = delegate
						{
							if (BankController.Instance.InterfaceEnabledCoroutineLocked)
							{
								Debug.LogWarning("InterfaceEnabledCoroutineLocked");
							}
							else
							{
								BankController.Instance.BackRequested -= handleBackFromBank;
								BankController.Instance.InterfaceEnabled = false;
								GuiActive = true;
							}
						};
						BankController.Instance.BackRequested += handleBackFromBank;
						BankController.Instance.InterfaceEnabled = true;
						GuiActive = false;
					}
				}
			};
		}
		if (backButton != null)
		{
			backButton.GetComponent<ButtonHandler>().Clicked += delegate
			{
				StartCoroutine(BackAfterDelay());
			};
		}
		UIButton[] array = equips;
		UIButton ee;
		for (int i = 0; i < array.Length; i++)
		{
			ee = array[i];
			ee.GetComponent<ButtonHandler>().Clicked += delegate
			{
				if (Defs.isSoundFX)
				{
					ee.GetComponent<UIPlaySound>().Play();
				}
				if (WeaponCategory)
				{
					string text = WeaponManager.LastBoughtTag(viewedId);
					if (text == null)
					{
						return;
					}
					Weapon w = null;
					foreach (Weapon allAvailablePlayerWeapon in WeaponManager.sharedManager.allAvailablePlayerWeapons)
					{
						if (allAvailablePlayerWeapon.weaponPrefab.CompareTag(text))
						{
							w = allAvailablePlayerWeapon;
							break;
						}
					}
					WeaponManager.sharedManager.EquipWeapon(w);
					if (equipAction != null)
					{
						equipAction(text);
					}
					chosenId = text;
					UpdateIcon(currentCategory);
				}
				else if (WearCategory)
				{
					string text2 = WeaponManager.LastBoughtTag(viewedId);
					if (text2 != null)
					{
						EquipWear(text2);
					}
				}
				else if (currentCategory == CategoryNames.SkinsCategory)
				{
					SetSkinAsCurrent(viewedId);
					UpdateIcon(currentCategory, true);
				}
				UpdateButtons();
			};
		}
		unequip.GetComponent<ButtonHandler>().Clicked += delegate
		{
			if (Defs.isSoundFX)
			{
				unequip.GetComponent<UIPlaySound>().Play();
			}
			if (WearCategory)
			{
				CategoryNames cat = currentCategory;
				UnequipCurrentWearInCategory(cat, inGame);
			}
			UpdateButtons();
		};
		enable.GetComponent<ButtonHandler>().Clicked += delegate
		{
			if (viewedId != null && viewedId.Equals("CustomSkinID"))
			{
				TryToBuy(mainPanel, currentPrice(viewedId, currentCategory), delegate
				{
					if (Defs.isSoundFX)
					{
						enable.GetComponent<UIPlaySound>().Play();
					}
					if (ShopNGUIController.GunBought != null)
					{
						ShopNGUIController.GunBought();
					}
					FlurryPluginWrapper.LogAddYourSkinBoughtEvent();
					Storager.setInt(Defs.SkinsMakerInProfileBought, 1, true);
					SynchronizeAndroidPurchases("Custom skin");
					FlurryPluginWrapper.LogEvent("Enable_Custom Skin");
					wholePrice.gameObject.SetActive(false);
					if (!inGame)
					{
						goToSM();
					}
				}, delegate
				{
					FlurryPluginWrapper.LogEvent("Try_Enable_Custom Skin");
				}, null, delegate
				{
					PlayWeaponAnimation();
				}, delegate
				{
					SetBankCamerasEnabled();
				}, delegate
				{
					SetOtherCamerasEnabled(false);
				});
				UpdateButtons();
			}
			else if (viewedId != null && viewedId.Equals(Wear.cape_Custom))
			{
				BuyOrUpgradeWeapon(false);
			}
		};
		create.GetComponent<ButtonHandler>().Clicked += delegate
		{
			ButtonClickSound.Instance.PlayClick();
			if (!inGame)
			{
				goToSM();
			}
		};
		edit.GetComponent<ButtonHandler>().Clicked += delegate
		{
			ButtonClickSound.Instance.PlayClick();
			if (!inGame)
			{
				goToSM();
			}
		};
		delete.GetComponent<ButtonHandler>().Clicked += delegate
		{
			ButtonClickSound.Instance.PlayClick();
			string currentSkinNameForPers = SkinsController.currentSkinNameForPers;
			SkinsController.DeleteUserSkin(viewedId);
			if (viewedId.Equals(currentSkinNameForPers))
			{
				SetSkinAsCurrent("0");
			}
			ReloadCarousel(SkinsController.currentSkinNameForPers ?? "0");
		};
		Action<List<GameObject>, CategoryNames> action = delegate(List<GameObject> prefabs, CategoryNames c)
		{
			Comparison<GameObject> comparison = delegate(GameObject go1, GameObject go2)
			{
				List<string> list = null;
				List<string> list2 = null;
				foreach (List<string> item in Wear.wear[c])
				{
					if (item.Contains(go1.name))
					{
						list = item;
					}
					if (item.Contains(go2.name))
					{
						list2 = item;
					}
				}
				if (list == null || list2 == null)
				{
					return 0;
				}
				return (list == list2) ? (list.IndexOf(go1.name) - list.IndexOf(go2.name)) : (Wear.wear[c].IndexOf(list) - Wear.wear[c].IndexOf(list2));
			};
			prefabs.Sort(comparison);
		};
		hats.AddRange(Resources.LoadAll<GameObject>("Hats"));
		action(hats, CategoryNames.HatsCategory);
		capes.AddRange(Resources.LoadAll<GameObject>("Capes"));
		action(capes, CategoryNames.CapesCategory);
		boots.AddRange(Resources.LoadAll<GameObject>("Shop_Boots"));
		action(boots, CategoryNames.BootsCategory);
		pixlMan = Resources.Load<GameObject>("PixlManForSkins");
		armor.AddRange(Resources.LoadAll<GameObject>("Armor"));
		action(armor, CategoryNames.ArmorCategory);
		gear.AddRange(Resources.LoadAll<GameObject>("Shop_Gear"));
		gear.Sort((GameObject go1, GameObject go2) => Array.IndexOf(gearOrder, go1.name) - Array.IndexOf(gearOrder, go2.name));
		if (!Device.IsLoweMemoryDevice)
		{
			_onPersArmorRefs = Resources.LoadAll<GameObject>("Armor_Shop");
		}
	}

	public void goToSM()
	{
		GameObject gameObject = UnityEngine.Object.Instantiate(Resources.Load<GameObject>("SkinEditorController")) as GameObject;
		SkinEditorController component = gameObject.GetComponent<SkinEditorController>();
		if (!(component != null))
		{
			return;
		}
		Action<string> backHandler = null;
		backHandler = delegate(string n)
		{
			SkinEditorController.ExitFromSkinEditor -= backHandler;
			MenuBackgroundMusic.sharedMusic.StopCustomMusicFrom(SkinEditorController.sharedController.gameObject);
			mainPanel.SetActive(true);
			if (currentCategory == CategoryNames.CapesCategory || n != null)
			{
				if (viewedId != null && viewedId.Equals("CustomSkinID"))
				{
					SetSkinAsCurrent(n);
				}
				if (currentCategory == CategoryNames.SkinsCategory && viewedId != null && viewedId.Equals(SkinsController.currentSkinNameForPers))
				{
					FireOnEquipSkin(n);
				}
				if (viewedId != null && viewedId.Equals(Wear.cape_Custom))
				{
					EquipWear(Wear.cape_Custom);
				}
				StartCoroutine(ReloadAfterEditing(n));
			}
			else
			{
				StartCoroutine(ReloadAfterEditing(n, n == null));
			}
		};
		SkinEditorController.ExitFromSkinEditor += backHandler;
		SkinEditorController.currentSkinName = ((!viewedId.Equals("CustomSkinID")) ? viewedId : null);
		SkinEditorController.modeEditor = ((currentCategory != CategoryNames.SkinsCategory) ? SkinEditorController.ModeEditor.Cape : SkinEditorController.ModeEditor.SkinPers);
		mainPanel.SetActive(false);
	}

	public IEnumerator ReloadAfterEditing(string n, bool shouldReload = true)
	{
		yield return null;
		if (shouldReload)
		{
			ReloadCarousel(n ?? Wear.cape_Custom);
		}
		PlayWeaponAnimation();
		UpdateIcon(currentCategory);
	}

	private static void SetBankCamerasEnabled()
	{
		List<Camera> list = BankController.Instance.GetComponentsInChildren<Camera>(true).ToList();
		List<Camera> list2 = list;
		foreach (Camera item in list2)
		{
			if ((!(ExpController.Instance != null) || !ExpController.Instance.IsRenderedWithCamera(item)) && !item.gameObject.tag.Equals("CamTemp") && !sharedShop.ourCameras.Contains(item))
			{
				item.rect = new Rect(0f, 0f, 1f, 1f);
			}
		}
	}

	private void BuyOrUpgradeWeapon(bool upgradeNotBuy = false)
	{
		string id = ((currentCategory != CategoryNames.GearCategory) ? viewedId : ((!upgradeNotBuy) ? IDForCurrentGear : NextUpgradeIDForCurrentGear));
		string tg = id;
		if (WeaponManager.tagToStoreIDMapping.ContainsKey(tg))
		{
			id = WeaponManager.tagToStoreIDMapping[(!Defs.IsTraining) ? WeaponManager.FirstUnboughtOrForOurTier(tg) : tg];
		}
		if (!Defs.IsTraining && WearCategory)
		{
			id = WeaponManager.FirstUnboughtTag(id);
			tg = id;
		}
		if (id == null)
		{
			return;
		}
		ItemPrice itemPrice = currentPrice(viewedId, currentCategory, upgradeNotBuy);
		TryToBuy(mainPanel, itemPrice, delegate
		{
			if (Defs.isSoundFX)
			{
				((!upgradeNotBuy) ? buy : upgrade).GetComponent<UIPlaySound>().Play();
			}
			ActualBuy(id, tg);
		}, delegate
		{
			if (currentCategory == CategoryNames.CapesCategory && viewedId.Equals(Wear.cape_Custom))
			{
				FlurryPluginWrapper.LogEvent("Try_Enable_Custom Cape");
			}
		}, () => Defs.IsTraining, delegate
		{
			PlayWeaponAnimation();
		}, delegate
		{
			SetBankCamerasEnabled();
		}, delegate
		{
			SetOtherCamerasEnabled(false);
			StartCoroutine(ReloadAfterEditing(viewedId));
		});
	}

	public static void ProvideShopItemOnStarterPackBoguht(CategoryNames c, string sourceTg, int gearCount = 1, bool buyArmorUpToSourceTg = false, int timeForRentIndex = 0, Action<string> contextSpecificAction = null, Action<string> customEquipWearAction = null)
	{
		string text = ((c != CategoryNames.GearCategory) ? sourceTg : GearManager.HolderQuantityForID(sourceTg));
		string text2 = text;
		if (WeaponManager.tagToStoreIDMapping.ContainsKey(text2))
		{
			text = WeaponManager.tagToStoreIDMapping[text2];
		}
		if (text == null)
		{
			return;
		}
		ProvdeShopItemWithRightId(c, text, text2, null, delegate(string item)
		{
			if (customEquipWearAction != null)
			{
				customEquipWearAction(item);
			}
			else
			{
				SetAsEquippedAndSendToServer(item, c);
			}
		}, contextSpecificAction, delegate(string item)
		{
			SaveSkinAndSendToServer(item);
		}, true, gearCount, buyArmorUpToSourceTg, timeForRentIndex);
	}

	private void EquipTemporaryItem(string itemTag)
	{
	}

	public static void ProvideAllTypeShopItem(CategoryNames category, string sourceTag, int gearCount, int timeForRent)
	{
		int timeForRentIndex = 0;
		if (timeForRent != -1)
		{
			int days = timeForRent / 24;
			timeForRentIndex = TempItemsController.RentIndexFromDays(days);
		}
		ProvideShopItemOnStarterPackBoguht(category, sourceTag, gearCount, false, timeForRentIndex, null, delegate(string tg)
		{
			if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.weaponsInGame != null)
			{
				if (GuiActive && sharedShop != null)
				{
					int num = PromoActionsGUIController.CatForTg(tg);
					if (num != -1)
					{
						EquipWearInCategoryIfNotEquiped(tg, (CategoryNames)num, WeaponManager.sharedManager != null && WeaponManager.sharedManager.myPlayerMoveC != null);
					}
				}
				else
				{
					int num2 = PromoActionsGUIController.CatForTg(tg);
					if (num2 != -1)
					{
						SetAsEquippedAndSendToServer(tg, (CategoryNames)num2);
					}
				}
			}
		});
		TempItemsController.sharedController.ExpiredItems.Remove(sourceTag);
	}

	private static void ProvdeShopItemWithRightId(CategoryNames c, string id, string tg, Action onTrainingAction, Action<string> onEquipWearAction, Action<string> contextSpecificAction, Action<string> onSkinBoughtAction, bool giveOneItemOfGear = false, int gearCount = 1, bool buyArmorAndHatsUpToTg = false, int timeForRentIndex = 0)
	{
		if (!Defs.IsTraining && ShopNGUIController.GunBought != null)
		{
			ShopNGUIController.GunBought();
		}
		if (Defs.IsTraining && onTrainingAction != null)
		{
			onTrainingAction();
		}
		if (IsWearCategory(c))
		{
			if (!Defs.IsTraining)
			{
				if (buyArmorAndHatsUpToTg && Wear.wear.ContainsKey(c))
				{
					List<List<string>> list = Wear.wear[c];
					List<string> list2 = null;
					foreach (List<string> item in list)
					{
						if (item.Contains(tg))
						{
							list2 = item;
							break;
						}
					}
					if (list2 != null)
					{
						for (int i = 0; i < list2.Count; i++)
						{
							Storager.setInt(list2[i], 1, true);
							if (list2[i].Equals(tg))
							{
								break;
							}
						}
						string text = WeaponManager.LastBoughtTag(list2[0]) ?? string.Empty;
						switch (c)
						{
						}
					}
				}
				else if (TempItemsController.PriceCoefs.ContainsKey(tg))
				{
					int tm = TempItemsController.RentTimeForIndex(timeForRentIndex);
					TempItemsController.sharedController.AddTemporaryItem(tg, tm);
				}
				else
				{
					Storager.setInt(tg, 1, true);
					string text2 = WeaponManager.LastBoughtTag(tg) ?? string.Empty;
					switch (c)
					{
					}
				}
				SynchronizeAndroidPurchases("Wear: " + tg);
			}
			if (onEquipWearAction != null)
			{
				onEquipWearAction(tg);
			}
		}
		if (!Defs.IsTraining && IsWeaponCategory(c) && !WeaponManager.FirstUnboughtTag(tg).Equals(tg))
		{
			List<string> list3 = WeaponUpgrades.ChainForTag(tg);
			if (list3 != null)
			{
				int num = list3.IndexOf(tg) - 1;
				if (num >= 0)
				{
					for (int j = 0; j <= num; j++)
					{
						try
						{
							Storager.setInt(WeaponManager.storeIDtoDefsSNMapping[WeaponManager.tagToStoreIDMapping[list3[j]]], 1, true);
						}
						catch
						{
							Debug.LogError("Error filling chain in indexOfWeaponBeforeCurrentTg");
						}
					}
				}
			}
		}
		WeaponManager.sharedManager.AddMinerWeapon(id, timeForRentIndex);
		if (c == CategoryNames.GearCategory)
		{
			if (id.Contains(GearManager.UpgradeSuffix))
			{
				string key = GearManager.NameForUpgrade(GearManager.HolderQuantityForID(id), GearManager.CurrentNumberOfUphradesForGear(GearManager.HolderQuantityForID(id)) + 1);
				Storager.setInt(key, 1, false);
			}
			else
			{
				int num2 = GearManager.ItemsInPackForGear(GearManager.HolderQuantityForID(id));
				if (Storager.getInt(id, false) + num2 > GearManager.MaxCountForGear(id))
				{
					num2 = GearManager.MaxCountForGear(id) - Storager.getInt(id, false);
				}
				Storager.setInt(id, Storager.getInt(id, false) + ((!giveOneItemOfGear) ? num2 : gearCount), false);
			}
		}
		if (contextSpecificAction != null)
		{
			contextSpecificAction(id);
		}
		if (c != CategoryNames.SkinsCategory)
		{
			return;
		}
		if (id != null && SkinsController.shopKeyFromNameSkin.ContainsKey(id))
		{
			string text3 = SkinsController.shopKeyFromNameSkin[id];
			if (Array.IndexOf(StoreKitEventListener.skinIDs, text3) >= 0)
			{
				foreach (KeyValuePair<string, string> value in InAppData.inAppData.Values)
				{
					if (value.Key != null && value.Key.Equals(text3))
					{
						Storager.setInt(value.Value, 1, true);
						SynchronizeAndroidPurchases("Skin: " + text3);
						break;
					}
				}
			}
		}
		if (onSkinBoughtAction != null)
		{
			onSkinBoughtAction(id);
		}
	}

	public void FireBuyAction(string item)
	{
		if (buyAction != null)
		{
			buyAction(item);
		}
	}

	public void ActualBuy(string id, string tg)
	{
		CategoryNames c = currentCategory;
		ProvdeShopItemWithRightId(c, id, tg, delegate
		{
			if (id.Equals("greandeLauncher_2"))
			{
				trainBougt1 = true;
			}
			else if (id.Equals("grenade_launcher_3"))
			{
				trainBought2 = true;
			}
			else if (id.Equals(Wear.Armor_Army_1))
			{
				armorBougt1 = true;
			}
			else if (id.Equals(Wear.Armor_Army_2))
			{
				armorBought2 = true;
			}
		}, delegate(string item)
		{
			EquipWear(item);
		}, delegate(string item)
		{
			if (IsWeaponCategory(c) || IsWearCategory(c))
			{
				FireBuyAction(item);
			}
			purchaseSuccessful.SetActive(true);
			_timePurchaseSuccessfulShown = Time.realtimeSinceStartup;
		}, delegate(string item)
		{
			SetSkinAsCurrent(item);
		});
		if (!Defs.IsTraining)
		{
			if (WeaponManager.tagToStoreIDMapping.ContainsValue(id))
			{
				IEnumerable<string> source = from item in WeaponManager.tagToStoreIDMapping
					where item.Value == id
					select item into kv
					select kv.Key;
				SynchronizeAndroidPurchases("Weapon: " + source.FirstOrDefault());
				ItemPrice priceByShopId = ItemDb.GetPriceByShopId(id);
				int? num = null;
				if (priceByShopId != null)
				{
					num = priceByShopId.Price;
				}
				if (num.HasValue && num.Value >= PlayerPrefs.GetInt(Defs.MostExpensiveWeapon, 0))
				{
					PlayerPrefs.SetInt(Defs.MostExpensiveWeapon, num.Value);
					PlayerPrefs.SetString(Defs.MenuPersWeaponTag, (source.Count() <= 0) ? string.Empty : source.ElementAt(0));
					PlayerPrefs.Save();
				}
			}
			string text = id;
			if (WeaponManager.tagToStoreIDMapping.ContainsKey(id))
			{
				text = WeaponManager.tagToStoreIDMapping[id];
			}
			List<int> value;
			Dictionary<string, string> dictionary;
			if (PromoActionsManager.sharedManager.discounts.TryGetValue(WeaponManager.LastBoughtTag(viewedId) ?? WeaponManager.FirstUnboughtTag(viewedId), out value) && value.Any())
			{
				int num2 = value.First();
				string itemNameNonLocalized = ItemDb.GetItemNameNonLocalized(WeaponManager.LastBoughtTag(viewedId) ?? WeaponManager.FirstUnboughtTag(viewedId), text, currentCategory, "Unknown");
				dictionary = new Dictionary<string, string>();
				dictionary.Add(num2.ToString(), itemNameNonLocalized);
				Dictionary<string, string> parameters = dictionary;
				FlurryPluginWrapper.LogEventAndDublicateToConsole("Offers Sale", parameters);
			}
			string text2 = currentCategory.ToString();
			if (currentCategory == CategoryNames.SkinsCategory && text != null && SkinsController.shopKeyFromNameSkin.ContainsKey(text))
			{
				text = SkinsController.shopKeyFromNameSkin[text];
			}
			string text3 = ItemDb.GetItemNameNonLocalized(WeaponManager.LastBoughtTag(viewedId) ?? WeaponManager.FirstUnboughtTag(viewedId), text, currentCategory);
			if (currentCategory == CategoryNames.GearCategory && text3 != null && !text3.Contains(GearManager.UpgradeSuffix) && GearManager.Gear.Contains(text3))
			{
				text3 = GearManager.AnalyticsIDForOneItemOfGear(text3);
			}
			string eventName = string.Format("Shop Purchases {0}", "Total");
			dictionary = new Dictionary<string, string>();
			dictionary.Add("All Categories", text2);
			dictionary.Add(text2, text3);
			dictionary.Add("Item", text3);
			Dictionary<string, string> dictionary2 = dictionary;
			if (currentCategory != CategoryNames.GearCategory)
			{
				dictionary2.Add("Without Quick Shop", text3);
			}
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, dictionary2);
			string payingSuffix = FlurryPluginWrapper.GetPayingSuffix();
			string eventName2 = string.Format("Shop Purchases {0}", "Total" + payingSuffix);
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName2, dictionary2);
			if (ExperienceController.sharedController != null)
			{
				int currentLevel = ExperienceController.sharedController.currentLevel;
				int num3 = (currentLevel - 1) / 9;
				string arg = string.Format("[{0}, {1})", num3 * 9 + 1, (num3 + 1) * 9 + 1);
				string eventName3 = string.Format("Shop Purchases On Level {0} ({1}){2}", arg, payingSuffix.Trim(), string.Empty);
				dictionary = new Dictionary<string, string>();
				dictionary.Add("Level " + currentLevel, text3);
				Dictionary<string, string> parameters2 = dictionary;
				FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName3, parameters2);
			}
			LogPurchaseAfterPaymentAnalyticsEvent(text3);
		}
		if (Defs.IsTraining)
		{
			if (WeaponCategory)
			{
				if (trainBougt1)
				{
					if (!trainBought2)
					{
						chosenId = WeaponTags.GrenadeLuancher_2Tag;
						viewedId = WeaponTags.grenade_launcher_3_Tag;
					}
					else
					{
						chosenId = WeaponTags.grenade_launcher_3_Tag;
						viewedId = WeaponTags.grenade_launcher_3_Tag;
					}
				}
			}
			else if (armorBougt1)
			{
				if (!armorBought2)
				{
					chosenId = Wear.Armor_Army_1;
					viewedId = Wear.Armor_Army_2;
				}
				else
				{
					chosenId = Wear.Armor_Army_2;
					viewedId = Wear.Armor_Army_2;
				}
			}
		}
		else
		{
			chosenId = WeaponManager.LastBoughtTag(viewedId);
			viewedId = ((currentCategory != CategoryNames.GearCategory) ? chosenId : GearManager.NameForUpgrade(GearManager.HolderQuantityForID(viewedId), GearManager.CurrentNumberOfUphradesForGear(GearManager.HolderQuantityForID(viewedId))));
		}
		UpdateIcon(currentCategory, true);
		ReloadCarousel(null);
		ChooseCarouselItem(viewedId, false, true);
		Resources.UnloadUnusedAssets();
		if (!inGame && currentCategory == CategoryNames.CapesCategory && viewedId.Equals(Wear.cape_Custom))
		{
			FlurryPluginWrapper.LogEvent("Enable_Custom Cape");
			wholePrice.gameObject.SetActive(false);
			goToSM();
		}
		if (Defs.IsTraining)
		{
			TrainingUpdate();
		}
	}

	private static void SaveSkinAndSendToServer(string id)
	{
		SkinsController.SetCurrentSkin(id);
		byte[] array = SkinsController.currentSkinForPers.EncodeToPNG();
		if (array != null)
		{
			string text = Convert.ToBase64String(array);
			if (text != null)
			{
				FriendsController.sharedController.skin = text;
				FriendsController.sharedController.SendOurData(true);
			}
		}
	}

	private void FireOnEquipSkin(string id)
	{
		if (onEquipSkinAction != null)
		{
			onEquipSkinAction(id);
		}
	}

	public void SetSkinAsCurrent(string id)
	{
		SaveSkinAndSendToServer(id);
		FireOnEquipSkin(id);
	}

	public static void SetAsEquippedAndSendToServer(string tg, CategoryNames c)
	{
		if (Defs.IsTraining)
		{
			return;
		}
		Storager.setString(SnForWearCategory(c), tg, false);
		switch (c)
		{
		case CategoryNames.CapesCategory:
			FriendsController.sharedController.capeName = tg;
			break;
		case CategoryNames.HatsCategory:
			FriendsController.sharedController.hatName = tg;
			break;
		case CategoryNames.BootsCategory:
			FriendsController.sharedController.bootsName = tg;
			break;
		case CategoryNames.ArmorCategory:
			FriendsController.sharedController.armorName = tg;
			break;
		}
		if (c == CategoryNames.CapesCategory && tg.Equals(Wear.cape_Custom))
		{
			byte[] array = SkinsController.capeUserTexture.EncodeToPNG();
			if (array != null)
			{
				string text = Convert.ToBase64String(array);
				if (text != null)
				{
					FriendsController.sharedController.capeSkin = text;
				}
			}
		}
		FriendsController.sharedController.SendOurData(false);
	}

	public IEnumerator BackAfterDelay()
	{
		yield return null;
		if (Defs.IsTraining)
		{
			TrainingController.isNextStep = TrainingController.stepTrainingList["Shop"];
		}
		if (resumeAction != null)
		{
			resumeAction();
		}
		else
		{
			GuiActive = false;
		}
		if (wearResumeAction != null)
		{
			wearResumeAction();
		}
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.isShowRanks = false;
		}
	}

	public static string SnForWearCategory(CategoryNames c)
	{
		string result;
		switch (c)
		{
		case CategoryNames.CapesCategory:
			result = Defs.CapeEquppedSN;
			break;
		case CategoryNames.BootsCategory:
			result = Defs.BootsEquppedSN;
			break;
		case CategoryNames.ArmorCategory:
			result = Defs.ArmorNewEquppedSN;
			break;
		default:
			result = Defs.HatEquppedSN;
			break;
		}
		return result;
	}

	public static string NoneEquippedForWearCategory(CategoryNames c)
	{
		string result;
		switch (c)
		{
		case CategoryNames.CapesCategory:
			result = Defs.CapeNoneEqupped;
			break;
		case CategoryNames.BootsCategory:
			result = Defs.BootsNoneEqupped;
			break;
		case CategoryNames.ArmorCategory:
			result = Defs.ArmorNewNoneEqupped;
			break;
		default:
			result = Defs.HatNoneEqupped;
			break;
		}
		return result;
	}

	public string WearForCat(CategoryNames c)
	{
		if (Defs.IsTraining && trainStep < 3)
		{
			return Defs.ArmorNewNoneEqupped;
		}
		string result;
		switch (c)
		{
		case CategoryNames.CapesCategory:
			result = _currentCape;
			break;
		case CategoryNames.BootsCategory:
			result = _currentBoots;
			break;
		case CategoryNames.ArmorCategory:
			result = _currentArmor;
			break;
		case CategoryNames.HatsCategory:
			result = _currentHat;
			break;
		default:
			result = string.Empty;
			break;
		}
		return result;
	}

	private void SetWearForCategory(CategoryNames cat, string wear)
	{
		switch (cat)
		{
		case CategoryNames.CapesCategory:
			_currentCape = wear;
			break;
		case CategoryNames.HatsCategory:
			_currentHat = wear;
			break;
		case CategoryNames.BootsCategory:
			_currentBoots = wear;
			break;
		case CategoryNames.ArmorCategory:
			_currentArmor = wear;
			break;
		case CategoryNames.SkinsCategory:
			break;
		}
	}

	public void LoadCurrentWearToVars()
	{
		_currentCape = Storager.getString(Defs.CapeEquppedSN, false);
		_currentHat = Storager.getString(Defs.HatEquppedSN, false);
		_currentBoots = Storager.getString(Defs.BootsEquppedSN, false);
		_currentArmor = Storager.getString(Defs.ArmorNewEquppedSN, false);
	}

	private void HandleActionsUUpdated()
	{
		UpdateButtons();
		UpdateItemParameters();
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (pauseStatus)
		{
			SaveShowArmorHatToPrefs();
		}
	}

	private void OnDestroy()
	{
		if (profile != null)
		{
			if (Device.IsLoweMemoryDevice)
			{
				Resources.UnloadAsset(profile);
			}
			profile = null;
		}
		SaveShowArmorHatToPrefs();
	}

	private void Start()
	{
		SetNick();
		_purchaseActivityIndicator = StoreKitEventListener.purchaseActivityInd;
		if (_purchaseActivityIndicator == null)
		{
			Debug.LogWarning("Start(): _purchaseActivityIndicator is null.");
		}
		StartCoroutine(TryToShowExpiredBanner());
	}

	private IEnumerator TryToShowExpiredBanner()
	{
		while (FriendsController.sharedController == null || TempItemsController.sharedController == null)
		{
			yield return null;
		}
		while (true)
		{
			yield return StartCoroutine(FriendsController.sharedController.MyWaitForSeconds(1f));
			try
			{
				if (!GuiActive || rentScreenPoint.childCount != 0 || (Storager.getInt(Defs.PremiumEnabledFromServer, false) == 1 && ShowPremimAccountExpiredIfPossible(rentScreenPoint, "NGUIShop", string.Empty)))
				{
					continue;
				}
				ShowTempItemExpiredIfPossible(rentScreenPoint, "NGUIShop", delegate(string tg)
				{
					if (PromoActionsGUIController.CatForTg(tg) == (int)currentCategory)
					{
						chosenId = WeaponManager.LastBoughtTag(tg);
					}
					if (tg.Equals(viewedId))
					{
						viewedId = ((currentCategory != CategoryNames.GearCategory) ? chosenId : GearManager.NameForUpgrade(GearManager.HolderQuantityForID(viewedId), GearManager.CurrentNumberOfUphradesForGear(GearManager.HolderQuantityForID(viewedId))));
						UpdateButtons();
					}
					UpdateIcons();
					purchaseSuccessful.SetActive(true);
					_timePurchaseSuccessfulShown = Time.realtimeSinceStartup;
				}, delegate
				{
					SetBankCamerasEnabled();
				}, delegate
				{
					SetOtherCamerasEnabled(false);
				}, delegate(string item)
				{
					if (item != null)
					{
						int num = PromoActionsGUIController.CatForTg(item);
						if (num != -1)
						{
							EquipWearInCategoryIfNotEquiped(item, (CategoryNames)num, inGame);
						}
					}
				});
			}
			catch (Exception e)
			{
				Debug.LogWarning("exception in Shop  TryToShowExpiredBanner: " + e);
			}
		}
	}

	private void Update()
	{
		if (!ActiveObject.activeInHierarchy)
		{
			return;
		}
		ExperienceController.sharedController.isShowRanks = rentScreenPoint.childCount == 0 && SkinEditorController.sharedController == null;
		if (Time.realtimeSinceStartup - timeToUpdateTempGunTime >= 1f)
		{
			timeToUpdateTempGunTime = Time.realtimeSinceStartup;
			if (GuiActive && TempItemsController.IsCategoryContainsTempItems(currentCategory) && viewedId != null && TempItemsController.PriceCoefs.ContainsKey(viewedId))
			{
				UpdateTempItemTime();
			}
		}
		string showHatTag = ((hatPoint.transform.childCount > 1) ? hatPoint.transform.GetChild(1).gameObject.tag : ((hatPoint.transform.childCount <= 0) ? "none" : hatPoint.transform.GetChild(0).gameObject.tag));
		bool flag = currentCategory == CategoryNames.HatsCategory && !Wear.NonArmorHat(showHatTag);
		bool flag2 = currentCategory == CategoryNames.ArmorCategory && viewedId != null && !TempItemsController.PriceCoefs.ContainsKey(viewedId);
		if (showArmorButton.gameObject.activeSelf != flag2)
		{
			showArmorButton.gameObject.SetActive(flag2);
		}
		bool flag3 = flag && viewedId != null && !TempItemsController.PriceCoefs.ContainsKey(viewedId);
		if (showHatButton.gameObject.activeSelf != flag3)
		{
			showHatButton.gameObject.SetActive(flag3);
		}
		bool flag4 = currentCategory == CategoryNames.ArmorCategory && viewedId != null && TempItemsController.PriceCoefs.ContainsKey(viewedId);
		if (showArmorButtonTempArmor.gameObject.activeSelf != flag4)
		{
			showArmorButtonTempArmor.gameObject.SetActive(flag4);
		}
		bool flag5 = flag && viewedId != null && TempItemsController.PriceCoefs.ContainsKey(viewedId);
		if (showHatButtonTempHat.gameObject.activeSelf != flag5)
		{
			showHatButtonTempHat.gameObject.SetActive(flag5);
		}
		if (Time.realtimeSinceStartup - _timePurchaseSuccessfulShown >= 2f)
		{
			purchaseSuccessful.SetActive(false);
		}
		if (Time.realtimeSinceStartup - _timePurchaseRentSuccessfulShown >= 2f)
		{
			purchaseSuccessfulRent.SetActive(false);
		}
		if (mainPanel.activeInHierarchy && !HOTween.IsTweening(MainMenu_Pers))
		{
			float num = -120f;
			num *= ((BuildSettings.BuildTarget != BuildTarget.Android) ? 0.5f : 2f);
			Rect rect = new Rect(0f, 0.1f * (float)Screen.height, 0.5f * (float)Screen.width, 0.8f * (float)Screen.height);
			if (Input.touchCount > 0)
			{
				Touch touch = Input.GetTouch(0);
				if (touch.phase == TouchPhase.Moved && rect.Contains(touch.position))
				{
					idleTimerLastTime = Time.realtimeSinceStartup;
					MainMenu_Pers.Rotate(Vector3.up, touch.deltaPosition.x * num * 0.5f * (Time.realtimeSinceStartup - lastTime));
				}
			}
			if (Application.isEditor)
			{
				float num2 = Input.GetAxis("Mouse ScrollWheel") * 3f * num * (Time.realtimeSinceStartup - lastTime);
				MainMenu_Pers.Rotate(Vector3.up, num2);
				if (num2 != 0f)
				{
					idleTimerLastTime = Time.realtimeSinceStartup;
				}
			}
			lastTime = Time.realtimeSinceStartup;
		}
		if (currentCategory != CategoryNames.CapesCategory && Time.realtimeSinceStartup - idleTimerLastTime > IdleTimeoutPers)
		{
			SetCamera();
		}
		if (!(_purchaseActivityIndicator == null))
		{
			_purchaseActivityIndicator.SetActive(StoreKitEventListener.restoreInProcess);
		}
		float num3 = scrollViewPanel.GetViewSize().x / 2f;
		ShopCarouselElement[] componentsInChildren = wrapContent.GetComponentsInChildren<ShopCarouselElement>(false);
		ShopCarouselElement[] array = componentsInChildren;
		foreach (ShopCarouselElement shopCarouselElement in array)
		{
			Transform transform = shopCarouselElement.transform;
			float x = scrollViewPanel.clipOffset.x;
			float num4 = Mathf.Abs(transform.localPosition.x - x);
			float num5 = scaleCoef + (1f - scaleCoef) * (1f - num4 / num3);
			float num6 = 0.65f;
			num5 = ((!(num4 <= num3 / 3f)) ? (scaleCoef + (num6 - scaleCoef) * (1f - (num4 - num3 / 3f) / (num3 * 2f / 3f))) : (num6 + (1f - num6) * (1f - num4 / (num3 / 3f))));
			if (num4 >= num3 * 0.9f)
			{
				num5 = 0f;
			}
			float num7 = transform.localPosition.x - x;
			float num8 = 0f;
			float num9 = ((num7 <= 0f) ? 1 : (-1));
			if (num7 != 0f)
			{
				num8 = ((Mathf.Abs(num7) <= wrapContent.cellWidth) ? (firstOFfset * (Mathf.Abs(num7) / wrapContent.cellWidth)) : ((!(Mathf.Abs(num7) <= 2f * wrapContent.cellWidth)) ? (secondOffset * (1f - (Mathf.Abs(num7) - 2f * wrapContent.cellWidth) / wrapContent.cellWidth)) : (firstOFfset + (secondOffset - firstOFfset) * ((Mathf.Abs(num7) - wrapContent.cellWidth) / wrapContent.cellWidth))));
			}
			num8 *= num9;
			if (!EnableConfigurePos || scrollViewPanel.GetComponent<UIScrollView>().isDragging || scrollViewPanel.GetComponent<UIScrollView>().currentMomentum.x > 0f)
			{
				shopCarouselElement.SetPos(num5, num8);
			}
			shopCarouselElement.topSeller.gameObject.SetActive(shopCarouselElement.showTS && Mathf.Abs(num4) <= wrapContent.cellWidth / 10f);
			shopCarouselElement.newnew.gameObject.SetActive(shopCarouselElement.showNew && Mathf.Abs(num4) <= wrapContent.cellWidth / 10f);
			shopCarouselElement.quantity.gameObject.SetActive(shopCarouselElement.showQuantity && Mathf.Abs(num4) <= wrapContent.cellWidth / 10f);
		}
		CheckCenterItemChanging();
	}

	private void LateUpdate()
	{
		if (_escapeRequested)
		{
			StartCoroutine(BackAfterDelay());
			_escapeRequested = false;
		}
		if (!Input.GetKeyUp(KeyCode.Escape) || (BankController.Instance != null && BankController.Instance.InterfaceEnabled) || (ProfileController.Instance != null && ProfileController.Instance.InterfaceEnabled))
		{
			return;
		}
		if (!GuiActive)
		{
			if (Defs.IsDeveloperBuild)
			{
				Debug.Log(GetType().Name + ".LateUpdate():    Ignoring Escape because Shop GUI is not active.");
			}
		}
		else
		{
			Input.ResetInputAxes();
			_escapeRequested = true;
		}
	}

	public void SetNick()
	{
		Vector3 position = ourCameras[1].WorldToViewportPoint(hatPoint.position + new Vector3(0f, 1.4f, 0f));
		Vector3 position2 = ourCameras[0].ViewportToWorldPoint(position);
		nick.transform.position = position2;
		nick.transform.localPosition = new Vector3(nick.transform.localPosition.x, nick.transform.localPosition.y, 0f);
	}

	public void SetGearCatEnabled(bool e)
	{
		inGame = e;
	}

	private IEnumerator DisableStub()
	{
		for (int i = 0; i < 3; i++)
		{
			yield return null;
		}
		stub.SetActive(false);
	}

	public void MakeACtiveAfterDelay(string idToSet, CategoryNames cn)
	{
		Light[] array = UnityEngine.Object.FindObjectsOfType<Light>();
		if (array == null)
		{
			array = new Light[0];
		}
		Light[] array2 = array;
		foreach (Light light in array2)
		{
			if (!mylights.Contains(light))
			{
				light.cullingMask &= ~(1 << LayerMask.NameToLayer("NGUIShop"));
			}
		}
		sharedShop.ActiveObject.SetActive(true);
		wrapContent.Reposition();
		if (ExperienceController.sharedController != null && ExpController.Instance != null)
		{
			ExperienceController.sharedController.isShowRanks = true;
			ExpController.Instance.InterfaceEnabled = true;
		}
		if (!Defs.IsTraining)
		{
			UpdatePersHat(_currentHat);
			UpdatePersCape(_currentCape);
			UpdatePersArmor(_currentArmor);
			UpdatePersBoots(_currentBoots);
			UpdatePersSkin(SkinsController.currentSkinNameForPers);
		}
		SetNick();
		MyCenterOnChild myCenterOnChild = carouselCenter;
		myCenterOnChild.onFinished = (SpringPanel.OnFinished)Delegate.Combine(myCenterOnChild.onFinished, new SpringPanel.OnFinished(HandleCarouselCentering));
		PromoActionsManager.ActionsUUpdated += HandleActionsUUpdated;
		PlayWeaponAnimation();
		idleTimerLastTime = Time.realtimeSinceStartup;
		if (idToSet != null)
		{
			sharedShop.ChooseCarouselItem(idToSet, false, true);
		}
		GameObject[] array3 = bystepCollider;
		foreach (GameObject gameObject in array3)
		{
			gameObject.SetActive(false);
		}
		if (Defs.IsTraining)
		{
			TrainingUpdate();
		}
		sharedShop.carouselCenter.enabled = true;
		AdjustCategoryButtonsForFilterMap();
	}

	private void AdjustCategoryButtonsForFilterMap()
	{
		List<int> list = new List<int>();
		if (Application.loadedLevelName.Equals("Sniper"))
		{
			List<int> list2 = new List<int>();
			list2.Add(0);
			list2.Add(4);
			list = list2;
		}
		else if (Application.loadedLevelName.Equals("Knife"))
		{
			List<int> list2 = new List<int>();
			list2.Add(0);
			list2.Add(1);
			list2.Add(3);
			list2.Add(4);
			list = list2;
		}
		else if (Defs.IsTraining)
		{
			List<int> list2 = new List<int>();
			list2.Add(0);
			list2.Add(1);
			list2.Add(2);
			list2.Add(3);
			list2.Add(5);
			list2.Add(8);
			list2.Add(7);
			list2.Add(9);
			list2.Add(10);
			list = list2;
		}
		else if (Defs.isHunger)
		{
			List<int> list2 = new List<int>();
			list2.Add(5);
			list2.Add(6);
			list = list2;
		}
		for (int i = 0; i < category.buttons.Length; i++)
		{
			category.buttons[i].onButton.GetComponent<BoxCollider>().enabled = !list.Contains(i) && category.buttons[i].onButton.GetComponent<BoxCollider>().enabled;
			category.buttons[i].offButton.GetComponent<BoxCollider>().enabled = !list.Contains(i);
		}
	}

	private void TrainingUpdate()
	{
		trainStep++;
		foreach (Transform trainingLAbel in trainingLAbels)
		{
			trainingLAbel.gameObject.SetActive(trainingLAbel.gameObject.name.Equals(trainStep.ToString()));
		}
		for (int i = 0; i < bystepCollider.Length; i++)
		{
			bystepCollider[i].SetActive(false);
		}
		if (trainStep < bystepCollider.Length)
		{
			bystepCollider[trainStep].SetActive(true);
		}
		else
		{
			Debug.LogError(string.Format("Train step {0} is out of range {1}.", trainStep, bystepCollider.Length));
		}
		switch (trainStep)
		{
		case 0:
			toBlink = buy.tweenTarget.GetComponent<UISprite>();
			break;
		case 1:
			buy.tweenTarget.GetComponent<UISprite>().spriteName = "green_btn";
			buy.normalSprite = "green_btn";
			toBlink = upgrade.tweenTarget.GetComponent<UISprite>();
			break;
		case 2:
			upgrade.tweenTarget.GetComponent<UISprite>().spriteName = "green_btn";
			upgrade.normalSprite = "green_btn";
			toBlink = category.buttons[6].offButton.tweenTarget.GetComponent<UISprite>();
			break;
		case 3:
			category.buttons[6].offButton.tweenTarget.GetComponent<UISprite>().spriteName = "shop_gold_btn";
			category.buttons[6].offButton.normalSprite = "shop_gold_btn";
			toBlink = buy.tweenTarget.GetComponent<UISprite>();
			break;
		case 4:
			buy.tweenTarget.GetComponent<UISprite>().spriteName = "green_btn";
			buy.normalSprite = "green_btn";
			toBlink = upgrade.tweenTarget.GetComponent<UISprite>();
			break;
		case 5:
			upgrade.tweenTarget.GetComponent<UISprite>().spriteName = "green_btn";
			upgrade.normalSprite = "green_btn";
			toBlink = backButton.tweenTarget.GetComponent<UISprite>();
			break;
		}
		StopCoroutine("Blink");
		StartCoroutine("Blink", (trainStep == 2) ? new string[2] { "shop_gold_btn_on", "shop_gold_btn" } : new string[2] { "yell_btn", "green_btn" });
	}

	private IEnumerator Blink(string[] images)
	{
		while (true)
		{
			toBlink.spriteName = ((!toBlink.spriteName.Equals(images[0])) ? images[0] : images[1]);
			yield return StartCoroutine(MyWaitForSeconds(0.5f));
		}
	}

	public IEnumerator MyWaitForSeconds(float tm)
	{
		float startTime = Time.realtimeSinceStartup;
		do
		{
			yield return null;
		}
		while (Time.realtimeSinceStartup - startTime < tm);
	}

	private static string TemppOrHighestDPSGunInCategory(int cInt)
	{
		string text = null;
		if (WeaponManager.sharedManager != null && WeaponManager.sharedManager._weaponsByCat != null && WeaponManager.sharedManager._weaponsByCat.Count > cInt)
		{
			List<GameObject> list = WeaponManager.sharedManager._weaponsByCat[cInt];
			GameObject gameObject = list.Find((GameObject w) => ItemDb.IsTemporaryGun(w.tag));
			if (gameObject != null)
			{
				text = gameObject.tag;
			}
			if (text == null && list.Count > 0)
			{
				for (int num = list.Count - 1; num >= 0; num--)
				{
					if (!ItemDb.IsTemporaryGun(list[num].tag) && ExpController.Instance != null && list[num].GetComponent<WeaponSounds>().tier <= ExpController.Instance.OurTier)
					{
						text = list[num].tag;
						break;
					}
				}
			}
		}
		return text;
	}

	public static string TempGunOrHighestDPSGun(CategoryNames c, out CategoryNames cn)
	{
		cn = c;
		string text = null;
		text = TemppOrHighestDPSGunInCategory((int)c);
		if (text == null && WeaponManager.sharedManager.playerWeapons.Count > 0)
		{
			int num = (WeaponManager.sharedManager.playerWeapons[0] as Weapon).weaponPrefab.GetComponent<WeaponSounds>().categoryNabor - 1;
			text = TemppOrHighestDPSGunInCategory(num);
			cn = (CategoryNames)num;
		}
		return text;
	}

	public void ResetTrainingState()
	{
		trainStep = -1;
		trainBougt1 = (trainBought2 = (armorBougt1 = (armorBought2 = false)));
	}

	private void OnLevelWasLoaded(int level)
	{
		if (GuiActive)
		{
			_storedAmbientLight = RenderSettings.ambientLight;
			_storedFogEnabled = RenderSettings.fog;
			RenderSettings.ambientLight = Defs.AmbientLightColorForShop();
			RenderSettings.fog = false;
		}
	}

	public void SetOtherCamerasEnabled(bool e)
	{
		List<Camera> list = (Camera.allCameras ?? new Camera[0]).ToList();
		List<Camera> collection = ProfileController.Instance.GetComponentsInChildren<Camera>(true).ToList();
		List<Camera> collection2 = BankController.Instance.GetComponentsInChildren<Camera>(true).ToList();
		list.AddRange(collection);
		list.AddRange(collection2);
		foreach (Camera item in list)
		{
			if ((!(ExpController.Instance != null) || !ExpController.Instance.IsRenderedWithCamera(item)) && !item.gameObject.tag.Equals("CamTemp") && !sharedShop.ourCameras.Contains(item))
			{
				item.rect = new Rect(0f, 0f, e ? 1 : 0, e ? 1 : 0);
			}
		}
	}

	private static void SetIconChosen(CategoryNames cn)
	{
		for (int i = 0; i < sharedShop.category.buttons.Length; i++)
		{
			sharedShop.category.buttons[i].SetCheckedImage(i == (int)cn);
			if (i == (int)cn)
			{
				sharedShop.category.buttons[i].onButton.GetComponent<BoxCollider>().enabled = false;
			}
		}
	}

	public IEnumerator HideAfterDelay()
	{
		yield return null;
	}

	public static void DisableLightProbesRecursively(GameObject w)
	{
		Player_move_c.PerformActionRecurs(w, delegate(Transform t)
		{
			MeshRenderer component = t.GetComponent<MeshRenderer>();
			SkinnedMeshRenderer component2 = t.GetComponent<SkinnedMeshRenderer>();
			if (component != null)
			{
				component.useLightProbes = false;
			}
			if (component2 != null)
			{
				component2.useLightProbes = false;
			}
		});
	}

	public void SetWeapon(string tg)
	{
		animationCoroutineRunner.StopAllCoroutines();
		if (WeaponManager.sharedManager == null)
		{
			return;
		}
		if (armorPoint.childCount > 0)
		{
			ArmorRefs component = armorPoint.GetChild(0).GetChild(0).GetComponent<ArmorRefs>();
			if (component != null)
			{
				if (component.leftBone != null)
				{
					Vector3 position = component.leftBone.position;
					Quaternion rotation = component.leftBone.rotation;
					component.leftBone.parent = armorPoint.GetChild(0).GetChild(0);
					component.leftBone.position = position;
					component.leftBone.rotation = rotation;
				}
				if (component.rightBone != null)
				{
					Vector3 position2 = component.rightBone.position;
					Quaternion rotation2 = component.rightBone.rotation;
					component.rightBone.parent = armorPoint.GetChild(0).GetChild(0);
					component.rightBone.position = position2;
					component.rightBone.rotation = rotation2;
				}
			}
		}
		List<Transform> list = new List<Transform>();
		foreach (Transform item in body.transform)
		{
			list.Add(item);
		}
		foreach (Transform item2 in list)
		{
			item2.parent = null;
			item2.position = new Vector3(0f, -10000f, 0f);
			UnityEngine.Object.Destroy(item2.gameObject);
		}
		if (tg == null)
		{
			return;
		}
		if (profile != null)
		{
			if (Device.IsLoweMemoryDevice)
			{
				Resources.UnloadAsset(profile);
			}
			profile = null;
		}
		GameObject gameObject = null;
		UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
		for (int i = 0; i < weaponsInGame.Length; i++)
		{
			GameObject gameObject2 = (GameObject)weaponsInGame[i];
			if (gameObject2.tag.Equals(tg))
			{
				gameObject = gameObject2;
				break;
			}
		}
		UnityEngine.Object[] weaponsInGame2 = WeaponManager.sharedManager.weaponsInGame;
		for (int j = 0; j < weaponsInGame2.Length; j++)
		{
			GameObject gameObject3 = (GameObject)weaponsInGame2[j];
			if (gameObject3.tag.Equals(tg))
			{
				gameObject = gameObject3;
				break;
			}
		}
		if (gameObject == null)
		{
			Debug.Log("pref==null");
			return;
		}
		profile = Resources.Load<AnimationClip>("ProfileAnimClips/" + gameObject.name + "_Profile");
		GameObject gameObject4 = UnityEngine.Object.Instantiate(gameObject) as GameObject;
		DisableLightProbesRecursively(gameObject4);
		Player_move_c.SetLayerRecursively(gameObject4, LayerMask.NameToLayer("NGUIShop"));
		gameObject4.transform.parent = body.transform;
		weapon = gameObject4;
		weapon.transform.localScale = new Vector3(1f, 1f, 1f);
		weapon.transform.position = body.transform.position;
		weapon.transform.localPosition = Vector3.zero;
		weapon.transform.localRotation = Quaternion.identity;
		WeaponSounds component2 = weapon.GetComponent<WeaponSounds>();
		if (armorPoint.childCount > 0 && component2 != null)
		{
			ArmorRefs component3 = armorPoint.GetChild(0).GetChild(0).GetComponent<ArmorRefs>();
			if (component3 != null)
			{
				if (component3.leftBone != null && component2.LeftArmorHand != null)
				{
					component3.leftBone.parent = component2.LeftArmorHand;
					component3.leftBone.localPosition = Vector3.zero;
					component3.leftBone.localRotation = Quaternion.identity;
					component3.leftBone.localScale = new Vector3(1f, 1f, 1f);
				}
				if (component3.rightBone != null && component2.RightArmorHand != null)
				{
					component3.rightBone.parent = component2.RightArmorHand;
					component3.rightBone.localPosition = Vector3.zero;
					component3.rightBone.localRotation = Quaternion.identity;
					component3.rightBone.localScale = new Vector3(1f, 1f, 1f);
				}
			}
		}
		PlayWeaponAnimation();
		DisableGunflashes(weapon);
		if (SkinsController.currentSkinForPers != null)
		{
			SetSkinOnPers(SkinsController.currentSkinForPers);
		}
		_assignedWeaponTag = tg;
	}

	internal static void SynchronizeAndroidPurchases(string comment)
	{
		if (BuildSettings.BuildTarget != BuildTarget.Android)
		{
			return;
		}
		Debug.Log("Trying to synchronize purchases to cloud (" + comment + ")");
		Action ResetWeaponManager = delegate
		{
			PlayerPrefs.DeleteKey("PendingGooglePlayGamesSync");
			if (WeaponManager.sharedManager != null)
			{
				int currentWeaponIndex = WeaponManager.sharedManager.CurrentWeaponIndex;
				WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(Application.loadedLevelName) ? Defs.filterMaps[Application.loadedLevelName] : 0);
				WeaponManager.sharedManager.CurrentWeaponIndex = currentWeaponIndex;
			}
			if (GuiActive)
			{
				sharedShop.UpdateIcons();
			}
		};
		switch (Defs.AndroidEdition)
		{
		case Defs.RuntimeAndroidEdition.Amazon:
			PurchasesSynchronizer.Instance.SynchronizeAmazonPurchases();
			ResetWeaponManager();
			break;
		case Defs.RuntimeAndroidEdition.GoogleLite:
			PlayerPrefs.SetInt("PendingGooglePlayGamesSync", 1);
			PurchasesSynchronizer.Instance.AuthenticateAndSynchronize(delegate(bool success)
			{
				Debug.Log("Google purchases syncronized (" + comment + "): " + success);
				if (success)
				{
					ResetWeaponManager();
				}
			}, true);
			break;
		}
	}
}
