using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public sealed class MarafonBonusController
{
	private SaltedInt _currentBonusIndex;

	private static MarafonBonusController _instance;

	private static List<List<SaltedInt>> countsForPremiumAccountLevels = new List<List<SaltedInt>>
	{
		new List<SaltedInt>
		{
			6, 6, 6, 6, 6, 6, 2, 6, 6, 6,
			6, 6, 6, 2, 6, 6, 6, 6, 6, 6,
			2, 6, 6, 6, 6, 12, 6, 2, 6, 6
		},
		new List<SaltedInt>
		{
			7, 7, 7, 7, 7, 7, 3, 7, 7, 7,
			7, 7, 7, 3, 7, 7, 7, 7, 7, 7,
			3, 7, 7, 7, 7, 14, 7, 3, 7, 7
		},
		new List<SaltedInt>
		{
			8, 8, 8, 8, 8, 8, 4, 8, 8, 8,
			8, 8, 8, 4, 8, 8, 8, 8, 8, 8,
			4, 8, 8, 8, 8, 16, 8, 4, 8, 8
		},
		new List<SaltedInt>
		{
			10, 10, 10, 10, 10, 10, 5, 10, 10, 10,
			10, 10, 10, 5, 10, 10, 10, 10, 10, 10,
			5, 10, 10, 10, 10, 20, 10, 5, 10, 10
		},
		new List<SaltedInt>
		{
			5, 5, 5, 5, 5, 5, 1, 5, 5, 5,
			5, 5, 5, 1, 5, 5, 5, 5, 5, 5,
			1, 5, 5, 5, 5, 10, 5, 1, 5, 5
		}
	};

	public List<BonusMarafonItem> BonusItems { get; private set; }

	public BonusMarafonItem CurrentBonus { get; private set; }

	public static MarafonBonusController Get
	{
		get
		{
			if (_instance == null)
			{
				_instance = new MarafonBonusController();
			}
			return _instance;
		}
	}

	public MarafonBonusController()
	{
		CurrentBonus = null;
		InitializeBonusItems();
		_currentBonusIndex.Value = Storager.getInt(Defs.NextMarafonBonusIndex, false);
	}

	public void TakeMarafonBonus()
	{
		int value = _currentBonusIndex.Value;
		TakeBonusPlayer(value);
	}

	private static int GetCountForDayForCurrentPremiumLevel(int day)
	{
		int num = (int)((!(PremiumAccountController.Instance != null)) ? PremiumAccountController.AccountType.None : PremiumAccountController.Instance.GetCurrentAccount());
		day--;
		if (countsForPremiumAccountLevels.Count > num && countsForPremiumAccountLevels[num].Count > day && day >= 0)
		{
			return countsForPremiumAccountLevels[num][day].Value;
		}
		return 0;
	}

	public void InitializeBonusItems()
	{
		BonusItems = new List<BonusMarafonItem>();
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(1), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(2), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Real, GetCountForDayForCurrentPremiumLevel(3), "bonus_gems"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(4), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Granade, GetCountForDayForCurrentPremiumLevel(5), "bonus_grenade"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(6), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.PotionInvisible, GetCountForDayForCurrentPremiumLevel(7), "bonus_potion"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(8), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(9), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Real, GetCountForDayForCurrentPremiumLevel(10), "bonus_gems"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(11), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Granade, GetCountForDayForCurrentPremiumLevel(12), "bonus_grenade"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(13), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.JetPack, GetCountForDayForCurrentPremiumLevel(14), "bonus_jetpack"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(15), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(16), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Real, GetCountForDayForCurrentPremiumLevel(17), "bonus_gems"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(18), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Granade, GetCountForDayForCurrentPremiumLevel(19), "bonus_grenade"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(20), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Turret, GetCountForDayForCurrentPremiumLevel(21), "bonus_turret"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(22), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(23), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Real, GetCountForDayForCurrentPremiumLevel(24), "bonus_gems"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(25), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Granade, GetCountForDayForCurrentPremiumLevel(26), "bonus_grenade"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(27), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Mech, GetCountForDayForCurrentPremiumLevel(28), "bonus_mech"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Gold, GetCountForDayForCurrentPremiumLevel(29), "bonus_coins"));
		BonusItems.Add(new BonusMarafonItem(BonusItemType.Mech, GetCountForDayForCurrentPremiumLevel(30), "bonus_mech"));
	}

	private void AddGearForPlayer(string gearId, int addCount)
	{
		int @int = Storager.getInt(gearId, false);
		int val = @int + addCount;
		Storager.setInt(gearId, val, false);
	}

	private void TakeBonusPlayer(int indexBonus)
	{
		if (BonusItems.Count != 0)
		{
			CurrentBonus = BonusItems[indexBonus];
			switch (CurrentBonus.type)
			{
			case BonusItemType.Gold:
				BankController.AddCoins(CurrentBonus.count.Value);
				FlurryEvents.LogCoinsGained("Marathon bonus", CurrentBonus.count.Value);
				break;
			case BonusItemType.Real:
				BankController.AddGems(CurrentBonus.count.Value);
				FlurryEvents.LogGemsGained("Marathon bonus", CurrentBonus.count.Value);
				break;
			case BonusItemType.PotionInvisible:
				AddGearForPlayer(GearManager.InvisibilityPotion, CurrentBonus.count.Value);
				break;
			case BonusItemType.JetPack:
				AddGearForPlayer(GearManager.Jetpack, CurrentBonus.count.Value);
				break;
			case BonusItemType.Granade:
				AddGearForPlayer(GearManager.Grenade, CurrentBonus.count.Value);
				break;
			case BonusItemType.Turret:
				AddGearForPlayer(GearManager.Turret, CurrentBonus.count.Value);
				break;
			case BonusItemType.Mech:
				AddGearForPlayer(GearManager.Mech, CurrentBonus.count.Value);
				break;
			case BonusItemType.TemporaryWeapon:
			{
				ShopNGUIController.CategoryNames itemCategory = (ShopNGUIController.CategoryNames)ItemDb.GetItemCategory(CurrentBonus.tag);
				TempItemsController.sharedController.TakeTemporaryItemToPlayer(itemCategory, CurrentBonus.tag, TempItemsController.RentIndexFromDays(CurrentBonus.count.Value));
				break;
			}
			}
			if (indexBonus + 1 >= BonusItems.Count)
			{
				Storager.setInt(Defs.NextMarafonBonusIndex, 0, false);
			}
			else
			{
				Storager.setInt(Defs.NextMarafonBonusIndex, indexBonus + 1, false);
			}
			_currentBonusIndex.Value = Storager.getInt(Defs.NextMarafonBonusIndex, false);
			Storager.setInt(Defs.NeedTakeMarathonBonus, 0, false);
			PlayerPrefs.Save();
		}
	}

	public bool IsAvailable()
	{
		int value = _currentBonusIndex.Value;
		return value != -1;
	}

	public bool IsNeedShow()
	{
		return Storager.getInt(Defs.NeedTakeMarathonBonus, false) == 1;
	}

	public int GetCurrentBonusIndex()
	{
		return _currentBonusIndex.Value;
	}

	public bool IsBonusTemporaryWeapon()
	{
		BonusMarafonItem bonusMarafonItem = BonusItems[_currentBonusIndex.Value];
		return bonusMarafonItem.type == BonusItemType.TemporaryWeapon;
	}

	public BonusMarafonItem GetBonusForIndex(int index)
	{
		if (BonusItems == null || BonusItems.Count == 0)
		{
			return null;
		}
		if (index < 0 || index >= BonusItems.Count)
		{
			return null;
		}
		return BonusItems[index];
	}

	public void ResetSessionState()
	{
		if (BannerWindowController.SharedController != null)
		{
			BannerWindowController.SharedController.ResetStateBannerShowed(BannerWindowType.MarathonBonus);
		}
	}

	public void SetCurrentBonusIndex(int index)
	{
		_currentBonusIndex.Value = index;
	}
}
