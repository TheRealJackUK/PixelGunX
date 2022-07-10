using System;
using UnityEngine;

public sealed class RespawnWindowItemToBuy : MonoBehaviour
{
	public UITexture itemImage;

	public UILabel itemNameLabel;

	public GameObject itemPriceBtnBuyContainer;

	public UILabel needTierLabel;

	public UISprite itemPriceIcon;

	public UILabel itemPriceLabel;

	public UIButton btnBuy;

	[NonSerialized]
	public string itemTag;

	[NonSerialized]
	public int itemCategory;

	[NonSerialized]
	public ItemPrice itemPrice;

	[NonSerialized]
	public string nonLocalizedName;

	public void SetWeaponTag(string itemTag, int? upgradeNum = null)
	{
		if (string.IsNullOrEmpty(itemTag))
		{
			base.gameObject.SetActive(false);
			return;
		}
		base.gameObject.SetActive(true);
		int num = ItemDb.GetItemCategory(itemTag);
		ShopNGUIController.CategoryNames categoryNames = (ShopNGUIController.CategoryNames)num;
		this.itemTag = itemTag;
		itemCategory = num;
		itemPrice = null;
		itemImage.mainTexture = ItemDb.GetItemIcon(itemTag, categoryNames, upgradeNum);
		itemNameLabel.text = GetItemName(itemTag, categoryNames, upgradeNum.HasValue ? upgradeNum.Value : 0);
		nonLocalizedName = GetItemNonLocalizedName(itemTag, categoryNames, upgradeNum.HasValue ? upgradeNum.Value : 0);
		if (!IsCanBuy(itemTag, categoryNames))
		{
			itemPriceBtnBuyContainer.gameObject.SetActive(false);
			needTierLabel.gameObject.SetActive(false);
			return;
		}
		itemPriceBtnBuyContainer.SetActive(true);
		needTierLabel.gameObject.SetActive(false);
		if (ShopNGUIController.IsWeaponCategory(categoryNames))
		{
			int tier = ItemDb.GetWeaponInfo(itemTag).tier;
			if (ExpController.Instance != null && ExpController.Instance.OurTier < tier)
			{
				itemPriceBtnBuyContainer.SetActive(false);
				needTierLabel.gameObject.SetActive(true);
				int num2 = ((tier < 0 || tier >= ExpController.LevelsForTiers.Length) ? ExpController.LevelsForTiers[ExpController.LevelsForTiers.Length - 1] : ExpController.LevelsForTiers[tier]);
				string text = string.Format("{0} {1} {2}", LocalizationStore.Key_0226, num2, LocalizationStore.Get("Key_1022"));
				needTierLabel.text = text;
			}
		}
		itemPrice = ShopNGUIController.currentPrice(itemTag, categoryNames);
		SetPrice(itemPriceIcon, itemPriceLabel, itemPrice);
	}

	private static string GetItemName(string itemTag, ShopNGUIController.CategoryNames itemCategory, int upgradeNum = 0)
	{
		if (GearManager.IsItemGear(itemTag))
		{
			upgradeNum = Mathf.Min(upgradeNum, GearManager.NumOfGearUpgrades);
			itemTag = GearManager.UpgradeIDForGear(itemTag, upgradeNum);
		}
		return ItemDb.GetItemName(itemTag, itemCategory);
	}

	private static string GetItemNonLocalizedName(string itemTag, ShopNGUIController.CategoryNames itemCategory, int upgradeNum = 0)
	{
		string shopId = itemTag;
		if (ShopNGUIController.IsWeaponCategory(itemCategory))
		{
			shopId = ItemDb.GetShopIdByTag(itemTag);
		}
		if (GearManager.IsItemGear(itemTag))
		{
			upgradeNum = Mathf.Min(upgradeNum, GearManager.NumOfGearUpgrades);
			shopId = GearManager.UpgradeIDForGear(itemTag, upgradeNum);
		}
		return ItemDb.GetItemNameNonLocalized(itemTag, shopId, itemCategory, itemTag);
	}

	private static bool IsCanBuy(string itemTag, ShopNGUIController.CategoryNames itemCategory)
	{
		if (ShopNGUIController.IsWeaponCategory(itemCategory))
		{
			bool flag = ItemDb.IsCanBuy(itemTag) && !ItemDb.IsTemporaryGun(itemTag);
			bool flag2 = ItemDb.IsItemInInventory(itemTag);
			bool flag3 = ItemDb.HasWeaponNeedUpgradesForBuyNext(itemTag);
			string text = WeaponManager.FirstTagForOurTier(itemTag);
			return flag && !flag2 && (flag3 || (text != null && text.Equals(itemTag)));
		}
		if (GearManager.IsItemGear(itemTag))
		{
			return false;
		}
		if (itemCategory == ShopNGUIController.CategoryNames.ArmorCategory)
		{
			return !ItemDb.IsItemInInventory(itemTag) && !TempItemsController.PriceCoefs.ContainsKey(itemTag);
		}
		return false;
	}

	private static void SetPrice(UISprite priceIcon, UILabel priceLabel, ItemPrice price)
	{
		bool flag = price.Currency == "GemsCurrency";
		priceIcon.spriteName = ((!flag) ? "ingame_coin" : "gem_znachek");
		priceIcon.width = ((!flag) ? 30 : 24);
		priceIcon.height = ((!flag) ? 30 : 24);
		priceLabel.text = price.Price.ToString();
	}

	public void Reset()
	{
		itemImage.mainTexture = null;
		itemTag = string.Empty;
		nonLocalizedName = string.Empty;
	}
}
