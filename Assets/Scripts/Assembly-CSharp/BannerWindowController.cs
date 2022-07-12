using System;
using System.Collections.Generic;
using Rilisoft;
using UnityEngine;

public class BannerWindowController : MonoBehaviour
{
	private const int BannerWindowCount = 10;

	private const float StartBannerShowDelay = 3f;

	public BannerWindow[] bannerWindows;

	public static bool needSorryBunner;

	public static bool needSorryWeaponAndArmorBanner;

	[NonSerialized]
	public AdvertisementController advertiseController;

	private Queue<BannerWindow> _bannerQueue;

	private BannerWindow _currentBanner;

	private bool[] _bannerShowed = new bool[10];

	private bool[] _needShowBanner = new bool[10];

	private bool _someBannerShown;

	private float _lastCheckTime;

	private float _whenStart;

	private bool _isBlockShowForNewPlayer;

	public static BannerWindowController SharedController { get; private set; }

	internal bool IsAnyBannerShown
	{
		get
		{
			return _currentBanner != null;
		}
	}

	private void Awake()
	{
		SharedController = this;
	}

	private void Start()
	{
		_currentBanner = null;
		_bannerQueue = new Queue<BannerWindow>();
		_someBannerShown = false;
		_whenStart = Time.realtimeSinceStartup + 3f;
		//FriendsController.sharedController.DownloadInfoByEverydayDelta();
		//StarterPackController.Get.CheckShowStarterPack();
		//StarterPackController.Get.UpdateCountShownWindowByTimeCondition();
		//PromoActionsManager.UpdateDaysOfValorShownCondition();
		//_isBlockShowForNewPlayer = !IsBannersCanShowAfterNewInstall();
	}

	private void OnDestroy()
	{
		SharedController = null;
		_bannerQueue = null;
		advertiseController = null;
	}

	private void OnApplicationPause(bool pause)
	{
		if (!pause)
		{
			StarterPackController.Get.UpdateCountShownWindowByTimeCondition();
//			FriendsController.sharedController.DownloadInfoByEverydayDelta();
			PromoActionsManager.UpdateDaysOfValorShownCondition();
			_isBlockShowForNewPlayer = !IsBannersCanShowAfterNewInstall();
		}
	}

	private BannerWindow ShowBannerWindow(BannerWindowType windowType)
	{
		if (bannerWindows.Length < 0 || (int)windowType > bannerWindows.Length - 1)
		{
			return null;
		}
		if (bannerWindows[(int)windowType] == null)
		{
			return null;
		}
		if (bannerWindows[(int)windowType].gameObject.activeSelf)
		{
			return null;
		}
		BannerWindow bannerWindow = bannerWindows[(int)windowType];
		if (_currentBanner == null)
		{
			_currentBanner = bannerWindow;
			_currentBanner.type = windowType;
			bannerWindow.Show();
		}
		else
		{
			_bannerQueue.Enqueue(bannerWindow);
		}
		return bannerWindow;
	}

	public void HideBannerWindow()
	{
		if (_currentBanner != null)
		{
			_currentBanner.Hide();
			_currentBanner = null;
		}
		if (_bannerQueue.Count > 0)
		{
			(_currentBanner = _bannerQueue.Dequeue()).Show();
		}
	}

	private void ShowAdmobBanner()
	{
		if (!(AdmobPerelivWindow.admobTexture == null) && !string.IsNullOrEmpty(AdmobPerelivWindow.admobUrl))
		{
			ShowBannerWindow(BannerWindowType.Admob);
		}
	}

	public void AdmobBannerExitClick()
	{
		ButtonClickSound.Instance.PlayClick();
		HideBannerWindow();
		_bannerShowed[0] = false;
		_needShowBanner[0] = false;
		ResetStateBannerShowed(BannerWindowType.Admob);
	}

	public void AdmobBannerApplyClick()
	{
		if (AdmobPerelivWindow.Context != null)
		{
			Dictionary<string, string> levelAndTierParameters = FlurryPluginWrapper.LevelAndTierParameters;
			levelAndTierParameters.Add("Context", AdmobPerelivWindow.Context);
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Replace Admob Pereliv Opened", levelAndTierParameters);
		}
		Application.OpenURL(AdmobPerelivWindow.admobUrl);
	}

	private void ShowAdvertisementBanner(AdvertisementController advertisementController)
	{
		if (!(advertisementController.AdvertisementTexture == null))
		{
			advertiseController = advertisementController;
			BannerWindow bannerWindow = ShowBannerWindow(BannerWindowType.Advertisement);
			if (!(bannerWindow == null))
			{
				bannerWindow.SetBackgroundImage(advertisementController.AdvertisementTexture);
				bannerWindow.SetEnableExitButton(PromoActionsManager.Advert.btnClose);
			}
		}
	}

	public void AdvertBannerExitClick()
	{
		ButtonClickSound.Instance.PlayClick();
		advertiseController.Close();
		UpdateAdvertShownCount();
		HideBannerWindow();
	}

	public void NewVersionBannerExitClick()
	{
		ButtonClickSound.Instance.PlayClick();
		UpdateNewVersionShownCount();
		HideBannerWindow();
	}

	private static void UpdateNewVersionShownCount()
	{
		PlayerPrefs.SetInt(Defs.UpdateAvailableShownTimesSN, PlayerPrefs.GetInt(Defs.UpdateAvailableShownTimesSN, 3) - 1);
		PlayerPrefs.SetString(Defs.LastTimeUpdateAvailableShownSN, DateTimeOffset.Now.ToString("s"));
		PlayerPrefs.Save();
	}

	private static void ClearNewVersionShownCount()
	{
		PlayerPrefs.SetInt(Defs.UpdateAvailableShownTimesSN, 0);
		PlayerPrefs.SetString(Defs.LastTimeUpdateAvailableShownSN, DateTimeOffset.Now.ToString("s"));
		PlayerPrefs.Save();
	}

	public void AdvertBannerApplyClick()
	{
		ButtonClickSound.Instance.PlayClick();
		advertiseController.Close();
		UpdateAdvertShownCount();
		Application.OpenURL(PromoActionsManager.Advert.adUrl);
		HideBannerWindow();
	}

	public void NewVersionBannerApplyClick()
	{
		ButtonClickSound.Instance.PlayClick();
		ClearNewVersionShownCount();
		Application.OpenURL(MainMenu.RateUsURL);
		HideBannerWindow();
	}

	public void EverydayRewardApplyClick()
	{
		TakeEverydayRewardForPlayer();
		HideBannerWindow();
	}

	private void TakeEverydayRewardForPlayer()
	{
		NotificationController.isGetEveryDayMoney = false;
		if (MainMenu.sharedMenu != null)
		{
			MainMenu.sharedMenu.isShowAvard = false;
		}
		BankController.GiveInitialNumOfCoins();
		int @int = Storager.getInt("Coins", false);
		Storager.setInt("Coins", @int + 3, false);
		FlurryEvents.LogCoinsGained("Main Menu", 3);
		CoinsMessage.FireCoinsAddedEvent(false);
		AudioClip audioClip = Resources.Load("coin_get") as AudioClip;
		if (audioClip != null && Defs.isSoundFX)
		{
			NGUITools.PlaySound(audioClip);
		}
	}

	public void SorryBannerExitButtonClick()
	{
		MainMenuController.sharedController.stubLoading.SetActive(false);
		HideBannerWindow();
	}

	public void EventX3ExitClick()
	{
		UpdateEventX3ShownCount();
		HideBannerWindow();
	}

	public void EventX3ApplyClick()
	{
		EventX3ExitClick();
		if (MainMenuController.sharedController != null)
		{
			MainMenuController.sharedController.ShowBankWindow();
		}
		else if (ConnectSceneNGUIController.sharedController != null)
		{
			ConnectSceneNGUIController.sharedController.ShowBankWindow();
		}
	}

	private void UpdateEventX3ShownCount()
	{
		PlayerPrefs.SetInt(Defs.EventX3WindowShownCount, PlayerPrefs.GetInt(Defs.EventX3WindowShownCount, 1) - 1);
		PlayerPrefs.Save();
	}

	private void UpdateAdvertShownCount()
	{
		if (!PromoActionsManager.Advert.showAlways)
		{
			PlayerPrefs.SetInt(Defs.AdvertWindowShownCount, PlayerPrefs.GetInt(Defs.AdvertWindowShownCount, 3) - 1);
			PlayerPrefs.SetString(Defs.AdvertWindowShownLastTime, PromoActionsManager.CurrentUnixTime.ToString());
			PlayerPrefs.Save();
		}
	}

	private bool IsBannersCanShowAfterNewInstall()
	{
		if (string.IsNullOrEmpty(Defs.StartTimeShowBannersString))
		{
			return true;
		}
		DateTime result;
		if (!DateTime.TryParse(Defs.StartTimeShowBannersString, out result))
		{
			return true;
		}
		return (DateTime.UtcNow - result).TotalMinutes >= 2.0;
	}

	private void Update()
	{
		if (_isBlockShowForNewPlayer || Time.realtimeSinceStartup < _whenStart || !(Time.realtimeSinceStartup - _lastCheckTime >= 1f))
		{
			return;
		}
		CheckBannersShowConditions();
		for (int i = 0; i < _needShowBanner.Length; i++)
		{
			if ((_someBannerShown && i != 0) || !_needShowBanner[i] || ActivityIndicator.IsLoadingActive())
			{
				continue;
			}
			if (!MainMenuController.IsShowRentExpiredPoint() && (!(MainMenuController.sharedController != null) || (!MainMenuController.sharedController.freePanel.activeSelf && !MainMenuController.sharedController.singleModePanel.activeSelf)) && (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && (i != 8 || !Application.loadedLevelName.Equals("ConnectScene") || !MarafonBonusController.Get.IsBonusTemporaryWeapon()) && (i != 4 || !Application.loadedLevelName.Equals(Defs.MainMenuScene) || Storager.getInt(Defs.ShownLobbyLevelSN, false) >= 3) && FreeAwardController.FreeAwardChestIsInIdleState && !MainMenuController.SavedShwonLobbyLevelIsLessThanActual())
			{
				_needShowBanner[i] = false;
				switch (i)
				{
				case 0:
					ShowAdmobBanner();
					break;
				case 3:
					ShowAdvertisementBanner(advertiseController);
					break;
				default:
					ShowBannerWindow((BannerWindowType)i);
					break;
				}
				_someBannerShown = true;
			}
			break;
		}
		_lastCheckTime = Time.realtimeSinceStartup;
	}

	private void CheckDownloadAdvertisement()
	{
		/*
		if (BuildSettings.BuildTarget == BuildTarget.iPhone)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			PromoActionsManager.AdvertInfo advert = PromoActionsManager.Advert;
			bool flag = advert.minLevel == -1 || currentLevel >= advert.minLevel;
			bool flag2 = advert.maxLevel == -1 || currentLevel <= advert.maxLevel;
			bool flag3 = advert.showAlways || PlayerPrefs.GetInt(Defs.AdvertWindowShownCount, 3) > 0;
			if (advert.enabled && advertiseController.CurrentState == AdvertisementController.State.Idle && flag && flag2 && flag3)
			{
				advertiseController.Run();
			}
		}
		*/
	}

	private bool IsAdvertisementDownloading()
	{
		if (advertiseController == null)
		{
			return false;
		}
		AdvertisementController.State currentState = advertiseController.CurrentState;
		return currentState != 0 && currentState != AdvertisementController.State.Complete && currentState != AdvertisementController.State.Error;
	}

	private void CheckBannersShowConditions()
	{
		if (AdmobPerelivWindow.admobTexture != null && !string.IsNullOrEmpty(AdmobPerelivWindow.admobUrl) && !_bannerShowed[0])
		{
			_bannerShowed[0] = true;
			_needShowBanner[0] = true;
		}
		CheckDownloadAdvertisement();
		if (IsAdvertisementDownloading())
		{
			return;
		}
		if (needSorryBunner && !_bannerShowed[1])
		{
			_bannerShowed[1] = true;
			_needShowBanner[1] = true;
			needSorryBunner = false;
		}
		if (needSorryWeaponAndArmorBanner && !_bannerShowed[2])
		{
			_bannerShowed[2] = true;
			_needShowBanner[2] = true;
			needSorryWeaponAndArmorBanner = false;
		}
		if (PromoActionsManager.Advert.enabled && advertiseController.CurrentState == AdvertisementController.State.Complete && !_bannerShowed[3])
		{
			_bannerShowed[3] = true;
			_needShowBanner[3] = true;
		}
		if (true)
		{
			_bannerShowed[4] = true;
			_needShowBanner[4] = true;
		}
		if (true)
		{
			_bannerShowed[5] = true;
			_needShowBanner[5] = true;
		}
		if (MarafonBonusController.Get.IsAvailable())
		{
			if (MarafonBonusController.Get.IsNeedShow() && !_bannerShowed[8])
			{
				_bannerShowed[8] = true;
				_needShowBanner[8] = true;
			}
		}
		else if (NotificationController.isGetEveryDayMoney && !_bannerShowed[6])
		{
			_bannerShowed[6] = true;
			_needShowBanner[6] = true;
		}
		if (GlobalGameController.NewVersionAvailable && PlayerPrefs.GetInt(Defs.UpdateAvailableShownTimesSN, 3) > 0 && !_bannerShowed[7])
		{
			_bannerShowed[7] = true;
			_needShowBanner[7] = true;
		}
		if (!_bannerShowed[9])
		{
			_bannerShowed[9] = true;
			_needShowBanner[9] = true;
		}
	}

	public void ResetStateBannerShowed(BannerWindowType windowType)
	{
		if (bannerWindows.Length >= 0 && (int)windowType <= bannerWindows.Length - 1)
		{
			_bannerShowed[(int)windowType] = false;
			_someBannerShown = false;
		}
	}

	public bool IsBannerShow(BannerWindowType bannerType)
	{
		if (_currentBanner == null)
		{
			return false;
		}
		return _currentBanner.type == bannerType;
	}

	public void ForceShowBanner(BannerWindowType windowType)
	{
		if (_currentBanner == null)
		{
			ShowBannerWindow(windowType);
		}
		else if (_currentBanner.type != windowType)
		{
			HideBannerWindow();
			ShowBannerWindow(windowType);
		}
	}

	internal void SubmitCurrentBanner()
	{
		if (!(_currentBanner == null))
		{
			_currentBanner.Submit();
		}
	}
}
