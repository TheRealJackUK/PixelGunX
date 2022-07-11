using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Rilisoft;
using UnityEngine;

internal sealed class DeveloperConsoleController : MonoBehaviour
{
	public DeveloperConsoleView view;

	public static bool isDebugGuiVisible;

	private bool? _enemiesInCampaignDirty;

	private bool _backRequested;

	private bool _initialized;

	private bool _needsRestart;

	public void HandleBackButton()
	{
		_backRequested = true;
	}

	public void HandleClearKeychainAndPlayerPrefs()
	{
		Debug.Log("[Clear Keychain] pressed.");
		PlayerPrefs.DeleteAll();
		Application.Quit();
	}

	public void HandleLevelMinusButton()
	{
		if (ExperienceController.sharedController != null)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			if (currentLevel != ExperienceController.maxLevel)
			{
				int num = currentLevel - 1;
				Storager.setInt("currentLevel" + num, 1, true);
				PlayerPrefs.SetInt("currentLevel", num);
				ExperienceController.sharedController.Refresh();
				view.LevelLabel = "Level: " + num;
				RefreshExperience();
			}
		}
	}

	public void HandleLevelPlusButton()
	{
		if (ExperienceController.sharedController != null)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			if (currentLevel != ExperienceController.maxLevel)
			{
				int num = currentLevel + 1;
				Storager.setInt("currentLevel" + num, 1, true);
				PlayerPrefs.SetInt("currentLevel", num);
				ExperienceController.sharedController.Refresh();
				view.LevelLabel = "Level: " + num;
				RefreshExperience();
			}
		}
	}

	public void HandleCoinsInputSubmit(UIInput input)
	{
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			Storager.setInt("Coins", result, false);
		}
	}

	public void HandleEnemyCountInSurvivalWaveInput(UIInput input)
	{
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			ZombieCreator.EnemyCountInSurvivalWave = result;
		}
	}

	public void HandleEnemiesInCampaignChange()
	{
		if (_enemiesInCampaignDirty.HasValue)
		{
			_enemiesInCampaignDirty = true;
		}
	}

	public void HandleEnemiesInCampaignInput(UIInput input)
	{
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			GlobalGameController.EnemiesToKill = result;
		}
	}

	public void HandleTrainingCompleteChanged(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			int val = Convert.ToInt32(toggle.value);
			Storager.setInt(Defs.TrainingCompleted_4_4_Sett, val, false);
			Defs.isTrainingFlag = Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false) == 0;
		}
	}

	public void HandleSet60FpsChanged(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			if (toggle.value)
			{
				Application.targetFrameRate = 240;
			}
			else
			{
				Application.targetFrameRate = 30;
			}
		}
	}

	public void HandleMouseControlChanged(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			Defs.isMouseControl = toggle.value;
		}
	}

	public void HandleSpectatorMode(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			Defs.isRegimVidosDebug = toggle.value;
		}
	}

	public void HandleTempGunChanged(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			if (toggle.value)
			{
				TempItemsController.sharedController.AddTemporaryItem(WeaponTags.Impulse_Sniper_Rifle_Tag, 60);
			}
			else
			{
				WeaponManager.sharedManager.RemoveTemporaryItem(WeaponTags.Impulse_Sniper_Rifle_Tag);
			}
		}
	}

	public void HandleIpadMiniRetinaChanged(UIToggle toggle)
	{
		if (!(toggle == null) && _initialized)
		{
			int value = Convert.ToInt32(toggle.value);
			PlayerPrefs.SetInt("Dev.ResolutionDowngrade", value);
			_needsRestart = true;
		}
	}

	public void HandleIsPayingChanged(UIToggle toggle)
	{
		if (!(toggle == null) && _initialized)
		{
			if (toggle.value)
			{
				Storager.setString("AdvertCountDuringCurrentPeriod", "{}", false);
				StoreKitEventListener.SetLastPaymentTime();
				Storager.setInt("PayingUser", 1, true);
			}
			else
			{
				PlayerPrefs.DeleteKey("Last Payment Time");
				PlayerPrefs.DeleteKey("Last Payment Time (Advertisement)");
				Storager.setInt("PayingUser", 0, true);
			}
		}
	}

	public void HandleIsDebugGuiVisibleChanged(UIToggle toggle)
	{
		if (!(toggle == null) && _initialized)
		{
			isDebugGuiVisible = toggle.value;
		}
	}

	public void HandleForcedEventX3Changed(UIToggle toggle)
	{
		if (!(toggle == null) && _initialized)
		{
			PromoActionsManager.isEventX3Forced = toggle.value;
		}
	}

	public void HandleAdIdCanged(UIToggle toggle)
	{
		if (!(toggle == null) && _initialized)
		{
		}
	}

	public void HandleClearPurchasesButton()
	{
		Debug.Log("[Clear Purchases] clicked.");
		_needsRestart = true;
		Dictionary<string, string>.ValueCollection values = WeaponManager.storeIDtoDefsSNMapping.Values;
		List<string> list = new List<string>();
		foreach (KeyValuePair<ShopNGUIController.CategoryNames, List<List<string>>> item in Wear.wear)
		{
			foreach (List<string> item2 in item.Value)
			{
				list.AddRange(item2);
			}
		}
		IEnumerable<string> second = InAppData.inAppData.Values.Select((KeyValuePair<string, string> kv) => kv.Value);
		string[] second2 = new string[6]
		{
			Defs.SkinsMakerInProfileBought,
			Defs.hungerGamesPurchasedKey,
			Defs.CaptureFlagPurchasedKey,
			Defs.smallAsAntKey,
			Defs.code010110_Key,
			Defs.UnderwaterKey
		};
		IEnumerable<string> enumerable = from id in values.Concat(list).Concat(second).Concat(second2)
			where Storager.getInt(id, false) != 0
			select id;
		foreach (string item3 in enumerable)
		{
			Storager.setInt(item3, 0, false);
		}
		Storager.setString(Defs.MultiplayerWSSN, WeaponManager.sharedManager._KnifeAndPistolAndMP5AndSniperAndRocketnitzaSet(), false);
		Storager.setString(Defs.CampaignWSSN, WeaponManager.sharedManager._KnifeAndPistolAndShotgunSet(), false);
		Storager.setString(Defs.ArmorNewEquppedSN, Defs.ArmorNewNoneEqupped, false);
		Storager.setString(Defs.HatEquppedSN, Defs.HatNoneEqupped, false);
		Storager.setString(Defs.CapeEquppedSN, Defs.CapeNoneEqupped, false);
		Storager.setString(Defs.BootsEquppedSN, Defs.BootsNoneEqupped, false);
		string[] gear = GearManager.Gear;
		foreach (string text in gear)
		{
			for (int j = 1; j <= GearManager.NumOfGearUpgrades; j++)
			{
				Storager.setInt(GearManager.NameForUpgrade(text, j), 0, false);
			}
			Storager.setInt(text, 0, false);
		}
		StarterPackController.Get.ClearAllGooglePurchases();
	}

	public void HandleClearProgressButton()
	{
		CampaignProgress.boxesLevelsAndStars.Clear();
		CampaignProgress.boxesLevelsAndStars.Add(LevelBox.campaignBoxes[0].name, new Dictionary<string, int>());
		CampaignProgress.SaveCampaignProgress();
		Storager.setString(Defs.WeaponsGotInCampaign, string.Empty, false);
		Storager.setString(Defs.LevelsWhereGetCoinS, string.Empty, false);
	}

	public void HandleFillProgressButton()
	{
		CampaignProgress.boxesLevelsAndStars.Clear();
		int num = LevelBox.campaignBoxes.Count - 1;
		for (int i = 0; i < num; i++)
		{
			int starCount = ((i >= num - 1) ? 1 : 3);
			LevelBox levelBox = LevelBox.campaignBoxes[i];
			Dictionary<string, int> value = levelBox.levels.ToDictionary((CampaignLevel l) => l.sceneName, (CampaignLevel _) => starCount);
			CampaignProgress.boxesLevelsAndStars.Add(levelBox.name, value);
		}
		CampaignProgress.SaveCampaignProgress();
	}

	public void HandleClearCloud()
	{
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			PlayerPrefs.SetInt("WantToResetKeychain", 1);
			PlayerPrefs.Save();
			if (!Application.isEditor)
			{
				Application.Quit();
			}
		}
		else if (BuildSettings.BuildTarget == BuildTarget.Android)
		{
			CloudCleaner.Instance.CleanSlot(0);
			CloudCleaner.Instance.CleanSlot(1);
			CloudCleaner.Instance.CleanSavedGameFile("Purchases");
			CloudCleaner.Instance.CleanSavedGameFile("Progress");
		}
	}

	public void HandleUnbanUs(UIButton butt)
	{
		if (FriendsController.sharedController != null)
		{
			FriendsController.sharedController.UnbanUs(delegate
			{
				butt.GetComponent<UISprite>().spriteName = "green_btn";
				FriendsController.sharedController.Banned = 0;
			});
		}
	}

	public void HandleClearX3()
	{
		PlayerPrefs.SetInt(Defs.EventX3WindowShownCount, 1);
		PlayerPrefs.SetString(Defs.EventX3WindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
		PlayerPrefs.SetInt(Defs.AdvertWindowShownCount, 3);
		PlayerPrefs.SetString(Defs.AdvertWindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
	}

	private void RefreshExperience()
	{
		int currentLevel = PlayerPrefs.GetInt("currentLevel");;
		int num = ExperienceController.MaxExpLevels[currentLevel];
		int num2 = Mathf.Clamp(Convert.ToInt32(view.ExperiencePercentage * (float)num), 0, num - 1);
		float experiencePercentage = (float)num2 / (float)num;
		view.ExperienceLabel = "Exp: " + num2 + '/' + num;
		view.ExperiencePercentage = experiencePercentage;
		Storager.setInt("currentExperience", num2, false);
		ExperienceController.sharedController.Refresh();
		if (ExpController.Instance != null)
		{
			ExpController.Instance.Refresh();
		}
	}

	public void HandleExperienceSliderChanged()
	{
		if (ExperienceController.sharedController != null)
		{
			RefreshExperience();
		}
	}

	public void HandleSignInOuButton(UILabel socialUsernameLabel)
	{
		if (Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GoogleLite && Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GooglePro)
		{
			return;
		}
			if (socialUsernameLabel != null)
			{
				socialUsernameLabel.text = string.Empty;
			}
			return;
		Debug.Log("Signing in...");
	}

	public void SetMarathonTestMode(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			PlayerPrefs.SetInt(Defs.MarathonTestMode, toggle.value ? 1 : 0);
		}
	}

	public void SetMarathonCurrentDay(UIInput input)
	{
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			Storager.setInt(Defs.NextMarafonBonusIndex, result, false);
			MarafonBonusController.Get.SetCurrentBonusIndex(result);
		}
	}

	public void SetOffGameGUIMode(UIToggle toggle)
	{
		if (!(toggle == null))
		{
			PlayerPrefs.SetInt(Defs.GameGUIOffMode, toggle.value ? 1 : 0);
			PlayerPrefs.Save();
		}
	}

	public void ClearStarterPackData()
	{
		StarterPackController.Get.ClearStarterPackData();
	}

	private void Refresh()
	{
		if (view == null)
		{
			throw new InvalidOperationException();
		}
		if (ExperienceController.sharedController != null)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			int num = ExperienceController.MaxExpLevels[currentLevel];
			int currentExperience = ExperienceController.sharedController.CurrentExperience;
			view.LevelLabel = "Level: " + currentLevel;
			view.ExperienceLabel = "Exp: " + currentExperience + '/' + num;
			view.ExperiencePercentage = (float)currentExperience / (float)num;
		}
		view.CoinsInput = Storager.getInt("Coins", false);
		view.GemsInput = Storager.getInt("GemsCurrency", false);
		view.EnemiesInSurvivalWaveInput = ZombieCreator.EnemyCountInSurvivalWave;
		view.EnemiesInCampaignInput = GlobalGameController.EnemiesToKill;
		int @int = Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false);
		view.TrainingCompleted = Convert.ToBoolean(@int);
		view.TempGunActive = TempItemsController.sharedController.ContainsItem(WeaponTags.Impulse_Sniper_Rifle_Tag);
		view.Set60FPSActive = Application.targetFrameRate == 60;
		view.IsPayingUser = FlurryPluginWrapper.IsPayingUser();
		view.isDebugGuiVisibleCheckbox.value = isDebugGuiVisible;
		view.SetMouseControll = Defs.isMouseControl;
		view.SetSpectatorMode = Defs.isRegimVidosDebug;
		string @string = PlayerPrefs.GetString("RemotePushNotificationToken", string.Empty);
		if (string.IsNullOrEmpty(@string))
		{
			view.DevicePushTokenInput = "None";
		}
		else
		{
			view.DevicePushTokenInput = @string;
		}
		view.PlayerIdInput = ((!(FriendsController.sharedController != null)) ? "None" : FriendsController.sharedController.id);
		view.isEventX3ForcedCheckbox.value = PromoActionsManager.isEventX3Forced;
		view.starterPackLive.text = StarterPackModel.MaxLiveTimeEvent.TotalMinutes.ToString();
		view.starterPackCooldown.text = StarterPackModel.CooldownTimeEvent.TotalMinutes.ToString();
		PremiumAccountController instance = PremiumAccountController.Instance;
		view.oneDayPreminAccount.value = instance.oneDayAccountLive.ToString();
		view.threeDayPreminAccount.value = instance.threeDayAccountLive.ToString();
		view.sevenDayPreminAccount.value = instance.sevenDayAccountLive.ToString();
		view.monthDayPreminAccount.value = instance.monthDayAccountLive.ToString();
	}

	private void Awake()
	{
		if (view != null)
		{
			if (view.set60FpsCheckbox != null)
			{
				view.set60FpsCheckbox.startsActive = Application.targetFrameRate == 240;
			}
			if (view.tempGunCheckbox != null)
			{
			//	view.tempGunCheckbox.startsActive = TempItemsController.sharedController.ContainsItem(WeaponTags.Impulse_Sniper_Rifle_Tag);
			}
			int @int = Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false);
			if (view.trainingCheckbox != null)
			{
				view.trainingCheckbox.startsActive = Convert.ToBoolean(@int);
			}
			if (view.downgradeResolutionCheckbox != null)
			{
				view.downgradeResolutionCheckbox.startsActive = Convert.ToBoolean(PlayerPrefs.GetInt("Dev.ResolutionDowngrade", 1));
			}
			if (view.isPayingCheckbox != null)
			{
				view.isPayingCheckbox.startsActive = FlurryPluginWrapper.IsPayingUser();
			}
			if (view.deviceInfo != null)
			{
				view.deviceInfo.text = string.Format("{0} {{ Memory: {1}Mb }}  W: {2}  {3}\r\n{4}", SystemInfo.deviceModel, SystemInfo.systemMemorySize, Screen.width, "Q: " + QualitySettings.GetQualityLevel(), Device.FormatGpuModelMemoryRating());
			}
			if (view.marathonTestMode != null)
			{
				view.MarathonTestMode = PlayerPrefs.GetInt(Defs.MarathonTestMode, 0) == 1;
			}
			if (view.marathonCurrentDay != null)
			{
				view.MarathonDayInput = Storager.getInt(Defs.NextMarafonBonusIndex, false);
			}
			if (view.gameGUIOffMode != null)
			{
				view.GameGUIOffMode = PlayerPrefs.GetInt(Defs.GameGUIOffMode, 0) == 1;
			}
		}
	}

	private IEnumerator Start()
	{
		if (view != null)
		{
			Refresh();
		}
		_enemiesInCampaignDirty = false;
		yield return null;
		_initialized = true;
	}

	public void ChangePremiumAccountLiveTime(UIInput input)
	{
		PremiumAccountController.AccountType accountType = PremiumAccountController.AccountType.None;
		switch (input.name)
		{
		case "OneDayInput":
			accountType = PremiumAccountController.AccountType.OneDay;
			break;
		case "ThreeDayInput":
			accountType = PremiumAccountController.AccountType.ThreeDay;
			break;
		case "SevenDayInput":
			accountType = PremiumAccountController.AccountType.SevenDays;
			break;
		case "MonthDayInput":
			accountType = PremiumAccountController.AccountType.Month;
			break;
		}
		double result = 0.0;
		if (double.TryParse(input.value, out result))
		{
			PremiumAccountController.Instance.CheatChangeTimeLiveAccount(accountType, result);
		}
	}

	public void ClearAllPremiumAccounts()
	{
		PremiumAccountController.Instance.CheatStopAllAccounts();
	}

	public void ClearCurrentPremiumAccont()
	{
		PremiumAccountController.Instance.CheatRemoveCurrentAccount();
	}

	private void HandleGemsInputSubmit(UIInput input)
	{
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			Storager.setInt("GemsCurrency", result, false);
		}
	}

	private void Update()
	{
		if (_backRequested)
		{
			_backRequested = false;
			HandleCoinsInputSubmit(view.coinsInput);
			HandleGemsInputSubmit(view.gemsInput);
			HandleEnemyCountInSurvivalWaveInput(view.enemyCountInSurvivalWave);
			if (_enemiesInCampaignDirty.HasValue && _enemiesInCampaignDirty.Value)
			{
				HandleEnemiesInCampaignInput(view.enemiesInCampaignInput);
			}
			if (_needsRestart)
			{
				Application.Quit();
			}
			else
			{
				Application.LoadLevel(Defs.MainMenuScene);
			}
		}
	}

	private void LateUpdate()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_backRequested = true;
		}
	}

	public void OnChangeStarterPackLive(UIInput inputField)
	{
		if (!(inputField == null) && !string.IsNullOrEmpty(inputField.value))
		{
			float result = 0f;
			float.TryParse(inputField.value, out result);
			if (result > 0f)
			{
				StarterPackModel.MaxLiveTimeEvent = TimeSpan.FromMinutes(result);
			}
		}
	}

	public void OnChangeStarterPackCooldown(UIInput inputField)
	{
		if (!(inputField == null) && !string.IsNullOrEmpty(inputField.value))
		{
			float result = 0f;
			float.TryParse(inputField.value, out result);
			if (result > 0f)
			{
				StarterPackModel.CooldownTimeEvent = TimeSpan.FromMinutes(result);
			}
		}
	}
}
