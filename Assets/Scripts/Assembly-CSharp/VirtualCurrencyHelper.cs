using System;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;

public sealed class VirtualCurrencyHelper
{
	public static int[] coinInappsQuantity;

	public static int[] gemsInappsQuantity;

	public static readonly int[] coinPriceIds;

	public static readonly int[] gemsPriceIds;

	public static readonly int[] starterPackFakePrice;

	private static Dictionary<string, SaltedInt> prices;

	private static Random _prng;

	static VirtualCurrencyHelper()
	{
		coinInappsQuantity = new int[7] { 15, 45, 80, 165, 335, 865, 2000 };
		gemsInappsQuantity = new int[7] { 9, 27, 48, 100, 200, 517, 1200 };
		coinPriceIds = new int[7] { 1, 3, 5, 10, 20, 50, 100 };
		gemsPriceIds = new int[7] { 1, 3, 5, 10, 20, 50, 100 };
		starterPackFakePrice = new int[8] { 6, 5, 4, 3, 2, 1, 1, 1 };
		prices = new Dictionary<string, SaltedInt>();
		_prng = new Random(4103);
		AddPrice(PremiumAccountController.AccountType.OneDay.ToString(), 5);
		AddPrice(PremiumAccountController.AccountType.ThreeDay.ToString(), 10);
		AddPrice(PremiumAccountController.AccountType.SevenDays.ToString(), 20);
		AddPrice(PremiumAccountController.AccountType.Month.ToString(), 60);
		AddPrice("crystalsword", 185);
		AddPrice("Fullhealth", 15);
		AddPrice("bigammopack", 15);
		AddPrice("MinerWeapon", 35);
		AddPrice(StoreKitEventListener.elixirID, 15);
		AddPrice(StoreKitEventListener.chief, 25);
		AddPrice(StoreKitEventListener.nanosoldier, 25);
		AddPrice(StoreKitEventListener.endmanskin, 25);
		AddPrice(StoreKitEventListener.spaceengineer, 25);
		AddPrice(StoreKitEventListener.steelman, 25);
		AddPrice(StoreKitEventListener.CaptainSkin, 25);
		AddPrice(StoreKitEventListener.HawkSkin, 25);
		AddPrice(StoreKitEventListener.TunderGodSkin, 25);
		AddPrice(StoreKitEventListener.GreenGuySkin, 25);
		AddPrice(StoreKitEventListener.GordonSkin, 25);
		AddPrice(StoreKitEventListener.armor, 10);
		AddPrice(StoreKitEventListener.armor2, 15);
		AddPrice(StoreKitEventListener.armor3, 20);
		AddPrice(StoreKitEventListener.magicGirl, 25);
		AddPrice(StoreKitEventListener.braveGirl, 25);
		AddPrice(StoreKitEventListener.glamDoll, 25);
		AddPrice(StoreKitEventListener.kittyGirl, 25);
		AddPrice(StoreKitEventListener.famosBoy, 25);
		AddPrice(StoreKitEventListener.skin810_1, 25);
		AddPrice(StoreKitEventListener.skin810_2, 25);
		AddPrice(StoreKitEventListener.skin810_3, 25);
		AddPrice(StoreKitEventListener.skin810_4, 25);
		AddPrice(StoreKitEventListener.skin810_5, 25);
		AddPrice(StoreKitEventListener.skin810_6, 25);
		AddPrice(StoreKitEventListener.skin931_1, 25);
		AddPrice(StoreKitEventListener.skin931_2, 25);
		AddPrice(StoreKitEventListener.skin931_3, 2147483647);
		AddPrice(StoreKitEventListener.skin931_4, 50);
		AddPrice(StoreKitEventListener.skin931_5, 25);
		AddPrice("CustomSkinID", Defs.skinsMakerPrice);
		AddPrice(Wear.HitmanCape, 60);
		AddPrice(Wear.BerserkCape, 60);
		AddPrice(Wear.DemolitionCape, 60);
		AddPrice(Wear.SniperCape, 60);
		AddPrice(Wear.StormTrooperCape, 60);
		AddPrice(Wear.cape_Custom, 75);
		AddPrice(Wear.HitmanCape_Up1, 30);
		AddPrice(Wear.BerserkCape_Up1, 30);
		AddPrice(Wear.DemolitionCape_Up1, 30);
		AddPrice(Wear.SniperCape_Up1, 30);
		AddPrice(Wear.StormTrooperCape_Up1, 30);
		AddPrice(Wear.HitmanCape_Up2, 45);
		AddPrice(Wear.BerserkCape_Up2, 45);
		AddPrice(Wear.DemolitionCape_Up2, 45);
		AddPrice(Wear.SniperCape_Up2, 45);
		AddPrice(Wear.StormTrooperCape_Up2, 45);
		AddPrice(Wear.hat_DiamondHelmet, 65);
		AddPrice(Wear.hat_Adamant_3, 3);
		AddPrice(Wear.hat_Headphones, 50);
		AddPrice(Wear.hat_ManiacMask, 65);
		AddPrice(Wear.hat_KingsCrown, 150);
		AddPrice(Wear.hat_SeriousManHat, 50);
		AddPrice(Wear.hat_Samurai, 95);
		AddPrice(Wear.hat_AlmazHelmet, 95);
		AddPrice(Wear.hat_ArmyHelmet, 95);
		AddPrice(Wear.hat_SteelHelmet, 95);
		AddPrice(Wear.hat_GoldHelmet, 95);
		AddPrice(Wear.hat_Army_1, 70);
		AddPrice(Wear.hat_Army_2, 70);
		AddPrice(Wear.hat_Army_3, 70);
		AddPrice(Wear.hat_Army_4, 70);
		AddPrice(Wear.hat_Steel_1, 85);
		AddPrice(Wear.hat_Steel_2, 85);
		AddPrice(Wear.hat_Steel_3, 85);
		AddPrice(Wear.hat_Steel_4, 85);
		AddPrice(Wear.hat_Royal_1, 100);
		AddPrice(Wear.hat_Royal_2, 100);
		AddPrice(Wear.hat_Royal_3, 100);
		AddPrice(Wear.hat_Royal_4, 100);
		AddPrice(Wear.hat_Almaz_1, 120);
		AddPrice(Wear.hat_Almaz_2, 120);
		AddPrice(Wear.hat_Almaz_3, 120);
		AddPrice(Wear.hat_Almaz_4, 120);
		AddPrice(PotionsController.HastePotion, 2);
		AddPrice(PotionsController.MightPotion, 2);
		AddPrice(PotionsController.RegenerationPotion, 5);
		AddPrice(GearManager.UpgradeIDForGear("InvisibilityPotion", 1), 1);
		AddPrice("InvisibilityPotion" + GearManager.UpgradeSuffix + 2, 1);
		AddPrice("InvisibilityPotion" + GearManager.UpgradeSuffix + 3, 1);
		AddPrice("InvisibilityPotion" + GearManager.UpgradeSuffix + 4, 1);
		AddPrice("InvisibilityPotion" + GearManager.UpgradeSuffix + 5, 1);
		AddPrice("GrenadeID" + GearManager.UpgradeSuffix + 1, 1);
		AddPrice("GrenadeID" + GearManager.UpgradeSuffix + 2, 1);
		AddPrice("GrenadeID" + GearManager.UpgradeSuffix + 3, 1);
		AddPrice("GrenadeID" + GearManager.UpgradeSuffix + 4, 1);
		AddPrice("GrenadeID" + GearManager.UpgradeSuffix + 5, 1);
		AddPrice(GearManager.Turret + GearManager.UpgradeSuffix + 1, 1);
		AddPrice(GearManager.Turret + GearManager.UpgradeSuffix + 2, 1);
		AddPrice(GearManager.Turret + GearManager.UpgradeSuffix + 3, 1);
		AddPrice(GearManager.Turret + GearManager.UpgradeSuffix + 4, 1);
		AddPrice(GearManager.Turret + GearManager.UpgradeSuffix + 5, 1);
		AddPrice(GearManager.Mech + GearManager.UpgradeSuffix + 1, 1);
		AddPrice(GearManager.Mech + GearManager.UpgradeSuffix + 2, 1);
		AddPrice(GearManager.Mech + GearManager.UpgradeSuffix + 3, 1);
		AddPrice(GearManager.Mech + GearManager.UpgradeSuffix + 4, 1);
		AddPrice(GearManager.Mech + GearManager.UpgradeSuffix + 5, 1);
		AddPrice(GearManager.Jetpack + GearManager.UpgradeSuffix + 1, 1);
		AddPrice(GearManager.Jetpack + GearManager.UpgradeSuffix + 2, 1);
		AddPrice(GearManager.Jetpack + GearManager.UpgradeSuffix + 3, 1);
		AddPrice(GearManager.Jetpack + GearManager.UpgradeSuffix + 4, 1);
		AddPrice(GearManager.Jetpack + GearManager.UpgradeSuffix + 5, 1);
		AddPrice("InvisibilityPotion" + GearManager.OneItemSuffix + 0, 3);
		AddPrice("InvisibilityPotion" + GearManager.OneItemSuffix + 1, 3);
		AddPrice("InvisibilityPotion" + GearManager.OneItemSuffix + 2, 3);
		AddPrice("InvisibilityPotion" + GearManager.OneItemSuffix + 3, 3);
		AddPrice("InvisibilityPotion" + GearManager.OneItemSuffix + 4, 3);
		AddPrice("InvisibilityPotion" + GearManager.OneItemSuffix + 5, 3);
		AddPrice("GrenadeID" + GearManager.OneItemSuffix + 0, 3);
		AddPrice("GrenadeID" + GearManager.OneItemSuffix + 1, 3);
		AddPrice("GrenadeID" + GearManager.OneItemSuffix + 2, 3);
		AddPrice("GrenadeID" + GearManager.OneItemSuffix + 3, 3);
		AddPrice("GrenadeID" + GearManager.OneItemSuffix + 4, 3);
		AddPrice("GrenadeID" + GearManager.OneItemSuffix + 5, 3);
		AddPrice(GearManager.Turret + GearManager.OneItemSuffix + 0, 5);
		AddPrice(GearManager.Turret + GearManager.OneItemSuffix + 1, 5);
		AddPrice(GearManager.Turret + GearManager.OneItemSuffix + 2, 5);
		AddPrice(GearManager.Turret + GearManager.OneItemSuffix + 3, 5);
		AddPrice(GearManager.Turret + GearManager.OneItemSuffix + 4, 5);
		AddPrice(GearManager.Turret + GearManager.OneItemSuffix + 5, 5);
		AddPrice(GearManager.Mech + GearManager.OneItemSuffix + 0, 7);
		AddPrice(GearManager.Mech + GearManager.OneItemSuffix + 1, 7);
		AddPrice(GearManager.Mech + GearManager.OneItemSuffix + 2, 7);
		AddPrice(GearManager.Mech + GearManager.OneItemSuffix + 3, 7);
		AddPrice(GearManager.Mech + GearManager.OneItemSuffix + 4, 7);
		AddPrice(GearManager.Mech + GearManager.OneItemSuffix + 5, 7);
		AddPrice(GearManager.Jetpack + GearManager.OneItemSuffix + 0, 4);
		AddPrice(GearManager.Jetpack + GearManager.OneItemSuffix + 1, 4);
		AddPrice(GearManager.Jetpack + GearManager.OneItemSuffix + 2, 4);
		AddPrice(GearManager.Jetpack + GearManager.OneItemSuffix + 3, 4);
		AddPrice(GearManager.Jetpack + GearManager.OneItemSuffix + 4, 4);
		AddPrice(GearManager.Jetpack + GearManager.OneItemSuffix + 5, 4);
		AddPrice(Wear.HitmanBoots, 50);
		AddPrice(Wear.StormTrooperBoots, 50);
		AddPrice(Wear.SniperBoots, 50);
		AddPrice(Wear.DemolitionBoots, 50);
		AddPrice(Wear.BerserkBoots, 50);
		AddPrice(Wear.boots_tabi, 120);
		AddPrice(Wear.HitmanBoots_Up1, 25);
		AddPrice(Wear.StormTrooperBoots_Up1, 25);
		AddPrice(Wear.SniperBoots_Up1, 25);
		AddPrice(Wear.DemolitionBoots_Up1, 25);
		AddPrice(Wear.BerserkBoots_Up1, 25);
		AddPrice(Wear.HitmanBoots_Up2, 40);
		AddPrice(Wear.StormTrooperBoots_Up2, 40);
		AddPrice(Wear.SniperBoots_Up2, 40);
		AddPrice(Wear.DemolitionBoots_Up2, 40);
		AddPrice(Wear.BerserkBoots_Up2, 40);
		AddPrice(Wear.Armor_Army_1, 70);
		AddPrice(Wear.Armor_Army_2, 70);
		AddPrice(Wear.Armor_Army_3, 70);
		AddPrice(Wear.Armor_Steel, 85);
		AddPrice(Wear.Armor_Steel_2, 85);
		AddPrice(Wear.Armor_Steel_3, 85);
		AddPrice(Wear.Armor_Royal_1, 100);
		AddPrice(Wear.Armor_Royal_2, 100);
		AddPrice(Wear.Armor_Royal_3, 100);
		AddPrice(Wear.Armor_Almaz_1, 120);
		AddPrice(Wear.Armor_Almaz_2, 120);
		AddPrice(Wear.Armor_Almaz_3, 120);
		AddPrice(Wear.Armor_Army_4, 120);
		AddPrice(Wear.Armor_Steel_4, 120);
		AddPrice(Wear.Armor_Royal_4, 135);
		AddPrice(Wear.Armor_Almaz_4, 120);
		AddPrice(Wear.Armor_Adamant_3, 3);
		AddPrice(Wear.Armor_Rubin_1, 135);
		AddPrice(Wear.Armor_Rubin_2, 135);
		AddPrice(Wear.Armor_Rubin_3, 135);
		AddPrice(Wear.hat_Rubin_1, 135);
		AddPrice(Wear.hat_Rubin_2, 135);
		AddPrice(Wear.hat_Rubin_3, 135);
		AddPrice(Wear.Armor_Adamant_Const_1, 170);
		AddPrice(Wear.Armor_Adamant_Const_2, 170);
		AddPrice(Wear.Armor_Adamant_Const_3, 170);
		AddPrice(Wear.hat_Adamant_Const_1, 170);
		AddPrice(Wear.hat_Adamant_Const_2, 170);
		AddPrice(Wear.hat_Adamant_Const_3, 170);
		for (int i = 0; i < 11; i++)
		{
			AddPrice("newskin_" + i, 25);
		}
		for (int j = 11; j < 19; j++)
		{
			AddPrice("newskin_" + j, 25);
		}
		_prng = null;
	}

	public static ItemPrice Price(string key)
	{
		if (key == null || !prices.ContainsKey(key))
		{
			return null;
		}
		int value = prices[key].Value;
		string currency = "Coins";
		string text = GearManager.HolderQuantityForID(key);
		bool flag = false;
		flag = text != null && GearManager.Gear.Contains(text) && !key.Contains(GearManager.UpgradeSuffix) && !text.Equals(GearManager.Grenade);
		if (key == Wear.HitmanCape || key == Wear.BerserkCape || key == Wear.DemolitionCape || key == Wear.SniperCape || key == Wear.StormTrooperCape || key == Wear.HitmanCape_Up1 || key == Wear.BerserkCape_Up1 || key == Wear.DemolitionCape_Up1 || key == Wear.SniperCape_Up1 || key == Wear.StormTrooperCape_Up1 || key == Wear.HitmanCape_Up2 || key == Wear.BerserkCape_Up2 || key == Wear.DemolitionCape_Up2 || key == Wear.SniperCape_Up2 || key == Wear.StormTrooperCape_Up2)
		{
			flag = true;
		}
		if (key == Wear.HitmanBoots || key == Wear.StormTrooperBoots || key == Wear.SniperBoots || key == Wear.DemolitionBoots || key == Wear.BerserkBoots || key == Wear.HitmanBoots_Up1 || key == Wear.StormTrooperBoots_Up1 || key == Wear.SniperBoots_Up1 || key == Wear.DemolitionBoots_Up1 || key == Wear.BerserkBoots_Up1 || key == Wear.HitmanBoots_Up2 || key == Wear.StormTrooperBoots_Up2 || key == Wear.SniperBoots_Up2 || key == Wear.DemolitionBoots_Up2 || key == Wear.BerserkBoots_Up2)
		{
			flag = true;
		}
		if (TempItemsController.PriceCoefs.ContainsKey(key))
		{
			flag = true;
		}
		if (key != null && (key.Equals(PremiumAccountController.AccountType.OneDay.ToString()) || key.Equals(PremiumAccountController.AccountType.ThreeDay.ToString()) || key.Equals(PremiumAccountController.AccountType.SevenDays.ToString()) || key.Equals(PremiumAccountController.AccountType.Month.ToString())))
		{
			flag = true;
		}
		if (flag)
		{
			currency = "GemsCurrency";
		}
		return new ItemPrice(value, currency);
	}

	public static int GetVirtualCurrencyAmount(string currency, int inappIndex)
	{
		if (string.IsNullOrEmpty(currency))
		{
			throw new ArgumentException("Empty currency.", "currency");
		}
		HashSet<string> hashSet = new HashSet<string>();
		hashSet.Add("Coins");
		hashSet.Add("GemsCurrency");
		HashSet<string> hashSet2 = hashSet;
		if (!hashSet2.Contains(currency))
		{
			throw new ArgumentException("Invalid currency: " + currency, "currency");
		}
		return ((!PromoActionsManager.sharedManager.IsEventX3Active) ? 1 : 3) * ((!currency.Equals("Coins")) ? gemsInappsQuantity[inappIndex] : coinInappsQuantity[inappIndex]);
	}

	public static int GetCoinInappsQuantity(int inappIndex)
	{
		if (PromoActionsManager.sharedManager.IsEventX3Active)
		{
			return 3 * coinInappsQuantity[inappIndex];
		}
		return coinInappsQuantity[inappIndex];
	}

	public static int GetGemsInappsQuantity(int inappIndex)
	{
		if (PromoActionsManager.sharedManager.IsEventX3Active)
		{
			return 3 * gemsInappsQuantity[inappIndex];
		}
		return gemsInappsQuantity[inappIndex];
	}

	private static void AddPrice(string key, int value)
	{
		prices.Add(key, new SaltedInt(_prng.Next(), value));
	}
}
