using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Rilisoft;
using UnityEngine;

public sealed class RespawnWindow : MonoBehaviour
{
	public UILabel killerLevelNicknameLabel;

	public UITexture killerRank;

	public UILabel killerClanNameLabel;

	public UITexture killerClanLogo;

	public UILabel autoRespawnTitleLabel;

	public UILabel autoRespawnTimerLabel;

	public GameObject characterViewHolder;

	public Camera characterViewCamera;

	public UITexture characterViewTexture;

	public CharacterView characterView;

	public RespawnWindowItemToBuy killerWeapon;

	public RespawnWindowItemToBuy recommendedWeapon;

	public RespawnWindowItemToBuy recommendedArmor;

	public GameObject coinsShopButton;

	public RespawnWindowEquipmentItem hatItem;

	public RespawnWindowEquipmentItem maskItem;

	public RespawnWindowEquipmentItem armorItem;

	public RespawnWindowEquipmentItem capeItem;

	public RespawnWindowEquipmentItem bootsItem;

	public UILabel armorCountLabel;

	private static RespawnWindow _instance;

	private float _originalTimeout;

	private float _remained;

	[NonSerialized]
	public RenderTexture respawnWindowRT;

	public static RespawnWindow Instance
	{
		get
		{
			return _instance;
		}
	}

	public bool isShown
	{
		get
		{
			return base.gameObject.activeSelf;
		}
	}

	private void Start()
	{
		if (coinsShopButton != null)
		{
			ButtonHandler component = coinsShopButton.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += OnToBankClicked;
			}
		}
	}

	public void Show(KillerInfo inKillerInfo)
	{
		KillerInfo killerInfo = new KillerInfo();
		inKillerInfo.CopyTo(killerInfo);
		if (killerInfo.isGrenade)
		{
			killerInfo.weapon = GearManager.Grenade;
		}
		if (killerInfo.isTurret)
		{
			killerInfo.weapon = GearManager.Turret;
		}
		if (killerInfo.isMech)
		{
			killerInfo.weapon = GearManager.Mech;
		}
		killerLevelNicknameLabel.text = killerInfo.nickname;
		killerRank.mainTexture = killerInfo.rankTex;
		killerClanLogo.mainTexture = killerInfo.clanLogoTex;
		killerClanNameLabel.text = killerInfo.clanName;
		FillItemsToBuy(killerInfo);
		FillEquipments(killerInfo);
		FillStats(killerInfo);
		base.gameObject.SetActive(true);
		Defs.inRespawnWindow = true;
		_instance = this;
		characterViewHolder.SetActive(true);
		SetKillerNameVisible(false);
		_originalTimeout = 30f;
		StartCoroutine("CloseAfterDelay", _originalTimeout);
	}

	public void ShowCharacter(KillerInfo killerInfo)
	{
		if (killerInfo.isMech)
		{
			characterView.ShowCharacterType(CharacterView.CharacterType.Mech);
			characterView.UpdateMech(killerInfo.mechUpgrade);
		}
		else if (killerInfo.isTurret)
		{
			characterView.ShowCharacterType(CharacterView.CharacterType.Turret);
			characterView.UpdateTurret(killerInfo.turretUpgrade);
		}
		else
		{
			characterView.ShowCharacterType(CharacterView.CharacterType.Player);
			if (killerInfo.isGrenade)
			{
				characterView.SetWeaponAndSkin("WeaponGrenade", killerInfo.skinTex);
			}
			else
			{
				characterView.SetWeaponAndSkin(killerInfo.weapon, killerInfo.skinTex);
			}
			if (!string.IsNullOrEmpty(killerInfo.hat))
			{
				characterView.UpdateHat(killerInfo.hat);
			}
			else
			{
				characterView.RemoveHat();
			}
			if (!string.IsNullOrEmpty(killerInfo.cape))
			{
				characterView.UpdateCape(killerInfo.cape, killerInfo.capeTex);
			}
			else
			{
				characterView.RemoveCape();
			}
			if (!string.IsNullOrEmpty(killerInfo.boots))
			{
				characterView.UpdateBoots(killerInfo.boots);
			}
			else
			{
				characterView.RemoveBoots();
			}
			if (!string.IsNullOrEmpty(killerInfo.armor))
			{
				characterView.UpdateArmor(killerInfo.armor);
			}
			else
			{
				characterView.RemoveArmor();
			}
		}
		characterViewHolder.SetActive(true);
		characterViewCamera.targetTexture = Initializer.Instance.respawnWindowRT;
		characterViewCamera.gameObject.SetActive(true);
		characterViewTexture.mainTexture = Initializer.Instance.respawnWindowRT;
		characterView.gameObject.SetActive(true);
		SetKillerNameVisible(true);
	}

	[Obfuscation(Exclude = true)]
	public IEnumerator CloseAfterDelay(float seconds)
	{
		float closeTime = Time.realtimeSinceStartup + seconds;
		_remained = 0f;
		do
		{
			_remained = closeTime - Time.realtimeSinceStartup;
			autoRespawnTimerLabel.text = Mathf.CeilToInt(_remained).ToString();
			yield return null;
		}
		while (_remained > 0f);
		if (isShown)
		{
			RespawnPlayer();
			Hide();
		}
	}

	private void RespawnPlayer()
	{
		Player_move_c myPlayerMoveC = WeaponManager.sharedManager.myPlayerMoveC;
		if (myPlayerMoveC != null)
		{
			myPlayerMoveC.RespawnPlayer();
		}
	}

	public void Hide()
	{
		base.gameObject.SetActive(false);
		characterViewHolder.SetActive(false);
		characterView.gameObject.SetActive(false);
		Reset();
		Defs.inRespawnWindow = false;
		_instance = null;
	}

	public void OnBtnGoBattleClick()
	{
		RespawnPlayer();
		Hide();
	}

	private void FillEquipments(KillerInfo killerInfo)
	{
		hatItem.SetItemTag(killerInfo.hat, 5);
		armorItem.SetItemTag(killerInfo.armor, 6);
		capeItem.SetItemTag(killerInfo.cape, 8);
		bootsItem.SetItemTag(killerInfo.boots, 9);
	}

	private void FillItemsToBuy(KillerInfo killerInfo)
	{
		try
		{
			Debug.Log("FillItemsToBuy1");
			List<string> weaponsForBuy = GetWeaponsForBuy();
			Debug.Log("FillItemsToBuy2");
			string text = ((weaponsForBuy.Count <= 0) ? null : weaponsForBuy[0]);
			Debug.Log("FillItemsToBuy3");
			string text2 = GetArmorForBuy();
			Debug.Log("FillItemsToBuy4");
			if (string.IsNullOrEmpty(text2))
			{
				text2 = ((weaponsForBuy.Count <= 1) ? null : weaponsForBuy[1]);
			}
			Debug.Log("FillItemsToBuy5");
			if (killerInfo != null && killerInfo.weapon != null)
			{
				Debug.Log("killerInfo.weapon=" + killerInfo.weapon);
				string weapon = killerInfo.weapon;
				int? num = null;
				if (GearManager.IsItemGear(weapon))
				{
					if (weapon == GearManager.Turret)
					{
						Debug.Log("GearManager.Turret");
						num = 1 + killerInfo.turretUpgrade;
					}
					else if (weapon == GearManager.Mech)
					{
						Debug.Log("GearManager.Mech");
						num = 1 + killerInfo.mechUpgrade;
					}
				}
				Debug.Log("killerWeaponTag: " + weapon + ", upgradeNum: " + num);
				killerWeapon.SetWeaponTag(weapon, num);
				Debug.Log("killerWeapon.SetWeaponTag");
			}
			else
			{
				Debug.LogWarning("FillItemsToBuy: killerInfo == null || killerInfo.weapon == null " + Environment.StackTrace);
				killerWeapon.SetWeaponTag(string.Empty, 0);
			}
			Debug.Log("firstRecommendedItemTag: " + text);
			recommendedWeapon.SetWeaponTag(text);
			Debug.Log("otherRecommendedItemTag: " + text2);
			recommendedArmor.SetWeaponTag(text2);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public void OnItemToBuyClick(RespawnWindowItemToBuy itemToBuy)
	{
		if (itemToBuy.itemTag == null || itemToBuy.itemPrice == null)
		{
			return;
		}
		ShopNGUIController.TryToBuy(base.gameObject, itemToBuy.itemPrice, delegate
		{
			if (Defs.isSoundFX)
			{
				UIPlaySound component = itemToBuy.btnBuy.GetComponent<UIPlaySound>();
				if (component != null)
				{
					component.Play();
				}
			}
			int num = 1;
			if (GearManager.IsItemGear(itemToBuy.itemTag))
			{
				num = GearManager.ItemsInPackForGear(itemToBuy.itemTag);
				if (itemToBuy.itemTag == GearManager.Grenade)
				{
					int b = Defs2.MaxGrenadeCount - Storager.getInt(itemToBuy.itemTag, false);
					num = Mathf.Min(num, b);
				}
			}
			ShopNGUIController.ProvideShopItemOnStarterPackBoguht((ShopNGUIController.CategoryNames)itemToBuy.itemCategory, itemToBuy.itemTag, num, false, 0, delegate(string item)
			{
				if (ShopNGUIController.sharedShop != null)
				{
					ShopNGUIController.sharedShop.FireBuyAction(item);
				}
			});
			killerWeapon.SetWeaponTag(killerWeapon.itemTag);
			recommendedWeapon.SetWeaponTag(recommendedWeapon.itemTag);
			recommendedArmor.SetWeaponTag(recommendedArmor.itemTag);
			string text = "Cooldown Screen Purchases Total";
			string eventName = text + FlurryPluginWrapper.GetPayingSuffix();
			string text2 = ((ShopNGUIController.CategoryNames)itemToBuy.itemCategory).ToString();
			string nonLocalizedName = itemToBuy.nonLocalizedName;
			Dictionary<string, string> dictionary = new Dictionary<string, string>
			{
				{ "All Categories", text2 },
				{ text2, nonLocalizedName },
				{ "Item", nonLocalizedName }
			};
			if (itemToBuy.itemCategory != 10)
			{
				dictionary.Add("Without Quick Shop", nonLocalizedName);
			}
			FlurryPluginWrapper.LogEventAndDublicateToConsole(text, dictionary);
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, dictionary);
		}, null, null, null, delegate
		{
			SetPaused(true);
		}, delegate
		{
			SetPaused(false);
		});
	}

	private void FillStats(KillerInfo killerInfo)
	{
		int armorCountFor = Wear.GetArmorCountFor(killerInfo.armor, killerInfo.hat);
		armorCountLabel.text = armorCountFor.ToString();
	}

	private void OnBackFromBankClicked(object sender, EventArgs e)
	{
		BankController.Instance.BackRequested -= OnBackFromBankClicked;
		BankController.Instance.InterfaceEnabled = false;
		SetPaused(false);
	}

	private void OnToBankClicked(object sender, EventArgs e)
	{
		ShowBankWindow();
	}

	private void ShowBankWindow()
	{
		ButtonClickSound.Instance.PlayClick();
		BankController.Instance.BackRequested += OnBackFromBankClicked;
		BankController.Instance.InterfaceEnabled = true;
		SetPaused(true);
	}

	private void SetPaused(bool paused)
	{
		if (paused)
		{
			StopCoroutine("CloseAfterDelay");
		}
		else
		{
			StartCoroutine("CloseAfterDelay", _remained);
		}
	}

	private List<string> GetWeaponsForBuy()
	{
		List<string> list = new List<string>();
		string[] canBuyWeaponTags = ItemDb.GetCanBuyWeaponTags(false);
		string[] array = canBuyWeaponTags;
		foreach (string text in array)
		{
			if (WeaponManager.tagToStoreIDMapping.ContainsKey(text) && !ItemDb.IsTemporaryGun(text))
			{
				list.Add(text);
			}
		}
		bool filterNextTierUpgrades = true;
		List<string> list2 = PromoActionsGUIController.FilterPurchases(list, filterNextTierUpgrades);
		foreach (string item in list2)
		{
			list.Remove(item);
		}
		SortWeaponsByDps(list);
		return list;
	}

	private string GetArmorForBuy()
	{
		List<string> list = new List<string>();
		list.AddRange(Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0]);
		bool filterNextTierUpgrades = true;
		List<string> list2 = PromoActionsGUIController.FilterPurchases(list, filterNextTierUpgrades);
		foreach (string item in list)
		{
			if (TempItemsController.PriceCoefs.ContainsKey(item) && !list2.Contains(item))
			{
				list2.Add(item);
			}
		}
		foreach (string item2 in list2)
		{
			list.Remove(item2);
		}
		return list.FirstOrDefault();
	}

	private void SortWeaponsByDps(List<string> weaponTags)
	{
		weaponTags.Sort(delegate(string weaponTag1, string weaponTag2)
		{
			WeaponSounds weaponInfo = ItemDb.GetWeaponInfo(weaponTag1);
			if (weaponInfo == null)
			{
				return 1;
			}
			WeaponSounds weaponInfo2 = ItemDb.GetWeaponInfo(weaponTag2);
			return (weaponInfo2 == null) ? (-1) : weaponInfo2.DPS.CompareTo(weaponInfo.DPS);
		});
	}

	private void SetKillerNameVisible(bool visible)
	{
		killerLevelNicknameLabel.gameObject.SetActive(visible);
		killerRank.gameObject.SetActive(visible);
		killerClanNameLabel.gameObject.SetActive(visible);
		killerClanLogo.gameObject.SetActive(visible);
	}

	private void Reset()
	{
		killerWeapon.Reset();
		recommendedWeapon.Reset();
		recommendedArmor.Reset();
		hatItem.itemImage.mainTexture = null;
		armorItem.itemImage.mainTexture = null;
		capeItem.itemImage.mainTexture = null;
		bootsItem.itemImage.mainTexture = null;
	}
}
