using System;
using System.Collections.Generic;

public static class Wear
{
	public const int NumberOfArmorsPerTier = 3;

	public static readonly string BerserkCape;

	public static readonly string DemolitionCape;

	public static readonly string SniperCape;

	public static readonly string HitmanCape;

	public static readonly string StormTrooperCape;

	public static readonly string cape_Custom;

	public static readonly string hat_Headphones;

	public static readonly string hat_ManiacMask;

	public static readonly string hat_KingsCrown;

	public static readonly string hat_Samurai;

	public static readonly string hat_DiamondHelmet;

	public static readonly string hat_SeriousManHat;

	public static readonly string hat_AlmazHelmet;

	public static readonly string hat_ArmyHelmet;

	public static readonly string hat_GoldHelmet;

	public static readonly string hat_SteelHelmet;

	public static readonly string hat_Army_1;

	public static readonly string hat_Royal_1;

	public static readonly string hat_Almaz_1;

	public static readonly string hat_Steel_1;

	public static readonly string hat_Army_2;

	public static readonly string hat_Royal_2;

	public static readonly string hat_Almaz_2;

	public static readonly string hat_Steel_2;

	public static readonly string hat_Army_3;

	public static readonly string hat_Royal_3;

	public static readonly string hat_Almaz_3;

	public static readonly string hat_Steel_3;

	public static readonly string hat_Army_4;

	public static readonly string hat_Royal_4;

	public static readonly string hat_Almaz_4;

	public static readonly string hat_Steel_4;

	public static readonly string hat_Rubin_1;

	public static readonly string hat_Rubin_2;

	public static readonly string hat_Rubin_3;

	public static readonly string BerserkBoots;

	public static readonly string SniperBoots;

	public static readonly string StormTrooperBoots;

	public static readonly string DemolitionBoots;

	public static readonly string HitmanBoots;

	public static readonly string boots_tabi;

	public static readonly string Armor_Steel;

	public static readonly string Armor_Steel_2;

	public static readonly string Armor_Steel_3;

	public static readonly string Armor_Steel_4;

	public static readonly string Armor_Royal_1;

	public static readonly string Armor_Royal_2;

	public static readonly string Armor_Royal_3;

	public static readonly string Armor_Royal_4;

	public static readonly string Armor_Almaz_1;

	public static readonly string Armor_Almaz_2;

	public static readonly string Armor_Almaz_3;

	public static readonly string Armor_Almaz_4;

	public static readonly string Armor_Army_1;

	public static readonly string Armor_Army_2;

	public static readonly string Armor_Army_3;

	public static readonly string Armor_Army_4;

	public static readonly string Armor_Rubin_1;

	public static readonly string Armor_Rubin_2;

	public static readonly string Armor_Rubin_3;

	public static readonly string StormTrooperCape_Up1;

	public static readonly string StormTrooperCape_Up2;

	public static readonly string HitmanCape_Up1;

	public static readonly string HitmanCape_Up2;

	public static readonly string BerserkCape_Up1;

	public static readonly string BerserkCape_Up2;

	public static readonly string SniperCape_Up1;

	public static readonly string SniperCape_Up2;

	public static readonly string DemolitionCape_Up1;

	public static readonly string DemolitionCape_Up2;

	public static readonly string hat_Headphones_Up1;

	public static readonly string hat_Headphones_Up2;

	public static readonly string hat_ManiacMask_Up1;

	public static readonly string hat_ManiacMask_Up2;

	public static readonly string hat_KingsCrown_Up1;

	public static readonly string hat_KingsCrown_Up2;

	public static readonly string hat_Samurai_Up1;

	public static readonly string hat_Samurai_Up2;

	public static readonly string hat_DiamondHelmet_Up1;

	public static readonly string hat_DiamondHelmet_Up2;

	public static readonly string hat_SeriousManHat_Up1;

	public static readonly string hat_SeriousManHat_Up2;

	public static readonly string StormTrooperBoots_Up1;

	public static readonly string StormTrooperBoots_Up2;

	public static readonly string HitmanBoots_Up1;

	public static readonly string HitmanBoots_Up2;

	public static readonly string BerserkBoots_Up1;

	public static readonly string BerserkBoots_Up2;

	public static readonly string SniperBoots_Up1;

	public static readonly string SniperBoots_Up2;

	public static readonly string DemolitionBoots_Up1;

	public static readonly string DemolitionBoots_Up2;

	public static readonly string Armor_Adamant_3;

	public static readonly string hat_Adamant_3;

	public static readonly string Armor_Adamant_Const_1;

	public static readonly string Armor_Adamant_Const_2;

	public static readonly string Armor_Adamant_Const_3;

	public static readonly string hat_Adamant_Const_1;

	public static readonly string hat_Adamant_Const_2;

	public static readonly string hat_Adamant_Const_3;

	public static readonly Dictionary<ShopNGUIController.CategoryNames, List<List<string>>> wear;

	private static Dictionary<string, float> armorNum;

	public static Dictionary<string, List<float>> armorNumTemp;

	public static Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>> bootsMethods;

	public static Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>> capesMethods;

	public static Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>> hatsMethods;

	public static Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>> armorMethods;

	public static Dictionary<string, float> curArmor;

	static Wear()
	{
		BerserkCape = "cape_BloodyDemon";
		DemolitionCape = "cape_RoyalKnight";
		SniperCape = "cape_SkeletonLord";
		HitmanCape = "cape_Archimage";
		StormTrooperCape = "cape_EliteCrafter";
		cape_Custom = "cape_Custom";
		hat_Headphones = "hat_Headphones";
		hat_ManiacMask = "hat_ManiacMask";
		hat_KingsCrown = "hat_KingsCrown";
		hat_Samurai = "hat_Samurai";
		hat_DiamondHelmet = "hat_DiamondHelmet";
		hat_SeriousManHat = "hat_SeriousManHat";
		hat_AlmazHelmet = "hat_AlmazHelmet";
		hat_ArmyHelmet = "hat_ArmyHelmet";
		hat_GoldHelmet = "hat_GoldHelmet";
		hat_SteelHelmet = "hat_SteelHelmet";
		hat_Army_1 = "hat_Army_1";
		hat_Royal_1 = "hat_Royal_1";
		hat_Almaz_1 = "hat_Almaz_1";
		hat_Steel_1 = "hat_Steel_1";
		hat_Army_2 = "hat_Army_2";
		hat_Royal_2 = "hat_Royal_2";
		hat_Almaz_2 = "hat_Almaz_2";
		hat_Steel_2 = "hat_Steel_2";
		hat_Army_3 = "hat_Army_3";
		hat_Royal_3 = "hat_Royal_3";
		hat_Almaz_3 = "hat_Almaz_3";
		hat_Steel_3 = "hat_Steel_3";
		hat_Army_4 = "hat_Army_4";
		hat_Royal_4 = "hat_Royal_4";
		hat_Almaz_4 = "hat_Almaz_4";
		hat_Steel_4 = "hat_Steel_4";
		hat_Rubin_1 = "hat_Rubin_1";
		hat_Rubin_2 = "hat_Rubin_2";
		hat_Rubin_3 = "hat_Rubin_3";
		BerserkBoots = "boots_black";
		SniperBoots = "boots_blue";
		StormTrooperBoots = "boots_gray";
		DemolitionBoots = "boots_green";
		HitmanBoots = "boots_red";
		boots_tabi = "boots_tabi";
		Armor_Steel = "Armor_Steel_1";
		Armor_Steel_2 = "Armor_Steel_2";
		Armor_Steel_3 = "Armor_Steel_3";
		Armor_Steel_4 = "Armor_Steel_4";
		Armor_Royal_1 = "Armor_Royal_1";
		Armor_Royal_2 = "Armor_Royal_2";
		Armor_Royal_3 = "Armor_Royal_3";
		Armor_Royal_4 = "Armor_Royal_4";
		Armor_Almaz_1 = "Armor_Almaz_1";
		Armor_Almaz_2 = "Armor_Almaz_2";
		Armor_Almaz_3 = "Armor_Almaz_3";
		Armor_Almaz_4 = "Armor_Almaz_4";
		Armor_Army_1 = "Armor_Army_1";
		Armor_Army_2 = "Armor_Army_2";
		Armor_Army_3 = "Armor_Army_3";
		Armor_Army_4 = "Armor_Army_4";
		Armor_Rubin_1 = "Armor_Rubin_1";
		Armor_Rubin_2 = "Armor_Rubin_2";
		Armor_Rubin_3 = "Armor_Rubin_3";
		StormTrooperCape_Up1 = "StormTrooperCape_Up1";
		StormTrooperCape_Up2 = "StormTrooperCape_Up2";
		HitmanCape_Up1 = "HitmanCape_Up1";
		HitmanCape_Up2 = "HitmanCape_Up2";
		BerserkCape_Up1 = "BerserkCape_Up1";
		BerserkCape_Up2 = "BerserkCape_Up2";
		SniperCape_Up1 = "SniperCape_Up1";
		SniperCape_Up2 = "SniperCape_Up2";
		DemolitionCape_Up1 = "DemolitionCape_Up1";
		DemolitionCape_Up2 = "DemolitionCape_Up2";
		hat_Headphones_Up1 = "hat_Headphones_Up1";
		hat_Headphones_Up2 = "hat_Headphones_Up2";
		hat_ManiacMask_Up1 = "hat_ManiacMask_Up1";
		hat_ManiacMask_Up2 = "hat_ManiacMask_Up2";
		hat_KingsCrown_Up1 = "hat_KingsCrown_Up1";
		hat_KingsCrown_Up2 = "hat_KingsCrown_Up2";
		hat_Samurai_Up1 = "hat_Samurai_Up1";
		hat_Samurai_Up2 = "hat_Samurai_Up2";
		hat_DiamondHelmet_Up1 = "hat_DiamondHelmet_Up1";
		hat_DiamondHelmet_Up2 = "hat_DiamondHelmet_Up2";
		hat_SeriousManHat_Up1 = "hat_SeriousManHat_Up1";
		hat_SeriousManHat_Up2 = "hat_SeriousManHat_Up2";
		StormTrooperBoots_Up1 = "StormTrooperBoots_Up1";
		StormTrooperBoots_Up2 = "StormTrooperBoots_Up2";
		HitmanBoots_Up1 = "HitmanBoots_Up1";
		HitmanBoots_Up2 = "HitmanBoots_Up2";
		BerserkBoots_Up1 = "BerserkBoots_Up1";
		BerserkBoots_Up2 = "BerserkBoots_Up2";
		SniperBoots_Up1 = "SniperBoots_Up1";
		SniperBoots_Up2 = "SniperBoots_Up2";
		DemolitionBoots_Up1 = "DemolitionBoots_Up1";
		DemolitionBoots_Up2 = "DemolitionBoots_Up2";
		Armor_Adamant_3 = "Armor_Adamant_3";
		hat_Adamant_3 = "hat_Adamant_3";
		Armor_Adamant_Const_1 = "Armor_Adamant_Const_1";
		Armor_Adamant_Const_2 = "Armor_Adamant_Const_2";
		Armor_Adamant_Const_3 = "Armor_Adamant_Const_3";
		hat_Adamant_Const_1 = "hat_Adamant_Const_1";
		hat_Adamant_Const_2 = "hat_Adamant_Const_2";
		hat_Adamant_Const_3 = "hat_Adamant_Const_3";
		wear = new Dictionary<ShopNGUIController.CategoryNames, List<List<string>>>
		{
			{
				ShopNGUIController.CategoryNames.CapesCategory,
				new List<List<string>>
				{
					new List<string> { StormTrooperCape, StormTrooperCape_Up1, StormTrooperCape_Up2 },
					new List<string> { HitmanCape, HitmanCape_Up1, HitmanCape_Up2 },
					new List<string> { BerserkCape, BerserkCape_Up1, BerserkCape_Up2 },
					new List<string> { SniperCape, SniperCape_Up1, SniperCape_Up2 },
					new List<string> { DemolitionCape, DemolitionCape_Up1, DemolitionCape_Up2 },
					new List<string> { cape_Custom }
				}
			},
			{
				ShopNGUIController.CategoryNames.HatsCategory,
				new List<List<string>>
				{
					new List<string>
					{
						hat_Army_1, hat_Army_2, hat_Army_3, hat_Steel_1, hat_Steel_2, hat_Steel_3, hat_Royal_1, hat_Royal_2, hat_Royal_3, hat_Almaz_1,
						hat_Almaz_2, hat_Almaz_3, hat_Rubin_1, hat_Rubin_2, hat_Rubin_3, hat_Adamant_Const_1, hat_Adamant_Const_2, hat_Adamant_Const_3
					},
					new List<string> { hat_Adamant_3 },
					new List<string> { hat_Headphones },
					new List<string> { hat_ManiacMask },
					new List<string> { hat_KingsCrown },
					new List<string> { hat_Samurai },
					new List<string> { hat_DiamondHelmet },
					new List<string> { hat_SeriousManHat }
				}
			},
			{
				ShopNGUIController.CategoryNames.BootsCategory,
				new List<List<string>>
				{
					new List<string> { StormTrooperBoots, StormTrooperBoots_Up1, StormTrooperBoots_Up2 },
					new List<string> { HitmanBoots, HitmanBoots_Up1, HitmanBoots_Up2 },
					new List<string> { BerserkBoots, BerserkBoots_Up1, BerserkBoots_Up2 },
					new List<string> { SniperBoots, SniperBoots_Up1, SniperBoots_Up2 },
					new List<string> { DemolitionBoots, DemolitionBoots_Up1, DemolitionBoots_Up2 },
					new List<string> { boots_tabi }
				}
			},
			{
				ShopNGUIController.CategoryNames.ArmorCategory,
				new List<List<string>>
				{
					new List<string>
					{
						Armor_Army_1, Armor_Army_2, Armor_Army_3, Armor_Steel, Armor_Steel_2, Armor_Steel_3, Armor_Royal_1, Armor_Royal_2, Armor_Royal_3, Armor_Almaz_1,
						Armor_Almaz_2, Armor_Almaz_3, Armor_Rubin_1, Armor_Rubin_2, Armor_Rubin_3, Armor_Adamant_Const_1, Armor_Adamant_Const_2, Armor_Adamant_Const_3
					},
					new List<string> { Armor_Adamant_3 }
				}
			}
		};
		armorNum = new Dictionary<string, float>();
		armorNumTemp = new Dictionary<string, List<float>>
		{
			{
				Armor_Adamant_3,
				new List<float> { 5f, 10f, 16f, 20f, 25f }
			},
			{
				hat_Adamant_3,
				new List<float> { 5f, 10f, 16f, 20f, 25f }
			}
		};
		bootsMethods = new Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>>();
		capesMethods = new Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>>();
		hatsMethods = new Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>>();
		armorMethods = new Dictionary<string, KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>>();
		curArmor = new Dictionary<string, float>();
		bootsMethods.Add(HitmanBoots, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(ActivateBoots_red, deActivateBoots_red));
		bootsMethods.Add(StormTrooperBoots, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(ActivateBoots_grey, deActivateBoots_grey));
		bootsMethods.Add(SniperBoots, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(ActivateBoots_blue, deActivateBoots_blue));
		bootsMethods.Add(DemolitionBoots, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(ActivateBoots_green, deActivateBoots_green));
		bootsMethods.Add(BerserkBoots, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(ActivateBoots_black, deActivateBoots_black));
		capesMethods.Add(BerserkCape, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_cape_BloodyDemon, deActivate_cape_BloodyDemon));
		capesMethods.Add(DemolitionCape, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_cape_RoyalKnight, deActivate_cape_RoyalKnight));
		capesMethods.Add(SniperCape, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_cape_SkeletonLord, deActivate_cape_SkeletonLord));
		capesMethods.Add(HitmanCape, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_cape_Archimage, deActivate_cape_Archimage));
		capesMethods.Add(StormTrooperCape, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_cape_EliteCrafter, deActivate_cape_EliteCrafter));
		capesMethods.Add(cape_Custom, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_cape_Custom, deActivate_cape_Custom));
		hatsMethods.Add(hat_Adamant_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_EMPTY, deActivate_hat_EMPTY));
		hatsMethods.Add(hat_Headphones, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_EMPTY, deActivate_hat_EMPTY));
		hatsMethods.Add(hat_ManiacMask, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_ManiacMask, deActivate_hat_ManiacMask));
		hatsMethods.Add(hat_KingsCrown, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_KingsCrown, deActivate_hat_KingsCrown));
		hatsMethods.Add(hat_Samurai, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_Samurai, deActivate_hat_Samurai));
		hatsMethods.Add(hat_DiamondHelmet, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_DiamondHelmet, deActivate_hat_DiamondHelmet));
		hatsMethods.Add(hat_SeriousManHat, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_SeriousManHat, deActivate_hat_SeriousManHat));
		hatsMethods.Add(hat_AlmazHelmet, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_AlmazHelmet, deActivate_hat_AlmazHelmet));
		hatsMethods.Add(hat_ArmyHelmet, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_ArmyHelmet, deActivate_hat_ArmyHelmet));
		hatsMethods.Add(hat_GoldHelmet, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_GoldHelmet, deActivate_hat_GoldHelmet));
		hatsMethods.Add(hat_SteelHelmet, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_SteelHelmet, deActivate_hat_SteelHelmet));
		hatsMethods.Add(hat_Steel_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_Steel_1, deActivate_hat_Steel_1));
		hatsMethods.Add(hat_Royal_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_Royal_1, deActivate_hat_Royal_1));
		hatsMethods.Add(hat_Almaz_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_hat_Almaz_1, deActivate_hat_Almaz_1));
		bootsMethods.Add(boots_tabi, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_boots_tabi, deActivate_boots_tabi));
		armorMethods.Add(Armor_Adamant_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_EMPTY, deActivate_Armor_EMPTY));
		armorMethods.Add(Armor_Steel, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_EMPTY, deActivate_Armor_EMPTY));
		armorMethods.Add(Armor_Steel_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Steel_2, deActivate_Armor_Steel_2));
		armorMethods.Add(Armor_Steel_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Steel_3, deActivate_Armor_Steel_3));
		armorMethods.Add(Armor_Steel_4, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Steel_4, deActivate_Armor_Steel_4));
		armorMethods.Add(Armor_Royal_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Royal_1, deActivate_Armor_Royal_1));
		armorMethods.Add(Armor_Royal_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Royal_2, deActivate_Armor_Royal_2));
		armorMethods.Add(Armor_Royal_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Royal_3, deActivate_Armor_Royal_3));
		armorMethods.Add(Armor_Royal_4, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Royal_4, deActivate_Armor_Royal_4));
		armorMethods.Add(Armor_Almaz_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Almaz_1, deActivate_Armor_Almaz_1));
		armorMethods.Add(Armor_Almaz_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Almaz_2, deActivate_Armor_Almaz_2));
		armorMethods.Add(Armor_Almaz_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Almaz_3, deActivate_Armor_Almaz_3));
		armorMethods.Add(Armor_Almaz_4, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Almaz_4, deActivate_Armor_Almaz_4));
		armorMethods.Add(Armor_Army_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_1, deActivate_Armor_Army_1));
		armorMethods.Add(Armor_Army_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_2, deActivate_Armor_Army_2));
		armorMethods.Add(Armor_Army_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_3, deActivate_Armor_Army_3));
		armorMethods.Add(Armor_Army_4, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_4, deActivate_Armor_Army_4));
		armorMethods.Add(Armor_Rubin_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_1, deActivate_Armor_Army_1));
		armorMethods.Add(Armor_Rubin_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_2, deActivate_Armor_Army_2));
		armorMethods.Add(Armor_Rubin_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_3, deActivate_Armor_Army_3));
		armorMethods.Add(Armor_Adamant_Const_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_1, deActivate_Armor_Army_1));
		armorMethods.Add(Armor_Adamant_Const_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_2, deActivate_Armor_Army_2));
		armorMethods.Add(Armor_Adamant_Const_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_3, deActivate_Armor_Army_3));
		armorMethods.Add(hat_Rubin_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_1, deActivate_Armor_Army_1));
		armorMethods.Add(hat_Rubin_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_2, deActivate_Armor_Army_2));
		armorMethods.Add(hat_Rubin_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_3, deActivate_Armor_Army_3));
		armorMethods.Add(hat_Adamant_Const_1, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_1, deActivate_Armor_Army_1));
		armorMethods.Add(hat_Adamant_Const_2, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_2, deActivate_Armor_Army_2));
		armorMethods.Add(hat_Adamant_Const_3, new KeyValuePair<Action<Player_move_c, Dictionary<string, object>>, Action<Player_move_c, Dictionary<string, object>>>(Activate_Armor_Army_3, deActivate_Armor_Army_3));
		armorNum.Add(Armor_Army_1, 1f);
		armorNum.Add(Armor_Army_2, 2f);
		armorNum.Add(Armor_Army_3, 3f);
		armorNum.Add(Armor_Army_4, 9f);
		armorNum.Add(Armor_Steel, 4f);
		armorNum.Add(Armor_Steel_2, 5f);
		armorNum.Add(Armor_Steel_3, 8f);
		armorNum.Add(Armor_Steel_4, 27f);
		armorNum.Add(Armor_Royal_1, 9f);
		armorNum.Add(Armor_Royal_2, 10f);
		armorNum.Add(Armor_Royal_3, 14f);
		armorNum.Add(Armor_Royal_4, 63f);
		armorNum.Add(Armor_Almaz_1, 15f);
		armorNum.Add(Armor_Almaz_2, 16f);
		armorNum.Add(Armor_Almaz_3, 18f);
		armorNum.Add(Armor_Almaz_4, 133f);
		armorNum.Add(Armor_Rubin_1, 19f);
		armorNum.Add(Armor_Rubin_2, 20f);
		armorNum.Add(Armor_Rubin_3, 22f);
		armorNum.Add(Armor_Adamant_Const_1, 24f);
		armorNum.Add(Armor_Adamant_Const_2, 26f);
		armorNum.Add(Armor_Adamant_Const_3, 28f);
		armorNum.Add(hat_Army_1, 1f);
		armorNum.Add(hat_Steel_1, 4f);
		armorNum.Add(hat_Royal_1, 9f);
		armorNum.Add(hat_Almaz_1, 15f);
		armorNum.Add(hat_Army_2, 2f);
		armorNum.Add(hat_Steel_2, 5f);
		armorNum.Add(hat_Royal_2, 10f);
		armorNum.Add(hat_Almaz_2, 16f);
		armorNum.Add(hat_Army_3, 3f);
		armorNum.Add(hat_Steel_3, 8f);
		armorNum.Add(hat_Royal_3, 14f);
		armorNum.Add(hat_Almaz_3, 18f);
		armorNum.Add(hat_Army_4, 1f);
		armorNum.Add(hat_Steel_4, 1f);
		armorNum.Add(hat_Royal_4, 2f);
		armorNum.Add(hat_Almaz_4, 3f);
		armorNum.Add(hat_Rubin_1, 19f);
		armorNum.Add(hat_Rubin_2, 20f);
		armorNum.Add(hat_Rubin_3, 22f);
		armorNum.Add(hat_Adamant_Const_1, 24f);
		armorNum.Add(hat_Adamant_Const_2, 26f);
		armorNum.Add(hat_Adamant_Const_3, 28f);
	}

	public static void RemoveTemporaryWear(string item)
	{
		int num = PromoActionsGUIController.CatForTg(item);
		if (num != -1 && item != null)
		{
			if (!Storager.hasKey(ShopNGUIController.SnForWearCategory((ShopNGUIController.CategoryNames)num)))
			{
				Storager.setString(ShopNGUIController.SnForWearCategory((ShopNGUIController.CategoryNames)num), ShopNGUIController.NoneEquippedForWearCategory((ShopNGUIController.CategoryNames)num), false);
			}
			if (Storager.getString(ShopNGUIController.SnForWearCategory((ShopNGUIController.CategoryNames)num), false).Equals(item))
			{
				ShopNGUIController.UnequipCurrentWearInCategory((ShopNGUIController.CategoryNames)num, false);
			}
		}
	}

	public static bool NonArmorHat(string showHatTag)
	{
		return showHatTag.Equals("hat_ManiacMask") || showHatTag.Equals("hat_KingsCrown") || showHatTag.Equals("hat_Samurai") || showHatTag.Equals("hat_DiamondHelmet") || showHatTag.Equals("hat_SeriousManHat") || showHatTag.Equals("hat_Headphones");
	}

	public static float MaxArmorForItem(string armorName, int roomTier)
	{
		float value = 0f;
		if (armorName != null && TempItemsController.PriceCoefs.ContainsKey(armorName) && ExpController.Instance != null)
		{
			if (armorNumTemp.ContainsKey(armorName) && armorNumTemp[armorName].Count > ExpController.Instance.OurTier)
			{
				value = armorNumTemp[armorName][Math.Min(roomTier, ExpController.Instance.OurTier)];
			}
		}
		else
		{
			int num = Math.Min((!(ExpController.Instance != null)) ? (ExpController.LevelsForTiers.Length - 1) : ExpController.Instance.OurTier, roomTier);
			bool flag = false;
			List<string> list = null;
			foreach (List<List<string>> value2 in wear.Values)
			{
				foreach (List<string> item in value2)
				{
					if (item.Contains(armorName ?? string.Empty))
					{
						flag = true;
						list = item;
						break;
					}
				}
				if (flag)
				{
					break;
				}
			}
			if (list != null)
			{
				int num2 = list.IndexOf(armorName ?? string.Empty);
				if (num2 > 3 * (num + 1) - 1)
				{
					armorName = list[3 * (num + 1) - 1];
				}
			}
			armorNum.TryGetValue(armorName ?? string.Empty, out value);
		}
		return value * EffectsController.IcnreaseEquippedArmorPercentage;
	}

	public static int GetArmorCountFor(string armorTag, string hatTag)
	{
		return (int)(MaxArmorForItem(armorTag, ExpController.LevelsForTiers.Length - 1) + MaxArmorForItem(hatTag, ExpController.LevelsForTiers.Length - 1));
	}

	public static int TierForWear(string w)
	{
		if (w == null)
		{
			return 0;
		}
		if (wear[ShopNGUIController.CategoryNames.HatsCategory][0].Contains(w))
		{
			return wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(w) / 3;
		}
		if (wear[ShopNGUIController.CategoryNames.ArmorCategory][0].Contains(w))
		{
			return wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(w) / 3;
		}
		foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in wear)
		{
			foreach (List<string> item2 in item.Value)
			{
				if (item2.Contains(w))
				{
					return item2.IndexOf(w);
				}
			}
		}
		return 0;
	}

	public static void ActivateBoots_red(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivateBoots_red(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_boots_tabi(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_boots_tabi(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void ActivateBoots_grey(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivateBoots_grey(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void ActivateBoots_blue(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivateBoots_blue(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void ActivateBoots_green(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivateBoots_green(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void ActivateBoots_black(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivateBoots_black(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_cape_BloodyDemon(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_cape_BloodyDemon(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_cape_RoyalKnight(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_cape_RoyalKnight(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_cape_SkeletonLord(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_cape_SkeletonLord(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_cape_Archimage(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_cape_Archimage(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_cape_EliteCrafter(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_cape_EliteCrafter(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_cape_Custom(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
			move.koofDamageWeaponFromPotoins += 0.05f;
		}
	}

	public static void deActivate_cape_Custom(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
			move.koofDamageWeaponFromPotoins -= 0.05f;
		}
	}

	public static void Activate_hat_EMPTY(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_EMPTY(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_ManiacMask(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_ManiacMask(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_KingsCrown(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
			move.koofDamageWeaponFromPotoins += 0.05f;
		}
	}

	public static void deActivate_hat_KingsCrown(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
			move.koofDamageWeaponFromPotoins -= 0.05f;
		}
	}

	public static void Activate_hat_Samurai(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
			move.koofDamageWeaponFromPotoins += 0.05f;
		}
	}

	public static void deActivate_hat_Samurai(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
			move.koofDamageWeaponFromPotoins -= 0.05f;
		}
	}

	public static void Activate_hat_DiamondHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_DiamondHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_SeriousManHat(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_SeriousManHat(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_EMPTY(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_EMPTY(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Steel_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Steel_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Steel_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Steel_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Steel_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Steel_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Royal_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Royal_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Royal_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Royal_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Royal_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Royal_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Royal_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Royal_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Almaz_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Almaz_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Almaz_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Almaz_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Almaz_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Almaz_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Almaz_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Almaz_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Army_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Army_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Army_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Army_2(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Army_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Army_3(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_Armor_Army_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_Armor_Army_4(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_SteelHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_SteelHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_GoldHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_GoldHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_ArmyHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_ArmyHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_AlmazHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_AlmazHelmet(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_Steel_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_Steel_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_Royal_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_Royal_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void Activate_hat_Almaz_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void deActivate_hat_Almaz_1(Player_move_c move, Dictionary<string, object> p)
	{
		if (!(move == null))
		{
		}
	}

	public static void RenewCurArmor(int roomTier)
	{
		curArmor.Clear();
		foreach (string key in armorNum.Keys)
		{
			curArmor.Add(key, (!Defs.isHunger) ? MaxArmorForItem(key, roomTier) : 0f);
		}
		foreach (string key2 in armorNumTemp.Keys)
		{
			curArmor.Add(key2, (!Defs.isHunger) ? MaxArmorForItem(key2, roomTier) : 0f);
		}
	}
}
