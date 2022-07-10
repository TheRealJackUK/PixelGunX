using System;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public sealed class ItemRecord
{
	private readonly SaltedInt _mainPrice;

	private readonly SaltedInt _alternativePrice;

	private static readonly System.Random _prng = new System.Random(1879142401);

	private List<ItemPrice> _pricesForDifferentTiers;

	public int Id { get; private set; }

	public string Tag { get; private set; }

	public string StorageId { get; private set; }

	public string PrefabName { get; private set; }

	public string ShopId { get; private set; }

	public string ShopDisplayName { get; private set; }

	public bool CanBuy { get; private set; }

	public bool Deactivated { get; private set; }

	public bool UseImagesFromFirstUpgrade { get; private set; }

	private ItemPrice PriceForTierForThisItem
	{
		get
		{
			List<string> list = WeaponUpgrades.ChainForTag(Tag);
			if (list != null)
			{
				string text = WeaponManager.FirstTagForOurTier(Tag);
				if (text != null)
				{
					int num = list.IndexOf(text);
					if (num >= 0 && _pricesForDifferentTiers.Count > num)
					{
						return _pricesForDifferentTiers[num];
					}
				}
			}
			Debug.LogWarning("Error in PriceForTierForThisItem");
			return new ItemPrice(100, "Coins");
		}
	}

	public ItemPrice Price
	{
		get
		{
			if (_pricesForDifferentTiers != null)
			{
				return PriceForTierForThisItem;
			}
			if (alternativePrice == -1)
			{
				return new ItemPrice(mainPrice, mainCurrency);
			}
			WeaponSounds weaponSounds = null;
			weaponSounds = WeaponManager.AllWrapperPrefabs().Find((WeaponSounds w) => Tag != null && w.gameObject.tag.Equals(Tag));
			if (weaponSounds != null)
			{
				Defs2.InitializeTier8_3_0Key();
				int @int = Storager.getInt(Defs.TierAfter8_3_0Key, false);
				int price = ((!mainCurrency.Equals("GemsCurrency")) ? alternativePrice : mainPrice);
				int price2 = ((!mainCurrency.Equals("Coins")) ? alternativePrice : mainPrice);
				if (weaponSounds.tier <= @int)
				{
					return new ItemPrice(price2, "Coins");
				}
				return new ItemPrice(price, "GemsCurrency");
			}
			return new ItemPrice(mainPrice, mainCurrency);
		}
	}

	public bool TemporaryGun
	{
		get
		{
			return ShopId != null && StorageId == null;
		}
	}

	protected int mainPrice
	{
		get
		{
			return _mainPrice.Value;
		}
	}

	protected int alternativePrice
	{
		get
		{
			return _alternativePrice.Value;
		}
	}

	protected string mainCurrency { get; set; }

	protected string alternativeCurrency { get; set; }

	public ItemRecord(int id, string tag, string storageId, string prefabName, string shopId, string shopDisplayName, bool canBuy, bool deactivated, List<ItemPrice> pricesForDiffTiers, bool useImageOfFirstUpgrade = false)
	{
		SetMainFields(id, tag, storageId, prefabName, shopId, shopDisplayName, canBuy, deactivated, useImageOfFirstUpgrade);
		_pricesForDifferentTiers = pricesForDiffTiers;
		if (_pricesForDifferentTiers == null || _pricesForDifferentTiers.Count < 3)
		{
			Debug.LogError("ItemRecord: _pricesForDifferentTiers is null, or Count < 3!");
		}
	}

	public ItemRecord(int id, string tag, string storageId, string prefabName, string shopId, string shopDisplayName, int price, bool canBuy, bool deactivated, string currency = "Coins", int secondCurrencyPrice = -1, bool useImageOfFirstUpgrade = false)
	{
		SetMainFields(id, tag, storageId, prefabName, shopId, shopDisplayName, canBuy, deactivated, useImageOfFirstUpgrade);
		_mainPrice = new SaltedInt(_prng.Next(), price);
		_alternativePrice = new SaltedInt(_prng.Next(), secondCurrencyPrice);
		mainCurrency = currency;
		alternativeCurrency = ((!mainCurrency.Equals("Coins")) ? "Coins" : "GemsCurrency");
	}

	private void SetMainFields(int id, string tag, string storageId, string prefabName, string shopId, string shopDisplayName, bool canBuy, bool deactivated, bool useImageOfFirstUpgrade)
	{
		Id = id;
		Tag = tag;
		StorageId = storageId;
		PrefabName = prefabName;
		ShopId = shopId;
		ShopDisplayName = shopDisplayName;
		CanBuy = canBuy;
		Deactivated = deactivated;
		UseImagesFromFirstUpgrade = useImageOfFirstUpgrade;
	}
}
