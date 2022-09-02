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
	public static bool isPvpOff;

	private bool? _enemiesInCampaignDirty;

	private bool _backRequested;

	private bool _initialized;

	private bool _needsRestart;
	bool can = false;

	public void HandleBackButton()
	{
		#if UNITY_EDITOR
			_backRequested = true;
		#endif
	}

	public void HandleClearKeychainAndPlayerPrefs()
	{
		#if UNITY_EDITOR
		Debug.Log("[Clear Keychain] pressed.");
		Debug.LogError("Deleting all data");
		PlayerPrefs.DeleteAll();
		Application.Quit();
		#endif
	}

	public void HandleForceError()
	{
		#if UNITY_EDITOR
			Application.LoadLevel("FallbackErrorMenu");
		#endif
	}

	public void HandleLevelMinusButton()
	{
		#if UNITY_EDITOR
		if (ExperienceController.sharedController != null && ExperienceController.sharedController.currentLevel > 1)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			int num = currentLevel - 1;
			Storager.setInt("currentLevel" + num, 1, true);
			PlayerPrefs.SetInt("currentLevel", num);
			ExperienceController.sharedController.Refresh();
			view.LevelLabel = "Level: " + num;
			RefreshExperience();
		}
		#endif
	}

	public void HandleLevelPlusButton()
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void HandleCoinsInputSubmit(UIInput input)
	{
		#if UNITY_EDITOR
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			Storager.setInt("Coins", result, false);
		}
		#endif
	}

	public void HandleEnemyCountInSurvivalWaveInput(UIInput input)
	{
		#if UNITY_EDITOR
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			ZombieCreator.EnemyCountInSurvivalWave = result;
		}
		#endif
	}

	public void HandleEnemiesInCampaignChange()
	{
		#if UNITY_EDITOR
		if (_enemiesInCampaignDirty.HasValue)
		{
			_enemiesInCampaignDirty = true;
		}
		#endif
	}

	public void HandleEnemiesInCampaignInput(UIInput input)
	{
		#if UNITY_EDITOR
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			GlobalGameController.EnemiesToKill = result;
		}
		#endif
	}

	public void HandleTrainingCompleteChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null))
		{
			int val = Convert.ToInt32(toggle.value);
			Storager.setInt(Defs.TrainingCompleted_4_4_Sett, val, false);
			Defs.isTrainingFlag = Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false) == 0;
		}
		#endif
	}

	public void HandleSet60FpsChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null))
		{
			if (toggle.value)
			{
				Application.targetFrameRate = 9999;
			} else {
				Application.targetFrameRate = 240;
			}
		}
		#endif
	}

	public void HandleMouseControlChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null))
		{;
			PlayerPrefs.SetInt("isMouseControl", Convert.ToInt32(toggle.value));
			Defs.isMouseControl = Convert.ToBoolean(PlayerPrefs.GetInt("isMouseControl"));
		}
		#endif
	}

	public void HandleSpectatorMode(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null))
		{
			Defs.isRegimVidosDebug = toggle.value;
		}
		#endif
	}

	public void HandleTempGunChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void HandleIpadMiniRetinaChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null) && _initialized)
		{
			int value = Convert.ToInt32(toggle.value);
			PlayerPrefs.SetInt("Dev.ResolutionDowngrade", value);
			_needsRestart = true;
		}
		#endif
	}

	public void HandleIsPayingChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void HandleIsDebugGuiVisibleChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null) && _initialized)
		{
			isDebugGuiVisible = toggle.value;
		}
		#endif
	}

	public void HandleIsPvpOffChanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null) && _initialized)
		{
			if (toggle.value){
				Storager.setInt("weezing", 1, false);
				UnityEngine.Debug.LogError("\"weezing\" set to 1");
			}else{
				Storager.setInt("weezing", 0, false);
				UnityEngine.Debug.LogError("\"weezing\" set to 0");
			}
		}
		#endif
	}

	public void HandleForcedEventX3Changed(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null) && _initialized)
		{
			PromoActionsManager.isEventX3Forced = toggle.value;
		}
		#endif
	}

	public void HandleAdIdCanged(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null) && _initialized)
		{
		}
		#endif
	}

	public void HandleClearPurchasesButton()
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void HandleClearProgressButton()
	{
		#if UNITY_EDITOR
		CampaignProgress.boxesLevelsAndStars.Clear();
		CampaignProgress.boxesLevelsAndStars.Add(LevelBox.campaignBoxes[0].name, new Dictionary<string, int>());
		CampaignProgress.SaveCampaignProgress();
		Storager.setString(Defs.WeaponsGotInCampaign, string.Empty, false);
		Storager.setString(Defs.LevelsWhereGetCoinS, string.Empty, false);
		Debug.LogError("Deleting all data");
		PlayerPrefs.DeleteAll();
		#endif
	}

	public void HandleFillProgressButton()
	{
		#if UNITY_EDITOR
		CampaignProgress.boxesLevelsAndStars.Clear();
		int num = LevelBox.campaignBoxes.Count - 1;
		for (int i = 0; i < num; i++)
		{
			int starCount = ((i >= num - 1) ? 1 : 3);
			LevelBox levelBox = LevelBox.campaignBoxes[i];
			Dictionary<string, int> value = levelBox.levels.ToDictionary((CampaignLevel l) => l.sceneName, (CampaignLevel _) => starCount);
			CampaignProgress.boxesLevelsAndStars.Add(levelBox.name, value);
		}
		Storager.setInt("Coins", int.MaxValue, false);
		Storager.setInt("GemsCurrency", int.MaxValue, false);
		view.CoinsInput = int.MaxValue;
		view.GemsInput = int.MaxValue;
		CampaignProgress.SaveCampaignProgress();
		#endif
	}

	public void HandleClearCloud()
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void HandleUnbanUs(UIButton butt)
	{
		#if UNITY_EDITOR
		if (FriendsController.sharedController != null)
		{
			FriendsController.sharedController.UnbanUs(delegate
			{
				butt.GetComponent<UISprite>().spriteName = "green_btn";
				FriendsController.sharedController.Banned = 0;
			});
		}
		#endif
	}

	public void HandleClearX3()
	{
		#if UNITY_EDITOR
		PlayerPrefs.SetInt(Defs.EventX3WindowShownCount, 1);
		PlayerPrefs.SetString(Defs.EventX3WindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
		PlayerPrefs.SetInt(Defs.AdvertWindowShownCount, 3);
		PlayerPrefs.SetString(Defs.AdvertWindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
		#endif
	}

	private void RefreshExperience()
	{
		#if UNITY_EDITOR
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
		#endif
	}

	private void RefreshFOV()
	{
		#if UNITY_EDITOR
		int currentFOV = Storager.getInt("camerafov", false);
		int num = 179;
		int num2 = Mathf.Clamp(Convert.ToInt32(currentFOV * (float)num), 0, num);
		float fovPercentage = (float)currentFOV / (float)num;
		view.FovLabel = "FOV: " + currentFOV + '/' + num;
		view.FOVPercentage = fovPercentage;
		Debug.Log(currentFOV);
		// Storager.setInt("camerafov", num2, false);
		#endif
	}

	private void RAUFOV()
	{
		#if UNITY_EDITOR
		if (can){
			int currentFOV = Storager.getInt("camerafov", false);
			int num = 179;
			int num2 = Mathf.Clamp(Convert.ToInt32(view.FOVPercentage * (float)num), 0, num);
			float fovPercentage = (float)num2 / (float)num;
			view.FovLabel = "FOV: " + num2 + '/' + num;
			view.FOVPercentage = fovPercentage;
			Storager.setInt("camerafov", num2, false);
			Debug.Log(num2);
		}
		#endif
	}

	public void HandleExperienceSliderChanged()
	{
		#if UNITY_EDITOR
		if (ExperienceController.sharedController != null)
		{
			RefreshExperience();
		}
		#endif
	}
	public void HandleFOVSliderChanged()
	{
		#if UNITY_EDITOR
		{
			RAUFOV();
		}
		#endif
	}

	public void HandleSignInOuButton(UILabel socialUsernameLabel)
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void SetMarathonTestMode(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null))
		{
			PlayerPrefs.SetInt(Defs.MarathonTestMode, toggle.value ? 1 : 0);
		}
		#endif
	}

	public void SetMarathonCurrentDay(UIInput input)
	{
		#if UNITY_EDITOR
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			Storager.setInt(Defs.NextMarafonBonusIndex, result, false);
			MarafonBonusController.Get.SetCurrentBonusIndex(result);
		}
		#endif
	}

	public void SetOffGameGUIMode(UIToggle toggle)
	{
		#if UNITY_EDITOR
		if (!(toggle == null))
		{
			PlayerPrefs.SetInt(Defs.GameGUIOffMode, toggle.value ? 1 : 0);
			PlayerPrefs.Save();
		}
		#endif
	}

	public void ClearStarterPackData()
	{
		#if UNITY_EDITOR
		StarterPackController.Get.ClearStarterPackData();
		#endif
	}

	private void Refresh()
	{
		#if UNITY_EDITOR
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
		view.Set60FPSActive = Application.targetFrameRate == 9999;
		view.IsPayingUser = FlurryPluginWrapper.IsPayingUser();
		view.isDebugGuiVisibleCheckbox.value = isDebugGuiVisible;
		view.isPvpOffCheckbox.value = Storager.getInt("weezing", false)==1;
		view.SetMouseControll = Convert.ToBoolean(PlayerPrefs.GetInt("isMouseControl"));
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
		#endif
	}

	private void Awake()
	{
		#if UNITY_EDITOR
		if (view != null)
		{
			if (view.set60FpsCheckbox != null)
			{
				view.set60FpsCheckbox.startsActive = Application.targetFrameRate == 9999;
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
		#endif
	}

	private IEnumerator Start()
	{
		#if UNITY_EDITOR
		view.setFpsLabel = "Uncap FPS";
		RefreshFOV();
		can = true;
		if (view != null)
		{
			Refresh();
		}
		_enemiesInCampaignDirty = false;
		yield return null;
		_initialized = true;
		#endif
	}

	public void ChangePremiumAccountLiveTime(UIInput input)
	{
		#if UNITY_EDITOR
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
		#endif
	}

	public void ClearAllPremiumAccounts()
	{
		#if UNITY_EDITOR
		PremiumAccountController.Instance.CheatStopAllAccounts();
		#endif
	}

	public void ClearCurrentPremiumAccont()
	{
		#if UNITY_EDITOR
		PremiumAccountController.Instance.CheatRemoveCurrentAccount();
		#endif
	}

	private void HandleGemsInputSubmit(UIInput input)
	{
		#if UNITY_EDITOR
		int result;
		if (!(input == null) && !string.IsNullOrEmpty(input.value) && int.TryParse(input.value, out result))
		{
			Storager.setInt("GemsCurrency", result, false);
		}
		#endif
	}

	private void Update()
	{
		#if UNITY_EDITOR
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
		#endif
	}

	private void LateUpdate()
	{
		#if UNITY_EDITOR
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_backRequested = true;
		}
		#endif
	}

	public void OnChangeStarterPackLive(UIInput inputField)
	{
		#if UNITY_EDITOR
		if (!(inputField == null) && !string.IsNullOrEmpty(inputField.value))
		{
			float result = 0f;
			float.TryParse(inputField.value, out result);
			if (result > 0f)
			{
				StarterPackModel.MaxLiveTimeEvent = TimeSpan.FromMinutes(result);
			}
		}
		#endif
	}

	public void OnChangeStarterPackCooldown(UIInput inputField)
	{
		#if UNITY_EDITOR
		if (!(inputField == null) && !string.IsNullOrEmpty(inputField.value))
		{
			float result = 0f;
			float.TryParse(inputField.value, out result);
			if (result > 0f)
			{
				StarterPackModel.CooldownTimeEvent = TimeSpan.FromMinutes(result);
			}
		}
		#endif
	}
}
