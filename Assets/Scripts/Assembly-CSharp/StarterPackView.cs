using UnityEngine;

public class StarterPackView : BannerWindow
{
	public UILabel[] timerEvent;

	public StarterPackItem[] items;

	public UILabel buttonLabel;

	public UILabel[] title;

	public UIWidget backgroundItems;

	public UIWidget backgroundMoney;

	public UIWidget itemsCentralPanel;

	public UIWidget moneyCentralPanel;

	public UITexture moneyLeftSprite;

	public UITexture moneyRightSprite;

	public UILabel[] moneyCountLabel;

	public UILabel[] moneySaleLabel;

	public UILabel[] moneySaveSaleLabel;

	public UIWidget buttonMoneyContainer;

	public UILabel buttonMoneyDescription;

	public UISprite buttonMoneyIcon;

	public UILabel buttonMoneyCount;

	private void SetupItemsData()
	{
		if (items.Length == 0)
		{
			return;
		}
		StarterPackData currentPackData = StarterPackController.Get.GetCurrentPackData();
		if (currentPackData == null || currentPackData.items == null)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < items.Length; i++)
		{
			if (i >= currentPackData.items.Count)
			{
				items[i].gameObject.SetActive(false);
				num++;
			}
			else
			{
				items[i].SetData(currentPackData.items[i]);
			}
		}
		CenterItems(num);
	}

	private void CenterItems(int countHideElements)
	{
		if (items.Length >= 2 && countHideElements != 0)
		{
			float num = (float)countHideElements / 2f;
			float num2 = items[1].transform.localPosition.x - items[0].transform.localPosition.x;
			float num3 = num2 * num;
			int num4 = items.Length - countHideElements;
			for (int i = 0; i < num4; i++)
			{
				Vector3 localPosition = items[i].transform.localPosition;
				items[i].transform.localPosition = new Vector3(localPosition.x + num3, localPosition.y, localPosition.z);
			}
		}
	}

	private void Update()
	{
		string timeToEndEvent = StarterPackController.Get.GetTimeToEndEvent();
		for (int i = 0; i < timerEvent.Length; i++)
		{
			timerEvent[i].text = timeToEndEvent;
		}
	}

	public void OnButtonBuyClick()
	{
		StarterPackController get = StarterPackController.Get;
		if (!(get == null))
		{
			if (get.IsPackSellForGameMoney())
			{
				get.CheckBuyPackForGameMoney(this);
				return;
			}
			get.CheckBuyRealMoney();
			HideWindow();
		}
	}

	private void SetTitleText(string text)
	{
		for (int i = 0; i < title.Length; i++)
		{
			title[i].text = text;
		}
	}

	private void SetSaleSaveText(string text)
	{
		for (int i = 0; i < moneySaveSaleLabel.Length; i++)
		{
			moneySaveSaleLabel[i].text = text;
		}
	}

	private void SetButtonText()
	{
		if (StarterPackController.Get.IsPackSellForGameMoney())
		{
			ItemPrice priceDataForItemsPack = StarterPackController.Get.GetPriceDataForItemsPack();
			if (priceDataForItemsPack != null)
			{
				buttonMoneyContainer.gameObject.SetActive(true);
				buttonLabel.gameObject.SetActive(false);
				buttonMoneyDescription.text = LocalizationStore.Get("Key_1043");
				buttonMoneyIcon.spriteName = ((!(priceDataForItemsPack.Currency == "GemsCurrency")) ? "coin_znachek" : "gem_znachek");
				buttonMoneyIcon.MakePixelPerfect();
				buttonMoneyCount.text = priceDataForItemsPack.Price.ToString();
			}
		}
		else
		{
			buttonMoneyContainer.gameObject.SetActive(false);
			buttonLabel.gameObject.SetActive(true);
			string priceLabelForCurrentPack = StarterPackController.Get.GetPriceLabelForCurrentPack();
			buttonLabel.text = string.Format("{0} {1}", LocalizationStore.Get("Key_1043"), priceLabelForCurrentPack);
		}
	}

	private void SetCountMoneyLabel(int count, bool isCoins)
	{
		string empty = string.Empty;
		empty = ((!isCoins) ? LocalizationStore.Get("Key_0771") : LocalizationStore.Get("Key_0936"));
		for (int i = 0; i < moneyCountLabel.Length; i++)
		{
			moneyCountLabel[i].text = string.Format("{0}\n{1}", count, empty);
		}
	}

	private void SetSaleLabel(int sale)
	{
		for (int i = 0; i < moneySaleLabel.Length; i++)
		{
			moneySaleLabel[i].text = string.Format("{0}% {1}", sale, LocalizationStore.Get("Key_0276"));
		}
	}

	private void SetMoneyData(bool isCoins)
	{
		StarterPackData currentPackData = StarterPackController.Get.GetCurrentPackData();
		string empty = string.Empty;
		int num = 0;
		if (isCoins)
		{
			empty = "Textures/Bank/Coins_Shop_5";
			num = currentPackData.coinsCount;
		}
		else
		{
			empty = "Textures/Bank/Coins_Shop_Gem_5";
			num = currentPackData.gemsCount;
		}
		Texture mainTexture = Resources.Load<Texture>(empty);
		moneyLeftSprite.mainTexture = mainTexture;
		moneyRightSprite.mainTexture = mainTexture;
		SetCountMoneyLabel(num, isCoins);
		SetSaleLabel(currentPackData.sale);
	}

	private void ShowCustomInterface()
	{
		StarterPackModel.TypePack currentPackType = StarterPackController.Get.GetCurrentPackType();
		bool flag = currentPackType == StarterPackModel.TypePack.Items;
		bool moneyData = currentPackType == StarterPackModel.TypePack.Coins;
		itemsCentralPanel.gameObject.SetActive(flag);
		backgroundItems.gameObject.SetActive(flag);
		moneyCentralPanel.gameObject.SetActive(!flag);
		backgroundMoney.gameObject.SetActive(!flag);
		if (flag)
		{
			SetupItemsData();
		}
		else
		{
			SetMoneyData(moneyData);
		}
		SetSaleSaveText(StarterPackController.Get.GetSavingMoneyByCarrentPack());
		SetTitleText(StarterPackController.Get.GetCurrentPackName());
		SetButtonText();
	}

	public override void Show()
	{
		base.Show();
		StarterPackController.Get.CheckFindStoreKitEventListner();
		StarterPackController.Get.UpdateCountShownWindowByShowCondition();
		ShowCustomInterface();
	}

	public void HideWindow()
	{
		StarterPackController.Get.CheckSendEventChangeEnabled();
		BannerWindowController sharedController = BannerWindowController.SharedController;
		if (sharedController != null)
		{
			sharedController.HideBannerWindow();
		}
		else
		{
			Hide();
		}
	}
}
