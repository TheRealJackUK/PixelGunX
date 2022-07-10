using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class TempItemsController : MonoBehaviour
{
	private const long _salt = 1002855644958404316L;

	private const string DurationKey = "Duration";

	private const string StartKey = "Start";

	private const string ExpiredItemsKey = "ExpiredITemptemsControllerKey";

	public static TempItemsController sharedController;

	public List<string> ExpiredItems = new List<string>();

	public static Dictionary<string, List<float>> PriceCoefs;

	public static Dictionary<string, string> GunsMappingFromTempToConst;

	private Dictionary<string, Dictionary<string, SaltedLong>> Items = new Dictionary<string, Dictionary<string, SaltedLong>>();

	private static List<int> rentTms;

	static TempItemsController()
	{
		PriceCoefs = new Dictionary<string, List<float>>
		{
			{
				WeaponTags.Assault_Machine_Gun_Tag,
				new List<float> { 1f, 2f, 4f }
			},
			{
				WeaponTags.Impulse_Sniper_Rifle_Tag,
				new List<float> { 1f, 2.3333333f, 3.6666667f }
			},
			{
				Wear.Armor_Adamant_3,
				new List<float> { 1f, 2.6666667f, 5.3333335f }
			},
			{
				Wear.hat_Adamant_3,
				new List<float> { 1f, 2.6666667f, 5.3333335f }
			},
			{
				WeaponTags.RailRevolver_1_Tag,
				new List<float> { 1f, 2f, 4f }
			},
			{
				WeaponTags.Autoaim_Rocketlauncher_Tag,
				new List<float> { 1f, 2f, 3.125f }
			},
			{
				WeaponTags.TwoBoltersRent_Tag,
				new List<float> { 1f, 2f, 3.125f }
			},
			{
				WeaponTags.Red_StoneRent_Tag,
				new List<float> { 1f, 2f, 3.125f }
			},
			{
				WeaponTags.DragonGunRent_Tag,
				new List<float> { 1f, 2f, 3.125f }
			},
			{
				WeaponTags.PumpkinGunRent_Tag,
				new List<float> { 1f, 2f, 3.125f }
			},
			{
				WeaponTags.RayMinigunRent_Tag,
				new List<float> { 1f, 2f, 3.125f }
			}
		};
		GunsMappingFromTempToConst = new Dictionary<string, string>();
		rentTms = null;
		GunsMappingFromTempToConst.Add(WeaponTags.Assault_Machine_Gun_Tag, WeaponTags.Assault_Machine_GunBuy_Tag);
		GunsMappingFromTempToConst.Add(WeaponTags.Impulse_Sniper_Rifle_Tag, WeaponTags.Impulse_Sniper_RifleBuy_Tag);
		GunsMappingFromTempToConst.Add(WeaponTags.RailRevolver_1_Tag, WeaponTags.RailRevolverBuy_Tag);
		GunsMappingFromTempToConst.Add(WeaponTags.Autoaim_Rocketlauncher_Tag, WeaponTags.Autoaim_RocketlauncherBuy_Tag);
	}

	public static int RentIndexFromDays(int days)
	{
		int result = 0;
		switch (days)
		{
		case 1:
			result = 0;
			break;
		case 2:
			result = 3;
			break;
		case 3:
			result = 1;
			break;
		case 5:
			result = 4;
			break;
		case 7:
			result = 2;
			break;
		}
		return result;
	}

	public static bool IsCategoryContainsTempItems(ShopNGUIController.CategoryNames cat)
	{
		return ShopNGUIController.IsWeaponCategory(cat) || cat == ShopNGUIController.CategoryNames.ArmorCategory || cat == ShopNGUIController.CategoryNames.HatsCategory;
	}

	public void AddTemporaryItem(string tg, int tm)
	{
		AddTimeForItem(tg, (tm >= 0) ? tm : 0);
	}

	public static int RentTimeForIndex(int timeForRentIndex)
	{
		if (rentTms == null)
		{
			List<int> list = new List<int>();
			list.Add(60);
			list.Add(300);
			list.Add(86400);
			list.Add(172800);
			list.Add(432000);
			rentTms = list;
		}
		int result = 86400;
		if (timeForRentIndex < rentTms.Count && timeForRentIndex >= 0)
		{
			result = rentTms[timeForRentIndex];
		}
		return result;
	}

	public bool CanShowExpiredBannerForTag(string tg)
	{
		if (tg == null)
		{
			return false;
		}
		bool flag = ItemIsArmorOrHat(tg);
		if (flag)
		{
			return false;
		}
		bool num;
		if (flag)
		{
			if (WeaponManager.sharedManager != null && !Defs.IsTraining)
			{
				num = WeaponManager.sharedManager.myPlayerMoveC == null;
				goto IL_0095;
			}
		}
		else if (WeaponManager.sharedManager != null && !WeaponManager.sharedManager.ResetLockSet && !Defs.isHunger && !Defs.IsTraining)
		{
			num = WeaponManager.sharedManager.myPlayerMoveC == null;
			goto IL_0095;
		}
		goto IL_009c;
		IL_009c:
		return false;
		IL_0095:
		if (num)
		{
			if (flag)
			{
				return true;
			}
			bool result = false;
			UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
			for (int i = 0; i < weaponsInGame.Length; i++)
			{
				GameObject gameObject = (GameObject)weaponsInGame[i];
				if (gameObject.tag.Equals(tg))
				{
					WeaponSounds component = gameObject.GetComponent<WeaponSounds>();
					if (component != null)
					{
						result = WeaponManager.sharedManager._currentFilterMap == 0 || component.IsAvalibleFromFilter(WeaponManager.sharedManager._currentFilterMap);
					}
					break;
				}
			}
			return result;
		}
		goto IL_009c;
	}

	public long TimeRemainingForItems(string tg)
	{
		if (tg == null || !ContainsItem(tg))
		{
			return 0L;
		}
		Dictionary<string, SaltedLong> dictionary = Items[tg];
		SaltedLong value;
		SaltedLong value2;
		if (dictionary.TryGetValue("Start", out value) && dictionary.TryGetValue("Duration", out value2))
		{
			return Math.Max(value.Value + value2.Value - PromoActionsManager.CurrentUnixTime, 0L);
		}
		return 0L;
	}

	public static string TempItemTimeRemainsStringRepresentation(long seconds)
	{
		TimeSpan timeSpan = TimeSpan.FromSeconds(seconds);
		string empty = string.Empty;
		if (seconds >= 86400)
		{
			long num = seconds / 86400;
			long num2 = seconds % 86400;
			if (num2 > 43200)
			{
				num++;
			}
			return num.ToString();
		}
		return string.Format("{0:D2}h:{1:D2}m:{2:D2}s", timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds);
	}

	public string TimeRemainingForItemString(string tg)
	{
		return TempItemTimeRemainsStringRepresentation(TimeRemainingForItems(tg));
	}

	public void AddTimeForItem(string item, int time)
	{
		if (item == null || (float)time <= 0f)
		{
			return;
		}
		if (Items.ContainsKey(item))
		{
			long num = Items[item]["Duration"].Value;
			long value = Items[item]["Start"].Value;
			if (value + num - PromoActionsManager.CurrentUnixTime < 0)
			{
				num = PromoActionsManager.CurrentUnixTime - value;
			}
			num += time;
			Items[item]["Duration"] = new SaltedLong(1002855644958404316L, num);
		}
		else
		{
			Items.Add(item, new Dictionary<string, SaltedLong>
			{
				{
					"Duration",
					new SaltedLong(1002855644958404316L, time)
				},
				{
					"Start",
					new SaltedLong(1002855644958404316L, PromoActionsManager.CurrentUnixTime)
				}
			});
		}
	}

	public bool ContainsItem(string item)
	{
		if (item == null)
		{
			return false;
		}
		return Items.ContainsKey(item);
	}

	private static void PrepareKeyForItemsJson()
	{
		if (!Storager.hasKey(Defs.TempItemsDictionaryKey))
		{
			Storager.setString(Defs.TempItemsDictionaryKey, "{}", false);
		}
	}

	private static bool ItemIsArmorOrHat(string tg)
	{
		int num = PromoActionsGUIController.CatForTg(tg);
		int result;
		switch (num)
		{
		default:
			result = ((num == 5) ? 1 : 0);
			break;
		case 6:
			result = 1;
			break;
		case -1:
			result = 0;
			break;
		}
		return (byte)result != 0;
	}

	private void Awake()
	{
		sharedController = this;
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		DeserializeItems();
		DeserializeExpiredObjects();
		CheckForTimeHack();
		RemoveExpiredItems();
	}

	private void Start()
	{
		StartCoroutine(Step());
	}

	private void RemoveExpiredItems()
	{
		if (Defs.IsTraining || !(WeaponManager.sharedManager != null) || WeaponManager.sharedManager.weaponsInGame == null || Application.loadedLevelName.Equals("ConnectScene") || WeaponManager.sharedManager.ResetLockSet)
		{
			return;
		}
		List<KeyValuePair<string, Dictionary<string, SaltedLong>>> list = Items.Where((KeyValuePair<string, Dictionary<string, SaltedLong>> kvp) => PromoActionsManager.CurrentUnixTime - kvp.Value["Start"].Value >= kvp.Value["Duration"].Value).ToList();
		if (WeaponManager.sharedManager.myPlayerMoveC == null)
		{
			foreach (KeyValuePair<string, Dictionary<string, SaltedLong>> item in list)
			{
				Items.Remove(item.Key);
				RemoveTemporaryItem(item.Key);
				if (!ExpiredItems.Contains(item.Key))
				{
					ExpiredItems.Add(item.Key);
				}
			}
			if (list.Count > 0 && ShopNGUIController.sharedShop != null)
			{
				ShopNGUIController.sharedShop.ReloadCategoryTempItemsRemoved(list.Select((KeyValuePair<string, Dictionary<string, SaltedLong>> kvp) => kvp.Key).ToList());
			}
			return;
		}
		foreach (KeyValuePair<string, Dictionary<string, SaltedLong>> item2 in list)
		{
			if (!ExpiredItems.Contains(item2.Key))
			{
				ExpiredItems.Add(item2.Key);
			}
		}
	}

	private void RemoveTemporaryItem(string key)
	{
		if (ItemIsArmorOrHat(key))
		{
			Wear.RemoveTemporaryWear(key);
		}
		else
		{
			WeaponManager.sharedManager.RemoveTemporaryItem(key);
		}
	}

	private IEnumerator Step()
	{
		while (true)
		{
			if (FriendsController.sharedController == null)
			{
				yield return null;
				continue;
			}
			yield return StartCoroutine(FriendsController.sharedController.MyWaitForSeconds(1f));
			RemoveExpiredItems();
		}
	}

	private void CheckForTimeHack()
	{
		long lastSuspendTime = GetLastSuspendTime();
		if (lastSuspendTime <= PromoActionsManager.CurrentUnixTime)
		{
			return;
		}
		foreach (KeyValuePair<string, Dictionary<string, SaltedLong>> item in Items)
		{
			if (item.Value != null && item.Value.ContainsKey("Duration"))
			{
				item.Value["Duration"] = new SaltedLong(1002855644958404316L, 0L);
				item.Value["Start"] = new SaltedLong(1002855644958404316L, 0L);
			}
		}
		SerializeItems();
	}

	private static Dictionary<string, Dictionary<string, SaltedLong>> ToSaltedDictionary(Dictionary<string, Dictionary<string, long>> normalDict)
	{
		if (normalDict == null)
		{
			return null;
		}
		Dictionary<string, Dictionary<string, SaltedLong>> dictionary = new Dictionary<string, Dictionary<string, SaltedLong>>();
		foreach (KeyValuePair<string, Dictionary<string, long>> item in normalDict)
		{
			Dictionary<string, SaltedLong> dictionary2 = new Dictionary<string, SaltedLong>();
			if (item.Value != null)
			{
				foreach (KeyValuePair<string, long> item2 in item.Value)
				{
					if (item2.Key != null)
					{
						dictionary2.Add(item2.Key, new SaltedLong(1002855644958404316L, item2.Value));
					}
				}
			}
			dictionary.Add(item.Key, dictionary2);
		}
		return dictionary;
	}

	private static Dictionary<string, Dictionary<string, long>> ToNormalDictionary(Dictionary<string, Dictionary<string, SaltedLong>> saltedDict_)
	{
		if (saltedDict_ == null)
		{
			return null;
		}
		Dictionary<string, Dictionary<string, long>> dictionary = new Dictionary<string, Dictionary<string, long>>();
		foreach (KeyValuePair<string, Dictionary<string, SaltedLong>> item in saltedDict_)
		{
			Dictionary<string, long> dictionary2 = new Dictionary<string, long>();
			if (item.Value != null)
			{
				foreach (KeyValuePair<string, SaltedLong> item2 in item.Value)
				{
					if (item2.Key != null)
					{
						dictionary2.Add(item2.Key, item2.Value.Value);
					}
				}
			}
			dictionary.Add(item.Key, dictionary2);
		}
		return dictionary;
	}

	private void DeserializeItems()
	{
		//Discarded unreachable code: IL_0110, IL_016e
		PrepareKeyForItemsJson();
		if (PlayerPrefs.HasKey("WantToResetKeychain"))
		{
			return;
		}
		object obj = Json.Deserialize(Storager.getString(Defs.TempItemsDictionaryKey, false));
		if (obj == null)
		{
			Debug.LogWarning("Error Deserializing temp items JSON");
			return;
		}
		Dictionary<string, object> dictionary = obj as Dictionary<string, object>;
		if (dictionary == null)
		{
			Debug.LogWarning("Error casting to dict in deserializing temp items JSON");
			return;
		}
		Dictionary<string, Dictionary<string, long>> dictionary2 = new Dictionary<string, Dictionary<string, long>>();
		foreach (KeyValuePair<string, object> item in dictionary)
		{
			if (item.Value == null)
			{
				Debug.LogWarning("Error kvp.Value == null kvp.Key = " + item.Key + " in deserializing temp items JSON");
				continue;
			}
			Dictionary<string, object> dictionary3 = item.Value as Dictionary<string, object>;
			object value;
			if (dictionary3 == null)
			{
				Debug.LogWarning("Error innerDict == null kvp.Key = " + item.Key + " in deserializing temp items JSON");
			}
			else if (dictionary3.TryGetValue("Duration", out value) && value != null)
			{
				long value2;
				try
				{
					value2 = (long)value;
				}
				catch (Exception ex)
				{
					Debug.LogWarning("Error unboxing DurationValue in deserializing temp items JSON: " + ex.Message);
					continue;
				}
				object value3;
				if (dictionary3.TryGetValue("Start", out value3) && value3 != null)
				{
					long value4;
					try
					{
						value4 = (long)value3;
					}
					catch (Exception ex2)
					{
						Debug.LogWarning("Error unboxing StartValue in deserializing temp items JSON: " + ex2.Message);
						continue;
					}
					dictionary2.Add(item.Key, new Dictionary<string, long>
					{
						{ "Start", value4 },
						{ "Duration", value2 }
					});
				}
				else
				{
					Debug.LogWarning(" ! (innerDict.TryGetValue(StartKey,out StartValueObj) && StartValueObj != null) in deserializing temp items JSON");
				}
			}
			else
			{
				Debug.LogWarning(" ! (innerDict.TryGetValue(DurationKey,out DurationValueObj) && DurationValueObj != null) in deserializing temp items JSON");
			}
		}
		Items = ToSaltedDictionary(dictionary2);
	}

	private void SerializeItems()
	{
		Dictionary<string, Dictionary<string, long>> obj = ToNormalDictionary(Items ?? new Dictionary<string, Dictionary<string, SaltedLong>>());
		Storager.setString(Defs.TempItemsDictionaryKey, Json.Serialize(obj), false);
	}

	private void DeserializeExpiredObjects()
	{
		//Discarded unreachable code: IL_00d7
		if (!Storager.hasKey("ExpiredITemptemsControllerKey"))
		{
			Storager.setString("ExpiredITemptemsControllerKey", "[]", false);
		}
		if (PlayerPrefs.HasKey("WantToResetKeychain"))
		{
			return;
		}
		string @string = Storager.getString("ExpiredITemptemsControllerKey", false);
		object obj = Json.Deserialize(@string);
		if (obj == null)
		{
			Debug.LogWarning("Error Deserializing expired items JSON");
			return;
		}
		List<object> list = obj as List<object>;
		if (list == null)
		{
			Debug.LogWarning("Error casting expired items obj to list");
			return;
		}
		try
		{
			ExpiredItems.Clear();
			foreach (string item in list)
			{
				ExpiredItems.Add(item);
			}
		}
		catch (Exception ex)
		{
			Debug.LogWarning("Exception when iterating expired items list: " + ex);
		}
	}

	private void SerializeExpiredItems()
	{
		Storager.setString("ExpiredITemptemsControllerKey", Json.Serialize(ExpiredItems), false);
	}

	private static long GetLastSuspendTime()
	{
		return PromoActionsManager.GetUnixTimeFromStorage(Defs.LastTimeTempItemsSuspended);
	}

	private static void SaveSuspendTime()
	{
		Storager.setString(Defs.LastTimeTempItemsSuspended, PromoActionsManager.CurrentUnixTime.ToString(), false);
	}

	private void OnApplicationPause(bool pauseStatus)
	{
		if (pauseStatus)
		{
			SerializeItems();
			SerializeExpiredItems();
			SaveSuspendTime();
		}
		else
		{
			DeserializeItems();
			DeserializeExpiredObjects();
			CheckForTimeHack();
			RemoveExpiredItems();
		}
	}

	private void OnDestroy()
	{
		SerializeItems();
		SerializeExpiredItems();
		SaveSuspendTime();
	}

	public void TakeTemporaryItemToPlayer(ShopNGUIController.CategoryNames categoryName, string tag, int indexTimeLife)
	{
		ShopNGUIController.ProvideShopItemOnStarterPackBoguht(categoryName, tag, 1, false, indexTimeLife);
		ExpiredItems.Remove(tag);
	}
}
