using System.Collections.Generic;

public static class EffectsController
{
	private static float slowdownCoeff = 1f;

	public static float SlowdownCoeff
	{
		get
		{
			return slowdownCoeff;
		}
		set
		{
			slowdownCoeff = value;
		}
	}

	public static float JumpModifier
	{
		get
		{
			float num = 1f;
			num += ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_Samurai)) ? 0f : 0.05f);
			num += ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.cape_Custom)) ? 0f : 0.05f);
			num += ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.StormTrooperBoots)) ? 0f : 0.2f);
			num += ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.StormTrooperBoots_Up1)) ? 0f : 0.3f);
			num += ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.StormTrooperBoots_Up2)) ? 0f : 0.4f);
			return num * SlowdownCoeff;
		}
	}

	public static bool NinjaJumpEnabled
	{
		get
		{
			return Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.boots_tabi) || Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.BerserkBoots) || Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.BerserkBoots_Up1) || Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.BerserkBoots_Up2);
		}
	}

	public static float ExplosionImpulseRadiusIncreaseCoef
	{
		get
		{
			return ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots)) ? 0f : 0.1f) + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots_Up1)) ? 0f : 0.15f) + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots_Up2)) ? 0f : 0.25f);
		}
	}

	public static float GrenadeExplosionDamageIncreaseCoef
	{
		get
		{
			return ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots)) ? 0f : 0.5f) + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots_Up1)) ? 0f : 0.55f) + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots_Up2)) ? 0f : 0.6f);
		}
	}

	public static float GrenadeExplosionRadiusIncreaseCoef
	{
		get
		{
			float num = 1f;
			num += ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape)) ? 0f : 0.5f);
			num += ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape_Up1)) ? 0f : 0.55f);
			num += ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape_Up2)) ? 0f : 0.6f);
			return 1f;
		}
	}

	public static float SelfExplosionDamageDecreaseCoef
	{
		get
		{
			return 1f * ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_KingsCrown)) ? 1f : 0.75f) * ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_DiamondHelmet)) ? 1f : 0.5f) * ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape)) ? 1f : 0.5f) * ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape_Up1)) ? 1f : 0.25f) * ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape_Up2)) ? 1f : 0.1f);
		}
	}

	public static bool WeAreStealth
	{
		get
		{
			return Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots) || Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots_Up1) || Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots_Up2);
		}
	}

	public static float ArmorBonus
	{
		get
		{
			float num = 0f;
			if (Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.HitmanBoots))
			{
				num += 2f;
			}
			if (Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.HitmanBoots_Up1))
			{
				num += 3f;
			}
			if (Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.HitmanBoots_Up2))
			{
				num += 4f;
			}
			return num;
		}
	}

	public static float IcnreaseEquippedArmorPercentage
	{
		get
		{
			float num = 1f;
			num += ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape)) ? 0f : 0.1f);
			num += ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape_Up1)) ? 0f : 0.2f);
			return num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape_Up2)) ? 0f : 0.3f);
		}
	}

	public static float RegeneratingArmorTime
	{
		get
		{
			float result = 0f;
			if (Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.HitmanCape))
			{
				result = 12f;
			}
			if (Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.HitmanCape_Up1))
			{
				result = 10f;
			}
			if (Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.HitmanCape_Up2))
			{
				result = 8f;
			}
			return result;
		}
	}

	public static List<float> ReloadAnimationSpeed
	{
		get
		{
			List<float> defaultReloadSpeeds = WeaponManager.DefaultReloadSpeeds;
			List<float> list;
			List<float> list2 = (list = defaultReloadSpeeds);
			int index;
			int index2 = (index = 0);
			float num = list[index];
			list2[index2] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.StormTrooperCape)) ? 0f : 0.15f);
			List<float> list3;
			List<float> list4 = (list3 = defaultReloadSpeeds);
			int index3 = (index = 0);
			num = list3[index];
			list4[index3] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.StormTrooperCape_Up1)) ? 0f : 0.2f);
			List<float> list5;
			List<float> list6 = (list5 = defaultReloadSpeeds);
			int index4 = (index = 0);
			num = list5[index];
			list6[index4] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.StormTrooperCape_Up2)) ? 0f : 0.25f);
			List<float> list7;
			List<float> list8 = (list7 = defaultReloadSpeeds);
			int index5 = (index = 3);
			num = list7[index];
			list8[index5] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.SniperCape)) ? 0f : 0.25f);
			List<float> list9;
			List<float> list10 = (list9 = defaultReloadSpeeds);
			int index6 = (index = 3);
			num = list9[index];
			list10[index6] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.SniperCape_Up1)) ? 0f : 0.35f);
			List<float> list11;
			List<float> list12 = (list11 = defaultReloadSpeeds);
			int index7 = (index = 3);
			num = list11[index];
			list12[index7] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.SniperCape_Up2)) ? 0f : 0.5f);
			List<float> list13;
			List<float> list14 = (list13 = defaultReloadSpeeds);
			int index8 = (index = 4);
			num = list13[index];
			list14[index8] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape)) ? 0f : 0.25f);
			List<float> list15;
			List<float> list16 = (list15 = defaultReloadSpeeds);
			int index9 = (index = 4);
			num = list15[index];
			list16[index9] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape_Up1)) ? 0f : 0.35f);
			List<float> list17;
			List<float> list18 = (list17 = defaultReloadSpeeds);
			int index10 = (index = 4);
			num = list17[index];
			list18[index10] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.DemolitionCape_Up2)) ? 0f : 0.5f);
			return defaultReloadSpeeds;
		}
	}

	public static bool IsRegeneratingArmor
	{
		get
		{
			return RegeneratingArmorTime > 0f;
		}
	}

	public static float ChanceToIgnoreHeadshot
	{
		get
		{
			float num = 0f;
			if (Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape))
			{
				num += 0.25f;
			}
			if (Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape_Up1))
			{
				num += 0.35f;
			}
			if (Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape_Up2))
			{
				num += 0.5f;
			}
			return num;
		}
	}

	public static float AmmoModForCategory(int i)
	{
		return 1f + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.StormTrooperBoots)) ? 0f : 0.1f) + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.StormTrooperBoots_Up1)) ? 0f : 0.15f) + ((!Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.StormTrooperBoots_Up2)) ? 0f : 0.2f);
	}

	public static float DamageModifsByCats(int i)
	{
		List<float> list = new List<float>(5);
		for (int j = 0; j < 5; j++)
		{
			list.Add(0f);
		}
		List<float> list2;
		List<float> list3 = (list2 = list);
		int index;
		int index2 = (index = 0);
		float num = list2[index];
		list3[index2] = num + ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_Headphones)) ? 0f : 0.05f);
		List<float> list4;
		List<float> list5 = (list4 = list);
		int index3 = (index = 2);
		num = list4[index];
		list5[index3] = num + ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_ManiacMask)) ? 0f : 0.1f);
		List<float> list6;
		List<float> list7 = (list6 = list);
		int index4 = (index = 2);
		num = list6[index];
		list7[index4] = num + ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_Samurai)) ? 0f : 0.05f);
		List<float> list8;
		List<float> list9 = (list8 = list);
		int index5 = (index = 1);
		num = list8[index];
		list9[index5] = num + ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_SeriousManHat)) ? 0f : 0.05f);
		List<float> list10;
		List<float> list11 = (list10 = list);
		int index6 = (index = 0);
		num = list10[index];
		list11[index6] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.StormTrooperCape)) ? 0f : 0.1f);
		List<float> list12;
		List<float> list13 = (list12 = list);
		int index7 = (index = 0);
		num = list12[index];
		list13[index7] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.StormTrooperCape_Up1)) ? 0f : 0.15f);
		List<float> list14;
		List<float> list15 = (list14 = list);
		int index8 = (index = 0);
		num = list14[index];
		list15[index8] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.StormTrooperCape_Up2)) ? 0f : 0.2f);
		List<float> list16;
		List<float> list17 = (list16 = list);
		int index9 = (index = 1);
		num = list16[index];
		list17[index9] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.HitmanCape)) ? 0f : 0.25f);
		List<float> list18;
		List<float> list19 = (list18 = list);
		int index10 = (index = 1);
		num = list18[index];
		list19[index10] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.HitmanCape_Up1)) ? 0f : 0.35f);
		List<float> list20;
		List<float> list21 = (list20 = list);
		int index11 = (index = 1);
		num = list20[index];
		list21[index11] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.HitmanCape_Up2)) ? 0f : 0.45f);
		List<float> list22;
		List<float> list23 = (list22 = list);
		int index12 = (index = 2);
		num = list22[index];
		list23[index12] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape)) ? 0f : 0.4f);
		List<float> list24;
		List<float> list25 = (list24 = list);
		int index13 = (index = 2);
		num = list24[index];
		list25[index13] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape_Up1)) ? 0f : 0.5f);
		List<float> list26;
		List<float> list27 = (list26 = list);
		int index14 = (index = 2);
		num = list26[index];
		list27[index14] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.BerserkCape_Up2)) ? 0f : 1f);
		return (i < 0 || i >= list.Count) ? 0f : list[i];
	}

	public static float SpeedModifier(int i)
	{
		float num = WeaponManager.sharedManager.currentWeaponSounds.speedModifier * ((!PotionsController.sharedController.PotionIsActive(PotionsController.HastePotion)) ? 1f : 1.25f) * ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_KingsCrown)) ? 1f : 1.05f) * ((!Storager.getString(Defs.HatEquppedSN, false).Equals(Wear.hat_Samurai)) ? 1f : 1.05f) * ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.cape_Custom)) ? 1f : 1.05f) * SlowdownCoeff;
		if (i == 1 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.HitmanBoots))
		{
			num *= 1.1f;
		}
		if (i == 1 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.HitmanBoots_Up1))
		{
			num *= 1.15f;
		}
		if (i == 1 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.HitmanBoots_Up2))
		{
			num *= 1.2f;
		}
		if (i == 2 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.BerserkBoots))
		{
			num *= 1.2f;
		}
		if (i == 2 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.BerserkBoots_Up1))
		{
			num *= 1.25f;
		}
		if (i == 2 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.BerserkBoots_Up2))
		{
			num *= 1.3f;
		}
		if (i == 3 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots))
		{
			num *= 1.2f;
		}
		if (i == 3 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots_Up1))
		{
			num *= 1.25f;
		}
		if (i == 3 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots_Up2))
		{
			num *= 1.3f;
		}
		if (i == 4 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots))
		{
			num *= 1.2f;
		}
		if (i == 4 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots_Up1))
		{
			num *= 1.25f;
		}
		if (i == 4 && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.DemolitionBoots_Up2))
		{
			num *= 1.3f;
		}
		return num;
	}

	public static float AddingForPotionDuration(string potion)
	{
		float num = 0f;
		if (potion == null)
		{
			return num;
		}
		if (potion.Equals("InvisibilityPotion") && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots))
		{
			num += 5f;
		}
		if (potion.Equals("InvisibilityPotion") && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots_Up1))
		{
			num += 10f;
		}
		if (potion.Equals("InvisibilityPotion") && Storager.getString(Defs.BootsEquppedSN, false).Equals(Wear.SniperBoots_Up2))
		{
			num += 15f;
		}
		return num;
	}

	public static float AddingForHeadshot(int cat)
	{
		List<float> list = new List<float>(5);
		for (int i = 0; i < 5; i++)
		{
			list.Add(0f);
		}
		List<float> list2;
		List<float> list3 = (list2 = list);
		int index;
		int index2 = (index = 3);
		float num = list2[index];
		list3[index2] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.SniperCape)) ? 0f : 0.25f);
		List<float> list4;
		List<float> list5 = (list4 = list);
		int index3 = (index = 3);
		num = list4[index];
		list5[index3] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.SniperCape_Up1)) ? 0f : 0.35f);
		List<float> list6;
		List<float> list7 = (list6 = list);
		int index4 = (index = 3);
		num = list6[index];
		list7[index4] = num + ((!Storager.getString(Defs.CapeEquppedSN, false).Equals(Wear.SniperCape_Up2)) ? 0f : 0.5f);
		return (cat < 0 || cat >= list.Count) ? 0f : list[cat];
	}
}
