using System;
using System.Collections.Generic;
using System.Net;
using Prime31;
using Rilisoft.MiniJson;
using UnityEngine;

public sealed class FlurryPluginWrapper : MonoBehaviour
{
	public const string BackToMainMenu = "Back to Main Menu";

	public const string UnlockHungerMoney = "Enable_Deadly Games";

	private const string PayingUserKey = "PayingUser";

	public static string ModeEnteredEvent = "ModeEnteredEvent";

	public static string MapEnteredEvent = "MapEnteredEvent";

	public static string MapNameParameter = "MapName";

	public static string ModeParameter = "Mode";

	public static string ModePressedEvent = "ModePressed";

	public static string SocialEventName = "Post to Social";

	public static string SocialParName = "Service";

	public static string AppVersionParameter = "App_version";

	public static string MultiplayeLocalEvent = "Local Button Pressed";

	public static string MultiplayerWayDeaathmatchEvent = "Way_to_start_multiplayer_DEATHMATCH";

	public static string MultiplayerWayCOOPEvent = "Way_to_start_multiplayer_COOP";

	public static string MultiplayerWayCompanyEvent = "Way_to_start_multiplayer_Company";

	public static string WayName = "Button";

	public static readonly string HatsCapesShopPressedEvent = "Hats_Capes_Shop";

	public static string FreeCoinsEv = "FreeCoins";

	public static string FreeCoinsParName = "type";

	public static string RateUsEv = "Rate_Us";

	public static Dictionary<string, string> LevelAndTierParameters
	{
		get
		{
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Levels", ((ExperienceController.sharedController != null) ? ExperienceController.sharedController.currentLevel : 0).ToString());
			dictionary.Add("Tiers", (((ExpController.Instance != null) ? ExpController.Instance.OurTier : 0) + 1).ToString());
			return dictionary;
		}
	}

	public static string MultiplayerWayEvent
	{
		get
		{
			return Defs.isCOOP ? MultiplayerWayCOOPEvent : ((!Defs.isCompany) ? MultiplayerWayDeaathmatchEvent : MultiplayerWayCompanyEvent);
		}
	}

	public static void LogLevelPressed(string n)
	{
		FlurryAnalytics.logEvent(n + "Pressed", false);
		LogEventToDevToDev(n + " Pressed");
	}

	public static void LogBoxOpened(string nm)
	{
		LogEvent(nm + "_Box_Opened");
	}

	public static void LogEventWithParameterAndValue(string ev, string pat, string val)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add(pat, val);
		dictionary.Add("Paying User", IsPayingUser().ToString());
		Dictionary<string, string> parameters = dictionary;
		FlurryAnalytics.logEvent(ev, parameters, false);
		LogEventToDevToDev(ev);
	}

	public static void LogEvent(string eventName)
	{
		FlurryAnalytics.logEvent(eventName, false);
		LogEventToDevToDev(eventName);
	}

	public static void LogTimedEvent(string eventName)
	{
		FlurryAnalytics.logEvent(eventName, true);
	}

	public static void LogEvent(string eventName, Dictionary<string, string> parameters)
	{
		if (!parameters.ContainsKey("Paying User"))
		{
			parameters.Add("Paying User", IsPayingUser().ToString());
		}
		FlurryAnalytics.logEvent(eventName, parameters, false);
		LogEventToDevToDev(eventName, parameters);
	}

	public static void LogTimedEvent(string eventName, Dictionary<string, string> parameters)
	{
		if (!parameters.ContainsKey("Paying User"))
		{
			parameters.Add("Paying User", IsPayingUser().ToString());
		}
		FlurryAnalytics.logEvent(eventName, parameters, true);
	}

	public static void EndTimedEvent(string eventName)
	{
		FlurryAnalytics.endTimedEvent(eventName);
	}

	public static void LogEventAndDublicateToConsole(string eventName, Dictionary<string, string> parameters)
	{
		LogEvent(eventName, parameters);
		if (Debug.isDebugBuild)
		{
			string text = ((parameters == null) ? "{ }" : Rilisoft.MiniJson.Json.Serialize(parameters));
			Debug.Log(eventName + " : " + text);
		}
	}

	public static void LogFastPurchase(string purchaseKind)
	{
		if (ExperienceController.sharedController != null)
		{
			int currentLevel = ExperienceController.sharedController.currentLevel;
			int num = (currentLevel - 1) / 9;
			string arg = string.Format("[{0}, {1})", num * 9 + 1, (num + 1) * 9 + 1);
			string eventName = string.Format("Shop Purchases On Level {0} ({1}){2}", arg, (!IsPayingUser()) ? "Non Paying" : "Paying", string.Empty);
			Dictionary<string, string> dictionary = new Dictionary<string, string>();
			dictionary.Add("Level " + currentLevel, purchaseKind);
			Dictionary<string, string> parameters = dictionary;
			LogEventAndDublicateToConsole(eventName, parameters);
		}
		else
		{
			Debug.LogWarning("ExperienceController.sharedController == null");
		}
	}

	public static void LogMatchCompleted(string mode)
	{
		if (ExperienceController.sharedController != null)
		{
			string eventName = string.Format("Match Completed ({0})", (!IsPayingUser()) ? "Non Paying" : "Paying");
			LogEventAndDublicateToConsole(eventName, new Dictionary<string, string>
			{
				{
					"Rank",
					ExperienceController.sharedController.currentLevel.ToString()
				},
				{ "Mode", mode }
			});
		}
	}

	public static void LogWinInMatch(string mode)
	{
		if (ExperienceController.sharedController != null)
		{
			string eventName = string.Format("Win In Match ({0})", (!IsPayingUser()) ? "Non Paying" : "Paying");
			LogEventAndDublicateToConsole(eventName, new Dictionary<string, string>
			{
				{
					"Rank",
					ExperienceController.sharedController.currentLevel.ToString()
				},
				{ "Mode", mode }
			});
		}
	}

	public static void LogTimedEventAndDublicateToConsole(string eventName)
	{
		LogTimedEvent(eventName);
		if (Debug.isDebugBuild)
		{
			Debug.Log(eventName);
		}
	}

	public static void LogModeEventWithValue(string val)
	{
		if (!PlayerPrefs.HasKey("Mode Pressed First Time"))
		{
			PlayerPrefs.SetInt("Mode Pressed First Time", 0);
			LogEventWithParameterAndValue("Mode Pressed First Time", ModeParameter, val);
		}
		else
		{
			LogEventWithParameterAndValue(ModePressedEvent, ModeParameter, val);
		}
	}

	public static void LogMultiplayerWayStart()
	{
		LogEventWithParameterAndValue(MultiplayerWayEvent, WayName, "Start");
		LogEvent("Start");
	}

	public static void LogMultiplayerWayQuckRandGame()
	{
		LogEventWithParameterAndValue(MultiplayerWayEvent, WayName, "Quick_rand_game");
		LogEvent("Random");
	}

	public static void LogMultiplayerWayCustom()
	{
		LogEventWithParameterAndValue(MultiplayerWayEvent, WayName, "Custom");
		LogEvent("Custom");
	}

	public static void LogDeathmatchModePress()
	{
		LogModeEventWithValue("Deathmatch");
		LogEvent("Deathmatch");
	}

	public static void LogCampaignModePress()
	{
		LogModeEventWithValue("Survival");
		LogEvent("Campaign");
	}

	public static void LogTrueSurvivalModePress()
	{
		LogModeEventWithValue("Arena_Survival");
		LogEvent("Survival");
	}

	public static void LogCooperativeModePress()
	{
		LogModeEventWithValue("COOP");
		LogEvent("Cooperative");
	}

	public static void LogSkinsMakerModePress()
	{
		LogEvent("Skins Maker");
	}

	public static void LogTwitter()
	{
		LogEventWithParameterAndValue(SocialEventName, SocialParName, "Twitter");
//		DevToDevSDK.SocialNetworkPost(DevToDevSocialNetwork.Twitter, DevToDevSocialNetworkPostReason.Other);
	}

	public static void LogFacebook()
	{
		LogEventWithParameterAndValue(SocialEventName, SocialParName, "Facebook");
	//	DevToDevSDK.SocialNetworkPost(DevToDevSocialNetwork.Facebook, DevToDevSocialNetworkPostReason.Other);
	}

	public static void LogGamecenter()
	{
		LogEvent("Game Center");
	}

	public static void LogFreeCoinsFacebook()
	{
		LogEventWithParameterAndValue(FreeCoinsEv, FreeCoinsParName, "Facebook");
		LogEvent("Facebook");
	//	DevToDevSDK.SocialNetworkPost(DevToDevSocialNetwork.Facebook, DevToDevSocialNetworkPostReason.Other);
	}

	public static void LogFreeCoinsTwitter()
	{
		LogEventWithParameterAndValue(FreeCoinsEv, FreeCoinsParName, "Twitter");
		LogEvent("Twitter");
		//DevToDevSDK.SocialNetworkPost(DevToDevSocialNetwork.Twitter, DevToDevSocialNetworkPostReason.Other);
	}

	public static void LogFreeCoinsYoutube()
	{
		LogEventWithParameterAndValue(FreeCoinsEv, FreeCoinsParName, "Youtube");
		LogEvent("YouTube");
	}

	public static void LogCoinEarned()
	{
		LogEvent("Earned Coin Survival");
	}

	public static void LogCoinEarned_COOP()
	{
		LogEvent("Earned Coin COOP");
	}

	public static void LogCoinEarned_Deathmatch()
	{
		LogEvent("Earned Coin Deathmatch");
	}

	public static void LogFreeCoinsRateUs()
	{
		LogEvent(RateUsEv);
	}

	public static void LogSkinsMakerEnteredEvent()
	{
		LogEvent("SkinsMaker");
	}

	public static void LogAddYourSkinBoughtEvent()
	{
		LogEvent("AddYourSkin_Bought");
	}

	public static void LogAddYourSkinTriedToBoughtEvent()
	{
		LogEvent("AddYourSkin_TriedToBought");
	}

	public static void LogAddYourSkinUsedEvent()
	{
		LogEvent("AddYourSkin_Used");
	}

	public static void LogMultiplayeLocalEvent()
	{
		LogEvent(MultiplayeLocalEvent);
	}

	public static void LogMultiplayeWorldwideEvent()
	{
		LogEvent("Worldwide");
	}

	public static void LogCategoryEnteredEvent(string catName)
	{
		LogEventWithParameterAndValue("Dhop_Category", "Category_name", catName);
	}

	public static void LogEnteringMap(int typeConnect, string mapName)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add(MapNameParameter, mapName);
		Dictionary<string, string> parameters = dictionary;
		string eventName = (Defs.isCOOP ? "COOP" : "Deathmatch_WorldWide");
		FlurryAnalytics.logEvent(eventName, parameters, false);
	}

	public static void DoWithResponse(HttpWebRequest request, Action<HttpWebResponse> responseAction)
	{
		Action action = delegate
		{
			request.BeginGetResponse(delegate(IAsyncResult iar)
			{
				HttpWebResponse obj = (HttpWebResponse)((HttpWebRequest)iar.AsyncState).EndGetResponse(iar);
				responseAction(obj);
			}, request);
		};
		action.BeginInvoke(delegate(IAsyncResult iar)
		{
			Action action2 = (Action)iar.AsyncState;
			action2.EndInvoke(iar);
		}, action);
	}

	public static HttpWebRequest RequestAppWithID(string _id)
	{
		return (HttpWebRequest)WebRequest.Create("http://itunes.apple.com/lookup?id=" + _id);
	}

	public static bool IsPayingUser()
	{
		//Discarded unreachable code: IL_004c, IL_0074
		try
		{
			string @string = PlayerPrefs.GetString("Last Payment Time", string.Empty);
			DateTime result;
			if (DateTime.TryParse(@string, out result))
			{
				TimeSpan timeSpan = DateTime.UtcNow - result;
				return timeSpan <= TimeSpan.FromDays(14.0);
			}
			return false;
		}
		catch (ArgumentException exception)
		{
			Debug.LogWarning("IsPayingUser() called incorrectly, stacktrace:    " + Environment.StackTrace);
			Debug.LogException(exception);
			return false;
		}
	}

	public static bool IsPayingNUser(int num)
	{
		return IsPayingUser() && StoreKitEventListener.GetDollarsSpent() > num;
	}

	public static string GetEventX3State()
	{
		if (PromoActionsManager.sharedManager.IsEventX3Active)
		{
			if (PromoActionsManager.sharedManager.IsNewbieEventX3Active)
			{
				return "Newbie";
			}
			return "Common";
		}
		return "None";
	}

	private void CheckForEdnermanApp()
	{
	}

	private void InitializeFlurryWindowsPhone()
	{
	}

	private void OnApplicationPause(bool pause)
	{
		if (pause)
		{
			FlurryAnalytics.logEvent("Application Paused", true);
			return;
		}
		FlurryAnalytics.endTimedEvent("Application Paused");
		CheckForEdnermanApp();
		InitializeFlurryWindowsPhone();
	}

	private void Start()
	{
		CheckForEdnermanApp();
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
		FlurryAnalytics.startSession("4G82F29HDF359K693N94");
		FlurryAnalytics.setUserID(SystemInfo.deviceUniqueIdentifier);
		InitializeFlurryWindowsPhone();
	//	DevToDevSDK.Initialize("c705a8af-9893-050d-bf70-9b5ef9f37a3c", "9iR85EXmukcCradFjPBAnUy7Wh0SfpOK");
	//	DevToDevSDK.StartSession();
	}

	private void OnDestroy()
	{
	//	DevToDevSDK.EndSession();
	}

	private void OnEnable()
	{
	}

	private void OnDisable()
	{
	}

	private void spaceDidDismissEvent(string space)
	{
		Debug.Log("spaceDidDismissEvent: " + space);
	}

	private void spaceWillLeaveApplicationEvent(string space)
	{
		Debug.Log("spaceWillLeaveApplicationEvent: " + space);
	}

	private void spaceDidFailToRenderEvent(string space)
	{
		Debug.Log("spaceDidFailToRenderEvent: " + space);
	}

	private void spaceDidReceiveAdEvent(string space)
	{
		Debug.Log("spaceDidReceiveAdEvent: " + space);
	}

	private void spaceDidFailToReceiveAdEvent(string space)
	{
		Debug.Log("spaceDidFailToReceiveAdEvent: " + space);
	}

	private void onCurrencyValueFailedToUpdateEvent(P31Error error)
	{
		Debug.LogError("onCurrencyValueFailedToUpdateEvent: " + error);
	}

	private void onCurrencyValueUpdatedEvent(string currency, float amount)
	{
		Debug.LogError("onCurrencyValueUpdatedEvent. currency: " + currency + ", amount: " + amount);
	}

	private void videoDidFinishEvent(string space)
	{
		Debug.Log("videoDidFinishEvent: " + space);
	}

	private static void LogEventToDevToDev(string eventName, Dictionary<string, string> parameters = null)
	{
//		DevToDevCustomEventParams devToDevCustomEventParams = new DevToDevCustomEventParams();
//		using (devToDevCustomEventParams)
		{
			try
			{
				if (parameters == null)
				{
					parameters = new Dictionary<string, string>();
				}
				foreach (KeyValuePair<string, string> parameter in parameters)
				{
//					devToDevCustomEventParams.Put(parameter.Key, parameter.Value);
				}
				if (!parameters.ContainsKey("App Version"))
				{
				//	devToDevCustomEventParams.Put("App Version", GlobalGameController.AppVersion);
				}
				if (!parameters.ContainsKey("Initial Version"))
				{
			//		devToDevCustomEventParams.Put("Initial Version", PlayerPrefs.GetString(Defs.InitialAppVersionKey));
				}
//				DevToDevSDK.CustomEvent(eventName, devToDevCustomEventParams);
			}
			catch (Exception message)
			{
				Debug.LogWarning(message);
			}
		}
	}

	public static string GetEventName(string eventName)
	{
		return eventName + GetPayingSuffix();
	}

	public static string GetPayingSuffix()
	{
		if (!IsPayingUser())
		{
			return " (Non Paying)";
		}
		if (IsPayingNUser(10))
		{
			return string.Format(" (Paying ${0})", 10);
		}
		return " (Paying)";
	}

	public static string GetPayingSuffixNo10()
	{
		if (!IsPayingUser())
		{
			return " (Non Paying)";
		}
		return " (Paying)";
	}
}
