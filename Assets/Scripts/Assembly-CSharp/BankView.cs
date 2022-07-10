using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

internal sealed class BankView : MonoBehaviour, IDisposable
{
	public ButtonHandler backButton;

	public GameObject premium;

	public GameObject premium5percent;

	public GameObject premium10percent;

	public GameObject interfaceHolder;

	public UILabel connectionProblemLabel;

	public UILabel crackersWarningLabel;

	public UILabel notEnoughCoinsLabel;

	public UILabel notEnoughGemsLabel;

	public UISprite purchaseSuccessfulLabel;

	public UILabel[] eventX3RemainTime;

	public GameObject btnTabContainer;

	public UIButton btnTabGold;

	public UIButton btnTabGems;

	public UIScrollView goldScrollView;

	public UIGrid goldItemGrid;

	public BankViewItem goldItemPrefab;

	public UIScrollView gemsScrollView;

	public UIGrid gemsItemGrid;

	public BankViewItem gemsItemPrefab;

	public UIButton freeAwardButton;

	public UIWidget eventX3AmazonBonusWidget;

	private StoreKitEventListener _storeKitEventListener;

	private bool _needResetScrollView;

	private bool _isPurchasesAreadyEnabled;

	public TweenColor colorBlinkForX3;

	private float _lastUpdateTime;

	private string _localizeSaleLabel;

	private readonly List<Action> _disposeActions = new List<Action>();

	private bool _disposed;

	public static readonly IList<PurchaseEventArgs> goldPurchasesInfo = new List<PurchaseEventArgs>
	{
		new PurchaseEventArgs(0, 0, 0m),
		new PurchaseEventArgs(1, 0, 0m),
		new PurchaseEventArgs(2, 0, 0m, "Coins", 7),
		new PurchaseEventArgs(3, 0, 0m, "Coins", 10),
		new PurchaseEventArgs(4, 0, 0m, "Coins", 12),
		new PurchaseEventArgs(5, 0, 0m, "Coins", 15),
		new PurchaseEventArgs(6, 0, 0m, "Coins", 33)
	};

	public static readonly IList<PurchaseEventArgs> gemsPurchasesInfo = new List<PurchaseEventArgs>
	{
		new PurchaseEventArgs(0, 0, 0m, "GemsCurrency"),
		new PurchaseEventArgs(1, 0, 0m, "GemsCurrency"),
		new PurchaseEventArgs(2, 0, 0m, "GemsCurrency", 7),
		new PurchaseEventArgs(3, 0, 0m, "GemsCurrency", 10),
		new PurchaseEventArgs(4, 0, 0m, "GemsCurrency", 12),
		new PurchaseEventArgs(5, 0, 0m, "GemsCurrency", 15),
		new PurchaseEventArgs(6, 0, 0m, "GemsCurrency", 33)
	};

	public bool InterfaceEnabled
	{
		get
		{
			return interfaceHolder != null && interfaceHolder.activeInHierarchy;
		}
		set
		{
			if (interfaceHolder != null)
			{
				interfaceHolder.SetActive(value);
			}
		}
	}

	public bool ConnectionProblemLabelEnabled
	{
		get
		{
			return connectionProblemLabel != null && connectionProblemLabel.gameObject.GetActive();
		}
		set
		{
			if (connectionProblemLabel != null)
			{
				connectionProblemLabel.gameObject.SetActive(value);
			}
		}
	}

	public bool CrackersWarningLabelEnabled
	{
		get
		{
			return crackersWarningLabel != null && crackersWarningLabel.gameObject.GetActive();
		}
		set
		{
			if (crackersWarningLabel != null)
			{
				crackersWarningLabel.gameObject.SetActive(value);
			}
		}
	}

	public bool NotEnoughCoinsLabelEnabled
	{
		get
		{
			return notEnoughCoinsLabel != null && notEnoughCoinsLabel.gameObject.GetActive();
		}
		set
		{
			if (notEnoughCoinsLabel != null)
			{
				notEnoughCoinsLabel.gameObject.SetActive(value);
			}
		}
	}

	public bool NotEnoughGemsLabelEnabled
	{
		get
		{
			return notEnoughGemsLabel != null && notEnoughGemsLabel.gameObject.GetActive();
		}
		set
		{
			if (notEnoughGemsLabel != null)
			{
				notEnoughGemsLabel.gameObject.SetActive(value);
			}
		}
	}

	public bool PurchaseButtonsEnabled
	{
		set
		{
			btnTabContainer.SetActive(value);
			if (value)
			{
				if (!_isPurchasesAreadyEnabled)
				{
					_isPurchasesAreadyEnabled = true;
					bool isEnabled = btnTabGold.isEnabled;
					goldScrollView.gameObject.SetActive(!isEnabled);
					gemsScrollView.gameObject.SetActive(isEnabled);
					ResetScrollView(isEnabled);
				}
			}
			else
			{
				goldScrollView.gameObject.SetActive(value);
				gemsScrollView.gameObject.SetActive(value);
				_isPurchasesAreadyEnabled = false;
			}
		}
	}

	public bool PurchaseSuccessfulLabelEnabled
	{
		get
		{
			return purchaseSuccessfulLabel != null && purchaseSuccessfulLabel.gameObject.GetActive();
		}
		set
		{
			if (purchaseSuccessfulLabel != null)
			{
				purchaseSuccessfulLabel.gameObject.SetActive(value);
			}
		}
	}

	public event EventHandler<PurchaseEventArgs> PurchaseButtonPressed;

	public event EventHandler BackButtonPressed
	{
		add
		{
			if (backButton != null)
			{
				backButton.Clicked += value;
			}
		}
		remove
		{
			if (backButton != null)
			{
				backButton.Clicked -= value;
			}
		}
	}

	public void Dispose()
	{
		if (_disposed)
		{
			return;
		}
		Debug.Log("Disposing " + GetType().Name);
		foreach (Action item in _disposeActions.Where((Action a) => a != null))
		{
			item();
		}
		_disposed = true;
	}

	private void OnDestroy()
	{
		Dispose();
	}

	private void Start()
	{
		StartCoroutine(InitializeButtonsCoroutine());
		if (connectionProblemLabel != null)
		{
			connectionProblemLabel.text = LocalizationStore.Get("Key_0278");
		}
	}

	private void Update()
	{
		if (_needResetScrollView)
		{
			_needResetScrollView = false;
			StartCoroutine(ResetScrollViewsDelayed());
		}
		if (Time.realtimeSinceStartup - _lastUpdateTime >= 0.5f)
		{
			long eventX3RemainedTime = PromoActionsManager.sharedManager.EventX3RemainedTime;
			TimeSpan timeSpan = TimeSpan.FromSeconds(eventX3RemainedTime);
			string empty = string.Empty;
			empty = ((timeSpan.Days <= 0) ? string.Format("{0}: {1:00}:{2:00}:{3:00}", _localizeSaleLabel, timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds) : string.Format("{0}: {1} {2} {3:00}:{4:00}:{5:00}", _localizeSaleLabel, timeSpan.Days, (timeSpan.Days != 1) ? "Days" : "Day", timeSpan.Hours, timeSpan.Minutes, timeSpan.Seconds));
			if (eventX3RemainTime != null)
			{
				for (int i = 0; i < eventX3RemainTime.Length; i++)
				{
					eventX3RemainTime[i].text = empty;
				}
			}
			if (colorBlinkForX3 != null && timeSpan.TotalHours < (double)Defs.HoursToEndX3ForIndicate && !colorBlinkForX3.enabled)
			{
				colorBlinkForX3.enabled = true;
			}
			_lastUpdateTime = Time.realtimeSinceStartup;
		}
		PremiumAccountController.AccountType accountType = PremiumAccountController.AccountType.None;
		if (PremiumAccountController.Instance != null)
		{
			accountType = PremiumAccountController.Instance.GetCurrentAccount();
		}
		premium.SetActive(accountType == PremiumAccountController.AccountType.SevenDays || accountType == PremiumAccountController.AccountType.Month);
		premium5percent.SetActive(accountType == PremiumAccountController.AccountType.SevenDays);
		premium10percent.SetActive(accountType == PremiumAccountController.AccountType.Month);
	}

	private EventHandler CreateButtonHandler(PurchaseEventArgs purchaseInfo)
	{
		return delegate
		{
			EventHandler<PurchaseEventArgs> purchaseButtonPressed = this.PurchaseButtonPressed;
			if (purchaseButtonPressed != null)
			{
				purchaseButtonPressed(this, purchaseInfo);
			}
		};
	}

	private IEnumerator InitializeButtonsCoroutine()
	{
		while (!InterfaceEnabled)
		{
			yield return null;
		}
		_storeKitEventListener = UnityEngine.Object.FindObjectOfType<StoreKitEventListener>();
		if (_storeKitEventListener == null)
		{
			Debug.LogWarning("storeKitEventListener == null");
			goldItemPrefab.gameObject.SetActive(false);
			gemsItemPrefab.gameObject.SetActive(false);
		}
		else
		{
			PopulateItemGrid(false);
			PopulateItemGrid(true);
			OnEnable();
		}
	}

	private void PopulateItemGrid(bool isGems)
	{
		IList<PurchaseEventArgs> list2;
		if (isGems)
		{
			IList<PurchaseEventArgs> list = gemsPurchasesInfo;
			list2 = list;
		}
		else
		{
			list2 = goldPurchasesInfo;
		}
		IList<PurchaseEventArgs> list3 = list2;
		BankViewItem bankViewItem = ((!isGems) ? goldItemPrefab : gemsItemPrefab);
		UIScrollView uIScrollView = ((!isGems) ? goldScrollView : gemsScrollView);
		UIGrid uIGrid = ((!isGems) ? goldItemGrid : gemsItemGrid);
		for (int i = 0; i < list3.Count; i++)
		{
			BankViewItem bankViewItem2 = UnityEngine.Object.Instantiate(bankViewItem) as BankViewItem;
			bankViewItem2.name = string.Format("{0:00}", i);
			bankViewItem2.transform.parent = uIGrid.transform;
			bankViewItem2.transform.localScale = Vector3.one;
			bankViewItem2.transform.localPosition = Vector3.zero;
			bankViewItem2.transform.localRotation = Quaternion.identity;
			UpdateItem(bankViewItem2, i, isGems);
		}
		bankViewItem.gameObject.SetActive(false);
		ResetScrollView(isGems);
	}

	private void UpdateItem(BankViewItem item, int i, bool isGems)
	{
		PurchaseEventArgs purchaseEventArgs = ((!isGems) ? goldPurchasesInfo[i] : gemsPurchasesInfo[i]);
		string[] array = ((!isGems) ? StoreKitEventListener.coinIds : StoreKitEventListener.gemsIds);
		if (purchaseEventArgs.Index < array.Length)
		{
			purchaseEventArgs.Count = ((!isGems) ? VirtualCurrencyHelper.coinInappsQuantity[purchaseEventArgs.Index] : VirtualCurrencyHelper.gemsInappsQuantity[purchaseEventArgs.Index]);
			decimal num = ((!isGems) ? VirtualCurrencyHelper.coinPriceIds[purchaseEventArgs.Index] : VirtualCurrencyHelper.gemsPriceIds[purchaseEventArgs.Index]);
			purchaseEventArgs.CurrencyAmount = num - 0.01m;
		}
		string text = string.Format("${0}", purchaseEventArgs.CurrencyAmount);
		if (purchaseEventArgs.Index < array.Length)
		{
			string id = array[purchaseEventArgs.Index];
			IMarketProduct marketProduct = _storeKitEventListener.Products.FirstOrDefault((IMarketProduct p) => p.Id == id);
			if (marketProduct != null)
			{
				text = marketProduct.Price;
			}
			else
			{
				Debug.LogWarning("marketProduct == null,    id: " + id);
			}
		}
		else
		{
			Debug.LogWarning("purchaseInfo.Index >= StoreKitEventListener.coinIds.Length");
		}
		item.priceLabel.text = text;
		string path = ((!isGems) ? ("Textures/Bank/Coins_Shop_" + (i + 1)) : ("Textures/Bank/Coins_Shop_Gem_" + (i + 1)));
		item.icon.mainTexture = Resources.Load<Texture>(path);
		ButtonHandler purchaseButton = item.btnBuy.GetComponent<ButtonHandler>();
		if (!(purchaseButton == null))
		{
			item.countLabel.text = purchaseEventArgs.Count.ToString();
			if (item.countX3Label != null)
			{
				item.countX3Label.text = (3 * purchaseEventArgs.Count).ToString();
			}
			if (item.discountSprite != null)
			{
				item.discountSprite.gameObject.SetActive(purchaseEventArgs.Discount > 0);
			}
			if (item.discountPercentsLabel != null && purchaseEventArgs.Discount > 0)
			{
				item.discountPercentsLabel.text = string.Format("{0}%", purchaseEventArgs.Discount);
			}
			item.purchaseInfo = purchaseEventArgs;
			item.UpdateViewBestBuy();
			if (item.bonusButtonView != null)
			{
				item.bonusButtonView.UpdateState(purchaseEventArgs);
			}
			EventHandler rawButtonHandler = CreateButtonHandler(purchaseEventArgs);
			purchaseButton.Clicked += rawButtonHandler;
			_disposeActions.Add(delegate
			{
				purchaseButton.Clicked -= rawButtonHandler;
			});
		}
	}

	public void OnBtnTabClick(UIButton btnTab)
	{
		if (btnTab == btnTabGold)
		{
			Debug.Log("Activated Tab Gold");
			btnTabGold.isEnabled = false;
			btnTabGems.isEnabled = true;
			goldScrollView.gameObject.SetActive(true);
			gemsScrollView.gameObject.SetActive(false);
			ResetScrollView(false);
		}
		else if (btnTab == btnTabGems)
		{
			Debug.Log("Activated Tab Gems");
			btnTabGold.isEnabled = true;
			btnTabGems.isEnabled = false;
			goldScrollView.gameObject.SetActive(false);
			gemsScrollView.gameObject.SetActive(true);
			ResetScrollView(true);
		}
		else
		{
			Debug.Log("Unknown btnTab");
		}
	}

	private void OnEnable()
	{
		SortItemGrid(false);
		SortItemGrid(true);
		UIButton btnTab = btnTabGems;
		if (coinsShop.thisScript != null && coinsShop.thisScript.notEnoughCurrency != null && coinsShop.thisScript.notEnoughCurrency.Equals("Coins"))
		{
			btnTab = btnTabGold;
		}
		OnBtnTabClick(btnTab);
		_localizeSaleLabel = LocalizationStore.Get("Key_0419");
	}

	private void SortItemGrid(bool isGems)
	{
		UIGrid uIGrid = ((!isGems) ? goldItemGrid : gemsItemGrid);
		Transform transform = uIGrid.transform;
		List<BankViewItem> list = new List<BankViewItem>();
		for (int i = 0; i < transform.childCount; i++)
		{
			BankViewItem component = transform.GetChild(i).GetComponent<BankViewItem>();
			list.Add(component);
		}
		list.Sort();
		for (int j = 0; j < list.Count; j++)
		{
			list[j].gameObject.name = string.Format("{0:00}", j);
		}
		ResetScrollView(isGems);
	}

	private IEnumerator ResetScrollViewsDelayed()
	{
		yield return null;
		ResetScrollView(false, false);
		ResetScrollView(true, false);
	}

	private void ResetScrollView(bool isGems, bool needDelayedUpdate = true)
	{
		UIScrollView uIScrollView = ((!isGems) ? goldScrollView : gemsScrollView);
		UIGrid uIGrid = ((!isGems) ? goldItemGrid : gemsItemGrid);
		if (needDelayedUpdate)
		{
			_needResetScrollView = needDelayedUpdate;
			return;
		}
		uIGrid.Reposition();
		uIScrollView.ResetPosition();
	}
}
