using System;
using System.Collections;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

internal sealed class BankController : MonoBehaviour
{
	public const int InitialIosGems = 0;

	public const int InitialIosCoins = 0;

	public BankView bankViewCommon;

	public BankView bankViewX3;

	public GameObject uiRoot;

	public ChestBonusView bonusDetailView;

	private BankView _bankViewCurrent;

	private bool firsEnterToBankOccured;

	private float tmOfFirstEnterTheBank;

	private bool _lockInterfaceEnabledCoroutine;

	private int _counterEn;

	private readonly Rilisoft.Lazy<bool> _timeTamperingDetected = new Rilisoft.Lazy<bool>(delegate
	{
		bool flag = FreeAwardController.Instance.TimeTamperingDetected();
		if (flag)
		{
			Debug.LogWarning("FreeAwardController: time tampering detected in Bank.");
		}
		return flag;
	});

	private bool _debugOptionsEnabled;

	private string _debugMessage = string.Empty;

	private bool _escapePressed;

	private static BankController _instance;

	public BankView bankView
	{
		get
		{
			if (PromoActionsManager.sharedManager == null)
			{
				Debug.LogWarning("PromoActionsManager.sharedManager == null");
				return bankViewCommon;
			}
			return (!PromoActionsManager.sharedManager.IsEventX3Active) ? bankViewCommon : bankViewX3;
		}
	}

	public bool InterfaceEnabled
	{
		get
		{
			return bankView != null && bankView.interfaceHolder != null && bankView.interfaceHolder.gameObject.activeInHierarchy;
		}
		set
		{
			StartCoroutine(InterfaceEnabledCoroutine(value));
		}
	}

	public bool InterfaceEnabledCoroutineLocked
	{
		get
		{
			return _lockInterfaceEnabledCoroutine;
		}
	}

	public static BankController Instance
	{
		get
		{
			return _instance;
		}
	}

	public event EventHandler BackRequested
	{
		add
		{
			if (bankViewCommon != null)
			{
				bankViewCommon.BackButtonPressed += value;
			}
			if (bankViewX3 != null)
			{
				bankViewX3.BackButtonPressed += value;
			}
			this.EscapePressed = (EventHandler)Delegate.Combine(this.EscapePressed, value);
		}
		remove
		{
			if (bankViewCommon != null)
			{
				bankViewCommon.BackButtonPressed -= value;
			}
			if (bankViewX3 != null)
			{
				bankViewX3.BackButtonPressed -= value;
			}
			this.EscapePressed = (EventHandler)Delegate.Remove(this.EscapePressed, value);
		}
	}

	private event EventHandler EscapePressed;

	public static void GiveInitialNumOfCoins()
	{
		if (!Storager.hasKey("Coins"))
		{
			int val = 10;
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
			{
				val = 100;
			}
			Storager.setInt("Coins", val, false);
			PlayerPrefs.Save();
		}
		if (!Storager.hasKey("GemsCurrency"))
		{
			switch (BuildSettings.BuildTarget)
			{
			case BuildTarget.iPhone:
				Storager.setInt("GemsCurrency", 0, false);
				break;
			case BuildTarget.Android:
				Storager.setInt("GemsCurrency", 5, false);
				break;
			}
			PlayerPrefs.Save();
		}
	}

	private IEnumerator InterfaceEnabledCoroutine(bool value)
	{
		_lockInterfaceEnabledCoroutine = true;
		int cnt = _counterEn++;
		Debug.Log("InterfaceEnabledCoroutine " + cnt + " start: " + value);
		try
		{
			if (value && !firsEnterToBankOccured)
			{
				firsEnterToBankOccured = true;
				tmOfFirstEnterTheBank = Time.realtimeSinceStartup;
			}
			if (!value)
			{
				yield return null;
				yield return null;
			}
			if (bankView != _bankViewCurrent && _bankViewCurrent != null && _bankViewCurrent.interfaceHolder != null)
			{
				_bankViewCurrent.interfaceHolder.gameObject.SetActive(false);
				_bankViewCurrent = null;
			}
			if (bankView != null && bankView.interfaceHolder != null)
			{
				bankView.interfaceHolder.gameObject.SetActive(value);
				_bankViewCurrent = ((!value) ? null : bankView);
			}
			uiRoot.SetActive(value);
			if (!value && coinsShop.thisScript._purchaseActivityIndicator != null)
			{
				coinsShop.thisScript._purchaseActivityIndicator.SetActive(false);
			}
			FreeAwardShowHandler.CheckShowChest(value);
			if (value)
			{
				coinsShop.thisScript.RefreshProductsIfNeed(false);
				OnEventX3AmazonBonusUpdated();
			}
		}
		finally
		{
			_lockInterfaceEnabledCoroutine = false;
			Debug.Log("InterfaceEnabledCoroutine " + cnt + " stop: " + value);
		}
	}

	private void Awake()
	{
		GiveInitialNumOfCoins();
	}

	private void Start()
	{
		_instance = this;
		PromoActionsManager.EventX3Updated += OnEventX3Updated;
		if (bankViewCommon != null)
		{
			bankViewCommon.PurchaseButtonPressed += HandlePurchaseButtonPressed;
		}
		if (bankViewX3 != null)
		{
			bankViewX3.PurchaseButtonPressed += HandlePurchaseButtonPressed;
		}
		PromoActionsManager.EventAmazonX3Updated += OnEventX3AmazonBonusUpdated;
		HashSet<string> hashSet = new HashSet<string>();
		hashSet.Add("7FFC6ACA-F568-46C3-86AD-8A4FA2DF4401");
		HashSet<string> hashSet2 = hashSet;
		_debugOptionsEnabled = hashSet2.Contains(SystemInfo.deviceUniqueIdentifier);
		bankView.freeAwardButton.gameObject.SetActive(false);
	}

	private void OnEventX3Updated()
	{
		if (_bankViewCurrent != null)
		{
			InterfaceEnabled = true;
		}
	}

	private void OnEventX3AmazonBonusUpdated()
	{
		if (!(_bankViewCurrent == null) && !(_bankViewCurrent.eventX3AmazonBonusWidget == null))
		{
			GameObject gameObject = _bankViewCurrent.eventX3AmazonBonusWidget.gameObject;
			gameObject.SetActive(PromoActionsManager.sharedManager.IsAmazonEventX3Active);
		}
	}

	private void OnGUI()
	{
		if (InterfaceEnabled && _debugOptionsEnabled)
		{
			float num = 11f * Defs.Coef;
			float width = 212f * Defs.Coef;
			float height = 64f * Defs.Coef;
			if (GUI.Button(new Rect(num, num, width, height), "Add Coins: " + 67))
			{
				int @int = Storager.getInt("Coins", false);
				Storager.setInt("Coins", @int + 67, false);
			}
		}
	}

	private void Update()
	{
		if (!InterfaceEnabled)
		{
			_escapePressed = false;
			return;
		}
			bankView.freeAwardButton.gameObject.SetActive(true);
		UpdateBankView(bankViewCommon);
		UpdateBankView(bankViewX3);
		EventHandler escapePressed = this.EscapePressed;
		if (_escapePressed && escapePressed != null)
		{
			escapePressed(this, EventArgs.Empty);
			_escapePressed = false;
		}
		else if (Input.GetKeyUp(KeyCode.Escape))
		{
			Input.ResetInputAxes();
			_escapePressed = true;
		}
	}

	private void UpdateBankView(BankView bankView)
	{
		if (bankView == null || !bankView.gameObject.activeSelf)
		{
			return;
		}
		if (coinsShop.IsCheater)
		{
			bankView.ConnectionProblemLabelEnabled = false;
			bankView.CrackersWarningLabelEnabled = true;
			bankView.NotEnoughCoinsLabelEnabled = false;
			bankView.NotEnoughGemsLabelEnabled = false;
			bankView.PurchaseButtonsEnabled = false;
			bankView.PurchaseSuccessfulLabelEnabled = false;
		}
		else
		{
			if (!(coinsShop.thisScript != null))
			{
				return;
			}
			bankView.NotEnoughCoinsLabelEnabled = coinsShop.thisScript.notEnoughCurrency != null && coinsShop.thisScript.notEnoughCurrency.Equals("Coins");
			bankView.NotEnoughGemsLabelEnabled = coinsShop.thisScript.notEnoughCurrency != null && coinsShop.thisScript.notEnoughCurrency.Equals("GemsCurrency");
			if (coinsShop.thisScript._purchaseActivityIndicator != null)
			{
				coinsShop.thisScript._purchaseActivityIndicator.SetActive(StoreKitEventListener.purchaseInProcess);
			}
			bool isBillingSupported = coinsShop.IsBillingSupported;
			if (coinsShop.IsNoConnection)
			{
				if (Time.realtimeSinceStartup - tmOfFirstEnterTheBank > 3f)
				{
					bankView.ConnectionProblemLabelEnabled = true;
				}
				bankView.NotEnoughCoinsLabelEnabled = false;
				bankView.NotEnoughGemsLabelEnabled = false;
				bankView.PurchaseButtonsEnabled = false;
				bankView.PurchaseSuccessfulLabelEnabled = false;
			}
			else
			{
				bankView.ConnectionProblemLabelEnabled = false;
				bankView.PurchaseButtonsEnabled = true;
			}
			bankView.PurchaseSuccessfulLabelEnabled = coinsShop.thisScript.ProductPurchasedRecently;
		}
	}

	private void OnDestroy()
	{
		PromoActionsManager.EventX3Updated -= OnEventX3Updated;
		PromoActionsManager.EventAmazonX3Updated -= OnEventX3AmazonBonusUpdated;
		if (bankViewCommon != null)
		{
			bankViewCommon.PurchaseButtonPressed -= HandlePurchaseButtonPressed;
		}
		if (bankViewX3 != null)
		{
			bankViewX3.PurchaseButtonPressed -= HandlePurchaseButtonPressed;
		}
	}

	private void HandlePurchaseButtonPressed(object sender, PurchaseEventArgs e)
	{
		Debug.Log("Bank button pressed: " + e);
		if (StoreKitEventListener.purchaseInProcess)
		{
			Debug.Log("Cannot perform request while purchase is in progress.");
		}
		if (coinsShop.thisScript != null)
		{
			coinsShop.thisScript.HandlePurchaseButton(e.Index, e.Currency);
		}
	}

	private static string ClampCoinCount(int coinCount)
	{
		return coinCount.ToString();
	}

	public static void AddCoins(int count)
	{
		int @int = Storager.getInt("Coins", false);
		Storager.setInt("Coins", @int + count, false);
		CoinsMessage.FireCoinsAddedEvent(false);
	}

	public static void AddGems(int count)
	{
		int @int = Storager.getInt("GemsCurrency", false);
		Storager.setInt("GemsCurrency", @int + count, false);
		CoinsMessage.FireCoinsAddedEvent(true);
	}

	public void FreeAwardButtonClick()
	{
		if (FreeAwardController.Instance.AdvertCountLessThanLimit())
		{
			FreeAwardController.Instance.SetWatchState();
		}
	}
}
