using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public static class ItemDb
{
	public const int CrystalCrossbowCoinsPrice = 150;

	private static List<ItemRecord> _records;

	private static Dictionary<int, ItemRecord> _recordsById;

	private static Dictionary<string, ItemRecord> _recordsByTag;

	private static Dictionary<string, ItemRecord> _recordsByStorageId;

	private static Dictionary<string, ItemRecord> _recordsByShopId;

	private static Dictionary<string, ItemRecord> _recordsByPrefabName;

	static ItemDb()
	{
		_records = ItemDbRecords.GetRecords();
		_recordsById = new Dictionary<int, ItemRecord>(_records.Count);
		_recordsByTag = new Dictionary<string, ItemRecord>(_records.Count);
		_recordsByStorageId = new Dictionary<string, ItemRecord>(_records.Count);
		_recordsByShopId = new Dictionary<string, ItemRecord>(_records.Count);
		_recordsByPrefabName = new Dictionary<string, ItemRecord>(_records.Count);
		for (int i = 0; i < _records.Count; i++)
		{
			ItemRecord itemRecord = _records[i];
			_recordsById[itemRecord.Id] = itemRecord;
			if (!string.IsNullOrEmpty(itemRecord.Tag))
			{
				_recordsByTag[itemRecord.Tag] = itemRecord;
			}
			if (!string.IsNullOrEmpty(itemRecord.StorageId))
			{
				_recordsByStorageId[itemRecord.StorageId] = itemRecord;
			}
			if (!string.IsNullOrEmpty(itemRecord.ShopId))
			{
				_recordsByShopId[itemRecord.ShopId] = itemRecord;
			}
			if (!string.IsNullOrEmpty(itemRecord.PrefabName))
			{
				_recordsByPrefabName[itemRecord.PrefabName] = itemRecord;
			}
		}
	}

	public static ItemRecord GetById(int id)
	{
		if (_recordsById.ContainsKey(id))
		{
			return _recordsById[id];
		}
		return null;
	}

	public static ItemRecord GetByTag(string tag)
	{
		if (_recordsByTag.ContainsKey(tag))
		{
			return _recordsByTag[tag];
		}
		return null;
	}

	public static ItemRecord GetByPrefabName(string prefabName)
	{
		if (_recordsByPrefabName.ContainsKey(prefabName))
		{
			return _recordsByPrefabName[prefabName];
		}
		return null;
	}

	public static ItemRecord GetByShopId(string shopId)
	{
		if (_recordsByShopId.ContainsKey(shopId))
		{
			return _recordsByShopId[shopId];
		}
		return null;
	}

	public static ItemPrice GetPriceByShopId(string shopId)
	{
		if (_recordsByShopId.ContainsKey(shopId))
		{
			return _recordsByShopId[shopId].Price;
		}
		return VirtualCurrencyHelper.Price(shopId);
	}

	public static bool IsCanBuy(string tag)
	{
		ItemRecord byTag = GetByTag(tag);
		if (byTag != null)
		{
			return byTag.CanBuy;
		}
		return false;
	}

	public static string GetShopIdByTag(string tag)
	{
		ItemRecord byTag = GetByTag(tag);
		return (byTag == null) ? null : byTag.ShopId;
	}

	public static string GetTagByShopId(string shopId)
	{
		ItemRecord byShopId = GetByShopId(shopId);
		return (byShopId == null) ? null : byShopId.Tag;
	}

	public static string GetStorageIdByTag(string tag)
	{
		ItemRecord byTag = GetByTag(tag);
		return (byTag == null) ? null : byTag.StorageId;
	}

	public static string GetStorageIdByShopId(string shopId)
	{
		ItemRecord byShopId = GetByShopId(shopId);
		return (byShopId == null) ? null : byShopId.StorageId;
	}

	public static IEnumerable<ItemRecord> GetCanBuyWeapon(bool includeDeactivated = false)
	{
		if (includeDeactivated)
		{
			return _records.Where((ItemRecord item) => item.CanBuy);
		}
		return _records.Where((ItemRecord item) => item.CanBuy && !item.Deactivated);
	}

	public static string[] GetCanBuyWeaponTags(bool includeDeactivated = false)
	{
		return (from item in GetCanBuyWeapon(includeDeactivated)
			select item.Tag).ToArray();
	}

	public static string[] GetCanBuyWeaponStorageIds(bool includeDeactivated = false)
	{
		return (from item in GetCanBuyWeapon(includeDeactivated)
			where item.StorageId != null
			select item.StorageId).ToArray();
	}

	public static void Fill_tagToStoreIDMapping(Dictionary<string, string> tagToStoreIDMapping)
	{
		tagToStoreIDMapping.Clear();
		foreach (KeyValuePair<string, ItemRecord> item in _recordsByTag)
		{
			if (!string.IsNullOrEmpty(item.Value.ShopId))
			{
				tagToStoreIDMapping[item.Key] = item.Value.ShopId;
			}
		}
	}

	public static void Fill_storeIDtoDefsSNMapping(Dictionary<string, string> storeIDtoDefsSNMapping)
	{
		storeIDtoDefsSNMapping.Clear();
		foreach (KeyValuePair<string, ItemRecord> item in _recordsByShopId)
		{
			if (!string.IsNullOrEmpty(item.Value.StorageId))
			{
				storeIDtoDefsSNMapping[item.Key] = item.Value.StorageId;
			}
		}
	}

	public static bool IsTemporaryGun(string tg)
	{
		if (tg == null)
		{
			return false;
		}
		ItemRecord byTag = GetByTag(tg);
		return byTag != null && byTag.TemporaryGun;
	}

	public static bool IsWeaponCanDrop(string tag)
	{
		if (tag == "Knife")
		{
			return false;
		}
		ItemRecord byTag = GetByTag(tag);
		if (byTag == null)
		{
			return false;
		}
		return !byTag.CanBuy;
	}

	public static void InitStorageForTag(string tag)
	{
		ItemRecord byTag = GetByTag(tag);
		if (byTag == null)
		{
			Debug.LogWarning("item didn't found for tag: " + tag);
		}
		else if (string.IsNullOrEmpty(byTag.StorageId))
		{
			Debug.LogWarning("StoragId is null or empty for tag: " + tag);
		}
		else
		{
			Storager.setInt(byTag.StorageId, 0, false);
		}
	}

	public static int GetItemCategory(string tag)
	{
		int num = -1;
		ItemRecord byTag = GetByTag(tag);
		if (byTag != null)
		{
			WeaponSounds weaponSounds = Resources.Load<WeaponSounds>("Weapons/" + byTag.PrefabName);
			return (!(weaponSounds != null)) ? (-1) : (weaponSounds.categoryNabor - 1);
		}
		if (num == -1)
		{
			bool flag = false;
			foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in Wear.wear)
			{
				foreach (List<string> item2 in item.Value)
				{
					if (item2.Contains(tag))
					{
						flag = true;
						num = (int)item.Key;
						break;
					}
				}
				if (flag)
				{
					break;
				}
			}
		}
		if (num == -1 && (SkinsController.skinsNamesForPers.ContainsKey(tag) || tag.Equals("CustomSkinID")))
		{
			num = 7;
		}
		if (num == -1 && GearManager.IsItemGear(tag))
		{
			num = 10;
		}
		return num;
	}

	public static int[] GetItemFilterMap(string tag)
	{
		ItemRecord byTag = GetByTag(tag);
		if (byTag != null)
		{
			WeaponSounds weaponSounds = Resources.Load<WeaponSounds>("Weapons/" + byTag.PrefabName);
			return (!(weaponSounds != null)) ? new int[0] : ((weaponSounds.filterMap == null) ? new int[0] : weaponSounds.filterMap);
		}
		return new int[0];
	}

	public static string GetItemName(string tag, ShopNGUIController.CategoryNames category)
	{
		ItemRecord byTag = GetByTag(tag);
		if (byTag != null)
		{
			WeaponSounds weaponSounds = Resources.Load<WeaponSounds>("Weapons/" + byTag.PrefabName);
			return (!(weaponSounds != null)) ? string.Empty : weaponSounds.shopName;
		}
		switch (category)
		{
		case ShopNGUIController.CategoryNames.ArmorCategory:
			return Resources.Load<ShopPositionParams>("Armor/" + tag).shopName;
		case ShopNGUIController.CategoryNames.HatsCategory:
			return Resources.Load<ShopPositionParams>("Hats/" + tag).shopName;
		case ShopNGUIController.CategoryNames.CapesCategory:
			return Resources.Load<ShopPositionParams>("Capes/" + tag).shopName;
		case ShopNGUIController.CategoryNames.BootsCategory:
			return Resources.Load<ShopPositionParams>("Shop_Boots/" + tag).shopName;
		case ShopNGUIController.CategoryNames.GearCategory:
			return Resources.Load<ShopPositionParams>("Shop_Gear/" + tag).shopName;
		default:
			return string.Empty;
		}
	}

	public static string GetItemNameNonLocalized(string tag, string shopId, ShopNGUIController.CategoryNames category, string defaultDesc = null)
	{
		ItemRecord byTag = GetByTag(tag);
		if (byTag != null)
		{
			WeaponSounds weaponSounds = Resources.Load<WeaponSounds>("Weapons/" + byTag.PrefabName);
			return (!(weaponSounds != null)) ? string.Empty : weaponSounds.shopNameNonLocalized;
		}
		switch (category)
		{
		case ShopNGUIController.CategoryNames.ArmorCategory:
			return Resources.Load<ShopPositionParams>("Armor/" + tag).shopNameNonLocalized;
		case ShopNGUIController.CategoryNames.HatsCategory:
			return Resources.Load<ShopPositionParams>("Hats/" + tag).shopNameNonLocalized;
		default:
			if (InAppData.inappReadableNames.ContainsKey(shopId))
			{
				return InAppData.inappReadableNames[shopId];
			}
			return defaultDesc ?? shopId;
		}
	}

	public static Texture GetItemIcon(string tag, ShopNGUIController.CategoryNames category, bool withUpdates)
	{
		if (category == (ShopNGUIController.CategoryNames)(-1))
		{
			return null;
		}
		string text = null;
		string text2 = tag;
		if (ShopNGUIController.IsWeaponCategory(category))
		{
			foreach (List<string> upgrade in WeaponUpgrades.upgrades)
			{
				if (upgrade.Contains(tag))
				{
					text2 = upgrade[0];
					break;
				}
			}
		}
		if (text2 != null)
		{
			if (withUpdates)
			{
				int num = 1;
				if (ShopNGUIController.IsWeaponCategory(category))
				{
					ItemRecord byTag = GetByTag(tag);
					if ((byTag == null || !byTag.UseImagesFromFirstUpgrade) && (byTag == null || !byTag.TemporaryGun))
					{
						bool maxUpgrade;
						num = 1 + ShopNGUIController._CurrentNumberOfUpgrades(text2, out maxUpgrade, category);
					}
				}
				else if (category == ShopNGUIController.CategoryNames.GearCategory)
				{
					num = ((!(tag != GearManager.Grenade)) ? 1 : (1 + GearManager.CurrentNumberOfUphradesForGear(tag)));
				}
				text = text2 + "_icon" + num + "_big";
			}
			else
			{
				text = text2 + "_icon1_big";
			}
		}
		if (!string.IsNullOrEmpty(text))
		{
		// (it dead)	Debug.LogError("the game did the for the " + text);
			return Resources.Load<Texture>("OfferIcons/" + text);
		}
		UnityEngine.Debug.LogError("the game no findy the icon for " + tag);
		return null;
	}

	public static Texture GetItemIcon(string tag, ShopNGUIController.CategoryNames category, int? upgradeNum = null)
	{
		if (category == (ShopNGUIController.CategoryNames)(-1))
		{
			return null;
		}
		string text = null;
		string text2 = tag;
		if (ShopNGUIController.IsWeaponCategory(category))
		{
			foreach (List<string> upgrade in WeaponUpgrades.upgrades)
			{
				int num = upgrade.IndexOf(tag);
				if (num != -1)
				{
					text2 = upgrade[0];
					if (!upgradeNum.HasValue)
					{
						upgradeNum = 1 + num;
					}
					break;
				}
			}
		}
		if (upgradeNum.HasValue)
		{
			int num2 = 1;
			if (ShopNGUIController.IsWeaponCategory(category))
			{
				ItemRecord byTag = GetByTag(tag);
				if ((byTag == null || !byTag.UseImagesFromFirstUpgrade) && (byTag == null || !byTag.TemporaryGun))
				{
					num2 = ((!upgradeNum.HasValue) ? 1 : upgradeNum.Value);
				}
			}
			text = text2 + "_icon" + num2 + "_big";
		}
		else
		{
			text = text2 + "_icon1_big";
		}
		if (!string.IsNullOrEmpty(text))
		{
		//	Debug.LogError("the game did the for the " + text);
			return Resources.Load<Texture>("OfferIcons/" + text);
		}
		return null;
	}

	public static Texture GetTextureItemByTag(string tag, int? upgradeNum = null)
	{
		int itemCategory = GetItemCategory(tag);
		return GetItemIcon(tag, (ShopNGUIController.CategoryNames)itemCategory, upgradeNum);
	}

	public static bool IsItemInInventory(string tag)
	{
		string key = tag;
		string storageIdByTag = GetStorageIdByTag(tag);
		if (!string.IsNullOrEmpty(storageIdByTag))
		{
			key = storageIdByTag;
		}
		if (!Storager.hasKey(key))
		{
			return false;
		}
		return Storager.getInt(key, true) == 1;
	}

	public static bool HasWeaponNeedUpgradesForBuyNext(string tag)
	{
		foreach (List<string> upgrade in WeaponUpgrades.upgrades)
		{
			int num = upgrade.IndexOf(tag);
			if (num != -1)
			{
				bool flag = true;
				for (int i = 0; i < num; i++)
				{
					flag = flag && IsItemInInventory(upgrade[i]);
				}
				return flag;
			}
		}
		return true;
	}

	public static string GetItemNameByTag(string tag)
	{
		int itemCategory = GetItemCategory(tag);
		return GetItemName(tag, (ShopNGUIController.CategoryNames)itemCategory);
	}

	public static WeaponSounds GetWeaponInfo(string weaponTag)
	{
		ItemRecord byTag = GetByTag(weaponTag);
		if (byTag != null)
		{
			WeaponSounds weaponSounds = Resources.Load<WeaponSounds>("Weapons/" + byTag.PrefabName);
			return (!(weaponSounds != null)) ? null : weaponSounds;
		}
		return null;
	}

	public static Texture GetTextureForShopItem(string itemTag)
	{
		int value = 0;
		string text = itemTag;
		bool flag = GearManager.IsItemGear(itemTag);
		if (flag)
		{
			text = GearManager.HolderQuantityForID(itemTag);
			value = GearManager.CurrentNumberOfUphradesForGear(text) + 1;
		}
		if (flag && (text == GearManager.Turret || text == GearManager.Mech))
		{
			int? upgradeNum = value;
			if (upgradeNum.HasValue && upgradeNum.Value > 0)
			{
				return GetTextureItemByTag(text, upgradeNum);
			}
		}
		return GetTextureItemByTag(text);
	}
}
