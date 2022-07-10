using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PromoActionsGUIController : MonoBehaviour
{
	public UIWrapContent wrapContent;

	public UILabel noOffersLabel;

	public UILabel checkInternetLabel;

	public GameObject fonPromoPanel;

	private bool isTraining;

	private bool initiallyUpdated;

	private bool updateOnEnable;

	private IEnumerator Start()
	{
		isTraining = Defs.isTrainingFlag;
		PromoActionsManager.ActionsUUpdated += UpdateAfterDelayHandler;
		ShopNGUIController.GunBought += MarkUpdateOnEnable;
		yield return null;
		HandleUpdated();
		initiallyUpdated = true;
	}

	private void OnEnable()
	{
		if (updateOnEnable || !initiallyUpdated)
		{
			StartCoroutine(UpdateAfterDelay());
		}
		updateOnEnable = false;
	}

	private void UpdateAfterDelayHandler()
	{
		if (base.gameObject.activeInHierarchy)
		{
			StartCoroutine(UpdateAfterDelay());
		}
	}

	private IEnumerator UpdateAfterDelay()
	{
		yield return null;
		HandleUpdated();
	}

	private void OnDestroy()
	{
		PromoActionsManager.ActionsUUpdated -= UpdateAfterDelayHandler;
		ShopNGUIController.GunBought -= MarkUpdateOnEnable;
	}

	private void Update()
	{
		if (wrapContent.transform.childCount <= 0 || wrapContent.transform.childCount > 3)
		{
			return;
		}
		float num = 0f;
		foreach (Transform item in wrapContent.transform)
		{
			num += item.localPosition.x;
		}
		num /= (float)wrapContent.transform.childCount;
		Transform parent = wrapContent.transform.parent;
		if (parent != null)
		{
			UIPanel component = parent.GetComponent<UIPanel>();
			if (component != null)
			{
				component.clipOffset = new Vector2(num, component.clipOffset.y);
				parent.localPosition = new Vector3(0f - num, parent.localPosition.y, parent.localPosition.z);
			}
		}
	}

	public void MarkUpdateOnEnable()
	{
		updateOnEnable = true;
		if (base.gameObject.activeInHierarchy)
		{
			HandleUpdated();
		}
	}

	private void HandleUpdated()
	{
		StartCoroutine(HandleUpdaeCoroutine());
	}

	public static List<string> FilteredLevelUpPurchases(out string arm, out string hat)
	{
		List<string> list = new List<string>();
		arm = null;
		hat = null;
		foreach (string item in FilterForLevelUp())
		{
			if (Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0].IndexOf(item) >= 0)
			{
				arm = item;
			}
			else if (Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0].IndexOf(item) >= 0)
			{
				hat = item;
			}
			else
			{
				list.Add(item);
			}
		}
		list.Sort(delegate(string w1, string w2)
		{
			string shopIdByTag = ItemDb.GetShopIdByTag(w1);
			if (string.IsNullOrEmpty(shopIdByTag))
			{
				return 1;
			}
			string shopIdByTag2 = ItemDb.GetShopIdByTag(w2);
			if (string.IsNullOrEmpty(shopIdByTag2))
			{
				return -1;
			}
			ItemPrice priceByShopId = ItemDb.GetPriceByShopId(shopIdByTag);
			if (priceByShopId == null)
			{
				return 1;
			}
			ItemPrice priceByShopId2 = ItemDb.GetPriceByShopId(shopIdByTag2);
			return (priceByShopId2 == null) ? (-1) : priceByShopId2.CompareTo(priceByShopId);
		});
		return list;
	}

	public static List<string> FilterForLevelUp()
	{
		List<string> list = new List<string>();
		list.AddRange(Wear.wear[ShopNGUIController.CategoryNames.ArmorCategory][0]);
		list.AddRange(Wear.wear[ShopNGUIController.CategoryNames.HatsCategory][0]);
		string[] canBuyWeaponTags = ItemDb.GetCanBuyWeaponTags(false);
		string[] array = canBuyWeaponTags;
		foreach (string text in array)
		{
			if (WeaponManager.tagToStoreIDMapping.ContainsKey(text))
			{
				list.Add(text);
			}
		}
		bool filterNextTierUpgrades = true;
		List<string> list2 = FilterPurchases(list, filterNextTierUpgrades, true, true);
		foreach (string item in list2)
		{
			list.Remove(item);
		}
		return list;
	}

	public static string FilterForLoadings(string tg, List<string> alreadyUsed)
	{
		//Discarded unreachable code: IL_0056
		if (tg == null || alreadyUsed == null)
		{
			return null;
		}
		string text = WeaponManager.FirstUnboughtTag(tg);
		string empty = string.Empty;
		try
		{
			empty = WeaponManager.storeIDtoDefsSNMapping[WeaponManager.tagToStoreIDMapping[text]];
		}
		catch (Exception ex)
		{
			Debug.Log("Exception in FilterForLoadings:  idefFirstUnobught = WeaponManager.storeIDtoDefsSNMapping[ WeaponManager.tagToStoreIDMapping[firstUnobught] ]:  " + ex);
			return null;
		}
		if (!Storager.hasKey(empty))
		{
			Storager.setInt(empty, 0, false);
		}
		bool flag = Storager.getInt(empty, true) > 0;
		WeaponSounds weaponSounds = null;
		UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
		for (int i = 0; i < weaponsInGame.Length; i++)
		{
			GameObject gameObject = (GameObject)weaponsInGame[i];
			if (gameObject.tag.Equals(text))
			{
				weaponSounds = gameObject.GetComponent<WeaponSounds>();
				break;
			}
		}
		if (weaponSounds == null)
		{
			return null;
		}
		if (!flag && weaponSounds.tier <= ExpController.Instance.OurTier)
		{
			return text;
		}
		WeaponSounds weaponSounds2 = weaponSounds;
		if (!flag)
		{
			string text2 = WeaponManager.LastBoughtTag(text);
			if (text2 != null)
			{
				List<string> list = null;
				foreach (List<string> upgrade in WeaponUpgrades.upgrades)
				{
					if (upgrade.Contains(text2))
					{
						list = upgrade;
						break;
					}
				}
				for (int num = list.IndexOf(text2); num >= 0; num--)
				{
					bool flag2 = false;
					UnityEngine.Object[] weaponsInGame2 = WeaponManager.sharedManager.weaponsInGame;
					for (int j = 0; j < weaponsInGame2.Length; j++)
					{
						GameObject gameObject2 = (GameObject)weaponsInGame2[j];
						if (gameObject2.tag.Equals(list[num]))
						{
							WeaponSounds component = gameObject2.GetComponent<WeaponSounds>();
							if (component.tier <= ExpController.Instance.OurTier)
							{
								flag2 = true;
								weaponSounds2 = component;
								break;
							}
						}
					}
					if (flag2)
					{
						break;
					}
				}
			}
		}
		float num2 = 1f;
		if (weaponSounds2 != null)
		{
			num2 = weaponSounds2.damageByTier[weaponSounds2.tier] / weaponSounds2.lengthForShot;
		}
		float initialDPS = num2;
		if (flag && weaponSounds.tier > ExpController.Instance.OurTier && weaponSounds2 != null)
		{
			try
			{
				initialDPS = num2 * (weaponSounds2.damageByTier[ExpController.Instance.OurTier] / weaponSounds2.damageByTier[weaponSounds2.tier]);
			}
			catch (Exception ex2)
			{
				Debug.Log("Exception in FilterForLoadings:  if (bought && ws.tier > ExpController.Instance.OurTier && lastBoughtInOurTierWS != null):  " + ex2);
			}
		}
		List<string> list2 = new List<string>();
		list2.Add(tg);
		List<string> list3 = list2;
		foreach (List<string> upgrade2 in WeaponUpgrades.upgrades)
		{
			if (upgrade2.Contains(tg))
			{
				list3 = upgrade2;
				break;
			}
		}
		List<string> list4 = new List<string>();
		List<GameObject> list5 = new List<GameObject>();
		UnityEngine.Object[] weaponsInGame3 = WeaponManager.sharedManager.weaponsInGame;
		for (int k = 0; k < weaponsInGame3.Length; k++)
		{
			GameObject gameObject3 = (GameObject)weaponsInGame3[k];
			if (list3.Contains(gameObject3.tag) || gameObject3.GetComponent<WeaponSounds>().tier > ExpController.Instance.OurTier || gameObject3.GetComponent<WeaponSounds>().campaignOnly || gameObject3.name.Equals(WeaponManager.AlienGunWN) || gameObject3.name.Equals(WeaponManager.BugGunWN) || gameObject3.name.Equals(WeaponManager.CampaignRifle_WN) || gameObject3.name.Equals(WeaponManager.Rocketnitza_WN) || gameObject3.name.Equals(WeaponManager.PistolWN) || gameObject3.name.Equals(WeaponManager.KnifeWN) || gameObject3.name.Equals(WeaponManager.ShotgunWN) || gameObject3.name.Equals(WeaponManager.MP5WN) || ItemDb.IsTemporaryGun(gameObject3.tag))
			{
				continue;
			}
			string text3 = WeaponManager.FirstUnboughtTag(gameObject3.tag);
			if (alreadyUsed.Contains(text3) || list4.Contains(text3))
			{
				continue;
			}
			bool flag3 = false;
			UnityEngine.Object[] weaponsInGame4 = WeaponManager.sharedManager.weaponsInGame;
			for (int l = 0; l < weaponsInGame4.Length; l++)
			{
				GameObject gameObject4 = (GameObject)weaponsInGame4[l];
				if (gameObject4.tag.Equals(text3))
				{
					flag3 = gameObject4.GetComponent<WeaponSounds>().tier > ExpController.Instance.OurTier;
					break;
				}
			}
			if (flag3)
			{
				continue;
			}
			string empty2 = string.Empty;
			try
			{
				empty2 = WeaponManager.storeIDtoDefsSNMapping[WeaponManager.tagToStoreIDMapping[text3]];
				if (Storager.getInt(empty2, true) > 0)
				{
					continue;
				}
			}
			catch (Exception ex3)
			{
				Debug.Log("Exception in FilterForLoadings:  defFirstUnobughtOther = WeaponManager.storeIDtoDefsSNMapping[ WeaponManager.tagToStoreIDMapping[firstUnboughtOthers] ]:  " + ex3);
			}
			list4.Add(text3);
			UnityEngine.Object[] weaponsInGame5 = WeaponManager.sharedManager.weaponsInGame;
			for (int m = 0; m < weaponsInGame5.Length; m++)
			{
				GameObject gameObject5 = (GameObject)weaponsInGame5[m];
				if (gameObject5.tag.Equals(text3))
				{
					list5.Add(gameObject5);
					break;
				}
			}
		}
		list5.Sort(delegate(GameObject go1, GameObject go2)
		{
			float num4 = 1f;
			float num5 = 1f;
			num4 = go1.GetComponent<WeaponSounds>().damageByTier[go1.GetComponent<WeaponSounds>().tier] / go1.GetComponent<WeaponSounds>().lengthForShot;
			num5 = go2.GetComponent<WeaponSounds>().damageByTier[go2.GetComponent<WeaponSounds>().tier] / go1.GetComponent<WeaponSounds>().lengthForShot;
			return (int)(num4 - num5);
		});
		GameObject gameObject6 = list5.Find(delegate(GameObject obj)
		{
			float num3 = 1f;
			num3 = obj.GetComponent<WeaponSounds>().damageByTier[obj.GetComponent<WeaponSounds>().tier] / obj.GetComponent<WeaponSounds>().lengthForShot;
			return num3 >= initialDPS;
		});
		if (gameObject6 == null)
		{
			gameObject6 = ((list5.Count <= 0) ? null : list5[list5.Count - 1]);
		}
		return (!(gameObject6 != null)) ? null : gameObject6.tag;
	}

	public static List<string> FilterPurchases(IEnumerable<string> input, bool filterNextTierUpgrades = false, bool filterWeapons = true, bool filterRentedTempWeapons = false)
	{
		List<string> list = new List<string>();
		string key;
		foreach (string item in input)
		{
			key = item;
			bool flag = ItemDb.IsTemporaryGun(key);
			bool flag2 = true;
			bool flag3 = false;
			foreach (List<GameObject> item2 in WeaponManager.sharedManager._weaponsByCat)
			{
				int num = item2.FindIndex((GameObject g) => g.tag.Equals(key));
				if (num >= 0 && num < item2.Count)
				{
					flag3 = true;
					break;
				}
			}
			if (!flag3 && WeaponManager.tagToStoreIDMapping.ContainsKey(key))
			{
				flag2 = false;
			}
			if (filterWeapons && (!flag2 || (flag2 && !flag && WeaponManager.tagToStoreIDMapping.ContainsKey(key) && WeaponManager.storeIDtoDefsSNMapping.ContainsKey(WeaponManager.tagToStoreIDMapping[key]) && Storager.getInt(WeaponManager.storeIDtoDefsSNMapping[WeaponManager.tagToStoreIDMapping[key]], true) > 0) || (filterRentedTempWeapons && flag2 && flag && TempItemsController.sharedController != null && TempItemsController.sharedController.ContainsItem(key))))
			{
				list.Add(key);
			}
			bool flag4 = false;
			bool flag5 = false;
			foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item3 in Wear.wear)
			{
				foreach (List<string> item4 in item3.Value)
				{
					if (item4.Contains(key))
					{
						flag5 = true;
						if (!TempItemsController.PriceCoefs.ContainsKey(key))
						{
							int num2 = item4.IndexOf(key);
							bool flag6 = Storager.getInt(key, true) == 0;
							bool flag7 = Wear.TierForWear(key) <= ExpController.Instance.OurTier;
							flag4 = (num2 == 0 && flag6 && flag7) || (num2 > 0 && flag6 && Storager.getInt(item4[num2 - 1], true) > 0 && (!filterNextTierUpgrades || flag7));
						}
						break;
					}
				}
			}
			if (!flag4 && (SkinsController.skinsNamesForPers.ContainsKey(key) || key.Equals("CustomSkinID")))
			{
				flag5 = true;
				flag4 = false;
			}
			if (flag5 && !flag4 && !TempItemsController.PriceCoefs.ContainsKey(key))
			{
				list.Add(key);
			}
			if (WeaponManager.sharedManager == null || ExpController.Instance == null)
			{
				continue;
			}
			UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
			for (int i = 0; i < weaponsInGame.Length; i++)
			{
				GameObject gameObject = (GameObject)weaponsInGame[i];
				if (filterWeapons && gameObject.tag.Equals(key))
				{
					WeaponSounds component = gameObject.GetComponent<WeaponSounds>();
					if (component != null && component.tier > ExpController.Instance.OurTier)
					{
						list.Add(key);
					}
					if (Application.loadedLevelName.Equals("Sniper") && component != null && component.categoryNabor != 4)
					{
						list.Add(key);
					}
					if (Application.loadedLevelName.Equals("Knife") && component != null && component.categoryNabor != 3)
					{
						list.Add(key);
					}
					break;
				}
			}
			if (!flag5 && !WeaponManager.tagToStoreIDMapping.ContainsKey(key))
			{
				list.Add(key);
			}
		}
		return list;
	}

	public static string IconNameForKey(string key, int cat)
	{
		string result = string.Empty;
		string text = key;
		if (cat > -1)
		{
			bool flag = TempItemsController.PriceCoefs.ContainsKey(text);
			if (ShopNGUIController.IsWeaponCategory((ShopNGUIController.CategoryNames)cat))
			{
				foreach (List<string> upgrade in WeaponUpgrades.upgrades)
				{
					if (upgrade.Contains(key))
					{
						text = upgrade[0];
						break;
					}
				}
			}
			if (text != null)
			{
				int num = 1;
				if (ShopNGUIController.IsWeaponCategory((ShopNGUIController.CategoryNames)cat))
				{
					ItemRecord byTag = ItemDb.GetByTag(key);
					if (byTag == null || !byTag.UseImagesFromFirstUpgrade)
					{
						bool maxUpgrade;
						num = 1 + ((!flag) ? ShopNGUIController._CurrentNumberOfUpgrades(text, out maxUpgrade, (ShopNGUIController.CategoryNames)cat) : 0);
					}
				}
				result = text + "_icon" + num + "_big";
			}
		}
		return result;
	}

	private IEnumerator HandleUpdaeCoroutine()
	{
		PromoActionPreview[] componentsInChildren = wrapContent.GetComponentsInChildren<PromoActionPreview>(true);
		foreach (PromoActionPreview pa in componentsInChildren)
		{
			pa.transform.parent = null;
			UnityEngine.Object.Destroy(pa.gameObject);
		}
		wrapContent.SortAlphabetically();
		if (isTraining)
		{
			if (fonPromoPanel.activeSelf)
			{
				fonPromoPanel.SetActive(false);
			}
			yield break;
		}
		Dictionary<string, PromoActionMenu> pas = new Dictionary<string, PromoActionMenu>();
		foreach (string key in PromoActionsManager.sharedManager.discounts.Keys)
		{
			PromoActionMenu pam = new PromoActionMenu
			{
				isDiscounted = true,
				discount = PromoActionsManager.sharedManager.discounts[key][0]
			};
			int price2 = (pam.price = PromoActionsManager.sharedManager.discounts[key][1]);
			pam.tg = key;
			pas.Add(key, pam);
		}
		foreach (string tg in PromoActionsManager.sharedManager.topSellers)
		{
			if (!pas.ContainsKey(tg))
			{
				pas.Add(tg, new PromoActionMenu
				{
					isTopSeller = true,
					tg = tg
				});
			}
			else
			{
				pas[tg].isTopSeller = true;
			}
		}
		foreach (string tg2 in PromoActionsManager.sharedManager.news)
		{
			if (!pas.ContainsKey(tg2))
			{
				pas.Add(tg2, new PromoActionMenu
				{
					isNew = true,
					tg = tg2
				});
			}
			else
			{
				pas[tg2].isNew = true;
			}
		}
		IEnumerable<string> input = pas.Keys;
		List<string> toRem = FilterPurchases(input);
		foreach (string key3 in toRem)
		{
			pas.Remove(key3);
		}
		string discountLocalize = LocalizationStore.Key_0419;
		foreach (string key2 in pas.Keys)
		{
			GameObject f = UnityEngine.Object.Instantiate(Resources.Load("PromoAction") as GameObject) as GameObject;
			f.transform.parent = wrapContent.transform;
			f.transform.localScale = new Vector3(1f, 1f, 1f);
			PromoActionPreview pap3 = f.GetComponent<PromoActionPreview>();
			string shopId = ItemDb.GetShopIdByTag(key2) ?? key2;
			ItemPrice price = null;
			if (!string.IsNullOrEmpty(shopId))
			{
				price = ItemDb.GetPriceByShopId(shopId);
			}
			if (pas[key2].isDiscounted)
			{
				pap3.sale.gameObject.SetActive(true);
				pap3.Discount = pas[key2].discount;
				pap3.sale.text = string.Format("{0}\n{1}%", discountLocalize, pas[key2].discount);
				pap3.coins.text = pas[key2].price.ToString();
			}
			else if (price != null)
			{
				pap3.coins.text = price.Price.ToString();
			}
			if (price != null)
			{
				pap3.currencyImage.spriteName = ((!price.Currency.Equals("Coins")) ? "gem_znachek" : "ingame_coin");
				pap3.currencyImage.width = ((!price.Currency.Equals("Coins")) ? 34 : 30);
				pap3.currencyImage.height = ((!price.Currency.Equals("Coins")) ? 24 : 30);
			}
			pap3.topSeller.gameObject.SetActive(pas[key2].isTopSeller);
			pap3.newItem.gameObject.SetActive(pas[key2].isNew);
			int cat = CatForTg(key2);
			string imageName = IconNameForKey(key2, cat);
			Texture t = Resources.Load<Texture>("OfferIcons/" + imageName);
			if (t != null)
			{
				pap3.unpressed = t;
				pap3.icon.mainTexture = t;
			}
			pap3.tg = key2;
			if (t != null)
			{
				pap3.pressed = t;
			}
		}
		noOffersLabel.gameObject.SetActive(pas.Count == 0 && PromoActionsManager.ActionsAvailable);
		checkInternetLabel.gameObject.SetActive(!PromoActionsManager.ActionsAvailable);
		if (fonPromoPanel.activeSelf != (pas.Count != 0 && PromoActionsManager.ActionsAvailable))
		{
			fonPromoPanel.SetActive(pas.Count != 0 && PromoActionsManager.ActionsAvailable);
		}
		if (pas.Count == 0)
		{
		}
		yield return null;
		PromoActionPreview[] paps = wrapContent.GetComponentsInChildren<PromoActionPreview>(true);
		if (paps == null)
		{
			paps = new PromoActionPreview[0];
		}
		Comparison<PromoActionPreview> comp = delegate(PromoActionPreview pap1, PromoActionPreview pap2)
		{
			int num = 0;
			int num2 = 0;
			if (pap1.newItem.gameObject.activeSelf)
			{
				num += 100;
			}
			if (pap2.newItem.gameObject.activeSelf)
			{
				num2 += 100;
			}
			if (pap1.topSeller.gameObject.activeSelf)
			{
				num += 50;
			}
			if (pap2.topSeller.gameObject.activeSelf)
			{
				num2 += 50;
			}
			if (pap1.sale.gameObject.activeSelf)
			{
				num += 10;
			}
			if (pap2.sale.gameObject.activeSelf)
			{
				num2 += 10;
			}
			return num2 - num;
		};
		Array.Sort(paps, comp);
		for (int i = 0; i < paps.Length; i++)
		{
			paps[i].gameObject.name = i.ToString("D7");
		}
		wrapContent.SortAlphabetically();
		wrapContent.WrapContent();
		Transform lookAtTransform = null;
		if (paps.Length > 0)
		{
			lookAtTransform = paps[0].transform;
		}
		if (lookAtTransform != null)
		{
			float x = lookAtTransform.localPosition.x - 9f;
			Transform scrollViewTr = wrapContent.transform.parent;
			if (scrollViewTr != null)
			{
				UIPanel scrollViewPanel = scrollViewTr.GetComponent<UIPanel>();
				if (scrollViewPanel != null)
				{
					scrollViewPanel.clipOffset = new Vector2(x, scrollViewPanel.clipOffset.y);
					scrollViewTr.localPosition = new Vector3(0f - x, scrollViewTr.localPosition.y, scrollViewTr.localPosition.z);
				}
			}
		}
		wrapContent.WrapContent();
		wrapContent.transform.parent.GetComponent<UIScrollView>().enabled = wrapContent.transform.childCount <= 0 || wrapContent.transform.childCount > 3;
	}

	public static int CatForTg(string tg)
	{
		int num = -1;
		if (WeaponManager.sharedManager == null)
		{
			return num;
		}
		UnityEngine.Object[] weaponsInGame = WeaponManager.sharedManager.weaponsInGame;
		for (int i = 0; i < weaponsInGame.Length; i++)
		{
			GameObject gameObject = (GameObject)weaponsInGame[i];
			if (gameObject.tag.Equals(tg))
			{
				num = gameObject.GetComponent<WeaponSounds>().categoryNabor - 1;
				break;
			}
		}
		if (num == -1)
		{
			bool flag = false;
			foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in Wear.wear)
			{
				foreach (List<string> item2 in item.Value)
				{
					if (item2.Contains(tg))
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
		if (num == -1 && (SkinsController.skinsNamesForPers.ContainsKey(tg) || tg.Equals("CustomSkinID")))
		{
			num = 7;
		}
		return num;
	}
}
