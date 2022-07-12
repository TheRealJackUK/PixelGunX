using System.Collections.Generic;

public static class InAppData
{
	public static Dictionary<int, KeyValuePair<string, string>> inAppData;

	public static Dictionary<string, string> inappReadableNames;

	static InAppData()
	{
		inAppData = new Dictionary<int, KeyValuePair<string, string>>();
		inappReadableNames = new Dictionary<string, string>();
		inAppData.Add(5, new KeyValuePair<string, string>(StoreKitEventListener.endmanskin, Defs.endmanskinBoughtSett));
		inAppData.Add(11, new KeyValuePair<string, string>(StoreKitEventListener.chief, Defs.chiefBoughtSett));
		inAppData.Add(12, new KeyValuePair<string, string>(StoreKitEventListener.spaceengineer, Defs.spaceengineerBoughtSett));
		inAppData.Add(13, new KeyValuePair<string, string>(StoreKitEventListener.nanosoldier, Defs.nanosoldierBoughtSett));
		inAppData.Add(14, new KeyValuePair<string, string>(StoreKitEventListener.steelman, Defs.steelmanBoughtSett));
		inAppData.Add(15, new KeyValuePair<string, string>(StoreKitEventListener.CaptainSkin, Defs.captainSett));
		inAppData.Add(16, new KeyValuePair<string, string>(StoreKitEventListener.HawkSkin, Defs.hawkSett));
		inAppData.Add(17, new KeyValuePair<string, string>(StoreKitEventListener.GreenGuySkin, Defs.greenGuySett));
		inAppData.Add(18, new KeyValuePair<string, string>(StoreKitEventListener.TunderGodSkin, Defs.TunderGodSett));
		inAppData.Add(19, new KeyValuePair<string, string>(StoreKitEventListener.GordonSkin, Defs.gordonSett));
		inAppData.Add(23, new KeyValuePair<string, string>(StoreKitEventListener.magicGirl, Defs.magicGirlSett));
		inAppData.Add(24, new KeyValuePair<string, string>(StoreKitEventListener.braveGirl, Defs.braveGirlSett));
		inAppData.Add(25, new KeyValuePair<string, string>(StoreKitEventListener.glamDoll, Defs.glamGirlSett));
		inAppData.Add(26, new KeyValuePair<string, string>(StoreKitEventListener.kittyGirl, Defs.kityyGirlSett));
		inAppData.Add(27, new KeyValuePair<string, string>(StoreKitEventListener.famosBoy, Defs.famosBoySett));
		for (int i = 0; i < 11; i++)
		{
			inAppData.Add(29 + i - 1, new KeyValuePair<string, string>("newskin_" + i, "newskin_" + i));
		}
		for (int j = 11; j < 19; j++)
		{
			inAppData.Add(29 + j - 1, new KeyValuePair<string, string>("newskin_" + j, "newskin_" + j));
		}
		inAppData.Add(47, new KeyValuePair<string, string>(StoreKitEventListener.skin810_1, Defs.skin810_1));
		inAppData.Add(48, new KeyValuePair<string, string>(StoreKitEventListener.skin810_2, Defs.skin810_2));
		inAppData.Add(49, new KeyValuePair<string, string>(StoreKitEventListener.skin810_3, Defs.skin810_3));
		inAppData.Add(50, new KeyValuePair<string, string>(StoreKitEventListener.skin810_4, Defs.skin810_4));
		inAppData.Add(51, new KeyValuePair<string, string>(StoreKitEventListener.skin810_5, Defs.skin810_5));
		inAppData.Add(52, new KeyValuePair<string, string>(StoreKitEventListener.skin810_6, Defs.skin810_6));
		inAppData.Add(53, new KeyValuePair<string, string>(StoreKitEventListener.skin931_1, Defs.skin931_1));
		inAppData.Add(54, new KeyValuePair<string, string>(StoreKitEventListener.skin931_2, Defs.skin931_2));
		inAppData.Add(55, new KeyValuePair<string, string>(StoreKitEventListener.skin931_3, Defs.skin931_3));
		inAppData.Add(56, new KeyValuePair<string, string>(StoreKitEventListener.skin931_4, Defs.skin931_4));
		inappReadableNames.Add("bigammopack", "Big Pack of Ammo");
		inappReadableNames.Add("Fullhealth", "Full Health");
		inappReadableNames.Add(StoreKitEventListener.elixirID, "Elixir of Resurrection");
		inappReadableNames.Add(StoreKitEventListener.armor, "Armor");
		inappReadableNames.Add(StoreKitEventListener.armor2, "Armor2");
		inappReadableNames.Add(StoreKitEventListener.armor3, "Armor3");
		inappReadableNames.Add(StoreKitEventListener.endmanskin, "End Man Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.chief, "Chief Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.spaceengineer, "Space Engineer Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.nanosoldier, "Nano Soldier Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.steelman, "Steel Man Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.CaptainSkin, "Captain Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.HawkSkin, "Hawk Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.TunderGodSkin, "Thunder God Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.GreenGuySkin, "Green Guy Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.GordonSkin, "Gordon Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.magicGirl, "Magic Girl Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.braveGirl, "Brave Girl Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.glamDoll, "Glam Doll Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.kittyGirl, "Kitty Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.famosBoy, "Famos Boy Skin for 40 coins");
		inappReadableNames.Add(StoreKitEventListener.skin810_1, "skin810_1");
		inappReadableNames.Add(StoreKitEventListener.skin810_2, "skin810_2");
		inappReadableNames.Add(StoreKitEventListener.skin810_3, "skin810_3");
		inappReadableNames.Add(StoreKitEventListener.skin810_4, "skin810_4");
		inappReadableNames.Add(StoreKitEventListener.skin810_5, "skin810_5");
		inappReadableNames.Add(StoreKitEventListener.skin810_6, "skin810_6");
		inappReadableNames.Add(StoreKitEventListener.skin931_1, "skin931_1");
		inappReadableNames.Add(StoreKitEventListener.skin931_2, "skin931_2");
		inappReadableNames.Add(StoreKitEventListener.skin931_3, "skin931_3");
		inappReadableNames.Add(StoreKitEventListener.skin931_4, "skin931_4");
		inappReadableNames.Add(Wear.HitmanCape, "Archimage Cape");
		inappReadableNames.Add(Wear.BerserkCape, "Bloody Demon Cape");
		inappReadableNames.Add(Wear.DemolitionCape, "Royal Knight Cape");
		inappReadableNames.Add(Wear.SniperCape, "Skeleton Lord Cape");
		inappReadableNames.Add(Wear.StormTrooperCape, "Elite Crafter Cape");
		inappReadableNames.Add(Wear.cape_Custom, "Custom Cape");
		inappReadableNames.Add(Wear.HitmanCape_Up1, "HitmanCape_Up1");
		inappReadableNames.Add(Wear.BerserkCape_Up1, "BerserkCape_Up1");
		inappReadableNames.Add(Wear.DemolitionCape_Up1, "DemolitionCape_Up1");
		inappReadableNames.Add(Wear.SniperCape_Up1, "SniperCape_Up1");
		inappReadableNames.Add(Wear.StormTrooperCape_Up1, "StormTrooperCape_Up1");
		inappReadableNames.Add(Wear.HitmanCape_Up2, "HitmanCape_Up2");
		inappReadableNames.Add(Wear.BerserkCape_Up2, "BerserkCape_Up2");
		inappReadableNames.Add(Wear.DemolitionCape_Up2, "DemolitionCape_Up2");
		inappReadableNames.Add(Wear.SniperCape_Up2, "SniperCape_Up2");
		inappReadableNames.Add(Wear.StormTrooperCape_Up2, "StormTrooperCape_Up2");
		inappReadableNames.Add(Wear.hat_Adamant_3, "hat_Adamant_3");
		inappReadableNames.Add(Wear.hat_DiamondHelmet, "Diamond Helmet");
		inappReadableNames.Add(Wear.hat_Headphones, "Headphones");
		inappReadableNames.Add(Wear.hat_ManiacMask, "Maniac Mask");
		inappReadableNames.Add(Wear.hat_KingsCrown, "King's Crown");
		inappReadableNames.Add(Wear.hat_SeriousManHat, "Leprechaun's Hat");
		inappReadableNames.Add(Wear.hat_Samurai, "Samurais Helm");
		inappReadableNames.Add(Wear.hat_AlmazHelmet, "hat_AlmazHelmet");
		inappReadableNames.Add(Wear.hat_ArmyHelmet, "hat_ArmyHelmet");
		inappReadableNames.Add(Wear.hat_SteelHelmet, "hat_SteelHelmet");
		inappReadableNames.Add(Wear.hat_GoldHelmet, "hat_GoldHelmet");
		inappReadableNames.Add(Wear.hat_Army_1, "hat_Army_1");
		inappReadableNames.Add(Wear.hat_Almaz_1, "hat_Almaz_1");
		inappReadableNames.Add(Wear.hat_Steel_1, "hat_Steel_1");
		inappReadableNames.Add(Wear.hat_Royal_1, "hat_Royal_1");
		inappReadableNames.Add(Wear.hat_Army_2, "hat_Army_2");
		inappReadableNames.Add(Wear.hat_Almaz_2, "hat_Almaz_2");
		inappReadableNames.Add(Wear.hat_Steel_2, "hat_Steel_2");
		inappReadableNames.Add(Wear.hat_Royal_2, "hat_Royal_2");
		inappReadableNames.Add(Wear.hat_Army_3, "hat_Army_3");
		inappReadableNames.Add(Wear.hat_Almaz_3, "hat_Almaz_3");
		inappReadableNames.Add(Wear.hat_Steel_3, "hat_Steel_3");
		inappReadableNames.Add(Wear.hat_Royal_3, "hat_Royal_3");
		inappReadableNames.Add(Wear.hat_Army_4, "hat_Army_4");
		inappReadableNames.Add(Wear.hat_Almaz_4, "hat_Almaz_4");
		inappReadableNames.Add(Wear.hat_Steel_4, "hat_Steel_4");
		inappReadableNames.Add(Wear.hat_Royal_4, "hat_Royal_4");
		inappReadableNames.Add(Wear.hat_Rubin_1, "hat_Rubin_1");
		inappReadableNames.Add(Wear.hat_Rubin_2, "hat_Rubin_2");
		inappReadableNames.Add(Wear.hat_Rubin_3, "hat_Rubin_3");
		inappReadableNames.Add(Wear.Armor_Steel, "Armor_Steel_1");
		inappReadableNames.Add(Wear.Armor_Steel_2, "Armor_Steel_2");
		inappReadableNames.Add(Wear.Armor_Steel_3, "Armor_Steel_3");
		inappReadableNames.Add(Wear.Armor_Steel_4, "Armor_Steel_4");
		inappReadableNames.Add(Wear.Armor_Royal_1, "Armor_Royal_1");
		inappReadableNames.Add(Wear.Armor_Royal_2, "Armor_Royal_2");
		inappReadableNames.Add(Wear.Armor_Royal_3, "Armor_Royal_3");
		inappReadableNames.Add(Wear.Armor_Royal_4, "Armor_Royal_4");
		inappReadableNames.Add(Wear.Armor_Almaz_1, "Armor_Almaz_1");
		inappReadableNames.Add(Wear.Armor_Almaz_2, "Armor_Almaz_2");
		inappReadableNames.Add(Wear.Armor_Almaz_3, "Armor_Almaz_3");
		inappReadableNames.Add(Wear.Armor_Almaz_4, "Armor_Almaz_4");
		inappReadableNames.Add(Wear.Armor_Army_1, "Armor_Army_1");
		inappReadableNames.Add(Wear.Armor_Army_2, "Armor_Army_2");
		inappReadableNames.Add(Wear.Armor_Army_3, "Armor_Army_3");
		inappReadableNames.Add(Wear.Armor_Army_4, "Armor_Army_4");
		inappReadableNames.Add(Wear.Armor_Rubin_1, "Armor_Rubin_1");
		inappReadableNames.Add(Wear.Armor_Rubin_2, "Armor_Rubin_2");
		inappReadableNames.Add(Wear.Armor_Rubin_3, "Armor_Rubin_3");
		inappReadableNames.Add(Wear.Armor_Adamant_Const_1, "Armor_Adamant_Const_1");
		inappReadableNames.Add(Wear.Armor_Adamant_Const_2, "Armor_Adamant_Const_2");
		inappReadableNames.Add(Wear.Armor_Adamant_Const_3, "Armor_Adamant_Const_3");
		inappReadableNames.Add(Wear.hat_Adamant_Const_1, "hat_Adamant_Const_1");
		inappReadableNames.Add(Wear.hat_Adamant_Const_2, "hat_Adamant_Const_2");
		inappReadableNames.Add(Wear.hat_Adamant_Const_3, "hat_Adamant_Const_3");
		inappReadableNames.Add(Wear.Armor_Adamant_3, "Armor_Adamant_3");
		string[] potions = PotionsController.potions;
		foreach (string text in potions)
		{
			inappReadableNames.Add(text, text);
		}
		inappReadableNames.Add(Wear.HitmanBoots, "boots_red");
		inappReadableNames.Add(Wear.StormTrooperBoots, "boots_gray");
		inappReadableNames.Add(Wear.SniperBoots, "boots_blue");
		inappReadableNames.Add(Wear.DemolitionBoots, "boots_green");
		inappReadableNames.Add(Wear.BerserkBoots, "boots_black");
		inappReadableNames.Add(Wear.boots_tabi, "boots ninja");
		inappReadableNames.Add(Wear.HitmanBoots_Up1, "HitmanBoots_Up1");
		inappReadableNames.Add(Wear.StormTrooperBoots_Up1, "StormTrooperBoots_Up1");
		inappReadableNames.Add(Wear.SniperBoots_Up1, "SniperBoots_Up1");
		inappReadableNames.Add(Wear.DemolitionBoots_Up1, "DemolitionBoots_Up1");
		inappReadableNames.Add(Wear.BerserkBoots_Up1, "BerserkBoots_Up1");
		inappReadableNames.Add(Wear.HitmanBoots_Up2, "HitmanBoots_Up2");
		inappReadableNames.Add(Wear.StormTrooperBoots_Up2, "StormTrooperBoots_Up2");
		inappReadableNames.Add(Wear.SniperBoots_Up2, "SniperBoots_Up2");
		inappReadableNames.Add(Wear.DemolitionBoots_Up2, "DemolitionBoots_Up2");
		inappReadableNames.Add(Wear.BerserkBoots_Up2, "BerserkBoots_Up2");
		for (int l = 0; l < 11; l++)
		{
			inappReadableNames.Add("newskin_" + l, "newskin_" + l);
		}
		for (int m = 11; m < 19; m++)
		{
			inappReadableNames.Add("newskin_" + m, "newskin_" + m);
		}
		inappReadableNames.Add("InvisibilityPotion" + GearManager.UpgradeSuffix + 1, "InvisibilityPotion" + GearManager.UpgradeSuffix + 1);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.UpgradeSuffix + 2, "InvisibilityPotion" + GearManager.UpgradeSuffix + 2);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.UpgradeSuffix + 3, "InvisibilityPotion" + GearManager.UpgradeSuffix + 3);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.UpgradeSuffix + 4, "InvisibilityPotion" + GearManager.UpgradeSuffix + 4);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.UpgradeSuffix + 5, "InvisibilityPotion" + GearManager.UpgradeSuffix + 5);
		inappReadableNames.Add("GrenadeID" + GearManager.UpgradeSuffix + 1, "GrenadeID" + GearManager.UpgradeSuffix + 1);
		inappReadableNames.Add("GrenadeID" + GearManager.UpgradeSuffix + 2, "GrenadeID" + GearManager.UpgradeSuffix + 2);
		inappReadableNames.Add("GrenadeID" + GearManager.UpgradeSuffix + 3, "GrenadeID" + GearManager.UpgradeSuffix + 3);
		inappReadableNames.Add("GrenadeID" + GearManager.UpgradeSuffix + 4, "GrenadeID" + GearManager.UpgradeSuffix + 4);
		inappReadableNames.Add("GrenadeID" + GearManager.UpgradeSuffix + 5, "GrenadeID" + GearManager.UpgradeSuffix + 5);
		inappReadableNames.Add(GearManager.Turret + GearManager.UpgradeSuffix + 1, GearManager.Turret + GearManager.UpgradeSuffix + 1);
		inappReadableNames.Add(GearManager.Turret + GearManager.UpgradeSuffix + 2, GearManager.Turret + GearManager.UpgradeSuffix + 2);
		inappReadableNames.Add(GearManager.Turret + GearManager.UpgradeSuffix + 3, GearManager.Turret + GearManager.UpgradeSuffix + 3);
		inappReadableNames.Add(GearManager.Turret + GearManager.UpgradeSuffix + 4, GearManager.Turret + GearManager.UpgradeSuffix + 4);
		inappReadableNames.Add(GearManager.Turret + GearManager.UpgradeSuffix + 5, GearManager.Turret + GearManager.UpgradeSuffix + 5);
		inappReadableNames.Add(GearManager.Mech + GearManager.UpgradeSuffix + 1, GearManager.Mech + GearManager.UpgradeSuffix + 1);
		inappReadableNames.Add(GearManager.Mech + GearManager.UpgradeSuffix + 2, GearManager.Mech + GearManager.UpgradeSuffix + 2);
		inappReadableNames.Add(GearManager.Mech + GearManager.UpgradeSuffix + 3, GearManager.Mech + GearManager.UpgradeSuffix + 3);
		inappReadableNames.Add(GearManager.Mech + GearManager.UpgradeSuffix + 4, GearManager.Mech + GearManager.UpgradeSuffix + 4);
		inappReadableNames.Add(GearManager.Mech + GearManager.UpgradeSuffix + 5, GearManager.Mech + GearManager.UpgradeSuffix + 5);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.UpgradeSuffix + 1, GearManager.Jetpack + GearManager.UpgradeSuffix + 1);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.UpgradeSuffix + 2, GearManager.Jetpack + GearManager.UpgradeSuffix + 2);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.UpgradeSuffix + 3, GearManager.Jetpack + GearManager.UpgradeSuffix + 3);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.UpgradeSuffix + 4, GearManager.Jetpack + GearManager.UpgradeSuffix + 4);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.UpgradeSuffix + 5, GearManager.Jetpack + GearManager.UpgradeSuffix + 5);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.OneItemSuffix + 0, "InvisibilityPotion" + GearManager.OneItemSuffix + 0);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.OneItemSuffix + 1, "InvisibilityPotion" + GearManager.OneItemSuffix + 1);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.OneItemSuffix + 2, "InvisibilityPotion" + GearManager.OneItemSuffix + 2);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.OneItemSuffix + 3, "InvisibilityPotion" + GearManager.OneItemSuffix + 3);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.OneItemSuffix + 4, "InvisibilityPotion" + GearManager.OneItemSuffix + 4);
		inappReadableNames.Add("InvisibilityPotion" + GearManager.OneItemSuffix + 5, "InvisibilityPotion" + GearManager.OneItemSuffix + 5);
		inappReadableNames.Add("GrenadeID" + GearManager.OneItemSuffix + 0, "GrenadeID" + GearManager.OneItemSuffix + 0);
		inappReadableNames.Add("GrenadeID" + GearManager.OneItemSuffix + 1, "GrenadeID" + GearManager.OneItemSuffix + 1);
		inappReadableNames.Add("GrenadeID" + GearManager.OneItemSuffix + 2, "GrenadeID" + GearManager.OneItemSuffix + 2);
		inappReadableNames.Add("GrenadeID" + GearManager.OneItemSuffix + 3, "GrenadeID" + GearManager.OneItemSuffix + 3);
		inappReadableNames.Add("GrenadeID" + GearManager.OneItemSuffix + 4, "GrenadeID" + GearManager.OneItemSuffix + 4);
		inappReadableNames.Add("GrenadeID" + GearManager.OneItemSuffix + 5, "GrenadeID" + GearManager.OneItemSuffix + 5);
		inappReadableNames.Add(GearManager.Turret + GearManager.OneItemSuffix + 0, GearManager.Turret + GearManager.OneItemSuffix + 0);
		inappReadableNames.Add(GearManager.Turret + GearManager.OneItemSuffix + 1, GearManager.Turret + GearManager.OneItemSuffix + 1);
		inappReadableNames.Add(GearManager.Turret + GearManager.OneItemSuffix + 2, GearManager.Turret + GearManager.OneItemSuffix + 2);
		inappReadableNames.Add(GearManager.Turret + GearManager.OneItemSuffix + 3, GearManager.Turret + GearManager.OneItemSuffix + 3);
		inappReadableNames.Add(GearManager.Turret + GearManager.OneItemSuffix + 4, GearManager.Turret + GearManager.OneItemSuffix + 4);
		inappReadableNames.Add(GearManager.Turret + GearManager.OneItemSuffix + 5, GearManager.Turret + GearManager.OneItemSuffix + 5);
		inappReadableNames.Add(GearManager.Mech + GearManager.OneItemSuffix + 0, GearManager.Mech + GearManager.OneItemSuffix + 0);
		inappReadableNames.Add(GearManager.Mech + GearManager.OneItemSuffix + 1, GearManager.Mech + GearManager.OneItemSuffix + 1);
		inappReadableNames.Add(GearManager.Mech + GearManager.OneItemSuffix + 2, GearManager.Mech + GearManager.OneItemSuffix + 2);
		inappReadableNames.Add(GearManager.Mech + GearManager.OneItemSuffix + 3, GearManager.Mech + GearManager.OneItemSuffix + 3);
		inappReadableNames.Add(GearManager.Mech + GearManager.OneItemSuffix + 4, GearManager.Mech + GearManager.OneItemSuffix + 4);
		inappReadableNames.Add(GearManager.Mech + GearManager.OneItemSuffix + 5, GearManager.Mech + GearManager.OneItemSuffix + 5);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.OneItemSuffix + 0, GearManager.Jetpack + GearManager.OneItemSuffix + 0);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.OneItemSuffix + 1, GearManager.Jetpack + GearManager.OneItemSuffix + 1);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.OneItemSuffix + 2, GearManager.Jetpack + GearManager.OneItemSuffix + 2);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.OneItemSuffix + 3, GearManager.Jetpack + GearManager.OneItemSuffix + 3);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.OneItemSuffix + 4, GearManager.Jetpack + GearManager.OneItemSuffix + 4);
		inappReadableNames.Add(GearManager.Jetpack + GearManager.OneItemSuffix + 5, GearManager.Jetpack + GearManager.OneItemSuffix + 5);
	}
}
