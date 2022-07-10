using System.Collections;
using System.Reflection;
using Prime31;
using Rilisoft;
using UnityEngine;

public sealed class MainMenu : MonoBehaviour
{
	public static MainMenu sharedMenu;

	public GameObject JoysticksUIRoot;

	public static bool BlockInterface;

	public static bool IsAdvertRun;

	private bool isShowDeadMatch;

	private bool isShowCOOP;

	public bool isFirstFrame = true;

	public bool isInappWinOpen;

	private bool musicOld;

	private bool fxOld;

	public Texture inAppFon;

	public GUIStyle puliInApp;

	public GUIStyle healthInApp;

	public GUIStyle pulemetInApp;

	public GUIStyle crystalSwordInapp;

	public GUIStyle elixirInapp;

	private bool showUnlockDialog;

	private bool isPressFullOnMulty;

	private float _timeWhenPurchShown;

	public GameObject skinsManagerPrefab;

	public GameObject weaponManagerPrefab;

	public GUIStyle backBut;

	private bool showMessagFacebook;

	private bool showMessagTiwtter;

	private GameObject _purchaseActivityIndicator;

	private ExperienceController expController;

	private bool clickButtonFacebook;

	private AdvertisementController _advertisementController;

	public bool isShowAvard;

	public static readonly string iTunesEnderManID = "811995374";

	private bool _canUserUseFacebookComposer;

	private bool invCur;

	private bool _hasPublishPermission;

	private bool _hasPublishActions;

	private bool _skinsMakerQuerySucceeded;

	private bool _backFromFreeCoinsPressed;

	public bool showFreeCoins;

	private bool _backFromSettingsPressed;

	public bool isShowSetting;

	public static int FontSizeForMessages
	{
		get
		{
			return Mathf.RoundToInt((float)Screen.height * 0.03f);
		}
	}

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

	public static float iOSVersion
	{
		get
		{
			float result = -1f;
			if (Application.platform == RuntimePlatform.IPhonePlayer)
			{
				string text = SystemInfo.operatingSystem.Replace("iPhone OS ", string.Empty);
				float.TryParse(text.Substring(0, 1), out result);
			}
			return result;
		}
	}

	public static string GetEndermanUrl()
	{
		if (Application.platform == RuntimePlatform.IPhonePlayer || Application.isEditor)
		{
			return "https://itunes.apple.com/us/app/slendy-raise-your-virtual/id" + iTunesEnderManID + "?mt=8";
		}
		if (Application.platform == RuntimePlatform.Android)
		{
			return (Defs.AndroidEdition != Defs.RuntimeAndroidEdition.Amazon) ? "https://play.google.com/store/apps/details?id=com.slender.android" : "http://www.amazon.com/Pocket-Slenderman-Rising-your-virtual/dp/B00I6IXU5A/ref=sr_1_5?s=mobile-apps&ie=UTF8&qid=1395990920&sr=1-5&keywords=slendy";
		}
		return string.Empty;
	}

	private string _SocialMessage()
	{
		string applicationUrl = Defs2.ApplicationUrl;
		return "Come and play with me in epic multiplayer shooter - Pixel Gun 3D! " + applicationUrl;
	}

	private string _SocialSentSuccess(string SocialName)
	{
		return "Your best score was sent to " + SocialName;
	}

	private void completionHandler(string error, object result)
	{
		if (error != null)
		{
			Debug.LogError(error);
		}
		else
		{
			Utils.logObject(result);
		}
	}

	private void facebookGraphReqCompl(object result)
	{
		Utils.logObject(result);
	}

	private void facebookSessionOpened()
	{
		_hasPublishPermission = ServiceLocator.FacebookFacade.GetSessionPermissions().Contains("publish_stream");
		_hasPublishActions = ServiceLocator.FacebookFacade.GetSessionPermissions().Contains("publish_actions");
	}

	private void facebookreauthorizationSucceededEvent()
	{
		_hasPublishPermission = ServiceLocator.FacebookFacade.GetSessionPermissions().Contains("publish_stream");
		_hasPublishActions = ServiceLocator.FacebookFacade.GetSessionPermissions().Contains("publish_actions");
	}

	private void Awake()
	{
		using (new StopwatchLogger("MainMenu.Awake()"))
		{
			GlobalGameController.SetMultiMode();
			if (WeaponManager.sharedManager != null)
			{
				WeaponManager.sharedManager.Reset(0);
			}
			else if (!WeaponManager.sharedManager && (bool)weaponManagerPrefab)
			{
				GameObject gameObject = Object.Instantiate(weaponManagerPrefab, Vector3.zero, Quaternion.identity) as GameObject;
				gameObject.GetComponent<WeaponManager>().Reset(0);
			}
		}
	}

	private IEnumerator WaitForExperienceGuiAndAdd(ExperienceController legacyExperienceController, int addend)
	{
		while (ExpController.Instance == null)
		{
			yield return null;
		}
		legacyExperienceController.addExperience(addend);
	}

	private void Start()
	{
		using (new StopwatchLogger("MainMenu.Start()"))
		{
			sharedMenu = this;
			StoreKitEventListener.State.Mode = "In_main_menu";
			StoreKitEventListener.State.PurchaseKey = "In shop";
			StoreKitEventListener.State.Parameters.Clear();
			if (EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Paused || EveryplayWrapper.Instance.CurrentState == EveryplayWrapper.State.Recording)
			{
				EveryplayWrapper.Instance.Stop();
			}
			if (!FriendsController.sharedController.dataSent)
			{
				FriendsController.sharedController.InitOurInfo();
				FriendsController.sharedController.SendOurData(true);
				FriendsController.sharedController.dataSent = true;
			}
			if (NotificationController.isGetEveryDayMoney)
			{
				isShowAvard = true;
			}
			invCur = PlayerPrefs.GetInt(Defs.InvertCamSN, 0) == 1;
			bool flag = false;
			expController = GameObject.FindGameObjectWithTag("ExperienceController").GetComponent<ExperienceController>();
			if (expController == null)
			{
				Debug.LogError("MainMenu.Start():    expController == null");
			}
			if (Storager.getInt(Defs.CoinsAfterTrainingSN, false) == 1)
			{
				Storager.setInt(Defs.CoinsAfterTrainingSN, 0, false);
				if ((BuildSettings.BuildTarget == BuildTarget.iPhone || BuildSettings.BuildTarget == BuildTarget.WP8Player) && !Storager.hasKey(Defs.GotCoinsForTraining))
				{
					int num = 5;
					BankController.AddGems(num);
					FlurryEvents.LogGemsGained("Main Menu", num);
					int num2 = 10;
					BankController.AddCoins(num2);
					FlurryEvents.LogCoinsGained("Main Menu", num2);
					AudioClip clip = Resources.Load("coin_get") as AudioClip;
					if (Defs.isSoundFX)
					{
						NGUITools.PlaySound(clip);
					}
					if (expController != null)
					{
						if (ExpController.Instance != null)
						{
							expController.addExperience(10);
						}
						else
						{
							StartCoroutine(WaitForExperienceGuiAndAdd(expController, 10));
						}
						flag = expController.currentLevel != expController.oldCurrentLevel;
					}
				}
				FlurryEvents.LogTrainingProgress("Complete");
				TrainingController.TrainingCompleted = true;
			}
			if (expController != null)
			{
				expController.isMenu = true;
			}
			float coef = Defs.Coef;
			if (expController != null)
			{
				expController.posRanks = new Vector2(21f * Defs.Coef, 21f * Defs.Coef);
			}
			string @string = PlayerPrefs.GetString(Defs.ShouldReoeatActionSett, string.Empty);
			if (@string.Equals(Defs.GoToProfileAction))
			{
				PlayerPrefs.SetString(Defs.ShouldReoeatActionSett, string.Empty);
				PlayerPrefs.Save();
			}
			Storager.setInt(Defs.EarnedCoins, 0, false);
			Invoke("setEnabledGUI", 0.1f);
			_purchaseActivityIndicator = StoreKitEventListener.purchaseActivityInd;
			if (_purchaseActivityIndicator == null)
			{
				Debug.LogWarning("_purchaseActivityIndicator is null.");
			}
			else
			{
				_purchaseActivityIndicator.SetActive(true);
			}
			PlayerPrefs.SetInt("typeConnect__", -1);
			if (!GameObject.FindGameObjectWithTag("SkinsManager") && (bool)skinsManagerPrefab)
			{
				Object.Instantiate(skinsManagerPrefab, Vector3.zero, Quaternion.identity);
			}
			if (!WeaponManager.sharedManager && (bool)weaponManagerPrefab)
			{
				Object.Instantiate(weaponManagerPrefab, Vector3.zero, Quaternion.identity);
			}
			GlobalGameController.ResetParameters();
			GlobalGameController.Score = 0;
			bool flag2 = false;
			if (PlayerPrefs.GetInt(Defs.ShouldEnableShopSN, 0) == 1)
			{
				flag2 = true;
				PlayerPrefs.SetInt(Defs.ShouldEnableShopSN, 0);
				PlayerPrefs.Save();
			}
			if (Application.platform != RuntimePlatform.WP8Player && (Application.platform != RuntimePlatform.Android || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon) && Defs.EnderManAvailable && !flag2 && !flag && !isShowAvard && PlayerPrefs.GetInt(Defs.ShowEnder_SN, 0) == 1)
			{
				float @float = PlayerPrefs.GetFloat(Defs.TimeFromWhichShowEnder_SN, 0f);
				float num3 = Switcher.SecondsFrom1970() - @float;
				Debug.Log("diff mainmenu: " + num3);
				if (num3 >= ((!Application.isEditor && !Debug.isDebugBuild) ? 86400f : 0f))
				{
					PlayerPrefs.SetInt(Defs.ShowEnder_SN, 0);
					Object.Instantiate(Resources.Load("Ender") as GameObject);
				}
			}
		}
	}

	private void SetInApp()
	{
		isInappWinOpen = !isInappWinOpen;
		if (expController != null)
		{
			expController.isShowRanks = !isInappWinOpen;
			expController.isMenu = !isInappWinOpen;
		}
		if (isInappWinOpen)
		{
			if (StoreKitEventListener.restoreInProcess && _purchaseActivityIndicator != null)
			{
				_purchaseActivityIndicator.SetActive(true);
			}
			if (!Defs.isMulti)
			{
				Time.timeScale = 0f;
			}
		}
		else if (_purchaseActivityIndicator == null)
		{
			Debug.LogWarning("SetInApp(): _purchaseActivityIndicator is null.");
		}
		else
		{
			_purchaseActivityIndicator.SetActive(false);
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
			showMessagTiwtter = true;
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
			showMessagTiwtter = true;
			Invoke("hideMessagTwitter", 3f);
		}
	}

	private void OnTwitterPostFailed(string _error)
	{
		TwitterManager.requestDidFinishEvent -= OnTwitterPost;
	}

	public static bool SkinsMakerSupproted()
	{
		bool result = BuildSettings.BuildTarget != BuildTarget.WP8Player;
		if (BuildSettings.BuildTarget == BuildTarget.Android)
		{
			result = Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GooglePro && Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GoogleLite;
		}
		return result;
	}

	private void HandleBackFromFreeCoins()
	{
		showFreeCoins = false;
		if (expController != null)
		{
			expController.isShowRanks = true;
		}
	}

	private void HandleBackFromSettings()
	{
		isShowSetting = false;
		if (expController != null)
		{
			expController.isShowRanks = true;
		}
	}

	private void Update()
	{
		float num = ((float)Screen.width - 42f * Defs.Coef - Defs.Coef * (672f + (float)(SkinsMakerSupproted() ? 262 : 0))) / ((!SkinsMakerSupproted()) ? 2f : 3f);
		if (expController != null)
		{
			expController.posRanks = new Vector2(21f * Defs.Coef, 21f * Defs.Coef);
		}
		if (showFreeCoins)
		{
			if (_backFromFreeCoinsPressed)
			{
				_backFromFreeCoinsPressed = false;
				HandleBackFromFreeCoins();
				return;
			}
			if (Input.GetKeyUp(KeyCode.Escape))
			{
				Input.ResetInputAxes();
				_backFromFreeCoinsPressed = true;
				return;
			}
		}
		if (isShowSetting && !JoysticksUIRoot.activeInHierarchy)
		{
			if (_backFromSettingsPressed)
			{
				_backFromSettingsPressed = false;
				HandleBackFromSettings();
			}
			else if (Input.GetKeyUp(KeyCode.Escape))
			{
				Input.ResetInputAxes();
				_backFromSettingsPressed = true;
			}
		}
	}

	private void LateUpdate()
	{
	}

	[Obfuscation(Exclude = true)]
	private void setEnabledGUI()
	{
		isFirstFrame = false;
	}

	private bool FacebookSupported()
	{
		return (Application.platform == RuntimePlatform.IPhonePlayer) ? (iOSVersion > 5f) : (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.WP8Player);
	}

	private void CompletionHandlerPostFacebook(string error, object result)
	{
		if (error != null)
		{
			Debug.LogError("Post error: " + error);
			Utils.logObject(result);
			return;
		}
		Debug.Log("Post to Success");
		Utils.logObject(result);
		showMessagFacebook = true;
		Invoke("hideMessag", 3f);
		FlurryPluginWrapper.LogFacebook();
		FlurryPluginWrapper.LogFreeCoinsFacebook();
		PlayerPrefs.SetInt("freeFacebook", 1);
		int @int = Storager.getInt("Coins", false);
		Storager.setInt("Coins", @int + 5, false);
		FlurryEvents.LogCoinsGained("Main Menu", 5);
	}

	private void OnDestroy()
	{
		sharedMenu = null;
		if (expController != null)
		{
			expController.isShowRanks = false;
			expController.isMenu = false;
		}
	}

	[Obfuscation(Exclude = true)]
	private void hideMessag()
	{
		showMessagFacebook = false;
	}

	[Obfuscation(Exclude = true)]
	private void hideMessagTwitter()
	{
		showMessagTiwtter = false;
	}
}
