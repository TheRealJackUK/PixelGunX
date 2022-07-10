using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Rilisoft;
using Rilisoft.MiniJson;
using SponsorPay;
using UnityEngine;

internal sealed class FreeAwardController : MonoBehaviour
{
	public class StateEventArgs : EventArgs
	{
		public State State { get; set; }

		public State OldState { get; set; }
	}

	public abstract class State
	{
		private static readonly Rilisoft.Lazy<SponsorPayPlugin> _sponsorPayPlugin = new Rilisoft.Lazy<SponsorPayPlugin>(InitializeSponsorPayPlugin);

		public static SponsorPayPlugin SponsorPayPlugin
		{
			get
			{
				return _sponsorPayPlugin.Value;
			}
		}

		private static SponsorPayPlugin InitializeSponsorPayPlugin()
		{
			SponsorPayPlugin pluginInstance = SponsorPayPluginMonoBehaviour.PluginInstance;
			if (pluginInstance == null)
			{
				throw new InvalidOperationException("Fyber (SponsorPay) plugin is not initialized.");
			}
			return pluginInstance;
		}
	}

	public sealed class IdleState : State
	{
		private static readonly IdleState _instance = new IdleState();

		internal static IdleState Instance
		{
			get
			{
				return _instance;
			}
		}

		private IdleState()
		{
		}
	}

	public sealed class WatchState : State
	{
		private static readonly WatchState _instance = new WatchState();

		internal static WatchState Instance
		{
			get
			{
				return _instance;
			}
		}

		private WatchState()
		{
		}
	}

	public sealed class WaitingState : State
	{
		private readonly float _startTime;

		public float StartTime
		{
			get
			{
				return _startTime;
			}
		}

		public WaitingState(float startTime)
		{
			_startTime = startTime;
		}

		public WaitingState()
			: this(Time.realtimeSinceStartup)
		{
		}
	}

	public sealed class WatchingState : State
	{
		private readonly float _startTime;

		private bool _adClosed;

		public bool AdClosed
		{
			get
			{
				return _adClosed;
			}
		}

		public float StartTime
		{
			get
			{
				return _startTime;
			}
		}

		public WatchingState()
		{
			WatchingState watchingState = this;
			_startTime = Time.realtimeSinceStartup;
			string context = DetermineContext();
			Storager.setInt("PendingFreeAward", (int)Instance.Provider, false);
			if (Instance.Provider == AdProvider.GoogleMobileAds)
			{
				AdvertisementInfo advertisementInfo = new AdvertisementInfo(Instance.RoundIndex, Instance.ProviderClampedIndex);
			}
			else if (Instance.Provider != AdProvider.UnityAds && Instance.Provider != AdProvider.Vungle && Instance.Provider == AdProvider.Fyber)
			{
				AdvertisementInfo advertisementInfo2 = new AdvertisementInfo(Instance.RoundIndex, Instance.ProviderClampedIndex);
				BrandEngageResultHandler handler = null;
				handler = delegate(string message)
				{
					State.SponsorPayPlugin.OnBrandEngageResultReceived -= handler;
					LogAdsEvent("Fyber (SponsorPay) - Video - Impressions", context);
					Dictionary<string, string> parameters = new Dictionary<string, string> { 
					{
						"Fyber - Rewarded Video",
						"Impression: " + message
					} };
					FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
					LogImpressionDetails(advertisementInfo2);
					_adClosed = true;
				};
				State.SponsorPayPlugin.OnBrandEngageResultReceived += handler;
				State.SponsorPayPlugin.StartBrandEngage();
				FyberVideoLoaded = null;
			}
		}

		private static void LogImpressionDetails(AdvertisementInfo advertisementInfo)
		{
			if (advertisementInfo == null)
			{
				advertisementInfo = AdvertisementInfo.Default;
			}
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendFormat("Round {0}", advertisementInfo.Round + 1);
			stringBuilder.AppendFormat(", Slot {0} ({1})", advertisementInfo.Slot + 1, AnalyticsHelper.GetAdProviderName(Instance.GetProviderByIndex(advertisementInfo.Slot)));
			if (InterstitialManager.Instance.Provider == AdProvider.GoogleMobileAds)
			{
				stringBuilder.AppendFormat(", Unit {0}", advertisementInfo.Unit + 1);
			}
			if (string.IsNullOrEmpty(advertisementInfo.Details))
			{
				stringBuilder.Append(" - Impression");
			}
			else
			{
				stringBuilder.AppendFormat(" - Impression: {0}", advertisementInfo.Details);
			}
		}

		private static string DetermineContext()
		{
			if (BankController.Instance != null && BankController.Instance.InterfaceEnabled)
			{
				if (Defs.isMulti)
				{
					return "Bank (Multiplayer)";
				}
				if (Defs.isCompany)
				{
					return "Bank (Campaign)";
				}
				if (Defs.IsSurvival)
				{
					return "Bank (Survival)";
				}
				return "Bank";
			}
			return "At Lobby";
		}

		private void LogUnityAdsImpression(string context)
		{
			LogAdsEvent("Unity Ads - Video - Impressions", context);
		}

		private void LogVungleImpression(string context)
		{
			LogAdsEvent("Vungle - Video - Impressions", context);
		}

		private void LogAdsEvent(string eventName, string context)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>(3);
			dictionary.Add("Context", context ?? string.Empty);
			Dictionary<string, string> dictionary2 = dictionary;
			if (ExperienceController.sharedController != null)
			{
				dictionary2.Add("Levels", ExperienceController.sharedController.currentLevel.ToString());
			}
			if (ExpController.Instance != null)
			{
				dictionary2.Add("Tiers", ExpController.Instance.OurTier.ToString());
			}
			FlurryPluginWrapper.LogEventAndDublicateToConsole(eventName, dictionary2);
		}

		private void LogUnityAdsClick(string result)
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>(3);
			dictionary.Add("Result", result ?? string.Empty);
			Dictionary<string, string> dictionary2 = dictionary;
			if (ExperienceController.sharedController != null)
			{
				dictionary2.Add("Levels", ExperienceController.sharedController.currentLevel.ToString());
			}
			if (ExpController.Instance != null)
			{
				dictionary2.Add("Tiers", ExpController.Instance.OurTier.ToString());
			}
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Unity Ads - Video - Clicks", dictionary2);
		}
	}

	public sealed class ConnectionState : State
	{
		private readonly float _startTime;

		public float StartTime
		{
			get
			{
				return _startTime;
			}
		}

		public ConnectionState()
		{
			_startTime = Time.realtimeSinceStartup;
		}
	}

	public sealed class AwardState : State
	{
		private static readonly AwardState _instance = new AwardState();

		internal static AwardState Instance
		{
			get
			{
				return _instance;
			}
		}

		private AwardState()
		{
		}
	}

	public sealed class CloseState : State
	{
		private static readonly CloseState _instance = new CloseState();

		internal static CloseState Instance
		{
			get
			{
				return _instance;
			}
		}

		private CloseState()
		{
		}
	}

	private const string AdvertCountDuringCurrentPeriodKey = "AdvertCountDuringCurrentPeriod";

	public const string PendingFreeAwardKey = "PendingFreeAward";

	public FreeAwardView view;

	private static FreeAwardController _instance;

	private int _adProviderIndex;

	private State _currentState = IdleState.Instance;

	private DateTime _currentTime;

	public static bool FreeAwardChestIsInIdleState
	{
		get
		{
			return Instance == null || Instance.IsInState<IdleState>();
		}
	}

	public static FreeAwardController Instance
	{
		get
		{
			return _instance;
		}
	}

	public AdProvider Provider
	{
		get
		{
			return GetProviderByIndex(_adProviderIndex);
		}
	}

	public int ProviderClampedIndex
	{
		get
		{
			if (PromoActionsManager.MobileAdvert == null)
			{
				return -1;
			}
			if (PromoActionsManager.MobileAdvert.AdProviders.Count == 0)
			{
				return 0;
			}
			return _adProviderIndex % PromoActionsManager.MobileAdvert.AdProviders.Count;
		}
	}

	public int RoundIndex
	{
		get
		{
			if (PromoActionsManager.MobileAdvert == null)
			{
				return -1;
			}
			if (PromoActionsManager.MobileAdvert.AdProviders.Count == 0)
			{
				return 0;
			}
			return _adProviderIndex / PromoActionsManager.MobileAdvert.AdProviders.Count;
		}
	}

	private State CurrentState
	{
		get
		{
			return _currentState;
		}
		set
		{
			if (value != null)
			{
				if (view != null)
				{
					view.CurrentState = value;
				}
				State currentState = _currentState;
				_currentState = value;
				EventHandler<StateEventArgs> stateChanged = this.StateChanged;
				if (stateChanged != null)
				{
					stateChanged(this, new StateEventArgs
					{
						State = value,
						OldState = currentState
					});
				}
			}
		}
	}

	internal static Future<bool> FyberVideoLoaded { get; set; }

	public int CountMoneyForAward
	{
		get
		{
			return 0;
		}
	}

	public event EventHandler<StateEventArgs> StateChanged;

	public AdProvider GetProviderByIndex(int index)
	{
		if (PromoActionsManager.MobileAdvert == null)
		{
			return AdProvider.None;
		}
		if (PromoActionsManager.MobileAdvert.AdProviders.Count == 0)
		{
			return (AdProvider)PromoActionsManager.MobileAdvert.AdProvider;
		}
		return (AdProvider)PromoActionsManager.MobileAdvert.AdProviders[index % PromoActionsManager.MobileAdvert.AdProviders.Count];
	}

	internal int SwitchAdProvider()
	{
		int adProviderIndex = _adProviderIndex;
		AdProvider provider = Provider;
		_adProviderIndex++;
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Switching provider from {0} ({1}) to {2} ({3})", adProviderIndex, provider, _adProviderIndex, Provider);
			Debug.Log(message);
		}
		return _adProviderIndex;
	}

	private void ResetAdProvider()
	{
		int adProviderIndex = _adProviderIndex;
		AdProvider provider = Provider;
		_adProviderIndex = 0;
		AdProvider provider2 = Provider;
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Resetting AdProvider from {0} ({1}) to {2} ({3})", adProviderIndex, provider, _adProviderIndex, Provider);
			Debug.Log(message);
		}
	}

	public T TryGetState<T>() where T : State
	{
		return CurrentState as T;
	}

	public bool IsInState<T>() where T : State
	{
		return CurrentState is T;
	}

	internal void SetWatchState()
	{
		ResetAdProvider();
		LoadVideo("SetWatchState");
		CurrentState = WatchState.Instance;
	}

	private void LoadVideo(string callerName = null)
	{
		if (callerName == null)
		{
			callerName = string.Empty;
		}
		else if (Instance.Provider == AdProvider.Fyber)
		{
			FyberVideoLoaded = LoadFyberVideo(callerName);
		}
	}

	public void HandleClose()
	{
		if (IsInState<CloseState>())
		{
			HideButtonsShowAward();
		}
		CurrentState = IdleState.Instance;
	}

	public void HandleWatch()
	{
		CurrentState = new WaitingState();
	}

	public void HandleDeveloperSkip()
	{
		CurrentState = new WatchingState();
	}

	public int GiveAwardAndIncrementCount()
	{
		int advertCountDuringCurrentPeriod = GetAdvertCountDuringCurrentPeriod();
		int num = advertCountDuringCurrentPeriod + 1;
		SetAdvertCountDuringCurrentPeriod(num);
		BankController.AddCoins(CountMoneyForAward);
		Storager.setInt("PendingFreeAward", 0, false);
		PlayerPrefs.Save();
		FlurryEvents.LogCoinsGained(FlurryEvents.GetPlayingMode(), CountMoneyForAward);
		return num;
	}

	public void HandleGetAward()
	{
		int num = GiveAwardAndIncrementCount();
		CurrentState = CloseState.Instance;
	}

	internal static Future<bool> LoadFyberVideo(string callerName = null)
	{
		if (callerName == null)
		{
			callerName = string.Empty;
		}
		Promise<bool> promise = new Promise<bool>();
		int attemptCount = 0;
		int roundIndex = Instance.RoundIndex;
		BrandEngageRequestResponseReceivedHandler receivedHandler = null;
		BrandEngageRequestErrorReceivedHandler errorHandler = null;
		receivedHandler = delegate(bool offersAvailable)
		{
			if (Defs.IsDeveloperBuild)
			{
				string message3 = string.Format("OnBrandEngageRequestResponseReceived ({0}). Offers available: {1}", callerName, offersAvailable);
				Debug.Log(message3);
			}
			if (offersAvailable)
			{
				promise.SetResult(true);
				State.SponsorPayPlugin.OnBrandEngageRequestResponseReceived -= receivedHandler;
				State.SponsorPayPlugin.OnBrandEngageRequestErrorReceived -= errorHandler;
			}
			else if (++attemptCount < 1)
			{
				RequestFyberRewardedVideo(roundIndex);
			}
			else
			{
				promise.SetResult(false);
				State.SponsorPayPlugin.OnBrandEngageRequestResponseReceived -= receivedHandler;
				State.SponsorPayPlugin.OnBrandEngageRequestErrorReceived -= errorHandler;
			}
		};
		errorHandler = delegate(string message)
		{
			string message2 = string.Format("OnBrandEngageRequestErrorReceived ({0}, {1}). Message: {2}", callerName, attemptCount, message);
			Debug.Log(message2);
			if (++attemptCount < 1)
			{
				RequestFyberRewardedVideo(roundIndex);
			}
			else
			{
				promise.SetResult(false);
				State.SponsorPayPlugin.OnBrandEngageRequestResponseReceived -= receivedHandler;
				State.SponsorPayPlugin.OnBrandEngageRequestErrorReceived -= errorHandler;
			}
		};
		State.SponsorPayPlugin.OnBrandEngageRequestResponseReceived += receivedHandler;
		State.SponsorPayPlugin.OnBrandEngageRequestErrorReceived += errorHandler;
		RequestFyberRewardedVideo(roundIndex);
		return promise.Future;
	}

	private static void RequestFyberRewardedVideo(int roundIndex)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("Fyber - Rewarded Video", "Request");
		Dictionary<string, string> parameters = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendFormat("Round {0}", roundIndex + 1);
		stringBuilder.AppendFormat(", Slot {0} ({1})", Instance.ProviderClampedIndex + 1, AnalyticsHelper.GetAdProviderName(Instance.Provider));
		stringBuilder.Append(" - Request");
		dictionary = new Dictionary<string, string>();
		dictionary.Add("ADS - Statistics - Rewarded", stringBuilder.ToString());
		Dictionary<string, string> parameters2 = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole("ADS Statistics Total", parameters2);
		State.SponsorPayPlugin.RequestBrandEngageOffers("golden_coins", false);
	}

	private void HideButtonsShowAward()
	{
		BankController instance = BankController.Instance;
		bool flag = false;
		if (instance != null && instance.InterfaceEnabled)
		{
			instance.bankView.freeAwardButton.gameObject.SetActive(false);
			flag = true;
		}
		MainMenuController sharedController = MainMenuController.sharedController;
		if (sharedController != null)
		{
			FreeAwardShowHandler component = sharedController.freeAwardChestObj.GetComponent<FreeAwardShowHandler>();
			if (flag)
			{
				component.HideChestTitle();
			}
			else
			{
				component.HideChestWithAnimation();
			}
		}
	}

	internal bool AdvertCountLessThanLimit()
	{
		return true;
	}

	internal bool TimeTamperingDetected()
	{
		if (!Storager.hasKey("AdvertCountDuringCurrentPeriod"))
		{
			return false;
		}
		string @string = Storager.getString("AdvertCountDuringCurrentPeriod", false);
		Dictionary<string, object> dictionary = Json.Deserialize(@string) as Dictionary<string, object>;
		if (dictionary == null)
		{
			return false;
		}
		string strB = dictionary.Keys.Min();
		string text = _currentTime.ToString("yyyy-MM-dd");
		return text.CompareTo(strB) < 0;
	}

	private void Awake()
	{
		_currentTime = DateTime.UtcNow;
		if (_instance == null)
		{
			_instance = this;
		}
		CurrentState = IdleState.Instance;
		view.prizeMoneyLabel.text = string.Format("+{0}\n{1}", CountMoneyForAward, LocalizationStore.Get("Key_0275"));
		SponsorPayPluginMonoBehaviour component = base.gameObject.GetComponent<SponsorPayPluginMonoBehaviour>();
		if (component == null)
		{
			component = base.gameObject.AddComponent<SponsorPayPluginMonoBehaviour>();
		}
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
	}

	private IEnumerator Start()
	{
		while (FriendsController.sharedController == null)
		{
			yield return null;
		}
		while (FriendsController.sharedController.id == null)
		{
			yield return null;
		}
		while (SponsorPayPluginMonoBehaviour.PluginInstance == null)
		{
			yield return null;
		}
		string appId = "00000";
		string securityToken = "00000000000000000000000000000000";
		if (BuildSettings.BuildTarget == BuildTarget.Android)
		{
			appId = "32897";
			securityToken = "cf77aeadd83faf98e0cad61a1f1403c8";
		}
		else if (BuildSettings.BuildTarget == BuildTarget.iPhone)
		{
			appId = "32894";
			securityToken = "1835ac9051f2f168547c88eb7c5a3edb";
		}
		SetCookieAcceptPolicy();
		SponsorPayPlugin sponsorPayPlugin = SponsorPayPluginMonoBehaviour.PluginInstance;
		sponsorPayPlugin.EnableLogging(true);
		sponsorPayPlugin.SetLogLevel(SPLogLevel.Verbose);
		Dictionary<string, string> parameters = new Dictionary<string, string>
		{
			{
				"pub0",
				SystemInfo.deviceModel
			},
			{
				"pub1",
				(FriendsController.sharedController.id.Length <= 4) ? FriendsController.sharedController.id : FriendsController.sharedController.id.Substring(FriendsController.sharedController.id.Length - 4, 4)
			}
		};
		sponsorPayPlugin.AddParameters(parameters);
		sponsorPayPlugin.Start(appId, FriendsController.sharedController.id, securityToken);
		yield return null;
		WWWForm wwwForm = new WWWForm();
		wwwForm.AddField("action", "get_time");
		wwwForm.AddField("app_version", string.Format("{0}:{1}", ProtocolListGetter.CurrentPlatform, GlobalGameController.AppVersion));
		wwwForm.AddField("uniq_id", FriendsController.sharedController.id);
		wwwForm.AddField("auth", FriendsController.Hash("get_time"));
		WWW download = new WWW(URLs.Friends, wwwForm);
		yield return download;
		string response = URLs.Sanitize(download);
		int currentServerTime;
		if (!string.IsNullOrEmpty(download.error))
		{
			Debug.LogWarning("FreeAwardController.Start() error:    “" + download.error + "”");
		}
		else if (!int.TryParse(response, out currentServerTime))
		{
			Debug.LogWarning("FreeAwardController.Start() parsing error:    “" + response + "”");
		}
		else
		{
			_currentTime = StarterPackModel.GetCurrentTimeByUnixTime(currentServerTime);
		}
	}

	private void Update()
	{
		WaitingState waitingState = TryGetState<WaitingState>();
		if (waitingState != null)
		{
			if (Application.isEditor || Application.platform == RuntimePlatform.WP8Player)
			{
				SwitchAdProvider();
				CurrentState = new ConnectionState();
			}
			else if (Provider == AdProvider.GoogleMobileAds)
			{
					LoadVideo("Update");
					CurrentState = new WaitingState(waitingState.StartTime);
				}
				else if (Time.realtimeSinceStartup - waitingState.StartTime > (float)PromoActionsManager.MobileAdvert.TimeoutWaitVideo)
				{
					CurrentState = new ConnectionState();
				}
			}
			else if (Provider == AdProvider.Fyber)
			{
				if (FyberVideoLoaded != null && FyberVideoLoaded.IsCompleted)
				{
					if (FyberVideoLoaded.Result)
					{
						CurrentState = new WatchingState();
						return;
					}
					if (Defs.IsDeveloperBuild)
					{
						Debug.Log("Fyber loading failed. Keep waiting.");
					}
					int num2 = SwitchAdProvider();
					if (PromoActionsManager.MobileAdvert.AdProviders.Count > 0 && num2 >= PromoActionsManager.MobileAdvert.CountRoundReplaceProviders * PromoActionsManager.MobileAdvert.AdProviders.Count)
					{
						CurrentState = new ConnectionState();
						return;
					}
					LoadVideo("Update");
					CurrentState = new WaitingState(waitingState.StartTime);
				}
					CurrentState = new ConnectionState();
			}
			else if (Time.realtimeSinceStartup - waitingState.StartTime > (float)PromoActionsManager.MobileAdvert.TimeoutWaitVideo)
			{
				CurrentState = new ConnectionState();
			}
			return;
		WatchingState watchingState = TryGetState<WatchingState>();
		if (watchingState != null)
		{
			bool flag = true;
			if (watchingState.AdClosed || flag)
			{
				if (flag)
				{
					CurrentState = AwardState.Instance;
					return;
				}
				ResetAdProvider();
				LoadVideo("Update");
				CurrentState = WatchState.Instance;
			}
		}
		else
		{
			ConnectionState connectionState = TryGetState<ConnectionState>();
			if (connectionState != null && Time.realtimeSinceStartup - connectionState.StartTime > 3f)
			{
				CurrentState = IdleState.Instance;
			}
		}
	}

	public int GetAdvertCountDuringCurrentPeriod()
	{
		string text = ((!Storager.hasKey("AdvertCountDuringCurrentPeriod")) ? "{}" : Storager.getString("AdvertCountDuringCurrentPeriod", false));
		Dictionary<string, object> dictionary = Json.Deserialize(text) as Dictionary<string, object>;
		if (dictionary == null)
		{
			if (Application.isEditor || Defs.IsDeveloperBuild)
			{
				Debug.LogWarning("Cannot parse “AdvertCountDuringCurrentPeriod” to dictionary: “" + text + "”");
			}
			SetAdvertCountDuringCurrentPeriod(0);
			return 0;
		}
		string text2 = _currentTime.ToString("yyyy-MM-dd");
		object value;
		if (!dictionary.TryGetValue(text2, out value))
		{
			if (Application.isEditor || Defs.IsDeveloperBuild)
			{
				Debug.LogWarning("Cannot get “" + text2 + "” from dictionary: “" + text + "”");
			}
			dictionary[text2] = 0;
			SetAdvertCounts(dictionary);
			return 0;
		}
		return Convert.ToInt32(value);
	}

	public void SetAdvertCountDuringCurrentPeriod(int count)
	{
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		dictionary.Add(_currentTime.ToString("yyyy-MM-dd"), count);
		Dictionary<string, object> advertCounts = dictionary;
		SetAdvertCounts(advertCounts);
	}

	private void SetAdvertCounts(Dictionary<string, object> d)
	{
		if (d == null)
		{
			d = new Dictionary<string, object>();
		}
		string val = Json.Serialize(d) ?? string.Empty;
		Storager.setString("AdvertCountDuringCurrentPeriod", val, false);
	}

	private static void SetCookieAcceptPolicy()
	{
		if (Defs.IsDeveloperBuild)
		{
			Debug.Log(string.Format("Setting cookie accept policy is dumb on {0}.", Application.platform));
		}
	}
}
