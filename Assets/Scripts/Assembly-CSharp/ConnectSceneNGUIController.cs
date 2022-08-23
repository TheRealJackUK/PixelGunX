using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Text;
using ExitGames.Client.Photon;
using Rilisoft;
using UnityEngine;

public class ConnectSceneNGUIController : MonoBehaviour
{
	public enum PlatformConnect
	{
		ios = 1,
		android,
		custom
	}

	public enum RegimGame
	{
		Deathmatch,
		TimeBattle,
		TeamFight,
		DeadlyGames,
		FlagCapture,
		CapturePoints
	}

	public struct infoServer
	{
		public string ipAddress;

		public int port;

		public string name;

		public string map;

		public int playerLimit;

		public int connectedPlayers;

		public string coments;
	}

	public struct infoClient
	{
		public string ipAddress;

		public string name;

		public string coments;
	}

	public const string PendingInterstitialKey = "PendingInterstitial";

	public static PlatformConnect myPlatformConnect = PlatformConnect.android;

	private string rulesDeadmatch;

	private string rulesTeamFight;

	private string rulesTimeBattle;

	private string rulesDeadlyGames;

	private string rulesFlagCapture;

	private string rulesCapturePoint;

	public int myLevelGame;

	public UILabel rulesLabel;

	public static int gameTier = 1;

	public static string[] masMapName = new string[47]
	{
		"Paradise", "RunAndJump", "Pizza", "Christmas_Town", "level_0", "level_1", "level_2", "level_3", "level_4", "level_5", "NuclearCity", "Supermarket", "Sky_islands", "Sniper", "Knife", "Heaven", "Hill",
		"Ants", "DarkMall", "Underwater", "Matrix", "Ships", "Portal", "Space", "actualgame", "Estate", "Parkour", "Pool", "School",
		"Coliseum_MP", "Bridge", "Jail", "Pool_Brian", "Slender_Multy", "Train", "Pool_Abandoned", "Lean_Matrix", "Tatuan", "ChinaPand", "PiratIsland",
		"emperors_palace", "Helicarrier", "train_robbery", "Candyland", "survival_7",
		"survival_3", "facility"
	};

	public static string[] masMapNameHunger = new string[5] { "Hungry", "Hungry_Night", "Hungry_2", "Gluk_3", "Cube" };

	public static string[] masMapNameCOOP = new string[6] { "Utopia", "Arena", "Bridge", "Assault", "Dust", "Winter" };

	public static string[] masMapNameCompany = new string[39]
	{
		"Heaven", "Barge", "Pizza", "Bota", "Paradise", "Christmas_Town_Night", "Space", "Train", "Day_D", "Sniper",
		"Knife", "Ants", "Underwater", "Matrix", "Ships_Night", "Portal", "actualgame", "Estate", "Parkour", "Pool", "Ranch",
		"Assault", "Aztec", "Dust", "Sky_islands", "NuclearCity", "Lean_Matrix", "Tatuan", "ChinaPand", "PiratIsland", "emperors_palace",
		"Christmas_dinner", "Secret_Base", "Helicarrier", "train_robbery", "Candyland", "survival_7",
		"survival_3", "facility"
	};

	public static string[] masMapNameflag = new string[17]
	{
		"Two_Castles", "Barge", "Bota", "Paradise", "Parkour", "NuclearCity", "Day_D", "Ants", "Underwater", "Matrix",
		"Portal", "Space", "Dust", "Ships", "Lean_Matrix", "emperors_palace", "Christmas_dinner"
	};

	public static string[] masMapNameCapturePoints = new string[4] { "Mine", "Bota", "Paradise", "Parkour" };

	public List<infoServer> servers = new List<infoServer>();

	private float posNumberOffPlayersX = -139f;

	private string goMapName;

	public static int[] masUseMaps;

	private Dictionary<string, Texture> mapPreview = new Dictionary<string, Texture>();

	public UILabel priceRegimLabel;

	public UILabel priceMapLabel;

	public UILabel priceMapLabelInCreate;

	public GameObject mapPreviewTexture;

	public GameObject grid;

	public Transform ScrollTransform;

	public Transform selectMapPanelTransform;

	public int selectIndexMap = -1;

	public float widthCell;

	public int countMap;

	public UIButton createRoomUIBtn;

	public UISprite fonMapPreview;

	public UIPanel mapPreviewPanel;

	public GameObject mainPanel;

	public GameObject localBtn;

	public GameObject customBtn;

	public GameObject randomBtn;

	public GameObject goBtn;

	public GameObject backBtn;

	public GameObject unlockBtn;

	public GameObject unlockMapBtnInCreate;

	public GameObject unlockMapBtn;

	public GameObject coinsShopButton;

	public GameObject cancelFromConnectToPhotonBtn;

	public GameObject connectToPhotonPanel;

	public GameObject failInternetLabel;

	public GameObject customPanel;

	public GameObject gameInfoItemPrefab;

	public GameObject loadingMapPanel;

	public GameObject searchPanel;

	public GameObject clearBtn;

	public GameObject searchBtn;

	public GameObject showSearchPanelBtn;

	public GameObject selectMapPanel;

	public GameObject createPanel;

	public GameObject goToCreateRoomBtn;

	public GameObject createRoomBtn;

	public GameObject setPasswordBtn;

	public GameObject clearInSetPasswordBtn;

	public GameObject okInsetPasswordBtn;

	public GameObject setPasswordPanel;

	public GameObject passONSprite;

	public GameObject enterPasswordPanel;

	public GameObject joinRoomFromEnterPasswordBtn;

	public GameObject connectToWiFIInCreateLabel;

	public GameObject connectToWiFIInCustomLabel;

	public Transform scrollViewSelectMapTransform;

	public PlusMinusController numberOfPlayer;

	public PlusMinusController killToWin;

	public TeamNumberOfPlayer teamCountPlayer;

	public UIGrid gridGames;

	public UIInput searchInput;

	public UIInput nameServerInput;

	public UIInput setPasswordInput;

	public UIInput enterPasswordInput;

	public Transform gridGamesTransform;

	public UITexture loadingToDraw;

	public UILabel conditionLabel;

	private static RegimGame _regim = RegimGame.Deathmatch;

	public int nRegim;

	private bool isSetUseMap;

	public string gameNameFilter;

	public List<GameObject> gamesInfo = new List<GameObject>();

	public DisableObjectFromTimer gameIsfullLabel;

	public DisableObjectFromTimer incorrectPasswordLabel;

	public DisableObjectFromTimer serverIsNotAvalible;

	public DisableObjectFromTimer accountBlockedLabel;

	public DisableObjectFromTimer nameAlreadyUsedLabel;

	private float timerShowBan = -1f;

	private bool isConnectingToPhoton;

	private bool isCancelConnectingToPhoton;

	private int pressButton;

	private List<RoomInfo> filteredRoomList = new List<RoomInfo>();

	private int countNoteCaptureDeadmatch = 5;

	private int countNoteCaptureCOOP = 5;

	private int countNoteCaptureHunger = 5;

	private int countNoteCaptureFlag = 5;

	private int countNoteCaptureCompany = 5;

	public static ConnectSceneNGUIController sharedController;

	private string password = string.Empty;

	public LANBroadcastService lanScan;

	private RoomInfo joinRoomInfoFromCustom;

	private bool firstConnectToPhoton;

	private bool isGoInPhotonGame;

	private bool isMainPanelActiv = true;

	public GameObject ChooseMapLabelSmall;

	private AdvertisementController _advertisementController;

	public UIToggle deathmatchToggle;

	public UIToggle teamFightToogle;

	public UIToggle timeBattleToogle;

	public UIToggle deadlyGamesToogle;

	public UIToggle flagCaptureToogle;

	public UIToggle capturePointsToogle;

	public bool isStartShowAdvert;

	private Action actAfterConnectToPhoton;

	public static Dictionary<string, Dictionary<string, Dictionary<string, Dictionary<string, int>>>> mapStatistics = new Dictionary<string, Dictionary<string, Dictionary<string, Dictionary<string, int>>>>();

	private bool loadReplaceAdmobPerelivRunning;

	private bool loadAdmobRunning;

	private int _countOfLoopsRequestAdThisTime;

	private float _lastTimeInterstitialShown;

	private float startPosX;

	private LoadingNGUIController _loadingNGUIController;

	public static RegimGame regim
	{
		get
		{
			return _regim;
		}
		set
		{
			_regim = value;
			UpdateUseMasMaps();
		}
	}

	internal static bool InterstitialRequest { get; set; }

	internal static bool ReplaceAdmobWithPerelivRequest { get; set; }

	public static string MainLoadingTexture()
	{
		return MemoryLimit.OptOut() ? "main_loading" : ((!Device.isRetinaAndStrong) ? "main_loading" : "main_loading_Hi");
	}

	public static void GoToClans()
	{
		FriendsController friendsController = FriendsController.sharedController;
		if (friendsController != null)
		{
			friendsController.StartCoroutine(friendsController.GetFriendDataOnce(true));
		}
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = "Clans";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	public static void GoToFriends()
	{
		FriendsController friendsController = FriendsController.sharedController;
		if (friendsController != null)
		{
			friendsController.StartCoroutine(friendsController.GetFriendDataOnce(true));
		}
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = "Friends";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	public static void Local()
	{
		if (EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Paused || EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Recording)
		{
			EveryplayWrapper.Instance.Stop();
		}
		PhotonNetwork.Disconnect();
		if (Defs.isGameFromFriends)
		{
			GoToFriends();
			return;
		}
		if (Defs.isGameFromClans)
		{
			GoToClans();
			return;
		}
		LoadConnectScene.textureToShow = null;
		LoadConnectScene.sceneToLoad = "ConnectScene";
		LoadConnectScene.noteToShow = null;
		Application.LoadLevel(Defs.PromSceneName);
	}

	public static void GoToProfile()
	{
		PlayerPrefs.SetInt(Defs.SkinEditorMode, 1);
		GlobalGameController.EditingLogo = 0;
		GlobalGameController.EditingCape = 0;
		Application.LoadLevel("SkinEditor");
	}

	private void Start()
	{
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.Refresh();
		}
		if (ExpController.Instance != null)
		{
			ExpController.Instance.Refresh();
		}
		rulesDeadmatch = LocalizationStore.Key_0550;
		rulesTeamFight = LocalizationStore.Key_0551;
		rulesTimeBattle = LocalizationStore.Key_0552;
		rulesDeadlyGames = LocalizationStore.Key_0553;
		rulesFlagCapture = LocalizationStore.Key_0554;
		rulesCapturePoint = LocalizationStore.Get("Key_1368");
		sharedController = this;
		myLevelGame = ((!(ExperienceController.sharedController != null) || ExperienceController.sharedController.currentLevel > 2) ? ((ExperienceController.sharedController != null && ExperienceController.sharedController.currentLevel <= 5) ? 1 : 2) : 0);
		mainPanel.SetActive(false);
		coinsShopButton.SetActive(false);
		selectMapPanel.SetActive(false);
		createPanel.SetActive(false);
		customPanel.SetActive(false);
		searchPanel.SetActive(false);
		setPasswordPanel.SetActive(false);
		enterPasswordPanel.SetActive(false);
		StartSearchLocalServers();
		PlayerPrefs.SetString("TypeGame", "client");
		gameIsfullLabel.gameObject.SetActive(false);
		accountBlockedLabel.gameObject.SetActive(false);
		serverIsNotAvalible.gameObject.SetActive(false);
		nameAlreadyUsedLabel.gameObject.SetActive(false);
		incorrectPasswordLabel.gameObject.SetActive(false);
		unlockMapBtn.SetActive(false);
		unlockMapBtnInCreate.SetActive(false);
		unlockBtn.SetActive(false);
		string path = MainLoadingTexture();
		loadingToDraw.mainTexture = Resources.Load<Texture>(path);
		loadingMapPanel.SetActive(true);
		connectToPhotonPanel.SetActive(false);
		if (PhotonNetwork.connectionState == ConnectionState.Connected)
		{
			firstConnectToPhoton = true;
		}
		ScrollTransform.GetComponent<UIPanel>().baseClipRegion = new Vector4(0f, 0f, 760 * Screen.width / Screen.height, 350f);
		SetPosSelectMapPanelInMainMenu();
		regim = ((!(ExperienceController.sharedController != null) || ExperienceController.sharedController.currentLevel > 4) ? ((RegimGame)PlayerPrefs.GetInt("RegimMulty", 2)) : RegimGame.TeamFight);
		deathmatchToggle.value = regim == RegimGame.Deathmatch;
		timeBattleToogle.value = regim == RegimGame.TimeBattle;
		teamFightToogle.value = regim == RegimGame.TeamFight;
		deadlyGamesToogle.value = regim == RegimGame.DeadlyGames;
		flagCaptureToogle.value = regim == RegimGame.FlagCapture;
		capturePointsToogle.value = regim == RegimGame.CapturePoints;
		deathmatchToggle.GetComponent<ButtonHandler>().Clicked += SetRegimDeathmatch;
		timeBattleToogle.GetComponent<ButtonHandler>().Clicked += SetRegimTimeBattle;
		teamFightToogle.GetComponent<ButtonHandler>().Clicked += SetRegimTeamFight;
		deadlyGamesToogle.GetComponent<ButtonHandler>().Clicked += SetRegimDeadleGames;
		flagCaptureToogle.GetComponent<ButtonHandler>().Clicked += SetRegimFlagCapture;
		capturePointsToogle.GetComponent<ButtonHandler>().Clicked += SetRegimCapturePoints;
		StartCoroutine(LoadMapPreview());
		if (localBtn != null)
		{
			ButtonHandler component = localBtn.GetComponent<ButtonHandler>();
			if (component != null)
			{
				component.Clicked += HandleLocalBtnClicked;
			}
		}
		if (customBtn != null)
		{
			ButtonHandler component2 = customBtn.GetComponent<ButtonHandler>();
			if (component2 != null)
			{
				component2.Clicked += HandleCustomBtnClicked;
			}
		}
		if (randomBtn != null)
		{
			ButtonHandler component3 = randomBtn.GetComponent<ButtonHandler>();
			if (component3 != null)
			{
				component3.Clicked += HandleRandomBtnClicked;
			}
		}
		if (goBtn != null)
		{
			ButtonHandler component4 = goBtn.GetComponent<ButtonHandler>();
			if (component4 != null)
			{
				component4.Clicked += HandleGoBtnClicked;
			}
		}
		if (backBtn != null)
		{
			ButtonHandler component5 = backBtn.GetComponent<ButtonHandler>();
			if (component5 != null)
			{
				component5.Clicked += HandleBackBtnClicked;
			}
		}
		if (unlockBtn != null)
		{
			ButtonHandler component6 = unlockBtn.GetComponent<ButtonHandler>();
			if (component6 != null)
			{
				component6.Clicked += HandleUnlockBtnClicked;
			}
		}
		if (coinsShopButton != null)
		{
			ButtonHandler component7 = coinsShopButton.GetComponent<ButtonHandler>();
			if (component7 != null)
			{
				component7.Clicked += HandleCoinsShopClicked;
			}
		}
		if (unlockMapBtn != null)
		{
			ButtonHandler component8 = unlockMapBtn.GetComponent<ButtonHandler>();
			if (component8 != null)
			{
				component8.Clicked += HandleUnlockMapBtnClicked;
			}
		}
		if (unlockMapBtnInCreate != null)
		{
			ButtonHandler component9 = unlockMapBtnInCreate.GetComponent<ButtonHandler>();
			if (component9 != null)
			{
				component9.Clicked += HandleUnlockMapBtnClicked;
			}
		}
		if (cancelFromConnectToPhotonBtn != null)
		{
			ButtonHandler component10 = cancelFromConnectToPhotonBtn.GetComponent<ButtonHandler>();
			if (component10 != null)
			{
				component10.Clicked += HandleCancelFromConnectToPhotonBtnClicked;
			}
		}
		if (clearBtn != null)
		{
			ButtonHandler component11 = clearBtn.GetComponent<ButtonHandler>();
			if (component11 != null)
			{
				component11.Clicked += HandleClearBtnClicked;
			}
		}
		if (searchBtn != null)
		{
			ButtonHandler component12 = searchBtn.GetComponent<ButtonHandler>();
			if (component12 != null)
			{
				component12.Clicked += HandleSearchBtnClicked;
			}
		}
		if (showSearchPanelBtn != null)
		{
			ButtonHandler component13 = showSearchPanelBtn.GetComponent<ButtonHandler>();
			if (component13 != null)
			{
				component13.Clicked += HandleShowSearchPanelBtnClicked;
			}
		}
		if (goToCreateRoomBtn != null)
		{
			ButtonHandler component14 = goToCreateRoomBtn.GetComponent<ButtonHandler>();
			if (component14 != null)
			{
				component14.Clicked += HandleGoToCreateRoomBtnClicked;
			}
		}
		if (createRoomBtn != null)
		{
			createRoomUIBtn = createRoomBtn.GetComponent<UIButton>();
			ButtonHandler component15 = createRoomBtn.GetComponent<ButtonHandler>();
			if (component15 != null)
			{
				component15.Clicked += HandleCreateRoomBtnClicked;
			}
		}
		if (setPasswordBtn != null)
		{
			ButtonHandler component16 = setPasswordBtn.GetComponent<ButtonHandler>();
			if (component16 != null)
			{
				component16.Clicked += HandleSetPasswordBtnClicked;
			}
		}
		if (clearInSetPasswordBtn != null)
		{
			ButtonHandler component17 = clearInSetPasswordBtn.GetComponent<ButtonHandler>();
			if (component17 != null)
			{
				component17.Clicked += HandleClearInSetPasswordBtnClicked;
			}
		}
		if (okInsetPasswordBtn != null)
		{
			ButtonHandler component18 = okInsetPasswordBtn.GetComponent<ButtonHandler>();
			if (component18 != null)
			{
				component18.Clicked += HandleOkInsetPasswordBtnClicked;
			}
		}
		if (joinRoomFromEnterPasswordBtn != null)
		{
			ButtonHandler component19 = joinRoomFromEnterPasswordBtn.GetComponent<ButtonHandler>();
			if (component19 != null)
			{
				component19.Clicked += HandleJoinRoomFromEnterPasswordBtnClicked;
			}
		}
		if (true)
		{
			SetUnLockedButton(flagCaptureToogle);
		}
		if (true)
		{
			SetUnLockedButton(deadlyGamesToogle);
		}
		InitializeBannerWindow();
		InterstitialManager.Instance.ResetAdProvider();
		if (ReplaceAdmobPerelivController.ReplaceAdmobWithPerelivApplicable() && ReplaceAdmobWithPerelivRequest)
		{
			ReplaceAdmobWithPerelivRequest = false;
			StartCoroutine(WaitLoadingAndShowReplaceAdmobPereliv("Connect Scene", false));
		}
	}

	private void OnApplicationPause(bool pausing)
	{
		if (pausing)
		{
			LogUserQuit();
			return;
		}
		InterstitialManager.Instance.ResetAdProvider();
		bool flag = ReplaceAdmobPerelivController.ReplaceAdmobWithPerelivApplicable() && ReplaceAdmobPerelivController.sharedController != null;
		if (flag)
		{
			ReplaceAdmobPerelivController.IncreaseTimesCounter();
		}
		if (flag && ReplaceAdmobPerelivController.ShouldShowAtThisTime && !loadAdmobRunning)
		{
			StartCoroutine(WaitLoadingAndShowReplaceAdmobPereliv("On return from pause to Connect Scene"));
		}
	}

	private IEnumerator WaitLoadingAndShowReplaceAdmobPereliv(string context, bool loadData = true)
	{
		if (loadReplaceAdmobPerelivRunning)
		{
			yield break;
		}
		try
		{
			loadReplaceAdmobPerelivRunning = true;
			if (loadData && !ReplaceAdmobPerelivController.sharedController.DataLoading && !ReplaceAdmobPerelivController.sharedController.DataLoaded)
			{
				ReplaceAdmobPerelivController.sharedController.LoadPerelivData();
			}
			while (ReplaceAdmobPerelivController.sharedController == null || !ReplaceAdmobPerelivController.sharedController.DataLoaded)
			{
				if (!ReplaceAdmobPerelivController.sharedController.DataLoading)
				{
					loadReplaceAdmobPerelivRunning = false;
					yield break;
				}
				yield return null;
			}
			if (mainPanel != null)
			{
				while (!mainPanel.activeInHierarchy)
				{
					yield return null;
				}
				yield return new WaitForSeconds(0.5f);
			}
			ReplaceAdmobPerelivController.TryShowPereliv(context);
			ReplaceAdmobPerelivController.sharedController.DestroyImage();
		}
		finally
		{
			loadReplaceAdmobPerelivRunning = false;
		}
	}

	private IEnumerator WaitLoadingAndShowInterstitialCoroutine(string context, bool loadData = true)
	{
		if (Defs.IsDeveloperBuild)
		{
			Debug.Log("Starting WaitLoadingAndShowInterstitialCoroutine()    " + InterstitialManager.Instance.Provider);
		}
		if (loadAdmobRunning)
		{
			if (Defs.IsDeveloperBuild)
			{
				Debug.Log("Quitting WaitLoadingAndShowInterstitialCoroutine() because loadAdmobRunning==true");
			}
			yield break;
		}
		loadAdmobRunning = true;
		try
		{
			if (InterstitialManager.Instance.Provider == AdProvider.Fyber)
			{
				float loadAttemptTime = Time.realtimeSinceStartup;
				if (Defs.IsDeveloperBuild)
				{
					Debug.Log("FyberFacade.Instance.Requests.Count: " + FyberFacade.Instance.Requests.Count);
				}
				LogUserInterstitialRequest();
				Future<bool> request2 = ((FyberFacade.Instance.Requests.Count <= 0) ? FyberFacade.Instance.RequestImageInterstitial("WaitLoadingAndShowInterstitialCoroutine()") : FyberFacade.Instance.Requests.Dequeue());
				if (Defs.IsDeveloperBuild)
				{
					Debug.Log("WaitLoadingAndShowInterstitialCoroutine(): Fyber request is completed: " + request2.IsCompleted);
				}
				while (!request2.IsCompleted)
				{
					if (Time.realtimeSinceStartup - loadAttemptTime > 5f)
					{
						if (Defs.IsDeveloperBuild)
						{
							Debug.Log("Loading timed out: " + InterstitialManager.Instance.Provider);
						}
						InterstitialManager.Instance.SwitchAdProvider();
						if (_countOfLoopsRequestAdThisTime < PromoActionsManager.MobileAdvert.CountRoundReplaceProviders - 1)
						{
							_countOfLoopsRequestAdThisTime++;
							if (InterstitialManager.Instance.Provider == AdProvider.Fyber)
							{
								LogUserInterstitialRequest();
								Future<bool> r = FyberFacade.Instance.RequestImageInterstitial("WaitLoadingAndShowInterstitialCoroutine()");
								FyberFacade.Instance.Requests.Enqueue(r);
							}
							else if (InterstitialManager.Instance.Provider == AdProvider.GoogleMobileAds)
							{
								LogUserInterstitialRequest();
							}
							loadAdmobRunning = false;
							yield return StartCoroutine(WaitLoadingAndShowInterstitialCoroutine(context, loadData));
						}
						yield break;
					}
					yield return null;
				}
				if (!request2.Result)
				{
					Debug.Log("Fyber offers are still not available, switching.");
					InterstitialManager.Instance.SwitchAdProvider();
					if (_countOfLoopsRequestAdThisTime < PromoActionsManager.MobileAdvert.CountRoundReplaceProviders - 1)
					{
						_countOfLoopsRequestAdThisTime++;
						if (InterstitialManager.Instance.Provider == AdProvider.Fyber)
						{
							LogUserInterstitialRequest();
							Future<bool> r2 = FyberFacade.Instance.RequestImageInterstitial("WaitLoadingAndShowInterstitialCoroutine()");
							FyberFacade.Instance.Requests.Enqueue(r2);
						}
						else if (InterstitialManager.Instance.Provider == AdProvider.GoogleMobileAds)
						{
							LogUserInterstitialRequest();
						}
						loadAdmobRunning = false;
						yield return StartCoroutine(WaitLoadingAndShowInterstitialCoroutine(context, loadData));
					}
					yield break;
				}
				if (mainPanel != null)
				{
					while (!mainPanel.activeInHierarchy)
					{
						yield return null;
					}
					yield return new WaitForSeconds(0.5f);
				}
				if (!PhotonNetwork.inRoom)
				{
					Future<InterstitialResult> showTask = FyberFacade.Instance.ShowInterstitial("WaitLoadingAndShowInterstitialCoroutine()");
					Storager.setInt("PendingInterstitial", 8, false);
					string context2 = default(string);
					showTask.Completed += delegate
					{
						Storager.setInt("PendingInterstitial", 0, false);
						Dictionary<string, string> dictionary = new Dictionary<string, string> { { "Context", context2 } };
						if (ExperienceController.sharedController != null)
						{
							dictionary.Add("Level", ExperienceController.sharedController.currentLevel.ToString());
						}
						if (ExpController.Instance != null)
						{
							dictionary.Add("Tier", ExpController.Instance.OurTier.ToString());
						}
						FlurryPluginWrapper.LogEventAndDublicateToConsole("Fyber ADV Interstitial", dictionary);
						LogIsShowAdvert("Connect Scene", true);
						isStartShowAdvert = false;
					};
				}
				else
				{
					Dictionary<string, string> parameters2 = new Dictionary<string, string> { { "Fyber - Interstitial", "Impression: Canceled (in Photon room)" } };
					FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters2);
				}
			}
			else if (InterstitialManager.Instance.Provider == AdProvider.GoogleMobileAds)
			{
				float loadAttemptTime2 = Time.realtimeSinceStartup;
				if (mainPanel != null)
				{
					while (!mainPanel.activeInHierarchy)
					{
						yield return null;
					}
					yield return new WaitForSeconds(0.5f);
				}
				if (!PhotonNetwork.inRoom)
				{
				}
				else
				{
					Dictionary<string, string> parameters = new Dictionary<string, string> { { "AdMob - Image", "Impression: Canceled (in Photon room)" } };
					FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
				}
			}
			_lastTimeInterstitialShown = Time.realtimeSinceStartup;
		}
		finally
		{
			loadAdmobRunning = false;
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

	private void SetUnLockedButton(UIToggle butToogle)
	{
		UIButton component = butToogle.gameObject.GetComponent<UIButton>();
		component.normalSprite = "yell_btn";
		component.hoverSprite = "yell_btn";
		component.pressedSprite = "green_btn_n";
		butToogle.transform.Find("LockedSprite").gameObject.SetActive(false);
		butToogle.transform.Find("Checkmark").GetComponent<UISprite>().spriteName = "mode_green_on";
	}

	private void SetRegimDeathmatch(object sender, EventArgs e)
	{
		if (regim != 0)
		{
			SetRegim(RegimGame.Deathmatch);
		}
	}

	private void SetRegimTeamFight(object sender, EventArgs e)
	{
		if (regim != RegimGame.TeamFight)
		{
			SetRegim(RegimGame.TeamFight);
		}
	}

	private void SetRegimTimeBattle(object sender, EventArgs e)
	{
		if (regim != RegimGame.TimeBattle)
		{
			SetRegim(RegimGame.TimeBattle);
		}
	}

	private void SetRegimDeadleGames(object sender, EventArgs e)
	{
		if (regim != RegimGame.DeadlyGames)
		{
			SetRegim(RegimGame.DeadlyGames);
		}
	}

	private void SetRegimFlagCapture(object sender, EventArgs e)
	{
		if (regim != RegimGame.FlagCapture)
		{
			SetRegim(RegimGame.FlagCapture);
		}
	}

	private void SetRegimCapturePoints(object sender, EventArgs e)
	{
		if (regim != RegimGame.CapturePoints)
		{
			SetRegim(RegimGame.CapturePoints);
		}
	}

	private void HandleJoinRoomFromEnterPasswordBtnClicked(object sender, EventArgs e)
	{
		if (enterPasswordInput.value.Equals(joinRoomInfoFromCustom.customProperties["pass"].ToString()))
		{
			JoinToRoomPhotonAfterCheck();
			return;
		}
		enterPasswordPanel.SetActive(false);
		ExperienceController.sharedController.isShowRanks = true;
		customPanel.SetActive(true);
		Invoke("UpdateFilteredRoomListInvoke", 0.03f);
	}

	private void HandleSetPasswordBtnClicked(object sender, EventArgs e)
	{
		createPanel.SetActive(false);
		coinsShopButton.SetActive(false);
		selectMapPanel.SetActive(false);
		setPasswordInput.value = password;
		setPasswordPanel.SetActive(true);
	}

	private void HandleClearInSetPasswordBtnClicked(object sender, EventArgs e)
	{
		setPasswordInput.value = string.Empty;
	}

	private void HandleOkInsetPasswordBtnClicked(object sender, EventArgs e)
	{
		password = setPasswordInput.value;
		BackFromSetPasswordPanel();
	}

	private void BackFromSetPasswordPanel()
	{
		createPanel.SetActive(true);
		coinsShopButton.SetActive(true);
		selectMapPanel.SetActive(true);
		passONSprite.SetActive(!string.IsNullOrEmpty(password));
		setPasswordPanel.SetActive(false);
	}

	private void HandleCreateRoomBtnClicked(object sender, EventArgs e)
	{
		string text = FilterBadWorld.FilterString(nameServerInput.value);
		bool flag = false;
		if (Defs.isInet)
		{
			RoomInfo[] roomList = PhotonNetwork.GetRoomList();
			for (int i = 0; i < roomList.Length; i++)
			{
				if (roomList[i].name.Equals(text))
				{
					flag = true;
					break;
				}
			}
		}
		if (flag)
		{
			nameAlreadyUsedLabel.timer = 3f;
			nameAlreadyUsedLabel.gameObject.SetActive(true);
			return;
		}
		goMapName = Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()];
		PlayerPrefs.SetString("MapName", goMapName);
		if (killToWin.value.Value > killToWin.maxValue.Value)
		{
			killToWin.value = killToWin.maxValue;
		}
		if (killToWin.value.Value < killToWin.minValue.Value)
		{
			killToWin.value = killToWin.minValue;
		}
		PlayerPrefs.SetString("MaxKill", killToWin.value.Value.ToString());
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]) ? Defs.filterMaps[Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]] : 0);
		}
		StartCoroutine(SetFonLoadingWaitForReset(goMapName));
		loadingMapPanel.SetActive(true);
		int num = ((regim != 0 && regim != RegimGame.TimeBattle && regim != RegimGame.DeadlyGames) ? teamCountPlayer.value : numberOfPlayer.value.Value);
		if (Defs.isInet)
		{
			int num2 = 7;
			string[] array = new string[num2 + ExperienceController.maxLevel];
			array[0] = "starting";
			array[1] = "map";
			array[2] = "MaxKill";
			array[3] = "pass";
			array[4] = "regim";
			array[5] = "TimeMatchEnd";
			array[6] = "platform";
			for (int j = num2; j < num2 + ExperienceController.maxLevel; j++)
			{
				array[j] = "Level_" + (j - num2 + 1);
			}
			ExitGames.Client.Photon.Hashtable hashtable = new ExitGames.Client.Photon.Hashtable();
			hashtable["starting"] = 0;
			hashtable["map"] = Defs.levelNumsForMusicInMult[goMapName];
			hashtable["MaxKill"] = killToWin.value.Value;
			hashtable["pass"] = password;
			hashtable["regim"] = regim;
			hashtable["TimeMatchEnd"] = PhotonNetwork.time;
			hashtable["platform"] = (int)((!string.IsNullOrEmpty(password)) ? PlatformConnect.custom : myPlatformConnect);
			for (int k = num2; k < num2 + ExperienceController.maxLevel; k++)
			{
				hashtable["Level_" + (k - num2 + 1)] = ((ExperienceController.sharedController != null && ExperienceController.sharedController.currentLevel == k - num2 + 1) ? 1 : 0);
			}
			loadingMapPanel.SetActive(true);
			if (StoreKitEventListener.purchaseActivityInd != null)
			{
				StoreKitEventListener.purchaseActivityInd.SetActive(true);
			}
			PhotonNetwork.CreateRoom(text);
		}
		else
		{
			//bool useNat = PhotonNetwork.HavePublicAddress();
			//PhotonNetwork.InitializeServer(num - 1, 25002, useNat);
			PlayerPrefs.SetString("ServerName", text);
			PlayerPrefs.SetString("PlayersLimits", num.ToString());
			Application.LoadLevelAsync("PromScene");
		}
	}

	private void HandleGoToCreateRoomBtnClicked(object sender, EventArgs e)
	{
		PlayerPrefs.SetString("TypeGame", "server");
		password = string.Empty;
		passONSprite.SetActive(false);
		SetPosSelectMapPanelInCreatePanel();
		createPanel.SetActive(true);
		coinsShopButton.SetActive(true);
		setPasswordBtn.SetActive(Defs.isInet);
		selectMapPanel.SetActive(true);
		customPanel.SetActive(false);
		nameAlreadyUsedLabel.timer = -1f;
		nameAlreadyUsedLabel.gameObject.SetActive(false);
		if (regim == RegimGame.Deathmatch)
		{
			teamCountPlayer.gameObject.SetActive(false);
			numberOfPlayer.gameObject.SetActive(true);
			numberOfPlayer.transform.localPosition = new Vector3(posNumberOffPlayersX, numberOfPlayer.transform.localPosition.y, numberOfPlayer.transform.localPosition.z);
			numberOfPlayer.minValue.Value = 2;
			numberOfPlayer.maxValue.Value = 10;
			numberOfPlayer.value.Value = 10;
			killToWin.headLabel.text = LocalizationStore.Get("Key_0953");
			killToWin.gameObject.SetActive(true);
			if (ExperienceController.sharedController != null)
			{
				if (ExperienceController.sharedController.currentLevel <= 2)
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
					killToWin.stepValue = 2;
				}
				else
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
					killToWin.stepValue = 2;
				}
			}
		}
		if (regim == RegimGame.TimeBattle)
		{
			teamCountPlayer.gameObject.SetActive(false);
			numberOfPlayer.gameObject.SetActive(true);
			numberOfPlayer.transform.localPosition = new Vector3(0f, numberOfPlayer.transform.localPosition.y, numberOfPlayer.transform.localPosition.z);
			numberOfPlayer.minValue.Value = 2;
			numberOfPlayer.maxValue.Value = 4;
			numberOfPlayer.value.Value = 4;
			killToWin.gameObject.SetActive(false);
		}
		if (regim == RegimGame.TeamFight)
		{
			teamCountPlayer.gameObject.SetActive(true);
			teamCountPlayer.SetValue(10);
			numberOfPlayer.gameObject.SetActive(false);
			numberOfPlayer.transform.localPosition = new Vector3(posNumberOffPlayersX, numberOfPlayer.transform.localPosition.y, numberOfPlayer.transform.localPosition.z);
			killToWin.gameObject.SetActive(true);
			killToWin.headLabel.text = LocalizationStore.Get("Key_0953");
			killToWin.stepValue = 2;
			if (ExperienceController.sharedController != null)
			{
				if (ExperienceController.sharedController.currentLevel <= 2)
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
				}
				else
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
				}
			}
		}
		if (regim == RegimGame.FlagCapture)
		{
			teamCountPlayer.gameObject.SetActive(true);
			teamCountPlayer.SetValue(10);
			numberOfPlayer.gameObject.SetActive(false);
			killToWin.gameObject.SetActive(true);
			killToWin.headLabel.text = LocalizationStore.Get("Key_0953");
			killToWin.stepValue = 2;
			if (ExperienceController.sharedController != null)
			{
				if (ExperienceController.sharedController.currentLevel <= 2)
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
				}
				else
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
				}
			}
		}
		if (regim == RegimGame.CapturePoints)
		{
			teamCountPlayer.gameObject.SetActive(true);
			teamCountPlayer.SetValue(10);
			numberOfPlayer.gameObject.SetActive(false);
			killToWin.gameObject.SetActive(true);
			killToWin.headLabel.text = LocalizationStore.Get("Key_0953");
			killToWin.stepValue = 2;
			if (ExperienceController.sharedController != null)
			{
				if (ExperienceController.sharedController.currentLevel <= 2)
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
				}
				else
				{
					killToWin.minValue.Value = 3;
					killToWin.maxValue.Value = 7;
					killToWin.value.Value = 3;
				}
			}
		}
		if (regim != RegimGame.DeadlyGames)
		{
			return;
		}
		teamCountPlayer.gameObject.SetActive(false);
		numberOfPlayer.gameObject.SetActive(true);
		numberOfPlayer.transform.localPosition = new Vector3(posNumberOffPlayersX, numberOfPlayer.transform.localPosition.y, numberOfPlayer.transform.localPosition.z);
		numberOfPlayer.minValue.Value = 3;
		numberOfPlayer.maxValue.Value = 8;
		numberOfPlayer.value.Value = 6;
		killToWin.gameObject.SetActive(true);
		killToWin.headLabel.text = LocalizationStore.Get("Key_0953");
		killToWin.stepValue = 5;
		if (ExperienceController.sharedController != null)
		{
			if (ExperienceController.sharedController.currentLevel <= 2)
			{
				killToWin.minValue.Value = 5;
				killToWin.maxValue.Value = 15;
				killToWin.value.Value = 10;
			}
			else
			{
				killToWin.minValue.Value = 5;
				killToWin.maxValue.Value = 15;
				killToWin.value.Value = 15;
			}
		}
	}

	private void HandleShowSearchPanelBtnClicked(object sender, EventArgs e)
	{
		customPanel.SetActive(false);
		if (searchInput != null)
		{
			searchInput.value = gameNameFilter;
		}
		searchPanel.SetActive(true);
	}

	private void HandleClearBtnClicked(object sender, EventArgs e)
	{
		if (searchInput != null)
		{
			searchInput.value = string.Empty;
		}
	}

	private void HandleSearchBtnClicked(object sender, EventArgs e)
	{
		customPanel.SetActive(true);
		if (searchInput != null)
		{
			gameNameFilter = searchInput.value;
		}
		updateFilteredRoomList(gameNameFilter);
		searchPanel.SetActive(false);
	}

	private void HandleCancelFromConnectToPhotonBtnClicked(object sender, EventArgs e)
	{
		failInternetLabel.SetActive(false);
		connectToPhotonPanel.SetActive(false);
		actAfterConnectToPhoton = null;
	}

	private void HandleUnlockMapBtnClicked(object sender, EventArgs e)
	{
		int mapPrice = Defs.PremiumMaps[Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]];
		Action action = null;
		action = delegate
		{
			coinsShop.thisScript.notEnoughCurrency = null;
			coinsShop.thisScript.onReturnAction = null;
			int @int = Storager.getInt("Coins", false);
			int num = @int - mapPrice;
			string text = Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()];
			if (num >= 0)
			{
				FlurryPluginWrapper.LogEvent("Unlock " + text + " map");
				Storager.setInt(text + "Key", 1, true);
				grid.transform.Find("Map_" + selectIndexMap).GetComponent<UITexture>().mainTexture = mapPreview[text];
				Storager.setInt("Coins", num, false);
				ShopNGUIController.SpendBoughtCurrency("Coins", mapPrice);
				PlayerPrefs.Save();
				ShopNGUIController.SynchronizeAndroidPurchases("Map unlocked from connect scene: " + text);
				if (coinsPlashka.thisScript != null)
				{
					coinsPlashka.thisScript.enabled = false;
				}
			}
			else
			{
				StoreKitEventListener.State.PurchaseKey = "In map selection";
				FlurryPluginWrapper.LogEvent("Try_Enable " + text + " map");
				if (BankController.Instance != null)
				{
					EventHandler handleBackFromBank = null;
					handleBackFromBank = delegate
					{
						BankController.Instance.BackRequested -= handleBackFromBank;
						mainPanel.transform.root.gameObject.SetActive(true);
						coinsShop.thisScript.notEnoughCurrency = null;
						BankController.Instance.InterfaceEnabled = false;
					};
					BankController.Instance.BackRequested += handleBackFromBank;
					mainPanel.transform.root.gameObject.SetActive(false);
					coinsShop.thisScript.notEnoughCurrency = "Coins";
					BankController.Instance.InterfaceEnabled = true;
				}
				else
				{
					Debug.LogWarning("BankController.Instance == null");
				}
			}
		};
		action();
	}

	public void ShowBankWindow()
	{
		if (BankController.Instance != null)
		{
			EventHandler backFromBankHandler = null;
			backFromBankHandler = delegate
			{
				BankController.Instance.BackRequested -= backFromBankHandler;
				mainPanel.transform.root.gameObject.SetActive(true);
				BankController.Instance.InterfaceEnabled = false;
			};
			BankController.Instance.BackRequested += backFromBankHandler;
			mainPanel.transform.root.gameObject.SetActive(false);
			BankController.Instance.InterfaceEnabled = true;
		}
		else
		{
			Debug.LogWarning("BankController.Instance == null");
		}
	}

	private void HandleCoinsShopClicked(object sender, EventArgs e)
	{
		ShowBankWindow();
	}

	private void HandleLocalBtnClicked(object sender, EventArgs e)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining(string.Concat(regim, ".Local"), TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		Defs.isInet = false;
		UpdateLocalServersList();
		CustomBtnAct();
	}

	private void ShowConnectToPhotonPanel()
	{
		if (FriendsController.sharedController != null && FriendsController.sharedController.Banned == 1)
		{
			accountBlockedLabel.timer = 3f;
			accountBlockedLabel.gameObject.SetActive(true);
		}
		else
		{
			ConnectToPhoton();
			connectToPhotonPanel.SetActive(true);
		}
	}

	private void HandleCustomBtnClicked(object sender, EventArgs e)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining(string.Concat(regim, ".Custom"), TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		actAfterConnectToPhoton = CustomBtnAct;
		PhotonNetwork.autoJoinLobby = true;
		ShowConnectToPhotonPanel();
	}

	private void CustomBtnAct()
	{
		gameNameFilter = string.Empty;
		if (Defs.isInet)
		{
			Invoke("UpdateFilteredRoomListInvoke", 0.03f);
		}
		showSearchPanelBtn.SetActive(Defs.isInet);
		mainPanel.SetActive(false);
		coinsShopButton.SetActive(false);
		selectMapPanel.SetActive(false);
		customPanel.SetActive(true);
		password = string.Empty;
		incorrectPasswordLabel.timer = -1f;
		incorrectPasswordLabel.gameObject.SetActive(false);
		gameIsfullLabel.timer = -1f;
		gameIsfullLabel.gameObject.SetActive(false);
	}

	[Obfuscation(Exclude = true)]
	private void UpdateFilteredRoomListInvoke()
	{
		updateFilteredRoomList(gameNameFilter);
	}

	private void HandleRandomBtnClicked(object sender, EventArgs e)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining(string.Concat(regim, ".Random"), TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		actAfterConnectToPhoton = RandomBtnAct;
		PhotonNetwork.autoJoinLobby = false;
		ShowConnectToPhotonPanel();
	}

	private void RandomBtnAct()
	{
		int num = UnityEngine.Random.Range(0, masUseMaps.Length);
		do
		{
			num++;
			if (num >= masUseMaps.Length)
			{
				num = 0;
			}
		}
		while (Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[string.Empty + masUseMaps[num]]) && Storager.getInt(Defs.levelNamesFromNums[string.Empty + masUseMaps[num]] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[string.Empty + masUseMaps[num]]));
		JoinRandomRoom(masUseMaps[num]);
	}

	private void HandleGoBtnClicked(object sender, EventArgs e)
	{
		if (TrainingController.TrainingCompleted.HasValue)
		{
			FlurryEvents.LogAfterTraining(string.Concat(regim, ".Go"), TrainingController.TrainingCompleted.Value);
			TrainingController.TrainingCompleted = null;
		}
		actAfterConnectToPhoton = GoBtnAct;
		PhotonNetwork.autoJoinLobby = false;
		ShowConnectToPhotonPanel();
	}

	private void JoinRandomRoom(int _map)
	{
		goMapName = Defs.levelNamesFromNums[_map.ToString()];
		ExitGames.Client.Photon.Hashtable hashtable = new ExitGames.Client.Photon.Hashtable();
		hashtable["pass"] = string.Empty;
		hashtable["map"] = _map;
		hashtable["starting"] = 0;
		hashtable["regim"] = regim;
		hashtable["platform"] = (int)myPlatformConnect;
		if (ExperienceController.sharedController != null)
		{
			for (int i = 0; i < ExperienceController.maxLevel; i++)
			{
				if (ExperienceController.accessByLevels[ExperienceController.sharedController.currentLevel - 1, i] == 0)
				{
					hashtable["Level_" + (i + 1)] = 0;
				}
			}
		}
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(goMapName) ? Defs.filterMaps[goMapName] : 0);
		}
		StartCoroutine(SetFonLoadingWaitForReset(goMapName));
		PlayerPrefs.SetString("TypeGame", "client");
		PhotonNetwork.JoinRandomRoom(hashtable, 0);
		if (StoreKitEventListener.purchaseActivityInd == null)
		{
			Debug.LogWarning("StoreKitEventListener.purchaseActivityInd");
		}
		else
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(true);
		}
		FlurryPluginWrapper.LogEnteringMap(0, Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]);
		FlurryPluginWrapper.LogMultiplayerWayStart();
		loadingMapPanel.SetActive(true);
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(true);
		}
	}

	private void GoBtnAct()
	{
		JoinRandomRoom(masUseMaps[selectIndexMap]);
	}

	private void OnGUI()
	{
		if (DeveloperConsoleController.isDebugGuiVisible && GUI.Button(new Rect(100f, 50f, 200f, 100f), "OnAppPause"))
		{
			OnApplicationPause(false);
		}
	}

	private void HandleBackBtnClicked(object sender, EventArgs e)
	{
		if (FriendsController.sharedController != null)
		{
			FriendsController.sharedController.StartCoroutine(FriendsController.sharedController.GetFriendDataOnce(false));
		}
		if (mainPanel != null && mainPanel.activeSelf)
		{
			FlurryPluginWrapper.LogEvent("Back to Main Menu");
			MenuBackgroundMusic.keepPlaying = true;
			LoadConnectScene.textureToShow = null;
			LoadConnectScene.sceneToLoad = Defs.MainMenuScene;
			LoadConnectScene.noteToShow = null;
			Application.LoadLevel(Defs.PromSceneName);
			isGoInPhotonGame = false;
		}
		if (customPanel != null && customPanel.activeSelf)
		{
			connectToWiFIInCreateLabel.SetActive(false);
			connectToWiFIInCustomLabel.SetActive(false);
			createRoomUIBtn.isEnabled = true;
			Defs.isInet = true;
			customPanel.SetActive(false);
			mainPanel.SetActive(true);
			coinsShopButton.SetActive(true);
			selectMapPanel.SetActive(true);
			PhotonNetwork.Disconnect();
		}
		if (searchPanel != null && searchPanel.activeSelf)
		{
			searchInput.value = gameNameFilter;
			searchPanel.SetActive(false);
			customPanel.SetActive(true);
		}
		if (createPanel != null && createPanel.activeSelf)
		{
			PlayerPrefs.SetString("TypeGame", "client");
			SetPosSelectMapPanelInMainMenu();
			createPanel.SetActive(false);
			coinsShopButton.SetActive(false);
			selectMapPanel.SetActive(false);
			customPanel.SetActive(true);
		}
		if (setPasswordPanel != null && setPasswordPanel.activeSelf)
		{
			BackFromSetPasswordPanel();
		}
		if (enterPasswordPanel != null && enterPasswordPanel.activeSelf)
		{
			enterPasswordPanel.SetActive(false);
			customPanel.SetActive(true);
			ExperienceController.sharedController.isShowRanks = true;
		}
	}

	private void HandleUnlockBtnClicked(object sender, EventArgs e)
	{
		int _price = 0;
		string _storagerPurchasedKey = string.Empty;
		if (regim == RegimGame.FlagCapture)
		{
			_price = Defs.CaptureFlagPrice;
			_storagerPurchasedKey = Defs.CaptureFlagPurchasedKey;
		}
		if (regim == RegimGame.DeadlyGames)
		{
			_price = Defs.HungerGamesPrice;
			_storagerPurchasedKey = Defs.hungerGamesPurchasedKey;
		}
		Action action = null;
		action = delegate
		{
			coinsShop.thisScript.notEnoughCurrency = null;
			coinsShop.thisScript.onReturnAction = null;
			int @int = Storager.getInt("Coins", false);
			int num = @int - _price;
			if (num >= 0)
			{
				FlurryPluginWrapper.LogEvent("Enable_Flags");
				Storager.setInt(_storagerPurchasedKey, 1, true);
				Storager.setInt("Coins", num, false);
				ShopNGUIController.SpendBoughtCurrency("Coins", _price);
				PlayerPrefs.Save();
				ShopNGUIController.SynchronizeAndroidPurchases("Mode enabled");
				if (coinsPlashka.thisScript != null)
				{
					coinsPlashka.thisScript.enabled = false;
				}
				if (regim == RegimGame.FlagCapture)
				{
					SetUnLockedButton(flagCaptureToogle);
				}
				if (regim == RegimGame.DeadlyGames)
				{
					SetUnLockedButton(deadlyGamesToogle);
				}
				unlockBtn.SetActive(false);
				customBtn.SetActive(true);
				randomBtn.SetActive(true);
				conditionLabel.gameObject.SetActive(false);
				goBtn.SetActive(true);
			}
			else
			{
				FlurryPluginWrapper.LogEvent("Try_Enable_CaptureFlag");
				StoreKitEventListener.State.PurchaseKey = "Mode opened";
				if (BankController.Instance != null)
				{
					EventHandler handleBackFromBank = null;
					handleBackFromBank = delegate
					{
						BankController.Instance.BackRequested -= handleBackFromBank;
						mainPanel.transform.root.gameObject.SetActive(true);
						coinsShop.thisScript.notEnoughCurrency = null;
						BankController.Instance.InterfaceEnabled = false;
					};
					BankController.Instance.BackRequested += handleBackFromBank;
					mainPanel.transform.root.gameObject.SetActive(false);
					coinsShop.thisScript.notEnoughCurrency = "Coins";
					BankController.Instance.InterfaceEnabled = true;
				}
				else
				{
					Debug.LogWarning("BankController.Instance == null");
				}
			}
		};
		action();
	}

	private void SetRegim(RegimGame _regim)
	{
		bool flag = true;
		bool flag2 = true;
		PlayerPrefs.SetInt("RegimMulty", (int)_regim);
		regim = _regim;
		deathmatchToggle.GetComponent<UIButton>().isEnabled = false;
		timeBattleToogle.GetComponent<UIButton>().isEnabled = false;
		teamFightToogle.GetComponent<UIButton>().isEnabled = false;
		deadlyGamesToogle.GetComponent<UIButton>().isEnabled = false;
		flagCaptureToogle.GetComponent<UIButton>().isEnabled = false;
		deathmatchToggle.GetComponent<UIButton>().pressedSprite = ((regim != 0) ? "yell_btn_n" : "green_btn_n");
		timeBattleToogle.GetComponent<UIButton>().pressedSprite = ((regim != RegimGame.TimeBattle) ? "yell_btn_n" : "green_btn_n");
		teamFightToogle.GetComponent<UIButton>().pressedSprite = ((regim != RegimGame.TeamFight) ? "yell_btn_n" : "green_btn_n");
		if (flag)
		{
			deadlyGamesToogle.GetComponent<UIButton>().pressedSprite = ((regim != RegimGame.DeadlyGames) ? "yell_btn_n" : "green_btn_n");
		}
		if (flag2)
		{
			flagCaptureToogle.GetComponent<UIButton>().pressedSprite = ((regim != RegimGame.FlagCapture) ? "yell_btn_n" : "green_btn_n");
		}
		unlockMapBtn.SetActive(false);
		unlockMapBtnInCreate.SetActive(false);
		createRoomBtn.SetActive(true);
		if (regim == RegimGame.Deathmatch)
		{
			Defs.isMulti = true;
			Defs.isInet = true;
			Defs.isCOOP = false;
			Defs.isCompany = false;
			Defs.isHunger = false;
			Defs.isFlag = false;
			Defs.isCapturePoints = false;
			Defs.IsSurvival = false;
			StoreKitEventListener.State.Mode = "Deathmatch Wordwide";
			StoreKitEventListener.State.Parameters.Clear();
			unlockBtn.SetActive(false);
			customBtn.SetActive(true);
			randomBtn.SetActive(true);
			conditionLabel.gameObject.SetActive(false);
			goBtn.SetActive(true);
			localBtn.SetActive(BuildSettings.BuildTarget != BuildTarget.WP8Player);
			rulesLabel.text = rulesDeadmatch;
		}
		if (regim == RegimGame.TimeBattle)
		{
			Defs.isMulti = true;
			Defs.isInet = true;
			Defs.isCOOP = true;
			Defs.isCompany = false;
			Defs.isHunger = false;
			Defs.isFlag = false;
			Defs.isCapturePoints = false;
			unlockBtn.SetActive(false);
			customBtn.SetActive(true);
			randomBtn.SetActive(true);
			conditionLabel.gameObject.SetActive(false);
			goBtn.SetActive(true);
			StoreKitEventListener.State.Mode = "Time Survival";
			StoreKitEventListener.State.Parameters.Clear();
			localBtn.SetActive(false);
			rulesLabel.text = rulesTimeBattle;
		}
		if (regim == RegimGame.TeamFight)
		{
			Defs.isMulti = true;
			Defs.isInet = true;
			Defs.isCOOP = false;
			Defs.isCompany = true;
			Defs.isHunger = false;
			Defs.isFlag = false;
			Defs.isCapturePoints = false;
			unlockBtn.SetActive(false);
			customBtn.SetActive(true);
			randomBtn.SetActive(true);
			conditionLabel.gameObject.SetActive(false);
			goBtn.SetActive(true);
			localBtn.SetActive(BuildSettings.BuildTarget != BuildTarget.WP8Player);
			StoreKitEventListener.State.Mode = "Team Battle";
			StoreKitEventListener.State.Parameters.Clear();
			rulesLabel.text = rulesTeamFight;
		}
		if (regim == RegimGame.FlagCapture)
		{
			Defs.isMulti = true;
			Defs.isInet = true;
			Defs.isCOOP = false;
			Defs.isCompany = false;
			Defs.isHunger = false;
			Defs.isFlag = true;
			Defs.isCapturePoints = false;
			localBtn.SetActive(false);
			rulesLabel.text = rulesFlagCapture;
			if (!flag2)
			{
				priceRegimLabel.text = Defs.CaptureFlagPrice.ToString();
				unlockBtn.SetActive(true);
				customBtn.SetActive(false);
				randomBtn.SetActive(false);
				conditionLabel.gameObject.SetActive(true);
				conditionLabel.text = "REACH LEVEL 4 TO OPEN";
				goBtn.SetActive(false);
			}
			else
			{
				unlockBtn.SetActive(false);
				customBtn.SetActive(true);
				randomBtn.SetActive(true);
				conditionLabel.gameObject.SetActive(false);
				goBtn.SetActive(true);
			}
			StoreKitEventListener.State.Mode = "Flag Capture";
			StoreKitEventListener.State.Parameters.Clear();
		}
		if (regim == RegimGame.CapturePoints)
		{
			Defs.isMulti = true;
			Defs.isInet = true;
			Defs.isCOOP = false;
			Defs.isCompany = false;
			Defs.isHunger = false;
			Defs.isCapturePoints = true;
			Defs.isFlag = false;
			localBtn.SetActive(false);
			rulesLabel.text = rulesCapturePoint;
			unlockBtn.SetActive(false);
			customBtn.SetActive(true);
			randomBtn.SetActive(true);
			conditionLabel.gameObject.SetActive(false);
			goBtn.SetActive(true);
			StoreKitEventListener.State.Mode = "Capture points";
			StoreKitEventListener.State.Parameters.Clear();
		}
		if (regim == RegimGame.DeadlyGames)
		{
			Defs.isMulti = true;
			Defs.isInet = true;
			Defs.isCOOP = false;
			Defs.isCompany = false;
			Defs.isHunger = true;
			Defs.isFlag = false;
			Defs.isCapturePoints = false;
			localBtn.SetActive(false);
			rulesLabel.text = rulesDeadlyGames;
			if (!flag)
			{
				priceRegimLabel.text = Defs.HungerGamesPrice.ToString();
				unlockBtn.SetActive(true);
				customBtn.SetActive(false);
				randomBtn.SetActive(false);
				conditionLabel.gameObject.SetActive(true);
				conditionLabel.text = "REACH LEVEL 3 TO OPEN";
				goBtn.SetActive(false);
			}
			else
			{
				unlockBtn.SetActive(false);
				customBtn.SetActive(true);
				randomBtn.SetActive(true);
				conditionLabel.gameObject.SetActive(false);
				goBtn.SetActive(true);
			}
			Defs.IsSurvival = false;
			StoreKitEventListener.State.Mode = "Deadly Games";
			StoreKitEventListener.State.Parameters.Clear();
			if (WeaponManager.sharedManager != null)
			{
				WeaponManager.sharedManager.GetWeaponPrefabs(0);
			}
		}
		StartCoroutine(SetUseMasMap());
	}

	private void Update()
	{
		try {
			if (Input.GetKeyUp(KeyCode.Escape))
			{
				Input.ResetInputAxes();
				if (BannerWindowController.SharedController != null && BannerWindowController.SharedController.IsAnyBannerShown)
				{
					BannerWindowController.SharedController.HideBannerWindow();
				}
				else
				{
					HandleBackBtnClicked(null, EventArgs.Empty);
				}
				return;
			}
		} catch (Exception e){
			UnityEngine.Debug.LogError("connectscene update 1: " + e.Message);
		}

		try {
			if (customPanel.activeSelf && !Defs.isInet)
			{
				UpdateLocalServersList();
			}
		} catch (Exception e){
			UnityEngine.Debug.LogError("connectscene update 2: " + e.Message);
		}

		try {
			if (!Defs.isInet)
			{
				connectToWiFIInCreateLabel.SetActive(!CheckLocalAvailability());
				connectToWiFIInCustomLabel.SetActive(!CheckLocalAvailability());
				if (createRoomUIBtn.isEnabled != CheckLocalAvailability())
				{
					createRoomUIBtn.isEnabled = CheckLocalAvailability();
				}
			}
			else
			{
				if (connectToWiFIInCreateLabel.activeSelf)
				{
					connectToWiFIInCreateLabel.SetActive(false);
				}
				if (connectToWiFIInCreateLabel.activeSelf)
				{
					connectToWiFIInCustomLabel.SetActive(false);
				}
			}
		} catch (Exception e){
			UnityEngine.Debug.LogError("connectscene update 3: " + e.Message);
		}

		try {
			if (selectMapPanel.activeInHierarchy && GameObject.FindGameObjectsWithTag("TexureSelectMap").Length > 0)
			{
				countMap = grid.transform.childCount;
				selectIndexMap = Mathf.Abs(Mathf.RoundToInt((ScrollTransform.localPosition.x + startPosX) / widthCell)) % countMap;
				if (ScrollTransform.localPosition.x > -1f * startPosX)
				{
					selectIndexMap = countMap - selectIndexMap;
				}
				if (selectIndexMap == countMap)
				{
					selectIndexMap = 0;
				}
			}
		} catch (Exception e){
			UnityEngine.Debug.LogError("connectscene update 4: " + e.Message);
		}

		try {
			if (unlockBtn.activeSelf || (!mainPanel.activeSelf && !createPanel.activeSelf))
			{
				return;
			}
		} catch (Exception e){
			UnityEngine.Debug.LogError("connectscene update 5: " + e.Message);
		}
		try {
			if (!isSetUseMap && Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]) && Storager.getInt(Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]))
			{
				if (!unlockMapBtn.activeSelf)
				{
					priceMapLabel.text = Defs.PremiumMaps[Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]].ToString();
					unlockMapBtn.SetActive(true);
					goBtn.SetActive(false);
					priceMapLabelInCreate.text = Defs.PremiumMaps[Defs.levelNamesFromNums[masUseMaps[selectIndexMap].ToString()]].ToString();
					unlockMapBtnInCreate.SetActive(true);
					createRoomBtn.SetActive(false);
				}
			}
			else if (unlockMapBtn.activeSelf)
			{
				unlockMapBtn.SetActive(false);
				goBtn.SetActive(true);
				unlockMapBtnInCreate.SetActive(false);
				createRoomBtn.SetActive(true);
			}
		} catch (Exception e){
			UnityEngine.Debug.LogError("connectscene update 6: " + e.Message);
		}
	}

	private bool IsUseMap(int indMap)
	{
		if (masUseMaps != null)
		{
			for (int i = 0; i < masUseMaps.Length; i++)
			{
				if (masUseMaps[i] == indMap)
				{
					bool flag = Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[masUseMaps[i].ToString()]) && Storager.getInt(Defs.levelNamesFromNums[masUseMaps[i].ToString()] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[masUseMaps[i].ToString()]);
					return !flag;
				}
			}
		}
		return false;
	}

	private IEnumerator LoadMapPreview()
	{
		string[][] arrArrays = new string[6][] { masMapName, masMapNameCompany, masMapNameCOOP, masMapNameflag, masMapNameHunger, masMapNameCapturePoints };
		string allScene = string.Empty;
		foreach (string[] _tekMasNames in arrArrays)
		{
			for (int i = 0; i < _tekMasNames.Length; i++)
			{
				if (!mapPreview.ContainsKey(_tekMasNames[i]))
				{
					allScene = allScene + _tekMasNames[i] + "\n";
					mapPreview.Add(_tekMasNames[i], Resources.Load("LevelLoadingsPreview" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading_" + _tekMasNames[i]) as Texture);
					if (Defs.PremiumMaps.ContainsKey(_tekMasNames[i]) && Storager.getInt(_tekMasNames[i] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(_tekMasNames[i]))
					{
						mapPreview.Add(_tekMasNames[i] + "_off", Resources.Load<Texture>("LevelLoadingsPreview" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading_" + _tekMasNames[i] + "_off"));
					}
					yield return null;
				}
			}
		}
		if (Application.isEditor)
		{
			Debug.Log(allScene);
		}
		yield return null;
		mainPanel.SetActive(true);
		coinsShopButton.SetActive(true);
		selectMapPanel.SetActive(true);
		SetRegim(regim);
		yield return null;
		InterstitialRequest = false;
		yield return null;
		loadingMapPanel.SetActive(false);
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(false);
		}
	}

	public static void UpdateUseMasMaps()
	{
		if (regim == RegimGame.TimeBattle)
		{
			masUseMaps = new int[masMapNameCOOP.Length];
			for (int i = 0; i < masMapNameCOOP.Length; i++)
			{
				masUseMaps[i] = Defs.levelNumsForMusicInMult[masMapNameCOOP[i]];
			}
		}
		else if (regim == RegimGame.TeamFight)
		{
			masUseMaps = new int[masMapNameCompany.Length];
			for (int j = 0; j < masMapNameCompany.Length; j++)
			{
				masUseMaps[j] = Defs.levelNumsForMusicInMult[masMapNameCompany[j]];
			}
		}
		else if (regim == RegimGame.DeadlyGames)
		{
			masUseMaps = new int[masMapNameHunger.Length];
			for (int k = 0; k < masMapNameHunger.Length; k++)
			{
				masUseMaps[k] = Defs.levelNumsForMusicInMult[masMapNameHunger[k]];
			}
		}
		else if (regim == RegimGame.FlagCapture)
		{
			masUseMaps = new int[masMapNameflag.Length];
			for (int l = 0; l < masMapNameflag.Length; l++)
			{
				masUseMaps[l] = Defs.levelNumsForMusicInMult[masMapNameflag[l]];
			}
		}
		else if (regim == RegimGame.CapturePoints)
		{
			masUseMaps = new int[masMapNameCapturePoints.Length];
			for (int m = 0; m < masMapNameCapturePoints.Length; m++)
			{
				masUseMaps[m] = Defs.levelNumsForMusicInMult[masMapNameCapturePoints[m]];
			}
		}
		else
		{
			masUseMaps = new int[masMapName.Length];
			for (int n = 0; n < masMapName.Length; n++)
			{
				masUseMaps[n] = Defs.levelNumsForMusicInMult[masMapName[n]];
			}
		}
	}

	private IEnumerator SetUseMasMap()
	{
		isSetUseMap = true;
		SpringPanel _spr = ScrollTransform.GetComponent<SpringPanel>();
		if (_spr != null)
		{
			UnityEngine.Object.Destroy(_spr);
		}
		ScrollTransform.GetComponent<UIPanel>().clipOffset = new Vector2(0f, 0f);
		SetPosSelectMapPanelInMainMenu();
		ScrollTransform.localPosition = new Vector3(0f, 0f, 0f);
		for (int i = 0; i < grid.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(grid.transform.GetChild(i).gameObject);
		}
		yield return null;
		for (int j = 0; j < masUseMaps.Length; j++)
		{
			GameObject newTexture = UnityEngine.Object.Instantiate(mapPreviewTexture) as GameObject;
			newTexture.transform.parent = grid.transform;
			bool _isClose = Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[string.Empty + masUseMaps[j]]) && Storager.getInt(Defs.levelNamesFromNums[string.Empty + masUseMaps[j]] + "Key", true) == 0 && !PremiumAccountController.MapAvailableDueToPremiumAccount(Defs.levelNamesFromNums[string.Empty + masUseMaps[j]]);
			newTexture.GetComponent<UITexture>().mainTexture = mapPreview[Defs.levelNamesFromNums[masUseMaps[j].ToString()] + ((!_isClose) ? string.Empty : "_off")];
			newTexture.name = "Map_" + j;
			newTexture.transform.localScale = new Vector3(1f, 1f, 1f);
			newTexture.transform.localPosition = new Vector3(widthCell * (float)j, 0f, 0f);
			if (Defs2.mapNamesForPreviewMap.ContainsKey(Defs.levelNamesFromNums[masUseMaps[j].ToString()]))
			{
				newTexture.GetComponent<MapPreviewController>().NameMapLbl.GetComponent<SetHeadLabelText>().SetText(Defs2.mapNamesForPreviewMap[Defs.levelNamesFromNums[masUseMaps[j].ToString()]].ToUpper());
			}
			if (Defs.levelNamesFromNums.ContainsKey(masUseMaps[j].ToString()) && Defs2.mapSizesForPreviewMap.ContainsKey(Defs.levelNamesFromNums[masUseMaps[j].ToString()]))
			{
				newTexture.GetComponent<MapPreviewController>().SizeMapNameLbl.text = Defs2.mapSizesForPreviewMap[Defs.levelNamesFromNums[masUseMaps[j].ToString()]];
			}
			newTexture.GetComponent<MapPreviewController>().mapID = masUseMaps[j].ToString();
			if (Defs.PremiumMaps.ContainsKey(Defs.levelNamesFromNums[string.Empty + masUseMaps[j]]))
			{
				newTexture.GetComponent<MapPreviewController>().premium.SetActive(true);
			}
			if (Defs.levelNamesFromNums[string.Empty + masUseMaps[j]].Equals("Knife"))
			{
				newTexture.GetComponent<MapPreviewController>().milee.SetActive(true);
				newTexture.GetComponent<MapPreviewController>().milee.GetComponent<UILabel>().text = LocalizationStore.Get("Key_0096");
			}
			if (Defs.levelNamesFromNums[string.Empty + masUseMaps[j]].Equals("Sniper"))
			{
				newTexture.GetComponent<MapPreviewController>().milee.SetActive(true);
				newTexture.GetComponent<MapPreviewController>().milee.GetComponent<UILabel>().text = LocalizationStore.Get("Key_0949");
			}
		}
		grid.GetComponent<UIWrapContent>().SortBasedOnScrollMovement();
		Transform curr = grid.transform.GetChild(0);
		foreach (Transform c in grid.transform)
		{
			if (c.gameObject.name.Equals("Map_0"))
			{
				curr = c;
				break;
			}
		}
		grid.GetComponent<UIWrapContent>().WrapContent();
		grid.SetActive(false);
		grid.SetActive(true);
		grid.GetComponent<MyCenterOnChild>().springStrength = 1E+11f;
		grid.GetComponent<MyCenterOnChild>().CenterOn(curr);
		grid.GetComponent<MyCenterOnChild>().springStrength = 8f;
		grid.transform.GetChild(1).transform.localScale = new Vector3(0.9f, 0.9f, 0.9f);
		grid.transform.GetChild(grid.transform.childCount - 1).transform.localScale = new Vector3(0.9f, 0.9f, 0.9f);
		startPosX = curr.localPosition.x;
		yield return null;
		isSetUseMap = false;
		Resources.UnloadUnusedAssets();
		deathmatchToggle.GetComponent<UIButton>().isEnabled = true;
		timeBattleToogle.GetComponent<UIButton>().isEnabled = true;
		teamFightToogle.GetComponent<UIButton>().isEnabled = true;
		deadlyGamesToogle.GetComponent<UIButton>().isEnabled = true;
		flagCaptureToogle.GetComponent<UIButton>().isEnabled = true;
	}

	public void OnReceivedRoomListUpdate()
	{
		if (customPanel.activeSelf && Defs.isInet)
		{
			updateFilteredRoomList(gameNameFilter);
		}
	}

	public void updateFilteredRoomList(string gFilter)
	{
		filteredRoomList.Clear();
		int num = 0;
		RoomInfo[] roomList = PhotonNetwork.GetRoomList();
		Dictionary<string, Dictionary<string, int>> dictionary = new Dictionary<string, Dictionary<string, int>>();
		for (int i = 0; i < roomList.Length; i++)
		{
			if (Application.isEditor)
			{
				string key = Defs.levelNamesFromNums[roomList[i].customProperties["map"].ToString()];
				if (dictionary.ContainsKey(key))
				{
					dictionary[key]["rooms"] = dictionary[key]["rooms"] + 1;
					dictionary[key]["players"] = dictionary[key]["players"] + roomList[i].playerCount;
				}
				else
				{
					Dictionary<string, int> dictionary2 = new Dictionary<string, int>();
					dictionary2.Add("rooms", 1);
					dictionary2.Add("players", roomList[i].playerCount);
					dictionary.Add(key, dictionary2);
				}
			}
			if (roomList[i].customProperties["platform"] != null)
			{
				string text = roomList[i].customProperties["platform"].ToString();
				int num2 = (int)myPlatformConnect;
				if (!text.Equals(num2.ToString()) && !roomList[i].customProperties["platform"].ToString().Equals(3.ToString()))
				{
					continue;
				}
			}
			if ((roomList[i].customProperties["regim"] != null && !roomList[i].customProperties["regim"].ToString().Equals(((int)regim).ToString())) || roomList[i].customProperties["starting"].Equals(1))
			{
				continue;
			}
			if (ExperienceController.sharedController != null)
			{
				bool flag = false;
				for (int j = 0; j < ExperienceController.maxLevel; j++)
				{
					if (ExperienceController.accessByLevels[ExperienceController.sharedController.currentLevel - 1, j] == 0 && roomList[i].customProperties["Level_" + (j + 1)].Equals(1))
					{
						flag = true;
						break;
					}
				}
				if (flag)
				{
					continue;
				}
			}
			if (roomList[i].name.StartsWith(gFilter, true, null) && IsUseMap((int)roomList[i].customProperties["map"]))
			{
				filteredRoomList.Add(roomList[i]);
			}
		}
		if (Application.isEditor)
		{
			if (!mapStatistics.ContainsKey(regim.ToString()))
			{
				mapStatistics.Add(regim.ToString(), new Dictionary<string, Dictionary<string, Dictionary<string, int>>>());
			}
			if (!mapStatistics[regim.ToString()].ContainsKey(gameTier.ToString()))
			{
				mapStatistics[regim.ToString()].Add(gameTier.ToString(), dictionary);
			}
			else
			{
				mapStatistics[regim.ToString()][gameTier.ToString()] = dictionary;
			}
			string text2 = string.Empty;
			foreach (KeyValuePair<string, Dictionary<string, Dictionary<string, Dictionary<string, int>>>> mapStatistic in mapStatistics)
			{
				Dictionary<string, Dictionary<string, int>> dictionary3 = new Dictionary<string, Dictionary<string, int>>();
				int num3 = 0;
				int num4 = 0;
				foreach (KeyValuePair<string, Dictionary<string, Dictionary<string, int>>> item in mapStatistic.Value)
				{
					foreach (KeyValuePair<string, Dictionary<string, int>> item2 in item.Value)
					{
						num3 += item2.Value["rooms"];
						num4 += item2.Value["players"];
						if (!dictionary3.ContainsKey(item2.Key))
						{
							Dictionary<string, int> dictionary4 = new Dictionary<string, int>();
							dictionary4.Add("rooms", item2.Value["rooms"]);
							dictionary4.Add("players", item2.Value["players"]);
							dictionary3.Add(item2.Key, dictionary4);
						}
						else
						{
							dictionary3[item2.Key]["rooms"] = dictionary3[item2.Key]["rooms"] + item2.Value["rooms"];
							dictionary3[item2.Key]["players"] = dictionary3[item2.Key]["players"] + item2.Value["players"];
						}
					}
				}
				text2 = text2 + mapStatistic.Key + "\t all count=" + num3 + "\t all players=" + num4 + "\n";
				text2 += "MAP\tcount room\t% room\tcount players\t% players\n";
				foreach (KeyValuePair<string, Dictionary<string, int>> item3 in dictionary3)
				{
					string empty = string.Empty;
					text2 = text2 + item3.Key + "\t" + item3.Value["rooms"] + "\t" + ((float)item3.Value["rooms"] / (float)num3 * 100f + (float)item3.Value["rooms"]) + "\t" + item3.Value["players"] + "\t" + (float)item3.Value["players"] / (float)num4 * 100f + "\n";
				}
				text2 += "\n\n";
			}
		}
		int num5 = 75;
		if (filteredRoomList.Count < num5)
		{
			num5 = filteredRoomList.Count;
		}
		while (num5 < gamesInfo.Count)
		{
			UnityEngine.Object.Destroy(gamesInfo[gamesInfo.Count - 1]);
			gamesInfo.RemoveAt(gamesInfo.Count - 1);
		}
		while (num5 > gamesInfo.Count)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(gameInfoItemPrefab) as GameObject;
			gameObject.name = "GameInfo_" + gamesInfo.Count;
			gameObject.transform.parent = gridGamesTransform;
			gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
			gamesInfo.Add(gameObject);
		}
		gridGames.Reposition();
		for (int k = 0; k < num5; k++)
		{
			GameInfo component = gamesInfo[k].GetComponent<GameInfo>();
			RoomInfo roomInfo = filteredRoomList[k];
			string text3 = roomInfo.name;
			if (text3.Length == 36 && text3.IndexOf("-") == 8 && text3.LastIndexOf("-") == 23)
			{
				text3 = LocalizationStore.Get("Key_0088");
			}
			component.serverNameLabel.text = text3;
			component.countPlayersLabel.text = roomInfo.playerCount + "/" + roomInfo.maxPlayers;
			if (string.IsNullOrEmpty(roomInfo.customProperties["pass"].ToString()))
			{
				component.openSprite.SetActive(true);
				component.closeSprite.SetActive(false);
			}
			else
			{
				component.openSprite.SetActive(false);
				component.closeSprite.SetActive(true);
			}
			string text4 = string.Format("{0}: {1}", LocalizationStore.Get("Key_0947"), Defs2.mapNamesForUser[Defs.levelNamesFromNums[roomInfo.customProperties["map"].ToString()]]);
			component.mapNameLabel.text = text4;
			component.roomInfo = roomInfo;
		}
	}

	private void OnPhotonRandomJoinFailed()
	{
		Debug.Log("OnPhotonJoinRoomFailed");
		PlayerPrefs.SetString("TypeGame", "server");
		int num = 7;
		string[] array = new string[num + ExperienceController.maxLevel];
		array[0] = "starting";
		array[1] = "map";
		array[2] = "MaxKill";
		array[3] = "pass";
		array[4] = "regim";
		array[5] = "TimeMatchEnd";
		array[6] = "platform";
		for (int i = num; i < num + ExperienceController.maxLevel; i++)
		{
			array[i] = "Level_" + (i - num + 1);
		}
		ExitGames.Client.Photon.Hashtable hashtable = new ExitGames.Client.Photon.Hashtable();
		hashtable["starting"] = 0;
		hashtable["map"] = Defs.levelNumsForMusicInMult[goMapName];
		hashtable["MaxKill"] = ((myLevelGame == 0) ? (Defs.isHunger ? 15 : ((regim != 0 && regim != RegimGame.TeamFight && regim != RegimGame.FlagCapture && regim != RegimGame.CapturePoints) ? 10 : 3)) : ((regim != 0 && regim != RegimGame.TeamFight && regim != RegimGame.FlagCapture && regim != RegimGame.CapturePoints) ? 15 : 3));
		hashtable["pass"] = string.Empty;
		hashtable["regim"] = regim;
		hashtable["TimeMatchEnd"] = PhotonNetwork.time;
		hashtable["platform"] = (int)myPlatformConnect;
		for (int j = num; j < num + ExperienceController.maxLevel; j++)
		{
			hashtable["Level_" + (j - num + 1)] = ((ExperienceController.sharedController != null && ExperienceController.sharedController.currentLevel == j - num + 1) ? 1 : 0);
		}
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(goMapName) ? Defs.filterMaps[goMapName] : 0);
		}
		StartCoroutine(SetFonLoadingWaitForReset(goMapName));
		PhotonNetwork.CreateRoom("you shouldnt be seeing this");
	}

	private void OnPhotonJoinRoomFailed()
	{
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(false);
		}
		loadingMapPanel.SetActive(false);
		gameIsfullLabel.timer = 3f;
		gameIsfullLabel.gameObject.SetActive(true);
		incorrectPasswordLabel.timer = -1f;
		incorrectPasswordLabel.gameObject.SetActive(false);
		Debug.Log("OnPhotonJoinRoomFailed");
	}

	private void OnJoinedRoom()
	{
		Debug.Log("OnJoinedRoom " + PhotonNetwork.room.customProperties["map"].ToString());
		PhotonNetwork.isMessageQueueRunning = false;
		NotificationController.ResetPaused();
		StartCoroutine(MoveToGameScene(Defs.levelNamesFromNums[PhotonNetwork.room.customProperties["map"].ToString()]));
	}

	private void OnCreatedRoom()
	{
		Debug.Log("OnCreatedRoom");
	}

	private void OnPhotonCreateRoomFailed()
	{
		Debug.Log("OnPhotonCreateRoomFailed");
		nameAlreadyUsedLabel.timer = 3f;
		nameAlreadyUsedLabel.gameObject.SetActive(true);
		loadingMapPanel.SetActive(false);
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(false);
		}
	}

	private void OnDisconnectedFromPhoton()
	{
		Debug.Log("OnDisconnectedFromPhoton");
		if ((!mainPanel.activeSelf || loadingMapPanel.activeSelf) && firstConnectToPhoton && Defs.isInet)
		{
			mainPanel.SetActive(true);
			coinsShopButton.SetActive(true);
			selectMapPanel.SetActive(true);
			createPanel.SetActive(false);
			customPanel.SetActive(false);
			searchPanel.SetActive(false);
			setPasswordPanel.SetActive(false);
			enterPasswordPanel.SetActive(false);
			ExperienceController.sharedController.isShowRanks = true;
			loadingMapPanel.SetActive(false);
			SetPosSelectMapPanelInMainMenu();
			serverIsNotAvalible.timer = 3f;
			serverIsNotAvalible.gameObject.SetActive(true);
		}
		if (actAfterConnectToPhoton != null)
		{
			Invoke("ConnectToPhoton", 0.5f);
		}
	}

	private void OnFailedToConnectToPhoton(object parameters)
	{
		Debug.Log("OnFailedToConnectToPhoton. StatusCode: " + parameters);
		if (connectToPhotonPanel.activeSelf)
		{
			failInternetLabel.SetActive(true);
		}
		if (!isCancelConnectingToPhoton)
		{
			Invoke("ConnectToPhoton", 1f);
		}
	}

	public void OnConnectedToMaster()
	{
		Debug.Log("OnConnectedToMaster");
		firstConnectToPhoton = true;
		PhotonNetwork.playerName = Defs.GetPlayerNameOrDefault();
		if (connectToPhotonPanel.activeSelf)
		{
			connectToPhotonPanel.SetActive(false);
		}
		if (actAfterConnectToPhoton != null)
		{
			actAfterConnectToPhoton();
			actAfterConnectToPhoton = null;
		}
		else
		{
			PhotonNetwork.Disconnect();
		}
	}

	public void OnConnectedToPhoton()
	{
		Debug.Log("OnConnectedToPhoton");
	}

	public void OnJoinedLobby()
	{
		Debug.Log("OnJoinedLobby");
		OnConnectedToMaster();
	}

	private IEnumerator SetFonLoadingWaitForReset(string _mapName = "", bool isAddCountRun = false)
	{
		GetMapName(_mapName, isAddCountRun);
		if (_loadingNGUIController != null)
		{
			UnityEngine.Object.Destroy(_loadingNGUIController.gameObject);
			_loadingNGUIController = null;
		}
		while (WeaponManager.sharedManager == null)
		{
			yield return null;
		}
		while (WeaponManager.sharedManager.LockGetWeaponPrefabs > 0)
		{
			yield return null;
		}
		ShowLoadingGUI(_mapName);
	}

	private void SetFonLoading(string _mapName = "", bool isAddCountRun = false)
	{
		GetMapName(_mapName, isAddCountRun);
		if (_loadingNGUIController != null)
		{
			UnityEngine.Object.Destroy(_loadingNGUIController.gameObject);
			_loadingNGUIController = null;
		}
		ShowLoadingGUI(_mapName);
	}

	private void ShowLoadingGUI(string _mapName)
	{
		_loadingNGUIController = (UnityEngine.Object.Instantiate(Resources.Load<GameObject>("LoadingGUI")) as GameObject).GetComponent<LoadingNGUIController>();
		_loadingNGUIController.SceneToLoad = _mapName;
		_loadingNGUIController.loadingNGUITexture.mainTexture = LoadConnectScene.textureToShow;
		_loadingNGUIController.transform.parent = loadingMapPanel.transform;
		_loadingNGUIController.transform.localPosition = Vector3.zero;
		_loadingNGUIController.Init();
	}

	private void GetMapName(string _mapName, bool isAddCountRun)
	{
		Debug.Log("setFonLoading " + _mapName);
		Texture texture = null;
		if (Defs.isCOOP)
		{
			int @int = PlayerPrefs.GetInt("CountRunCoop", 0);
			bool flag = @int < 5;
			if (isAddCountRun)
			{
				PlayerPrefs.SetInt("CountRunCoop", PlayerPrefs.GetInt("CountRunCoop", 0) + 1);
			}
			Texture texture2 = Resources.Load("NoteLoadings/note_Time_Survival_" + @int % countNoteCaptureCOOP) as Texture;
		}
		else if (Defs.isCompany)
		{
			int int2 = PlayerPrefs.GetInt("CountRunCompany", 0);
			bool flag = int2 < 5;
			Texture texture2 = Resources.Load("NoteLoadings/note_Team_Battle_" + int2 % countNoteCaptureCompany) as Texture;
			if (isAddCountRun)
			{
				PlayerPrefs.SetInt("CountRunCompany", PlayerPrefs.GetInt("CountRunCompany", 0) + 1);
			}
		}
		else if (Defs.isHunger)
		{
			int int3 = PlayerPrefs.GetInt("CountRunHunger", 0);
			bool flag = int3 < 5;
			Texture texture2 = Resources.Load("NoteLoadings/note_Deadly_Games_" + int3 % countNoteCaptureHunger) as Texture;
			if (isAddCountRun)
			{
				PlayerPrefs.SetInt("CountRunHunger", PlayerPrefs.GetInt("CountRunHunger", 0) + 1);
			}
		}
		else if (Defs.isFlag)
		{
			int int4 = PlayerPrefs.GetInt("CountRunFlag", 0);
			bool flag = int4 < 5;
			Texture texture2 = Resources.Load("NoteLoadings/note_Flag_Capture_" + int4 % countNoteCaptureFlag) as Texture;
			if (isAddCountRun)
			{
				PlayerPrefs.SetInt("CountRunFlag", PlayerPrefs.GetInt("CountRunFlag", 0) + 1);
			}
		}
		else
		{
			int int5 = PlayerPrefs.GetInt("CountRunDeadmath", 0);
			bool flag = int5 < 5;
			Texture texture2 = Resources.Load("NoteLoadings/note_Deathmatch_" + int5 % countNoteCaptureDeadmatch) as Texture;
			if (isAddCountRun)
			{
				PlayerPrefs.SetInt("CountRunDeadmath", PlayerPrefs.GetInt("CountRunDeadmath", 0) + 1);
			}
		}
		LoadConnectScene.textureToShow = Resources.Load("LevelLoadings" + ((!Device.isRetinaAndStrong) ? string.Empty : "/Hi") + "/Loading_" + _mapName) as Texture2D;
		LoadingInAfterGame.loadingTexture = LoadConnectScene.textureToShow;
		LoadConnectScene.sceneToLoad = _mapName;
		LoadConnectScene.noteToShow = null;
		loadingToDraw.gameObject.SetActive(false);
	}

	private IEnumerator MoveToGameScene(string _goMapName)
	{
		Debug.Log("MoveToGameScene=" + _goMapName);
		Defs.isGameFromFriends = false;
		Defs.isGameFromClans = false;
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(_goMapName) ? Defs.filterMaps[_goMapName] : 0);
		}
		GlobalGameController.countKillsBlue = 0;
		GlobalGameController.countKillsRed = 0;
		while (PhotonNetwork.room == null)
		{
			yield return 0;
		}
		PlayerPrefs.SetString("RoomName", PhotonNetwork.room.name);
		PlayerPrefs.SetInt("CustomGame", 0);
		for (int i = 0; i < grid.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(grid.transform.GetChild(i).gameObject);
		}
		mapPreview.Clear();
		PhotonNetwork.isMessageQueueRunning = false;
		yield return null;
		yield return Resources.UnloadUnusedAssets();
		StartCoroutine(SetFonLoadingWaitForReset(_goMapName, true));
		isGoInPhotonGame = true;
		AsyncOperation async = Application.LoadLevelAsync("PromScene");
		FlurryPluginWrapper.LogEvent("Play_" + _goMapName);
		if (FriendsController.sharedController != null)
		{
			FriendsController.sharedController.StartCoroutine(FriendsController.sharedController.GetFriendDataOnce(false));
		}
		yield return async;
	}

	[Obfuscation(Exclude = true)]
	private void ConnectToPhoton()
	{
		if (FriendsController.sharedController != null && FriendsController.sharedController.Banned == 1)
		{
			return;
		}
		if (PhotonNetwork.connectionState == ConnectionState.Connecting || PhotonNetwork.connectionState == ConnectionState.Connected)
		{
			Debug.Log("ConnectToPhoton return");
			return;
		}
		Debug.Log("ConnectToPhoton");
		if (FriendsController.sharedController != null && FriendsController.sharedController.Banned == 1)
		{
			timerShowBan = 3f;
			return;
		}
		isConnectingToPhoton = true;
		isCancelConnectingToPhoton = false;
		gameTier = ExpController.Instance.OurTier;
		PhotonNetwork.ConnectUsingSettings(Initializer.Separator + regim.ToString() + gameTier + "v" + GlobalGameController.MultiplayerProtocolVersion);
	}

	private void StartSearchLocalServers()
	{
		lanScan.StartSearchBroadCasting(SeachServer);
	}

	private void SeachServer(string ipServerSeaches)
	{
		bool flag = false;
		if (servers.Count > 0)
		{
			foreach (infoServer server in servers)
			{
				if (server.ipAddress.Equals(ipServerSeaches))
				{
					flag = true;
				}
			}
		}
		if (!flag)
		{
			infoServer item = default(infoServer);
			item.ipAddress = ipServerSeaches;
			servers.Add(item);
		}
	}

	private int LocalServerComparison(LANBroadcastService.ReceivedMessage msg1, LANBroadcastService.ReceivedMessage msg2)
	{
		return msg1.ipAddress.CompareTo(msg2.ipAddress);
	}

	private void UpdateLocalServersList()
	{
		List<LANBroadcastService.ReceivedMessage> list = new List<LANBroadcastService.ReceivedMessage>();
		for (int i = 0; i < lanScan.lstReceivedMessages.Count; i++)
		{
			if (lanScan.lstReceivedMessages[i].regim == (int)regim)
			{
				list.Add(lanScan.lstReceivedMessages[i]);
			}
		}
		if (list.Count > 0)
		{
			LANBroadcastService.ReceivedMessage[] array = list.ToArray();
			Array.Sort(array, LocalServerComparison);
			while (array.Length < gamesInfo.Count)
			{
				UnityEngine.Object.Destroy(gamesInfo[gamesInfo.Count - 1]);
				gamesInfo.RemoveAt(gamesInfo.Count - 1);
			}
			while (array.Length > gamesInfo.Count)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(gameInfoItemPrefab) as GameObject;
				gameObject.name = "GameInfo_" + gamesInfo.Count;
				gameObject.transform.parent = gridGamesTransform;
				gameObject.transform.localScale = new Vector3(1f, 1f, 1f);
				gamesInfo.Add(gameObject);
			}
			gridGames.Reposition();
			for (int j = 0; j < array.Length; j++)
			{
				GameInfo component = gamesInfo[j].GetComponent<GameInfo>();
				LANBroadcastService.ReceivedMessage roomInfoLocal = array[j];
				string text = roomInfoLocal.name;
				if (string.IsNullOrEmpty(text))
				{
					text = LocalizationStore.Get("Key_0948");
				}
				component.serverNameLabel.text = text;
				component.countPlayersLabel.text = roomInfoLocal.connectedPlayers + "/" + roomInfoLocal.playerLimit;
				component.openSprite.SetActive(true);
				component.closeSprite.SetActive(false);
				string arg = roomInfoLocal.map;
				if (Defs2.mapNamesForUser.ContainsKey(roomInfoLocal.map))
				{
					arg = Defs2.mapNamesForUser[roomInfoLocal.map];
				}
				component.mapNameLabel.text = string.Format("{0}: {1}", LocalizationStore.Get("Key_0947"), arg);
				component.roomInfoLocal = roomInfoLocal;
			}
		}
		else
		{
			while (gamesInfo.Count > 0)
			{
				UnityEngine.Object.Destroy(gamesInfo[gamesInfo.Count - 1]);
				gamesInfo.RemoveAt(gamesInfo.Count - 1);
			}
		}
	}

	public void JoinToLocalRoom(LANBroadcastService.ReceivedMessage _roomInfo)
	{
		if (_roomInfo.connectedPlayers == _roomInfo.playerLimit)
		{
			gameIsfullLabel.timer = 3f;
			gameIsfullLabel.gameObject.SetActive(true);
			incorrectPasswordLabel.timer = -1f;
			incorrectPasswordLabel.gameObject.SetActive(false);
			return;
		}
		GlobalGameController.countKillsBlue = 0;
		GlobalGameController.countKillsRed = 0;
		Defs.ServerIp = _roomInfo.ipAddress;
		PlayerPrefs.SetString("MaxKill", _roomInfo.comment);
		PlayerPrefs.SetString("MapName", _roomInfo.map);
		if (WeaponManager.sharedManager != null)
		{
			WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(_roomInfo.map) ? Defs.filterMaps[_roomInfo.map] : 0);
		}
		StartCoroutine(SetFonLoadingWaitForReset(_roomInfo.map));
		Invoke("goGame", 0.1f);
	}

	private bool CheckLocalAvailability()
	{
		if (Application.internetReachability == NetworkReachability.ReachableViaLocalAreaNetwork)
		{
			return true;
		}
		return false;
	}

	public void JoinToRoomPhoton(RoomInfo _roomInfo)
	{
		if (_roomInfo.playerCount == _roomInfo.maxPlayers)
		{
			gameIsfullLabel.timer = 3f;
			gameIsfullLabel.gameObject.SetActive(true);
			incorrectPasswordLabel.timer = -1f;
			incorrectPasswordLabel.gameObject.SetActive(false);
			return;
		}
		joinRoomInfoFromCustom = _roomInfo;
		if (string.IsNullOrEmpty(_roomInfo.customProperties["pass"].ToString()))
		{
			JoinToRoomPhotonAfterCheck();
			return;
		}
		gameIsfullLabel.timer = -1f;
		gameIsfullLabel.gameObject.SetActive(false);
		incorrectPasswordLabel.timer = 3f;
		incorrectPasswordLabel.gameObject.SetActive(true);
		enterPasswordInput.value = string.Empty;
		enterPasswordPanel.SetActive(true);
		ExperienceController.sharedController.isShowRanks = false;
		customPanel.SetActive(false);
	}

	public void JoinToRoomPhotonAfterCheck()
	{
		StartCoroutine(SetFonLoadingWaitForReset(Defs.levelNamesFromNums[joinRoomInfoFromCustom.customProperties["map"].ToString()]));
		loadingMapPanel.SetActive(true);
		PhotonNetwork.JoinRoom(joinRoomInfoFromCustom.name);
		if (StoreKitEventListener.purchaseActivityInd != null)
		{
			StoreKitEventListener.purchaseActivityInd.SetActive(true);
		}
	}

	private void SetPosSelectMapPanelInMainMenu()
	{
		float num = (float)Screen.width * 768f / (float)Screen.height - 322f;
		selectMapPanelTransform.localPosition = new Vector3(149f, 73f, 0f);
		fonMapPreview.width = Mathf.RoundToInt(num);
		fonMapPreview.height = 434;
		fonMapPreview.transform.localPosition = Vector3.zero;
		mapPreviewPanel.baseClipRegion = new Vector4(0f, 0f, num, mapPreviewPanel.baseClipRegion.w);
		ChooseMapLabelSmall.SetActive(true);
	}

	private void SetPosSelectMapPanelInCreatePanel()
	{
		selectMapPanelTransform.localPosition = new Vector3(0f, 35f, 0f);
		fonMapPreview.width = Mathf.RoundToInt((float)Screen.width * 768f / (float)Screen.height + 10f);
		fonMapPreview.height = 376;
		fonMapPreview.transform.localPosition = new Vector3(0f, -24f, 0f);
		mapPreviewPanel.baseClipRegion = new Vector4(0f, 0f, (float)Screen.width * 768f / (float)Screen.height, mapPreviewPanel.baseClipRegion.w);
		ChooseMapLabelSmall.SetActive(false);
	}

	[Obfuscation(Exclude = true)]
	private void goGame()
	{
		WeaponManager.sharedManager.Reset(Defs.filterMaps.ContainsKey(PlayerPrefs.GetString("MapName")) ? Defs.filterMaps[PlayerPrefs.GetString("MapName")] : 0);
		Application.LoadLevel(PlayerPrefs.GetString("MapName"));
	}

	private void LogUserQuit()
	{
		try
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendFormat("Round {0}", _countOfLoopsRequestAdThisTime + 1);
			stringBuilder.AppendFormat(", Slot {0} ({1})", InterstitialManager.Instance.ProviderClampedIndex + 1, AnalyticsHelper.GetAdProviderName(InterstitialManager.Instance.Provider));
			stringBuilder.Append(" - User quit");
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Quit - Interstitial", stringBuilder.ToString());
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("ADS Statistics Total", parameters);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private void LogUserInterstitialRequest()
	{
		try
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendFormat("Round {0}", _countOfLoopsRequestAdThisTime + 1);
			stringBuilder.AppendFormat(", Slot {0} ({1})", InterstitialManager.Instance.ProviderClampedIndex + 1, AnalyticsHelper.GetAdProviderName(InterstitialManager.Instance.Provider));
			if (InterstitialManager.Instance.Provider == AdProvider.GoogleMobileAds)
			{
				stringBuilder.AppendFormat(", Unit {0}" + 1);
			}
			stringBuilder.Append(" - Request");
			string value = stringBuilder.ToString();
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Quit - Interstitial", value);
			dictionary.Add("Statistics - Interstitial", value);
			Dictionary<string, string> parameters = dictionary;
			FlurryPluginWrapper.LogEventAndDublicateToConsole("ADS Statistics Total", parameters);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	private void OnDestroy()
	{
		Debug.Log("OnDestroy ConnectSceneController");
		if (isStartShowAdvert)
		{
			LogIsShowAdvert("Connect Scene", false);
		}
		LogUserQuit();
		if (!Defs.isInet || (!isGoInPhotonGame && PhotonNetwork.connectionState == ConnectionState.Connected) || PhotonNetwork.connectionState == ConnectionState.Connecting)
		{
			PhotonNetwork.Disconnect();
			Debug.Log("PhotonNetwork.Disconnect()");
		}
		if (ExperienceController.sharedController != null)
		{
			ExperienceController.sharedController.isShowRanks = false;
			ExperienceController.sharedController.isMenu = false;
			ExperienceController.sharedController.isConnectScene = false;
		}
		lanScan.StopBroadCasting();
		sharedController = null;
	}

	private void LogIsShowAdvert(string context, bool isShow)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("Context", context);
		Dictionary<string, string> dictionary2 = dictionary;
		dictionary2.Add("Show", isShow.ToString());
		if (ExperienceController.sharedController != null)
		{
			dictionary2.Add("Level", ExperienceController.sharedController.currentLevel.ToString());
		}
		if (ExpController.Instance != null)
		{
			dictionary2.Add("Tier", ExpController.Instance.OurTier.ToString());
		}
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Advert show", dictionary2);
	}
}
