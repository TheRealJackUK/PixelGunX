using System;
using System.Collections;
using System.Collections.Generic;
using Holoville.HOTween;
using Holoville.HOTween.Core;
using Holoville.HOTween.Plugins;
using Prime31;
using Rilisoft;
using UnityEngine;

internal sealed class MainMenuController : ControlsSettingsBase
{
	[Header("MainMenuController properties")]
	public UIButton premiumButton;

	public GameObject premium;

	public GameObject daysOfValor;

	public GameObject adventureButton;

	public GameObject achievementsButton;

	public GameObject clansButton;

	public GameObject leadersButton;

	public UILabel battleNowLabel;

	public UILabel trainingNowLabel;

	public UILabel premiumTime;

	public GameObject premiumUpPlashka;

	public GameObject premiumbottomPlashka;

	public List<GameObject> premiumLevels = new List<GameObject>();

	public GameObject starParticleStarterPackGaemObject;

	public Transform RentExpiredPoint;

	public Transform pers;

	public GameObject completeTraining;

	public GameObject stubLoading;

	public UITexture stubTexture;

	public MainMenuHeroCamera rotateCamera;

	public static MainMenuController sharedController;

	public GameObject campaignButton;

	public GameObject survivalButton;

	public GameObject multiplayerButton;

	public GameObject skinsMakerButton;

	public GameObject friendsButton;

	public GameObject profileButton;

	public GameObject freeButton;

	public GameObject youtubeButton;

	public GameObject everyplayButton;

	public GameObject gameCenterButton;

	public GameObject shopButton;

	public GameObject settingsButton;

	public GameObject supportButton;

	public GameObject supportPanel;

	public GameObject enderManButton;

	public GameObject coinsShopButton;

	public GameObject diclineButton;

	public GameObject agreeButton;

	public GameObject UserAgreementPanel;

	public UISprite newMessagesSprite;

	public GameObject postFacebookButton;

	public GameObject postTwitterButton;

	public GameObject rateUsButton;

	public GameObject backFromFreeButton;

	public GameObject twitterSubcribeButton;

	public GameObject facebookSubcribeButton;

	public GameObject freePanel;

	public GameObject mainPanel;

	public GameObject PromoActionsPanel;

	public UIToggle notShowAgain;

	public UILabel coinsLabel;

	public GameObject award800to810;

	public UIButton awardOk;

	public GameObject bannerContainer;

	public GameObject nicknameLabel;

	public UIButton developerConsole;

	public UICamera uiCamera;

	public GameObject eventX3Window;

	public UILabel[] eventX3RemainTime;

	private float _eventX3RemainTimeLastUpdateTime;

	private AdvertisementController _advertisementController;

	private ShopNGUIController _shopInstance;

	private bool isMultyPress;

	private bool isFriendsPress;

	private bool loadReplaceAdmobPerelivRunning;

	private bool loadAdmobRunning;

	private float _lastTimeInterstitialShown;

	private static bool _drawLoadingProgress = true;

	[NonSerialized]
	public GameObject freeAwardChestObj;

	private static bool _socialNetworkingInitilized;

	private Rect campaignRect;

	private Rect survivalRect;

	private Rect shopRect;

	public TweenColor colorBlinkForX3;

	private string _localizeSaleLabel;

	private float _timePremiumTimeUpdated;

	private readonly Rilisoft.Lazy<bool> _timeTamperingDetected = new Rilisoft.Lazy<bool>(delegate
	{
		bool flag = FreeAwardController.Instance.TimeTamperingDetected();
		if (flag)
		{
			Debug.LogWarning("FreeAwardController: time tampering detected in MainMenu.");
		}
		return flag;
	});

	private float lastTime;

	private float idleTimerLastTime;

	private float _bankEnteredTime;

	private MenuLeaderboardsController _menuLeaderboardsController;

	public UIPanel starterPackPanel;

	public UILabel starterPackTimer;

	public UITexture buttonBackground;

	private bool _starterPackEnabled;

	public UIWidget dayOfValorContainer;

	public UILabel dayOfValorTimer;

	private bool _dayOfValorEnabled;

	public GameObject singleModePanel;

	public UILabel singleModeBestScores;

	public UILabel singleModeStarsProgress;

	private Transform _parentBankPanel;

	public static string RateUsURL
	{
		get
		{
			string result = Defs2.ApplicationUrl;
			if (BuildSettings.BuildTarget == BuildTarget.Android)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite)
				{
					result = "https://play.google.com/store/apps/details?id=com.pixel.gun3d&hl=en";
				}
				else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
				{
					result = "https://play.google.com/store/apps/details?id=com.pixelgun3d.pro&hl=en";
				}
			}
			return result;
		}
	}

	private string _SocialMessage()
	{
		string applicationUrl = Defs2.ApplicationUrl;
		return "Come and play with me in epic multiplayer shooter - Pixel Gun 3D! " + applicationUrl;
	}

	public static bool ShowBannerOrLevelup()
	{
		return (ExperienceController.sharedController != null && ExperienceController.sharedController.isShowNextPlashka) || MainMenu.BlockInterface || Defs.isShowUserAgrement || (BannerWindowController.SharedController != null && BannerWindowController.SharedController.IsAnyBannerShown);
	}

	private void OnApplicationPause(bool pausing)
	{
		if (pausing)
		{
			return;
		}
		bool flag = ReplaceAdmobPerelivController.ReplaceAdmobWithPerelivApplicable() && ReplaceAdmobPerelivController.sharedController != null && FreeAwardController.FreeAwardChestIsInIdleState;
		if (flag)
		{
			ReplaceAdmobPerelivController.IncreaseTimesCounter();
		}
		if (flag && ReplaceAdmobPerelivController.ShouldShowAtThisTime && !loadAdmobRunning)
		{
			StartCoroutine(LoadAndShowReplaceAdmobPereliv("On return from pause to Lobby"));
		}
	}

	private IEnumerator LoadAndShowReplaceAdmobPereliv(string context)
	{
		if (loadReplaceAdmobPerelivRunning)
		{
			yield break;
		}
		try
		{
			loadReplaceAdmobPerelivRunning = true;
			if (!ReplaceAdmobPerelivController.sharedController.DataLoading && !ReplaceAdmobPerelivController.sharedController.DataLoaded)
			{
				ReplaceAdmobPerelivController.sharedController.LoadPerelivData();
			}
			while (!ReplaceAdmobPerelivController.sharedController.DataLoaded)
			{
				if (!ReplaceAdmobPerelivController.sharedController.DataLoading)
				{
					loadReplaceAdmobPerelivRunning = false;
					yield break;
				}
				yield return null;
			}
			yield return new WaitForSeconds(0.5f);
			if (FreeAwardController.FreeAwardChestIsInIdleState && (!(BannerWindowController.SharedController != null) || !BannerWindowController.SharedController.IsAnyBannerShown))
			{
				ReplaceAdmobPerelivController.TryShowPereliv(context);
				ReplaceAdmobPerelivController.sharedController.DestroyImage();
			}
		}
		finally
		{
			loadReplaceAdmobPerelivRunning = false;
		}
	}

	private void OnDestroy()
	{
		PromoActionsManager.EventX3Updated -= OnEventX3Updated;
		StarterPackController.OnStarterPackEnable -= OnStarterPackContainerShow;
		PromoActionsManager.OnDayOfValorEnable -= OnDayOfValorContainerShow;
		LocalizationStore.DelEventCallAfterLocalize(ChangeLocalizeLabel);
		PromoActionClick.Click -= HandlePromoActionClicked;
		SettingsController.ControlsClicked -= base.HandleControlsClicked;
		sharedController = null;
	}

	private void OnGUI()
	{
		if (DeveloperConsoleController.isDebugGuiVisible && GUI.Button(new Rect(100f, 50f, 200f, 100f), "OnAppPause"))
		{
			OnApplicationPause(false);
		}
		if (!Launcher.UsingNewLauncher && _drawLoadingProgress)
		{
			LoadingProgress.Instance.Draw(1f);
		}
	}

	private void InitializeBannerWindow()
	{
		_advertisementController = base.gameObject.GetComponent<AdvertisementController>();
		if (_advertisementController == null)
		{
			_advertisementController = base.gameObject.AddComponent<AdvertisementController>();
		}
		BannerWindowController.SharedController.advertiseController = _advertisementController;
	}

	private void CheckIfPendingAward()
	{
		if (Storager.hasKey("PendingFreeAward"))
		{
			int @int = Storager.getInt("PendingFreeAward", false);
			if (@int > 0)
			{
				int num = FreeAwardController.Instance.GiveAwardAndIncrementCount();
				Storager.setInt("PendingInterstitial", 0, false);
				Dictionary<string, string> dictionary = new Dictionary<string, string>();
				dictionary.Add("Context", "FreeAwardVideo");
				Dictionary<string, string> dictionary2 = dictionary;
				dictionary2.Add("Device", SystemInfo.deviceModel);
				dictionary2.Add("Provider", @int.ToString());
				if (ExperienceController.sharedController != null)
				{
					dictionary2.Add("Level", ExperienceController.sharedController.currentLevel.ToString());
				}
				if (ExpController.Instance != null)
				{
					dictionary2.Add("Tier", ExpController.Instance.OurTier.ToString());
				}
				FlurryPluginWrapper.LogEventAndDublicateToConsole("Crash on advertising", dictionary2);
			}
		}
		if (!Storager.hasKey("PendingInterstitial"))
		{
			return;
		}
		int int2 = Storager.getInt("PendingInterstitial", false);
		if (int2 > 0)
		{
			Storager.setInt("PendingInterstitial", 0, false);
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Context", "Interstitial");
			Dictionary<string, string> dictionary3 = dictionary;
			dictionary3.Add("Device", SystemInfo.deviceModel);
			dictionary3.Add("Provider", int2.ToString());
			if (ExperienceController.sharedController != null)
			{
				dictionary3.Add("Level", ExperienceController.sharedController.currentLevel.ToString());
			}
			if (ExpController.Instance != null)
			{
				dictionary3.Add("Tier", ExpController.Instance.OurTier.ToString());
			}
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Crash on advertising", dictionary3);
		}
	}

	private new IEnumerator Start()
	{
		if (Defs.IsDeveloperBuild)
		{
			Debug.Log("Resetting request for interstitial advertisement.");
		}
		ConnectSceneNGUIController.InterstitialRequest = false;
		CheckIfPendingAward();
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.Refresh();
		}
		if (ExpController.Instance != null)
		{
			ExpController.Instance.Refresh();
		}
		PlayerPrefs.SetInt("CountRunMenu", PlayerPrefs.GetInt("CountRunMenu", 0) + 1);
		freeAwardChestObj = GameObject.FindGameObjectWithTag("FreeAwardChest");
		freeAwardChestObj.SetActive(false);
		premiumTime.gameObject.SetActive(true);
		InitializeBannerWindow();
		bool developerConsoleEnabled = Debug.isDebugBuild || true;
		if (developerConsole != null)
		{
			developerConsole.gameObject.SetActive(developerConsoleEnabled);
		}
		if (Device.isWeakDevice || Application.platform == RuntimePlatform.WP8Player)
		{
			ParticleSystem[] particleSystems = UnityEngine.Object.FindObjectsOfType<ParticleSystem>();
			ParticleSystem[] array = particleSystems;
			foreach (ParticleSystem p in array)
			{
				p.gameObject.SetActive(false);
			}
		}
		starterPackPanel.gameObject.SetActive(false);
		dayOfValorContainer.gameObject.SetActive(false);
		stubLoading.SetActive(true);
		string bgTextureName = ConnectSceneNGUIController.MainLoadingTexture();
		stubTexture.mainTexture = Resources.Load<Texture>(bgTextureName);
		HOTween.Init(true, true, true);
		HOTween.EnableOverwriteManager(true);
		base.Start();
		idleTimerLastTime = Time.realtimeSinceStartup;
		SettingsController.ControlsClicked += base.HandleControlsClicked;
		Defs.isShowUserAgrement = false;
		shopButton.GetComponent<UIButton>().isEnabled = !Defs.isTrainingFlag;
		completeTraining.SetActive(!shopButton.GetComponent<UIButton>().isEnabled);
		mainPanel.SetActive(true);
		settingsPanel.SetActive(false);
		freePanel.SetActive(false);
		SettingsJoysticksPanel.SetActive(false);
		sharedController = this;
		if (campaignButton != null)
		{
			ButtonHandler bh23 = campaignButton.GetComponent<ButtonHandler>();
			if (bh23 != null)
			{
				bh23.Clicked += HandleCampaingClicked;
			}
		}
		if (survivalButton != null)
		{
			ButtonHandler bh22 = survivalButton.GetComponent<ButtonHandler>();
			if (bh22 != null)
			{
				bh22.Clicked += HandleSurvivalClicked;
			}
		}
		if (multiplayerButton != null)
		{
			ButtonHandler bh21 = multiplayerButton.GetComponent<ButtonHandler>();
			if (bh21 != null)
			{
				bh21.Clicked += HandleMultiPlayerClicked;
			}
		}
		if (skinsMakerButton != null)
		{
			if (MainMenu.SkinsMakerSupproted())
			{
				ButtonHandler bh20 = skinsMakerButton.GetComponent<ButtonHandler>();
				if (bh20 != null)
				{
					bh20.Clicked += HandleSkinsMakerClicked;
				}
			}
			else
			{
				skinsMakerButton.SetActive(false);
			}
		}
		if (profileButton != null)
		{
			ButtonHandler bh19 = profileButton.GetComponent<ButtonHandler>();
			if (bh19 != null)
			{
				bh19.Clicked += HandleProfileClicked;
			}
		}
		if (freeButton != null)
		{
			ButtonHandler bh18 = freeButton.GetComponent<ButtonHandler>();
			if (bh18 != null)
			{
				bh18.Clicked += HandleFreeClicked;
			}
		}
		if (gameCenterButton != null)
		{
			bool gameCenterButtonEnabled = BuildSettings.BuildTarget == BuildTarget.iPhone;
			gameCenterButton.SetActive(gameCenterButtonEnabled);
			UIButton gameServicesButton = gameCenterButton.GetComponent<UIButton>();
			if (gameServicesButton != null)
			{
				switch (BuildSettings.BuildTarget)
				{
				case BuildTarget.iPhone:
					gameServicesButton.normalSprite = "gamecntr";
					gameServicesButton.pressedSprite = "gamecntr_n";
					break;
				case BuildTarget.Android:
					if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
					{
						gameServicesButton.normalSprite = "google";
						gameServicesButton.pressedSprite = "google_n";
					}
					else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
					{
						gameServicesButton.normalSprite = "amazon";
						gameServicesButton.pressedSprite = "amazon_n";
					}
					else
					{
						gameCenterButton.SetActive(false);
					}
					break;
				default:
					gameCenterButton.SetActive(false);
					break;
				}
				ButtonHandler bh17 = gameCenterButton.GetComponent<ButtonHandler>();
				if (bh17 != null)
				{
					bh17.Clicked += HandleGameServicesClicked;
				}
			}
		}
		if (shopButton != null)
		{
			ButtonHandler bh16 = shopButton.GetComponent<ButtonHandler>();
			if (bh16 != null)
			{
				bh16.Clicked += HandleShopClicked;
			}
		}
		if (PlayerPrefs.GetInt(Defs.ShouldEnableShopSN, 0) == 1)
		{
			HandleShopClicked(null, null);
			PlayerPrefs.SetInt(Defs.ShouldEnableShopSN, 0);
			PlayerPrefs.Save();
			if (PromoActionsPanel != null && PromoActionsPanel.GetComponent<PromoActionsGUIController>() != null)
			{
				PromoActionsPanel.GetComponent<PromoActionsGUIController>().MarkUpdateOnEnable();
			}
		}
		if (settingsButton != null)
		{
			ButtonHandler bh15 = settingsButton.GetComponent<ButtonHandler>();
			if (bh15 != null)
			{
				bh15.Clicked += HandleSettingsClicked;
			}
			settingsButton.GetComponent<UIButton>().isEnabled = !Defs.isTrainingFlag;
		}
		if (BuildSettings.BuildTarget == BuildTarget.WP8Player)
		{
			postFacebookButton.gameObject.SetActive(false);
			postTwitterButton.gameObject.SetActive(false);
			youtubeButton.transform.localPosition = postFacebookButton.transform.localPosition;
		}
		else
		{
			if (postFacebookButton != null)
			{
				ButtonHandler bh14 = postFacebookButton.GetComponent<ButtonHandler>();
				if (bh14 != null)
				{
					bh14.Clicked += HandlePostFacebookClicked;
				}
			}
			if (postTwitterButton != null)
			{
				ButtonHandler bh13 = postTwitterButton.GetComponent<ButtonHandler>();
				if (bh13 != null)
				{
					bh13.Clicked += HandlePostTwittwerClicked;
				}
			}
		}
		if (rateUsButton != null)
		{
			ButtonHandler bh12 = rateUsButton.GetComponent<ButtonHandler>();
			if (bh12 != null)
			{
				bh12.Clicked += HandleRateAsClicked;
			}
		}
		if (backFromFreeButton != null)
		{
			ButtonHandler bh11 = backFromFreeButton.GetComponent<ButtonHandler>();
			if (bh11 != null)
			{
				bh11.Clicked += HandleBackFromSocialClicked;
			}
		}
		if (facebookSubcribeButton != null)
		{
			ButtonHandler bh10 = facebookSubcribeButton.GetComponent<ButtonHandler>();
			if (bh10 != null)
			{
				bh10.Clicked += HandleFacebookSubscribeClicked;
			}
		}
		if (twitterSubcribeButton != null)
		{
			ButtonHandler bh9 = twitterSubcribeButton.GetComponent<ButtonHandler>();
			if (bh9 != null)
			{
				bh9.Clicked += HandleTwitterSubscribeClicked;
			}
		}
		if (supportButton != null)
		{
			ButtonHandler bh8 = supportButton.GetComponent<ButtonHandler>();
			if (bh8 != null)
			{
				bh8.Clicked += HandleSupportButtonClicked;
			}
		}
		if (friendsButton != null)
		{
			ButtonHandler bh7 = friendsButton.GetComponent<ButtonHandler>();
			if (bh7 != null)
			{
				bh7.Clicked += HandleFriendsClicked;
			}
		}
		if (enderManButton != null)
		{
			ButtonHandler bh6 = enderManButton.GetComponent<ButtonHandler>();
			if (bh6 != null)
			{
				bh6.Clicked += HandleEnderClicked;
			}
		}
		if (agreeButton != null)
		{
			ButtonHandler bh5 = agreeButton.GetComponent<ButtonHandler>();
			if (bh5 != null)
			{
				bh5.Clicked += HandleAgreeClicked;
			}
		}
		if (diclineButton != null)
		{
			ButtonHandler bh4 = diclineButton.GetComponent<ButtonHandler>();
			if (bh4 != null)
			{
				bh4.Clicked += HandleDiclineClicked;
			}
		}
		if (coinsShopButton != null)
		{
			ButtonHandler bh3 = coinsShopButton.GetComponent<ButtonHandler>();
			if (bh3 != null)
			{
				bh3.Clicked += HandleBankClicked;
			}
		}
		if (youtubeButton != null)
		{
			ButtonHandler bh2 = youtubeButton.GetComponent<ButtonHandler>();
			if (bh2 != null)
			{
				bh2.Clicked += HandleYoutubeClicked;
			}
		}
		if (everyplayButton != null)
		{
			ButtonHandler bh = everyplayButton.GetComponent<ButtonHandler>();
			if (bh != null)
			{
				bh.Clicked += HandleEveryPlayClicked;
			}
		}
		if (BankController.Instance != null)
		{
			UnityEngine.Object.DontDestroyOnLoad(BankController.Instance.transform.root.gameObject);
		}
		else
		{
			Debug.LogWarning("bankController == null");
		}
		yield return new WaitForSeconds(0.5f);
		PromoActionClick.Click += HandlePromoActionClicked;
		yield return new WaitForSeconds(0.5f);
		_drawLoadingProgress = false;
		stubLoading.SetActive(false);
		ActivityIndicator.sharedActivityIndicator.SetActive(false);
		Debug.Log("Start initializing ProfileGui.");
		ProfileController profileController = UnityEngine.Object.FindObjectOfType<ProfileController>();
		if (profileController == null)
		{
			GameObject profileGuiRequest = Resources.Load<GameObject>("ProfileGui");
			yield return profileGuiRequest;
			GameObject go = (GameObject)UnityEngine.Object.Instantiate(profileGuiRequest);
			UnityEngine.Object.DontDestroyOnLoad(go);
		}
		if (!_socialNetworkingInitilized && Storager.getInt(Defs.TrainingCompleted_4_4_Sett, false) != 0)
		{
			if (Defs.IsDeveloperBuild)
			{
				Debug.Log("Social networking is not initialized; training is completed.");
			}
			GameObject gameServicesControllerGo = new GameObject();
			GameServicesController gameServicesController = gameServicesControllerGo.AddComponent<GameServicesController>();
			Action tryUpdateNickname = delegate
			{
				NickLabelStack sharedStack = NickLabelStack.sharedStack;
				if (sharedStack != null)
				{
					NickLabelController currentLabel = NickLabelStack.sharedStack.GetCurrentLabel();
					if (currentLabel != null)
					{
						currentLabel.UpdaeData();
					}
					else
					{
						Debug.LogWarning("nickLabelController == null");
					}
				}
				else
				{
					Debug.LogWarning("nameLabel == null");
				}
			};
			if (false)
			{
				Debug.Log("Play Game Services explicitly disabled.");
			}
			else if (false)
			{
				if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
				{
					_socialNetworkingInitilized = true;
					Debug.Log("Trying to authenticate with Google Play Games...");
					yield return null;
					gameServicesController.WaitAuthenticationAndIncrementBeginnerAchievement();
				}
				else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
				{
					_socialNetworkingInitilized = true;
					Debug.Log("Social user authenticated: " + Social.localUser.authenticated);
					PurchasesSynchronizer.Instance.SynchronizeAmazonPurchases();
					if (WeaponManager.sharedManager != null)
					{
						StartCoroutine(WeaponManager.sharedManager.ResetCoroutine(0));
						if (ExperienceController.sharedController != null)
						{
							ExperienceController.sharedController.Refresh();
						}
						if (ExpController.Instance != null)
						{
							ExpController.Instance.Refresh();
						}
					}
					yield return null;
					tryUpdateNickname();
					gameServicesController.WaitAuthenticationAndIncrementBeginnerAchievement();
				}
			}
			else if (Application.platform == RuntimePlatform.IPhonePlayer)
			{
				GameCenterSingleton initializedInstance = GameCenterSingleton.Instance;
				_socialNetworkingInitilized = true;
				yield return null;
				gameServicesController.WaitAuthenticationAndIncrementBeginnerAchievement();
			}
		}
		if (bannerContainer != null)
		{
			InGameGUI.SetLayerRecursively(bannerContainer, LayerMask.NameToLayer("Banners"));
		}
		PromoActionsManager.EventX3Updated += OnEventX3Updated;
		OnEventX3Updated();
		StarterPackController.OnStarterPackEnable += OnStarterPackContainerShow;
		OnStarterPackContainerShow(true);
		PromoActionsManager.OnDayOfValorEnable += OnDayOfValorContainerShow;
		//OnDayOfValorContainerShow(PromoActionsManager.sharedManager.IsDayOfValorEventActive);
		if (ReplaceAdmobPerelivController.sharedController != null && ReplaceAdmobPerelivController.sharedController.ShouldShowInLobby && ReplaceAdmobPerelivController.sharedController.DataLoaded)
		{
			ReplaceAdmobPerelivController.sharedController.ShouldShowInLobby = false;
			ReplaceAdmobPerelivController.TryShowPereliv("Lobby after launch");
			ReplaceAdmobPerelivController.sharedController.DestroyImage();
		}
		string key = GetAbuseKey_f1a4329e(4054069918u);
		if (Storager.hasKey(key))
		{
			string ticksHalvedString = Storager.getString(key, false);
			if (!string.IsNullOrEmpty(ticksHalvedString) && ticksHalvedString != "0")
			{
				Debug.LogError(string.Format("SettingsMainMenuController.Start(): Key “{0}” exists: {1}", key, ticksHalvedString));
				long nowTicksHalved = DateTime.UtcNow.Ticks >> 1;
				long abuseTicksHalved = nowTicksHalved;
				if (long.TryParse(ticksHalvedString, out abuseTicksHalved))
				{
					abuseTicksHalved = Math.Min(nowTicksHalved, abuseTicksHalved);
					Storager.setString(key, abuseTicksHalved.ToString(), false);
				}
				else
				{
					Storager.setString(key, nowTicksHalved.ToString(), false);
				}
				TimeSpan timespan = TimeSpan.FromTicks(nowTicksHalved - abuseTicksHalved);
				if (((!Defs.IsDeveloperBuild) ? (timespan.TotalDays >= 1.0) : (timespan.TotalMinutes >= 3.0)) && Application.platform != RuntimePlatform.IPhonePlayer)
				{
					Debug.Log("Setting alternative photon key: 68c9fbdb-682a-411f-a229-1a9786b5835c");
					PhotonNetwork.PhotonServerSettings.AppID = "68c9fbdb-682a-411f-a229-1a9786b5835c";
					PhotonNetwork.PhotonServerSettings.HostType = ServerSettings.HostingOption.PhotonCloud;
				}
			}
		}
		StartCoroutine(TryToShowExpiredBanner());
		LocalizationStore.AddEventCallAfterLocalize(ChangeLocalizeLabel);
		ChangeLocalizeLabel();
	}

	public void HandleClansClicked()
	{
		if (_shopInstance != null || ShowBannerOrLevelup())
		{
			return;
		}
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Clans", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		ButtonClickSound.Instance.PlayClick();
		Action action = delegate
		{
			if (!ProtocolListGetter.currentVersionIsSupported)
			{
				GameObject gameObject = GameObject.FindWithTag("MainCamera");
				if (gameObject != null)
				{
					_advertisementController = gameObject.GetComponent<AdvertisementController>();
					if (_advertisementController != null)
					{
						UnityEngine.Object.Destroy(_advertisementController);
					}
					_advertisementController = gameObject.AddComponent<AdvertisementController>();
					_advertisementController.updateFromMultiBanner = true;
					_advertisementController.Run();
				}
			}
			else
			{
				GoClans();
			}
		};
		if (Defs.isTrainingFlag)
		{
			GoToTraining(action);
		}
		else
		{
			action();
		}
	}

	private void ChangeLocalizeLabel()
	{
		_localizeSaleLabel = LocalizationStore.Get("Key_0419");
	}

	private void GoClans()
	{
		MenuBackgroundMusic.keepPlaying = true;
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = "Clans";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	private static string GetAbuseKey_f1a4329e(uint pad)
	{
		if (pad != 4054069918u)
		{
			Debug.LogError(string.Format("Invalid argument. {0:x} expected, but {1:x} passed.", 4054069918u, pad));
		}
		uint num = 0x354E43A7u ^ pad;
		if (num != 3303698745u)
		{
			Debug.LogError(string.Format("Logic error. {0:x} expected, but {1:x} computed.", 3303698745u, num));
		}
		return num.ToString("x");
	}

	public static bool IsShowRentExpiredPoint()
	{
		if (sharedController == null)
		{
			return false;
		}
		Transform rentExpiredPoint = sharedController.RentExpiredPoint;
		if (rentExpiredPoint == null)
		{
			return false;
		}
		return rentExpiredPoint.childCount > 0;
	}

	public static bool SavedShwonLobbyLevelIsLessThanActual()
	{
		return Storager.getInt(Defs.ShownLobbyLevelSN, false) < ExpController.LobbyLevel;
	}

	private IEnumerator TryToShowExpiredBanner()
	{
		while (FriendsController.sharedController == null || TempItemsController.sharedController == null)
		{
			yield return null;
		}
		while (true)
		{
			yield return StartCoroutine(FriendsController.sharedController.MyWaitForSeconds(1f));
			try
			{
				if (ShopNGUIController.GuiActive || (FreeAwardController.Instance != null && !FreeAwardController.Instance.IsInState<FreeAwardController.IdleState>()) || (BannerWindowController.SharedController != null && BannerWindowController.SharedController.IsAnyBannerShown) || (BankController.Instance != null && BankController.Instance.InterfaceEnabled) || settingsPanel.activeInHierarchy || (ProfileController.Instance != null && ProfileController.Instance.InterfaceEnabled) || stubLoading.activeInHierarchy || singleModePanel.activeSelf || RentExpiredPoint.childCount != 0)
				{
					continue;
				}
				if (SavedShwonLobbyLevelIsLessThanActual())
				{
					GameObject window = UnityEngine.Object.Instantiate(Resources.Load<GameObject>("LobbyLevels/LobbyLevelTips_" + (Storager.getInt(Defs.ShownLobbyLevelSN, false) + 1))) as GameObject;
					window.transform.parent = RentExpiredPoint;
					Player_move_c.SetLayerRecursively(window, LayerMask.NameToLayer("NGUI"));
					window.transform.localPosition = new Vector3(0f, 0f, -130f);
					window.transform.localRotation = Quaternion.identity;
					window.transform.localScale = new Vector3(1f, 1f, 1f);
				}
				else
				{
					if (Storager.getInt(Defs.PremiumEnabledFromServer, false) == 1 && ShopNGUIController.ShowPremimAccountExpiredIfPossible(RentExpiredPoint, "NGUI", string.Empty))
					{
						continue;
					}
					ShopNGUIController.ShowTempItemExpiredIfPossible(RentExpiredPoint, "NGUI", null, null, null, delegate(string item)
					{
						if (WeaponManager.sharedManager != null && WeaponManager.sharedManager.weaponsInGame != null)
						{
							int num = PromoActionsGUIController.CatForTg(item);
							if (num != -1)
							{
								ShopNGUIController.SetAsEquippedAndSendToServer(item, (ShopNGUIController.CategoryNames)num);
							}
						}
						if (PersConfigurator.currentConfigurator != null)
						{
							PersConfigurator.currentConfigurator._AddCapeAndHat();
						}
					});
					continue;
				}
			}
			catch (Exception e)
			{
				Debug.LogWarning("exception in Lobby  TryToShowExpiredBanner: " + e);
			}
		}
	}

	public void HandleDeveloperConsoleClicked()
	{
		if (!(SkinEditorController.sharedController != null))
		{
			Application.LoadLevel("DeveloperConsole");
		}
	}

	public void HandlePromoActionClicked(string tg)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Promoactions", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		int num = -1;
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
		if (ShopNGUIController.sharedShop != null)
		{
			ShopNGUIController.sharedShop.SetOfferID(tg);
			ShopNGUIController.sharedShop.offerCategory = (ShopNGUIController.CategoryNames)num;
		}
		HandleShopClicked(null, EventArgs.Empty);
	}

	private void RefreshNewMessagesNotification()
	{
		if (newMessagesSprite != null)
		{
			if (FriendsController.sharedController != null)
			{
				bool flag = FriendsController.sharedController.invitesToUs.Count > 0 || FriendsController.sharedController.ClanInvites.Count > 0;
				newMessagesSprite.gameObject.SetActive(flag);
			}
			else
			{
				newMessagesSprite.gameObject.SetActive(false);
			}
		}
	}

	private void CalcBtnRects()
	{
		Transform transform = NGUITools.GetRoot(base.gameObject).transform;
		Camera camera = transform.GetChild(0).GetComponent<Camera>();
		Transform relativeTo = camera.transform;
		float num = 768f;
		float num2 = num * ((float)Screen.width / (float)Screen.height);
		Bounds bounds = NGUIMath.CalculateRelativeWidgetBounds(relativeTo, shopButton.GetComponent<UIButton>().tweenTarget.transform, true);
		bounds.center += new Vector3(num2 * 0.5f, num * 0.5f, 0f);
		shopRect = new Rect((bounds.center.x - 105.5f) * Defs.Coef, (bounds.center.y - 57f) * Defs.Coef, 211f * Defs.Coef, 114f * Defs.Coef);
		Bounds bounds2 = NGUIMath.CalculateRelativeWidgetBounds(relativeTo, survivalButton.GetComponent<UIButton>().tweenTarget.transform, true);
		bounds2.center += new Vector3(num2 * 0.5f, num * 0.5f, 0f);
		survivalRect = new Rect((bounds2.center.x - 107f) * Defs.Coef, (bounds2.center.y - 35f) * Defs.Coef, 214f * Defs.Coef, 70f * Defs.Coef);
		Bounds bounds3 = NGUIMath.CalculateRelativeWidgetBounds(relativeTo, campaignButton.GetComponent<UIButton>().tweenTarget.transform, true);
		bounds3.center += new Vector3(num2 * 0.5f, num * 0.5f, 0f);
		campaignRect = new Rect((bounds3.center.x - 107f) * Defs.Coef, (bounds3.center.y - 35f) * Defs.Coef, 214f * Defs.Coef, 70f * Defs.Coef);
	}

	private void UpdateEventX3RemainedTime()
	{
		long eventX3RemainedTime = 999;
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
	}

	public bool PromoOffersPanelShouldBeShown()
	{
		return true;
	}

	private void Update()
	{
		if (multiplayerButton.activeSelf != (SkinEditorController.sharedController == null && ExpController.LobbyLevel > 0 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 0 && (ExpController.LobbyLevel != 2 || Storager.getInt(Defs.ShownLobbyLevelSN, false) != 1)))
		{
			multiplayerButton.SetActive(SkinEditorController.sharedController == null && ExpController.LobbyLevel > 0 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 0);
		}
		if (profileButton.activeSelf != (ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1))
		{
			profileButton.SetActive(ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1);
		}
		if (adventureButton.activeSelf != (ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1))
		{
			adventureButton.SetActive(ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1);
		}
		if (shopButton.activeSelf != (ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1))
		{
			shopButton.SetActive(ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1);
		}
		if (settingsButton.activeSelf != (ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1))
		{
			settingsButton.SetActive(ExpController.LobbyLevel > 1 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 1);
		}
		if (battleNowLabel.gameObject.activeSelf != !Defs.isTrainingFlag)
		{
			battleNowLabel.gameObject.SetActive(!Defs.isTrainingFlag);
		}
		if (trainingNowLabel.gameObject.activeSelf != Defs.isTrainingFlag)
		{
			trainingNowLabel.gameObject.SetActive(Defs.isTrainingFlag);
		}
		if (friendsButton.activeSelf != (ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2))
		{
			friendsButton.SetActive(ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2);
		}
		if (achievementsButton.activeSelf)
		{
			achievementsButton.SetActive(false);
		}
		if (leadersButton.activeSelf != (ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2))
		{
			leadersButton.SetActive(ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2);
		}
		if (clansButton.activeSelf != (ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2))
		{
			clansButton.SetActive(ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2);
		}
		if (daysOfValor.activeSelf != (ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2))
		{
			daysOfValor.SetActive(ExpController.LobbyLevel > 2 && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2);
		}
		bool flag = true;
		if (premium.activeSelf != (ExpController.LobbyLevel > 3 && flag && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 3))
		{
			premium.SetActive(ExpController.LobbyLevel > 3 && flag && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 3);
		}
		premiumButton.isEnabled = Storager.getInt(Defs.PremiumEnabledFromServer, false) == 1;
		if (premiumUpPlashka.activeSelf != (!(PremiumAccountController.Instance != null) || !PremiumAccountController.Instance.isAccountActive))
		{
			premiumUpPlashka.SetActive(!(PremiumAccountController.Instance != null) || !PremiumAccountController.Instance.isAccountActive);
		}
		if (premiumbottomPlashka.activeSelf != (PremiumAccountController.Instance != null && PremiumAccountController.Instance.isAccountActive))
		{
			premiumbottomPlashka.SetActive(PremiumAccountController.Instance != null && PremiumAccountController.Instance.isAccountActive);
		}
		if (PremiumAccountController.Instance != null)
		{
			long num = PremiumAccountController.Instance.GetDaysToEndAllAccounts();
			for (int i = 0; i < premiumLevels.Count; i++)
			{
				bool flag2 = false;
				if (num > 0 && num < 3 && i == 0)
				{
					flag2 = true;
				}
				if (num >= 3 && num < 7 && i == 1)
				{
					flag2 = true;
				}
				if (num >= 7 && num < 30 && i == 2)
				{
					flag2 = true;
				}
				if (num >= 30 && i == 3)
				{
					flag2 = true;
				}
				if (premiumLevels[i].activeSelf != flag2)
				{
					premiumLevels[i].SetActive(flag2);
				}
			}
			if (Time.realtimeSinceStartup - _timePremiumTimeUpdated >= 1f)
			{
				premiumTime.text = PremiumAccountController.Instance.GetTimeToEndAllAccounts();
				_timePremiumTimeUpdated = Time.realtimeSinceStartup;
			}
		}
		bool flag3 = (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && !ShopNGUIController.GuiActive;
		if (starParticleStarterPackGaemObject != null && starParticleStarterPackGaemObject.activeInHierarchy != flag3)
		{
			starParticleStarterPackGaemObject.SetActive(flag3);
		}
		if (Time.frameCount % 60 == 0)
		{
			RefreshNewMessagesNotification();
		}
		if (Time.realtimeSinceStartup - _eventX3RemainTimeLastUpdateTime >= 0.5f)
		{
			_eventX3RemainTimeLastUpdateTime = Time.realtimeSinceStartup;
			UpdateEventX3RemainedTime();
			if (_dayOfValorEnabled)
			{
				dayOfValorTimer.text = PromoActionsManager.sharedManager.GetTimeToEndDaysOfValor();
			}
		}
		if (_isCancellationRequested)
		{
			MainMenuController mainMenuController = sharedController;
			if (SettingsJoysticksPanel.activeSelf)
			{
				SettingsJoysticksPanel.SetActive(false);
				settingsPanel.SetActive(true);
			}
			else if (freePanel.activeSelf)
			{
				if (_shopInstance == null && !ShowBannerOrLevelup())
				{
					settingsPanel.SetActive(true);
					freePanel.SetActive(false);
				}
			}
			else if (BannerWindowController.SharedController != null && BannerWindowController.SharedController.IsAnyBannerShown)
			{
				if (BannerWindowController.SharedController.IsBannerShow(BannerWindowType.MarathonBonus))
				{
					BannerWindowController.SharedController.SubmitCurrentBanner();
					Input.ResetInputAxes();
				}
				else
				{
					BannerWindowController.SharedController.HideBannerWindow();
				}
			}
			else if ((!(settingsPanel != null) || !settingsPanel.activeInHierarchy) && (!(freePanel != null) || !freePanel.activeInHierarchy) && (!(BankController.Instance != null) || !BankController.Instance.InterfaceEnabled) && !ShopNGUIController.GuiActive && (!(ProfileController.Instance != null) || !ProfileController.Instance.InterfaceEnabled))
			{
				if (PremiumAccountScreenController.Instance != null)
				{
					PremiumAccountScreenController.Instance.Hide();
				}
				else if (mainMenuController != null && mainMenuController.singleModePanel.activeSelf)
				{
					mainMenuController.OnClickBackSingleModeButton();
				}
				else
				{
					PlayerPrefs.Save();
					Application.Quit();
				}
			}
			_isCancellationRequested = false;
		}
		PromoActionsPanel.SetActive(PromoOffersPanelShouldBeShown() && Storager.getInt(Defs.ShownLobbyLevelSN, false) > 2);
		if (rotateCamera != null && !rotateCamera.IsAnimPlaying)
		{
			float num2 = -120f;
			num2 *= ((BuildSettings.BuildTarget != BuildTarget.Android) ? 0.5f : 2f);
			Rect rect;
			if (settingsPanel.activeInHierarchy)
			{
				rect = new Rect(0f, 0.1f * (float)Screen.height, 0.5f * (float)Screen.width, 0.8f * (float)Screen.height);
			}
			else
			{
				if (campaignRect.width.Equals(0f))
				{
					CalcBtnRects();
				}
				rect = ((!(MenuLeaderboardsController.sharedController == null) || !MenuLeaderboardsController.sharedController.IsOpened) ? new Rect(0.2f * (float)Screen.width, 0.25f * (float)Screen.height, 1.4f * (float)Screen.width, 0.65f * (float)Screen.height) : new Rect(0.38f * (float)Screen.width, 0.25f * (float)Screen.height, 1.4f * (float)Screen.width, 0.65f * (float)Screen.height));
			}
			if (Input.touchCount > 0 && !ShopNGUIController.GuiActive)
			{
				Touch touch = Input.GetTouch(0);
				if (touch.phase == TouchPhase.Moved && rect.Contains(touch.position))
				{
					idleTimerLastTime = Time.realtimeSinceStartup;
					pers.Rotate(Vector3.up, touch.deltaPosition.x * num2 * 0.5f * (Time.realtimeSinceStartup - lastTime));
				}
			}
			if (Application.isEditor && !ShopNGUIController.GuiActive)
			{
				float num3 = Input.GetAxis("Mouse ScrollWheel") * 3f * num2 * (Time.realtimeSinceStartup - lastTime);
				pers.Rotate(Vector3.up, num3);
				if (num3 != 0f)
				{
					idleTimerLastTime = Time.realtimeSinceStartup;
				}
			}
			lastTime = Time.realtimeSinceStartup;
		}
		if (Time.realtimeSinceStartup - idleTimerLastTime > ShopNGUIController.IdleTimeoutPers)
		{
			ReturnPersTonNormState();
		}
		if (_starterPackEnabled)
		{
			//starterPackTimer.text = StarterPackController.Get.GetTimeToEndEvent();
		}
			freeAwardChestObj.SetActive(true);
	}

	private void LateUpdate()
	{
		if (Input.GetKeyUp(KeyCode.Escape))
		{
			_isCancellationRequested = true;
		}
	}

	private void ReturnPersTonNormState()
	{
		HOTween.Kill(pers);
		Vector3 p_endVal = new Vector3(-0.33f, 28f, -0.28f);
		idleTimerLastTime = Time.realtimeSinceStartup;
		HOTween.To(pers, 0.5f, new TweenParms().Prop("localRotation", new PlugQuaternion(p_endVal)).Ease(EaseType.Linear).OnComplete((TweenDelegate.TweenCallback)delegate
		{
			idleTimerLastTime = Time.realtimeSinceStartup;
		}));
	}

	private new void OnEnable()
	{
		base.OnEnable();
		RefreshNewMessagesNotification();
	}

	private void GoToTraining(Action act)
	{
		Defs.isFlag = false;
		Defs.isCOOP = false;
		Defs.isMulti = false;
		Defs.isHunger = false;
		Defs.isCompany = false;
		Defs.IsSurvival = false;
		Defs.isCapturePoints = false;
		GlobalGameController.Score = 0;
		GlobalGameController.InsideTraining = true;
		WeaponManager.sharedManager.Reset(0);
		Application.LoadLevel("CampaignLoading");
	}

	private void HandleAgreeClicked(object sender, EventArgs e)
	{
		Defs.isShowUserAgrement = false;
		UserAgreementPanel.SetActive(false);
		if (notShowAgain.value)
		{
			PlayerPrefs.SetInt("UserAgreement", 1);
		}
		if (isMultyPress)
		{
			GoMulty();
		}
		if (isFriendsPress)
		{
			GoFriens();
		}
	}

	private void HandleDiclineClicked(object sender, EventArgs e)
	{
		Defs.isShowUserAgrement = false;
		UserAgreementPanel.SetActive(false);
	}

	public void ShowBankWindow()
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Bank", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		if (_shopInstance != null)
		{
			Debug.LogWarning("_shopInstance != null");
			return;
		}
		if (BankController.Instance == null)
		{
			Debug.LogWarning("bankController == null");
			return;
		}
		if (BankController.Instance.InterfaceEnabledCoroutineLocked)
		{
			Debug.LogWarning("InterfaceEnabledCoroutineLocked");
			return;
		}
		BankController.Instance.BackRequested += HandleBackFromBankClicked;
		if (!ShowBannerOrLevelup())
		{
			_bankEnteredTime = Time.realtimeSinceStartup;
			ButtonClickSound.Instance.PlayClick();
			if (mainPanel != null)
			{
				mainPanel.transform.root.gameObject.SetActive(false);
			}
			if (nicknameLabel != null)
			{
				nicknameLabel.transform.root.gameObject.SetActive(false);
			}
			BankController.Instance.InterfaceEnabled = true;
		}
	}

	private void HandleBankClicked(object sender, EventArgs e)
	{
		ShowBankWindow();
	}

	private void HandleBackFromBankClicked(object sender, EventArgs e)
	{
		if (_shopInstance != null)
		{
			Debug.LogWarning("_shopInstance != null");
			return;
		}
		if (BankController.Instance == null)
		{
			Debug.LogWarning("bankController == null");
			return;
		}
		if (BankController.Instance.InterfaceEnabledCoroutineLocked)
		{
			Debug.LogWarning("InterfaceEnabledCoroutineLocked");
			return;
		}
		BankController.Instance.BackRequested -= HandleBackFromBankClicked;
		BankController.Instance.InterfaceEnabled = false;
		if (nicknameLabel != null)
		{
			nicknameLabel.transform.root.gameObject.SetActive(true);
		}
		if (mainPanel != null)
		{
			mainPanel.transform.root.gameObject.SetActive(true);
		}
		if (singleModePanel != null && singleModePanel.activeSelf)
		{
			ExperienceController.SetEnable(true);
		}
	}

	private void HandleEnderClicked(object sender, EventArgs e)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Ender", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		ButtonClickSound.Instance.PlayClick();
		FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Slendy Pressed");
		if (Application.isEditor)
		{
			Debug.Log(MainMenu.GetEndermanUrl());
		}
		else
		{
			Application.OpenURL(MainMenu.GetEndermanUrl());
		}
	}

	private void HandleSupportButtonClicked(object sender, EventArgs e)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Support", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		settingsPanel.SetActive(false);
		supportPanel.SetActive(true);
	}

	private void HandleCampaingClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Campaign", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			Action action = delegate
			{
				Defs.isFlag = false;
				Defs.isCOOP = false;
				Defs.isMulti = false;
				Defs.isHunger = false;
				Defs.isCompany = false;
				Defs.IsSurvival = false;
				Defs.isCapturePoints = false;
				GlobalGameController.Score = 0;
				WeaponManager.sharedManager.Reset(0);
				FlurryPluginWrapper.LogCampaignModePress();
				StoreKitEventListener.State.Mode = "Campaign";
				StoreKitEventListener.State.PurchaseKey = "In game";
				StoreKitEventListener.State.Parameters.Clear();
				Dictionary<string, string> parameters = new Dictionary<string, string>
				{
					{
						Defs.RankParameterKey,
						ExperienceController.sharedController.currentLevel.ToString()
					},
					{
						Defs.MultiplayerModesKey,
						StoreKitEventListener.State.Mode
					}
				};
				FlurryPluginWrapper.LogEvent(Defs.GameModesEventKey, parameters);
				MenuBackgroundMusic.keepPlaying = true;
				LoadConnectScene.textureToShow = null;
				LoadConnectScene.sceneToLoad = "CampaignChooseBox";
				LoadConnectScene.noteToShow = null;
				Application.LoadLevel(Defs.PromSceneName);
			};
			if (Defs.isTrainingFlag)
			{
				GoToTraining(action);
			}
			else
			{
				action();
			}
		}
	}

	private void HandleSurvivalClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Survival", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			Action action = delegate
			{
				Defs.isFlag = false;
				Defs.isCOOP = false;
				Defs.isMulti = false;
				Defs.isHunger = false;
				Defs.isCompany = false;
				Defs.isCapturePoints = false;
				Defs.IsSurvival = true;
				CurrentCampaignGame.levelSceneName = string.Empty;
				GlobalGameController.Score = 0;
				WeaponManager.sharedManager.Reset(0);
				FlurryPluginWrapper.LogTrueSurvivalModePress();
				FlurryPluginWrapper.LogEvent("Launch_Survival");
				StoreKitEventListener.State.Mode = "Survival";
				StoreKitEventListener.State.PurchaseKey = "In game";
				StoreKitEventListener.State.Parameters.Clear();
				Dictionary<string, string> parameters = new Dictionary<string, string>
				{
					{
						Defs.RankParameterKey,
						ExperienceController.sharedController.currentLevel.ToString()
					},
					{
						Defs.MultiplayerModesKey,
						StoreKitEventListener.State.Mode
					}
				};
				FlurryPluginWrapper.LogEvent(Defs.GameModesEventKey, parameters);
				Defs.CurrentSurvMapIndex = UnityEngine.Random.Range(0, Defs.SurvivalMaps.Length);
				Application.LoadLevel("CampaignLoading");
			};
			if (Defs.isTrainingFlag)
			{
				GoToTraining(action);
			}
			else
			{
				action();
			}
		}
	}

	private void GoMulty()
	{
		Defs.isFlag = false;
		Defs.isCOOP = false;
		Defs.isMulti = true;
		Defs.isHunger = false;
		Defs.isCompany = false;
		Defs.IsSurvival = false;
		Defs.isFlag = false;
		Defs.isCapturePoints = false;
		FlurryPluginWrapper.LogDeathmatchModePress();
		MenuBackgroundMusic.keepPlaying = true;
		string path = ConnectSceneNGUIController.MainLoadingTexture();
		LoadConnectScene.textureToShow = Resources.Load<Texture>(path);
		LoadConnectScene.sceneToLoad = "ConnectScene";
		FlurryPluginWrapper.LogEvent("Launch_Multiplayer");
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	public void OnClickMultiplyerButton()
	{
		ButtonClickSound.Instance.PlayClick();
		Action action = delegate
		{
			if (!ProtocolListGetter.currentVersionIsSupported)
			{
				BannerWindowController bannerWindowController = BannerWindowController.SharedController;
				if (bannerWindowController != null)
				{
					bannerWindowController.ForceShowBanner(BannerWindowType.NewVersion);
				}
			}
			else
			{
				GoMulty();
			}
		};
		if (Defs.isTrainingFlag)
		{
			GoToTraining(action);
		}
		else
		{
			action();
		}
	}

	public void HandleMultiPlayerClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			OnClickMultiplyerButton();
		}
	}

	private void HandleSkinsMakerClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Skins Maker", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			PlayerPrefs.SetInt(Defs.SkinEditorMode, 0);
			FlurryPluginWrapper.LogSkinsMakerModePress();
			FlurryPluginWrapper.LogSkinsMakerEnteredEvent();
			GlobalGameController.EditingCape = 0;
			GlobalGameController.EditingLogo = 0;
			FlurryPluginWrapper.LogEvent("Launch_Skins Maker");
			Application.LoadLevel("SkinEditor");
		}
	}

	private void GoFriens()
	{
		MenuBackgroundMusic.keepPlaying = true;
		ConnectSceneNGUIController.GoToFriends();
	}

	private void HandleFriendsClicked(object sender, EventArgs e)
	{
		if (_shopInstance != null || ShowBannerOrLevelup())
		{
			return;
		}
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Friends", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		ButtonClickSound.Instance.PlayClick();
		Action action = delegate
		{
			if (!ProtocolListGetter.currentVersionIsSupported)
			{
				GameObject gameObject = GameObject.FindWithTag("MainCamera");
				if (gameObject != null)
				{
					_advertisementController = gameObject.GetComponent<AdvertisementController>();
					if (_advertisementController != null)
					{
						UnityEngine.Object.Destroy(_advertisementController);
					}
					_advertisementController = gameObject.AddComponent<AdvertisementController>();
					_advertisementController.updateFromMultiBanner = true;
					_advertisementController.Run();
				}
			}
			else
			{
				GoFriens();
			}
		};
		if (Defs.isTrainingFlag)
		{
			GoToTraining(action);
		}
		else
		{
			action();
		}
	}

	private void HandleProfileClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Profile", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEvent("Profile");
			PlayerPrefs.SetInt(Defs.ProfileEnteredFromMenu, 0);
			GoToProfile();
		}
	}

	public void GoToProfile()
	{
		if (ProfileController.Instance == null)
		{
			Debug.LogWarning("ProfileController.Instance == null");
		}
		else
		{
			if (ShowBannerOrLevelup())
			{
				return;
			}
			ButtonClickSound.Instance.PlayClick();
			GameObject nicknameLabel_ = null;
			if (NickLabelStack.sharedStack != null)
			{
				nicknameLabel_ = NickLabelStack.sharedStack.GetCurrentLabel().gameObject;
			}
			if (nicknameLabel_ != null)
			{
				nicknameLabel_.SetActive(false);
			}
			if (mainPanel != null)
			{
				mainPanel.transform.root.gameObject.SetActive(false);
			}
			ProfileController.Instance.ShowInterface(delegate
			{
				if (nicknameLabel_ != null)
				{
					nicknameLabel_.SetActive(true);
					NickLabelController component = nicknameLabel_.GetComponent<NickLabelController>();
					if (component != null)
					{
						component.UpdaeData();
					}
					else if (Application.isEditor)
					{
						Debug.LogWarning("nickLabelController == null");
					}
				}
				if (mainPanel != null)
				{
					mainPanel.transform.root.gameObject.SetActive(true);
				}
				if (_menuLeaderboardsController == null)
				{
					_menuLeaderboardsController = UnityEngine.Object.FindObjectOfType<MenuLeaderboardsController>();
				}
				if (_menuLeaderboardsController != null)
				{
					_menuLeaderboardsController.RefreshWithCache();
				}
			});
		}
	}

	private void HandleFreeClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Free Coins", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			settingsPanel.SetActive(false);
			freePanel.SetActive(true);
		}
	}

	private void HandleGameServicesClicked(object sender, EventArgs e)
	{
		if (_shopInstance != null || ShowBannerOrLevelup())
		{
			return;
		}
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining("Game Services", TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		ButtonClickSound.Instance.PlayClick();
		switch (BuildSettings.BuildTarget)
		{
		case BuildTarget.iPhone:
			FlurryPluginWrapper.LogGamecenter();
			if (Application.isEditor)
			{
			}
			break;
		case BuildTarget.Android:
			if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro)
			{
				Social.ShowAchievementsUI();
			}
			else if (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
			{
				AGSAchievementsClient.ShowAchievementsOverlay();
			}
			break;
		}
	}

	private void HandleResumeFromShop()
	{
		if (!(_shopInstance != null))
		{
			return;
		}
		ShopNGUIController.GuiActive = false;
		_shopInstance.resumeAction = delegate
		{
		};
		_shopInstance = null;
		GameObject gameObject = NickLabelStack.sharedStack.GetCurrentLabel().gameObject;
		if (gameObject != null)
		{
			gameObject.SetActive(true);
			NickLabelController component = gameObject.GetComponent<NickLabelController>();
			if (component != null)
			{
				component.UpdaeData();
			}
			else if (Application.isEditor)
			{
				Debug.LogWarning("nickLabelController == null");
			}
		}
		if (StarterPackController.Get != null && StarterPackController.Get.isEventActive)
		{
			StarterPackController.Get.CheckShowStarterPack();
		}
	}

	public void HandleShopClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Shop", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			if (PlayerPrefs.GetInt(Defs.ShouldEnableShopSN, 0) != 1)
			{
				ButtonClickSound.Instance.PlayClick();
			}
			FlurryPluginWrapper.LogEvent("Shop");
			_shopInstance = ShopNGUIController.sharedShop;
			if (_shopInstance != null)
			{
				_shopInstance.SetGearCatEnabled(false);
				ShopNGUIController.GuiActive = true;
				_shopInstance.resumeAction = HandleResumeFromShop;
			}
			else
			{
				Debug.LogWarning("sharedShop == null");
			}
		}
	}

	private void HandleSettingsClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Settings", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			rotateCamera.OnMainMenuOpenOptions();
			ButtonClickSound.Instance.PlayClick();
			settingsPanel.SetActive(true);
			mainPanel.SetActive(false);
		}
	}

	private void HandleYoutubeClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null))
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("YouTube", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "YouTube Channel");
			Application.OpenURL("http://www.youtube.com/channel/UCsClw1gnMrmF6ssIB_166_Q");
		}
	}

	private void HandleEveryPlayClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null))
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Everyplay", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Everyplay Replays");
			Application.OpenURL("https://everyplay.com/pixel-gun-3d--");
		}
	}

	private void HandlePostFacebookClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Post Facebook", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Facebook Post");
			FacebookController.ShowPostDialog();
			FlurryPluginWrapper.LogFacebook();
			FlurryPluginWrapper.LogFreeCoinsFacebook();
		}
	}

	private void HandlePostTwittwerClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Post Twitter", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogTwitter();
			FlurryPluginWrapper.LogFreeCoinsTwitter();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Twitter Post");
			if (!Application.isEditor)
			{
				InitTwitter();
			}
		}
	}

	private void HandleRateAsClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null) && !ShowBannerOrLevelup())
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Rate", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			FlurryPluginWrapper.LogFreeCoinsRateUs();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Rate us!");
			string rateUsURL = RateUsURL;
			Application.OpenURL(rateUsURL);
		}
	}

	private void HandleBackFromSocialClicked(object sender, EventArgs e)
	{
		_isCancellationRequested = true;
	}

	private void HandleTwitterSubscribeClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null))
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Subscribe Twitter", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Twitter Channel");
			Application.OpenURL("https://twitter.com/PixelGun3D");
		}
	}

	private void HandleFacebookSubscribeClicked(object sender, EventArgs e)
	{
		if (!(_shopInstance != null))
		{
			if (TrainingController.TrainingCompleted.HasValue)
			{
				FlurryEvents.LogAfterTraining("Subscribe Facebook", TrainingController.TrainingCompleted.Value);
				TrainingController.TrainingCompleted = null;
			}
			ButtonClickSound.Instance.PlayClick();
			FlurryPluginWrapper.LogEventWithParameterAndValue("Social", "Buttons Pressed", "Facebook Page");
			Application.OpenURL("http://pixelgun3d.com/facebook.html");
		}
	}

	private void InitTwitter()
	{
		string empty = string.Empty;
		string empty2 = string.Empty;
		if (GlobalGameController.isFullVersion)
		{
			empty = "cuMbTHM8izr9Mb3bIfcTxA";
			empty2 = "mpTLWIku4kIaQq7sTTi91wRLlvAxADhalhlEresnuI";
		}
		else
		{
			empty = "Jb7CwCaMgCQQiMViQRNHw";
			empty2 = "zGVrax4vqgs3CYf04O7glsoRbNT3vhIafte6lfm8w";
		}
		ServiceLocator.TwitterFacade.Init(empty, empty2);
		if (!ServiceLocator.TwitterFacade.IsLoggedIn())
		{
			TwitterLogin();
		}
		else
		{
			TwitterPost();
		}
	}

	private void TwitterLogin()
	{
		TwitterManager.loginSucceededEvent += OnTwitterLogin;
		TwitterManager.loginFailedEvent += OnTwitterLoginFailed;
		ServiceLocator.TwitterFacade.ShowLoginDialog();
	}

	private void OnTwitterLogin(string s)
	{
		TwitterManager.loginSucceededEvent -= OnTwitterLogin;
		TwitterManager.loginFailedEvent -= OnTwitterLoginFailed;
		TwitterPost();
	}

	private void OnTwitterLoginFailed(string error)
	{
		TwitterManager.loginSucceededEvent -= OnTwitterLogin;
		TwitterManager.loginFailedEvent -= OnTwitterLoginFailed;
	}

	private void TwitterPost()
	{
		TwitterManager.requestDidFinishEvent += OnTwitterPost;
		ServiceLocator.TwitterFacade.PostStatusUpdate(_SocialMessage());
	}

	private void HandlePostComplete(object obj, string error)
	{
		if (error != null)
		{
			Debug.LogWarning("Twitter request error: " + error);
		}
		else if (obj != null)
		{
			Debug.Log(obj);
			Invoke("hideMessagTwitter", 3f);
		}
		else
		{
			Debug.LogWarning("obj == null");
		}
	}

	private void OnTwitterPost(object result)
	{
		if (result != null)
		{
			TwitterManager.requestDidFinishEvent -= OnTwitterPost;
			Invoke("hideMessagTwitter", 3f);
		}
	}

	private void OnTwitterPostFailed(string _error)
	{
		TwitterManager.requestDidFinishEvent -= OnTwitterPost;
	}

	public static void SetInputEnabled(bool enabled)
	{
		if (sharedController != null)
		{
			sharedController.uiCamera.enabled = enabled;
		}
	}

	private void OnEventX3Updated()
	{
		//eventX3RemainTime[0].gameObject.SetActive(PromoActionsManager.sharedManager.IsEventX3Active);
	}

	private void OnStarterPackContainerShow(bool enable)
	{
		starterPackPanel.gameObject.SetActive(enable);
		if (enable)
		{
			buttonBackground.mainTexture = StarterPackController.Get.GetCurrentPackImage();
		}
		_starterPackEnabled = enable;
		// funny trick 1! !!! Fuck you
		starterPackTimer.mAlignment = NGUIText.Alignment.Left;
		starterPackTimer.text = "";
	}

	public void OnStarterPackButtonClick()
	{
		if (!(SkinEditorController.sharedController != null))
		{
			BannerWindowController bannerWindowController = BannerWindowController.SharedController;
			if (!(bannerWindowController == null))
			{
				bannerWindowController.ForceShowBanner(BannerWindowType.StarterPack);
			}
		}
	}

	private void OnDayOfValorContainerShow(bool enable)
	{
		dayOfValorContainer.gameObject.SetActive(enable);
		_dayOfValorEnabled = enable;
		dayOfValorTimer.text = PromoActionsManager.sharedManager.GetTimeToEndDaysOfValor();
	}

	public void OnDayOfValorButtonClick()
	{
		BannerWindowController bannerWindowController = BannerWindowController.SharedController;
		if (!(bannerWindowController == null))
		{
			bannerWindowController.ForceShowBanner(BannerWindowType.DaysOfValor);
		}
	}

	public void HandlePremiumClicked()
	{
		ShopNGUIController.ShowPremimAccountExpiredIfPossible(RentExpiredPoint, "NGUI", string.Empty, false);
	}

	private void SetActiveSinglePanel(bool isActive)
	{
		mainPanel.SetActive(!isActive);
		singleModePanel.SetActive(isActive);
		FreeAwardShowHandler.CheckShowChest(isActive);
		ExperienceController.SetEnable(isActive);
	}

	public void OnClickSingleModeButton()
	{
		SetActiveSinglePanel(true);
		rotateCamera.OnOpenSingleModePanel();
		_parentBankPanel = coinsShopButton.transform.parent;
		coinsShopButton.transform.parent = singleModePanel.transform;
		int num = 0;
		foreach (KeyValuePair<string, Dictionary<string, int>> boxesLevelsAndStar in CampaignProgress.boxesLevelsAndStars)
		{
			foreach (KeyValuePair<string, int> item in boxesLevelsAndStar.Value)
			{
				num += item.Value;
			}
		}
		singleModeStarsProgress.text = string.Format("{0}: {1}", LocalizationStore.Get("Key_1262"), num + "/60");
		singleModeBestScores.text = string.Format("{0} {1}", LocalizationStore.Get("Key_0234").ToLower(), PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0).ToString());
	}

	public void OnClickBackSingleModeButton()
	{
		SetActiveSinglePanel(false);
		rotateCamera.OnCloseSingleModePanel();
		coinsShopButton.transform.parent = _parentBankPanel;
	}
}
