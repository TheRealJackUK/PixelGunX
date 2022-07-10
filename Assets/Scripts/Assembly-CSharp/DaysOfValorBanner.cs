using System;
using UnityEngine;

public class DaysOfValorBanner : BannerWindow
{
	public UILabel buttonApplyLabel;

	public UIWidget multiplyerContainer;

	public UIWidget expContainer;

	public UIWidget coinsContainer;

	public UISprite expMultiplyerSprite;

	public UISprite moneyMultiplyerSprite;

	private void SetButtonApplyText()
	{
		if (Application.loadedLevelName.Equals("ConnectScene"))
		{
			buttonApplyLabel.text = LocalizationStore.Get("Key_0012");
		}
		else
		{
			buttonApplyLabel.text = LocalizationStore.Get("Key_0085");
		}
	}

	private string GetNameSpriteForMultyplayer(int multiplyer)
	{
		return string.Format("{0}x", multiplyer);
	}

	private void SetSettingMultiplyerContainer()
	{
		PromoActionsManager sharedManager = PromoActionsManager.sharedManager;
		if (!(sharedManager == null))
		{
			Transform transform = expContainer.gameObject.transform;
			Transform transform2 = coinsContainer.gameObject.transform;
			transform.localPosition = Vector3.zero;
			transform2.localPosition = Vector3.zero;
			int num = expContainer.width / 2;
			int dayOfValorMultiplyerForExp = sharedManager.DayOfValorMultiplyerForExp;
			int dayOfValorMultiplyerForMoney = sharedManager.DayOfValorMultiplyerForMoney;
			if (dayOfValorMultiplyerForExp > 1 && dayOfValorMultiplyerForMoney > 1)
			{
				transform.gameObject.SetActive(true);
				transform2.gameObject.SetActive(true);
				transform.localPosition = new Vector3(-num, 0f, 0f);
				transform2.localPosition = new Vector3(num, 0f, 0f);
				expMultiplyerSprite.spriteName = GetNameSpriteForMultyplayer(dayOfValorMultiplyerForExp);
				moneyMultiplyerSprite.spriteName = GetNameSpriteForMultyplayer(dayOfValorMultiplyerForMoney);
			}
			else if (dayOfValorMultiplyerForExp > 1)
			{
				transform.gameObject.SetActive(true);
				transform2.gameObject.SetActive(false);
				expMultiplyerSprite.spriteName = GetNameSpriteForMultyplayer(dayOfValorMultiplyerForExp);
			}
			else if (dayOfValorMultiplyerForMoney > 1)
			{
				transform.gameObject.SetActive(false);
				transform2.gameObject.SetActive(true);
				moneyMultiplyerSprite.spriteName = GetNameSpriteForMultyplayer(dayOfValorMultiplyerForMoney);
			}
		}
	}

	private void OnEnable()
	{
		SetButtonApplyText();
		SetSettingMultiplyerContainer();
	}

	public void OnClickApplyButton()
	{
		if (Application.loadedLevelName.Equals("ConnectScene"))
		{
			HideWindow();
			return;
		}
		HideWindow();
		MainMenuController sharedController = MainMenuController.sharedController;
		if (sharedController != null)
		{
			sharedController.OnClickMultiplyerButton();
		}
	}

	public override void Show()
	{
		base.Show();
		PlayerPrefs.SetString("LastTimeShowDaysOfValor", DateTime.UtcNow.ToString("s"));
		PlayerPrefs.Save();
	}

	public void HideWindow()
	{
		if (BannerWindowController.SharedController != null)
		{
			BannerWindowController.SharedController.HideBannerWindow();
		}
		UpdateShownCount();
	}

	private void UpdateShownCount()
	{
		int @int = PlayerPrefs.GetInt("DaysOfValorShownCount", 1);
		PlayerPrefs.SetInt("DaysOfValorShownCount", @int - 1);
		PlayerPrefs.Save();
	}
}
