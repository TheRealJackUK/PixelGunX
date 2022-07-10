using System;
using System.Collections.Generic;
using UnityEngine;

public sealed class RentScreenController : PropertyInfoScreenController
{
	public GameObject viewButtonPanel;

	public GameObject rentButtonsPanel;

	public UIButton viewButton;

	public GameObject window;

	public UILabel[] header;

	public UILabel[] rentFor;

	public UILabel[] prices;

	public UILabel[] pricesCoins;

	public UIButton[] buttons;

	public UITexture itemImage;

	public Action<string> onPurchaseCustomAction;

	public Action onEnterCoinsShopAdditionalAction;

	public Action onExitCoinsShopAdditionalAction;

	public Action<string> customEquipWearAction;

	private string _itemTag;

	private ShopNGUIController.CategoryNames category;

	private Func<int, int> priceFormula
	{
		get
		{
			return delegate(int ind)
			{
				int result = 10;
				if (_itemTag != null)
				{
					ItemRecord byTag = ItemDb.GetByTag(_itemTag);
					ItemPrice priceByShopId = ItemDb.GetPriceByShopId((byTag == null || byTag.ShopId == null) ? _itemTag : byTag.ShopId);
					if (priceByShopId != null)
					{
						int num = -1;
						if (PromoActionsManager.sharedManager != null && PromoActionsManager.sharedManager.discounts.ContainsKey(_itemTag))
						{
							num = PromoActionsManager.sharedManager.discounts[_itemTag][0];
						}
						result = ((num == -1) ? Mathf.RoundToInt((float)priceByShopId.Price * TempItemsController.PriceCoefs[_itemTag][ind]) : Mathf.RoundToInt(PromoActionsManager.PriceWithDiscountFloat(priceByShopId.Price, num) * TempItemsController.PriceCoefs[_itemTag][ind]));
					}
				}
				return result;
			};
		}
	}

	public string Header
	{
		set
		{
			UILabel[] array = header;
			foreach (UILabel uILabel in array)
			{
				if (uILabel != null && value != null)
				{
					uILabel.text = value;
				}
			}
		}
	}

	public string RentFor
	{
		set
		{
			UILabel[] array = rentFor;
			foreach (UILabel uILabel in array)
			{
				if (uILabel != null && value != null && _itemTag != null)
				{
					uILabel.text = string.Format(value, ItemDb.GetItemNameByTag(_itemTag));
				}
			}
		}
	}

	public string ItemTag
	{
		set
		{
			_itemTag = value;
			if (_itemTag == null)
			{
				return;
			}
			string text = PromoActionsGUIController.IconNameForKey(cat: (int)(category = (ShopNGUIController.CategoryNames)PromoActionsGUIController.CatForTg(_itemTag)), key: _itemTag);
			Texture texture = Resources.Load<Texture>("OfferIcons/" + text);
			if (texture != null && itemImage != null)
			{
				itemImage.mainTexture = texture;
			}
			ItemRecord byTag = ItemDb.GetByTag(_itemTag);
			ItemPrice priceByShopId = ItemDb.GetPriceByShopId((byTag == null || byTag.ShopId == null) ? _itemTag : byTag.ShopId);
			bool flag = priceByShopId != null && priceByShopId.Currency != null && priceByShopId.Currency.Equals("Coins");
			UILabel[] array = ((!flag) ? prices : pricesCoins);
			foreach (UILabel uILabel in array)
			{
				if (uILabel != null)
				{
					uILabel.gameObject.SetActive(true);
					uILabel.text = priceFormula(Array.IndexOf((!flag) ? prices : pricesCoins, uILabel)).ToString();
				}
			}
			UILabel[] array2 = ((!flag) ? pricesCoins : prices);
			foreach (UILabel uILabel2 in array2)
			{
				if (uILabel2 != null)
				{
					uILabel2.gameObject.SetActive(false);
				}
			}
		}
	}

	public override void Hide()
	{
		base.transform.parent = null;
		UnityEngine.Object.Destroy(base.gameObject);
	}

	public void HandleRentButton(UIButton b)
	{
		if (Defs.isSoundFX)
		{
			ButtonClickSound.Instance.PlayClick();
		}
		int ind = Array.IndexOf(buttons, b);
		ItemRecord byTag = ItemDb.GetByTag(_itemTag);
		ItemPrice priceByShopId = ItemDb.GetPriceByShopId((byTag == null || byTag.ShopId == null) ? _itemTag : byTag.ShopId);
		ItemPrice price = new ItemPrice(priceFormula(ind), (priceByShopId == null) ? "GemsCurrency" : priceByShopId.Currency);
		bool hasBefore = TempItemsController.sharedController != null && TempItemsController.sharedController.ContainsItem(_itemTag);
		ShopNGUIController.TryToBuy(window, price, delegate
		{
			ShopNGUIController.ProvideShopItemOnStarterPackBoguht(category, _itemTag, 1, false, ind, delegate(string item)
			{
				if (ShopNGUIController.sharedShop != null)
				{
					ShopNGUIController.sharedShop.FireBuyAction(item);
				}
			}, customEquipWearAction);
			bool flag = Wear.armorNumTemp.ContainsKey(_itemTag ?? string.Empty);
			bool flag2 = !flag && _itemTag != null && (_itemTag.Equals(WeaponTags.DragonGunRent_Tag) || _itemTag.Equals(WeaponTags.PumpkinGunRent_Tag) || _itemTag.Equals(WeaponTags.RayMinigunRent_Tag) || _itemTag.Equals(WeaponTags.Red_StoneRent_Tag) || _itemTag.Equals(WeaponTags.TwoBoltersRent_Tag));
			string format = (flag ? "Time Armor and Hat {0}" : ((!flag2) ? "Time Weapons {0}" : "Time Weapons (red test) {0}"));
			string eventName = string.Format(format, "Total");
			string[] array = new string[3] { "1", "3", "7" };
			string text = ((array.Length <= ind || ind < 0) ? string.Empty : array[ind]) + " day - ";
			string value = text + (_itemTag ?? string.Empty) + ((!hasBefore) ? " - First Purchase" : string.Empty);
			Dictionary<string, string> parameters = new Dictionary<string, string>
			{
				{
					"Levels",
					((ExperienceController.sharedController != null) ? ExperienceController.sharedController.currentLevel : 0).ToString()
				},
				{
					"Tiers",
					(((ExpController.Instance != null) ? ExpController.Instance.OurTier : 0) + 1).ToString()
				},
				{ "Time Limits", value }
			};
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, parameters);
			string payingSuffixNo = FlurryPluginWrapper.GetPayingSuffixNo10();
			string eventName2 = string.Format(format, payingSuffixNo);
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName2, parameters);
			int price2 = price.Price;
			int num = price2 / 10;
			int num2 = price2 % 10;
			string format2 = ((price.Currency != null && price.Currency.Equals("GemsCurrency")) ? ((!flag) ? "Purchase for Gems {0}" : "Purchase for Gems TempArmor {0}") : ((!flag) ? "Purchase for Coins {0}" : "Purchase for Coins TempArmor {0}"));
			string totalEvent = string.Format(format2, "Total");
			string payingSuffixNo2 = FlurryPluginWrapper.GetPayingSuffixNo10();
			string totalPayingEvent = string.Format(format2, payingSuffixNo2);
			Action<int> action3 = delegate(int baseNumber)
			{
				Dictionary<string, string> parameters2 = new Dictionary<string, string>
				{
					{
						"Levels_" + baseNumber,
						((ExperienceController.sharedController != null) ? ExperienceController.sharedController.currentLevel : 0).ToString()
					},
					{
						"Tiers_" + baseNumber,
						(((ExpController.Instance != null) ? ExpController.Instance.OurTier : 0) + 1).ToString()
					}
				};
				FlurryPluginWrapper.LogEventAndDublicateToConsole(totalEvent, parameters2);
				FlurryPluginWrapper.LogEventAndDublicateToConsole(totalPayingEvent, parameters2);
			};
			for (int i = 0; i < num; i++)
			{
				action3(10);
			}
			for (int j = 0; j < num2; j++)
			{
				action3(1);
			}
			Action<string> action4 = onPurchaseCustomAction;
			if (action4 != null)
			{
				action4(_itemTag);
			}
			if (TempItemsController.sharedController != null)
			{
				TempItemsController.sharedController.ExpiredItems.Remove(_itemTag);
			}
			Hide();
		}, null, null, null, delegate
		{
			Action action2 = onEnterCoinsShopAdditionalAction;
			if (action2 != null)
			{
				action2();
			}
		}, delegate
		{
			Action action = onExitCoinsShopAdditionalAction;
			if (action != null)
			{
				action();
			}
		});
	}

	public void HandleViewButton()
	{
		Hide();
		if (_itemTag == null || !TempItemsController.GunsMappingFromTempToConst.ContainsKey(_itemTag))
		{
			return;
		}
		string text = WeaponManager.FirstUnboughtOrForOurTier(TempItemsController.GunsMappingFromTempToConst[_itemTag]);
		if (text != null)
		{
			int num = PromoActionsGUIController.CatForTg(text);
			if (num != -1)
			{
				ShopNGUIController.GoToShop((ShopNGUIController.CategoryNames)num, text);
			}
		}
	}

	private void Awake()
	{
		rentButtonsPanel.SetActive(false);
		viewButtonPanel.SetActive(true);
	}

	private void Update()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			Input.ResetInputAxes();
			Hide();
		}
	}

	private void SetDepthForExpGUI(int newDepth)
	{
		ExpController instance = ExpController.Instance;
		if (instance != null)
		{
			instance.experienceView.experienceCamera.depth = newDepth;
		}
	}

	private void Start()
	{
		SetDepthForExpGUI(89);
	}

	private void OnDestroy()
	{
		SetDepthForExpGUI(99);
	}
}
