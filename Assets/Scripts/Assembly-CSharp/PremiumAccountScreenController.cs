using System;
using System.Collections.Generic;
using UnityEngine;

public class PremiumAccountScreenController : MonoBehaviour
{
	public GameObject tapToActivate;

	public GameObject window;

	public UIButton[] rentButtons;

	public List<UILabel> headerLabels;

	public static PremiumAccountScreenController Instance;

	private bool ranksBefore;

	public string Header { get; set; }

	private bool InitialFreeAvailable
	{
		get
		{
			return Storager.getInt("PremiumInitialFree1Day", false) == 0;
		}
	}

	private void Start()
	{
		if (Application.loadedLevelName.Equals(Defs.MainMenuScene) && ExperienceController.sharedController != null)
		{
			ranksBefore = ExperienceController.sharedController.isShowRanks;
			ExperienceController.sharedController.isShowRanks = false;
		}
		UpdateFreeButtons();
		for (int i = 0; i < rentButtons.Length; i++)
		{
			foreach (Transform item in rentButtons[i].transform)
			{
				if (item.name.Equals("GemsIcon"))
				{
					PremiumAccountController.AccountType accountType = (PremiumAccountController.AccountType)i;
					string key = accountType.ToString();
					ItemPrice itemPrice = VirtualCurrencyHelper.Price(key);
					UILabel component = item.GetChild(0).GetComponent<UILabel>();
					component.text = itemPrice.Price.ToString();
					break;
				}
			}
		}
		Instance = this;
	}

	private void LogBuyAccount(string context)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("Type", context);
		Dictionary<string, string> dictionary2 = dictionary;
		if (ExperienceController.sharedController != null)
		{
			dictionary2.Add("Level", ExperienceController.sharedController.currentLevel.ToString());
		}
		if (ExpController.Instance != null)
		{
			dictionary2.Add("Tier", ExpController.Instance.OurTier.ToString());
		}
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Premium Account Buy", dictionary2);
	}

	public void HandleRentButtonPressed(UIButton button)
	{
		PremiumAccountController.AccountType accType = (PremiumAccountController.AccountType)Array.IndexOf(rentButtons, button);
		ItemPrice price = VirtualCurrencyHelper.Price(accType.ToString());
		Action<PremiumAccountController.AccountType> provideAcc = delegate(PremiumAccountController.AccountType at)
		{
			if (PremiumAccountController.Instance != null)
			{
				PremiumAccountController.Instance.BuyAccount(at);
			}
			UpdateFreeButtons();
		};
		if (InitialFreeAvailable && accType == PremiumAccountController.AccountType.OneDay)
		{
			SetInitialFreeUsed();
			provideAcc(accType);
			Hide();
			return;
		}
		ShopNGUIController.TryToBuy(window, price, delegate
		{
			provideAcc(accType);
			LogBuyAccount(accType.ToString());
			if (InitialFreeAvailable)
			{
				SetInitialFreeUsed();
				provideAcc(PremiumAccountController.AccountType.OneDay);
			}
			Hide();
		});
	}

	public void Hide()
	{
		UnityEngine.Object.Destroy(base.gameObject);
	}

	private void UpdateFreeButtons()
	{
		bool initialFreeAvailable = InitialFreeAvailable;
		foreach (Transform item in rentButtons[0].transform)
		{
			if (item.name.Equals("Free"))
			{
				item.gameObject.SetActive(initialFreeAvailable);
			}
			if (item.name.Equals("GemsIcon"))
			{
				item.gameObject.SetActive(!initialFreeAvailable);
			}
		}
		tapToActivate.SetActive(initialFreeAvailable);
	}

	private void SetInitialFreeUsed()
	{
		Storager.setInt("PremiumInitialFree1Day", 1, false);
	}

	private void OnDestroy()
	{
		Instance = null;
		if (Application.loadedLevelName.Equals(Defs.MainMenuScene) && ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.isShowRanks = ranksBefore;
		}
	}
}
