/*using System;
using System.Collections.Generic;
using System.Linq;
using GoogleMobileAds.Api;
using Rilisoft;
using Rilisoft.MiniJson;
using UnityEngine;

internal sealed class MobileAdManager
{
	public enum Type
	{
		Image,
		Video
	}

	public enum State
	{
		None,
		Idle,
		Loaded
	}

	internal enum SampleGroup
	{
		Unknown,
		Video,
		Image
	}

	internal const string TextInterstitialUnitId = "ca-app-pub-5590536419057381/7885668153";

	internal const string DefaultImageInterstitialUnitId = "ca-app-pub-5590536419057381/1950086558";

	internal const string DefaultVideoInterstitialUnitId = "ca-app-pub-5590536419057381/2096360557";

	private static byte[] _guid = new byte[0];

	private int _imageAdUnitIdIndex;

	private int _imageIdGroupIndex;

	private int _videoAdUnitIdIndex;

	private int _videoIdGroupIndex;

	private InterstitialAd _imageInterstitialAd;

	private InterstitialAd _videoInterstitialAd;

	private static readonly Rilisoft.Lazy<MobileAdManager> _instance = new Rilisoft.Lazy<MobileAdManager>(() => new MobileAdManager());

	public static MobileAdManager Instance
	{
		get
		{
			return _instance.Value;
		}
	}

	public State ImageInterstitialState
	{
		get
		{
			return GetInterstitialState(_imageInterstitialAd);
		}
	}

	public State VideoInterstitialState
	{
		get
		{
			return GetInterstitialState(_videoInterstitialAd);
		}
	}

	public string ImageAdFailedToLoadMessage { get; private set; }

	public string VideoAdFailedToLoadMessage { get; private set; }

	internal bool SuppressShowOnReturnFromPause { get; set; }

	internal static byte[] GuidBytes
	{
		get
		{
			if (_guid != null && _guid.Length > 0)
			{
				return _guid;
			}
			if (PlayerPrefs.HasKey("Guid"))
			{
				try
				{
					_guid = new Guid(PlayerPrefs.GetString("Guid")).ToByteArray();
				}
				catch
				{
					Guid guid = Guid.NewGuid();
					_guid = guid.ToByteArray();
					PlayerPrefs.SetString("Guid", guid.ToString("D"));
					PlayerPrefs.Save();
				}
			}
			else
			{
				Guid guid2 = Guid.NewGuid();
				_guid = guid2.ToByteArray();
				PlayerPrefs.SetString("Guid", guid2.ToString("D"));
				PlayerPrefs.Save();
			}
			return _guid;
		}
	}

	private string ImageInterstitialUnitId
	{
		get
		{
			if (PromoActionsManager.MobileAdvert == null || PromoActionsManager.MobileAdvert.AdmobImageAdUnitIds.Count == 0)
			{
				return "ca-app-pub-5590536419057381/1950086558";
			}
			return AdmobImageAdUnitIds[_imageAdUnitIdIndex % AdmobImageAdUnitIds.Count];
		}
	}

	private string VideoInterstitialUnitId
	{
		get
		{
			if (PromoActionsManager.MobileAdvert == null)
			{
				return "ca-app-pub-5590536419057381/2096360557";
			}
			if (AdmobVideoAdUnitIds.Count == 0)
			{
				return (!string.IsNullOrEmpty(PromoActionsManager.MobileAdvert.AdmobVideoAdUnitId)) ? PromoActionsManager.MobileAdvert.AdmobVideoAdUnitId : "ca-app-pub-5590536419057381/2096360557";
			}
			return AdmobVideoAdUnitIds[_videoAdUnitIdIndex % AdmobVideoAdUnitIds.Count];
		}
	}

	private List<string> AdmobVideoAdUnitIds
	{
		get
		{
			if (PromoActionsManager.MobileAdvert.AdmobVideoIdGroups.Count == 0)
			{
				return PromoActionsManager.MobileAdvert.AdmobVideoAdUnitIds;
			}
			return PromoActionsManager.MobileAdvert.AdmobVideoIdGroups[_videoIdGroupIndex % PromoActionsManager.MobileAdvert.AdmobVideoIdGroups.Count];
		}
	}

	private List<string> AdmobImageAdUnitIds
	{
		get
		{
			if (PromoActionsManager.MobileAdvert.AdmobImageIdGroups.Count == 0)
			{
				return PromoActionsManager.MobileAdvert.AdmobImageAdUnitIds;
			}
			return PromoActionsManager.MobileAdvert.AdmobImageIdGroups[_imageIdGroupIndex % PromoActionsManager.MobileAdvert.AdmobImageIdGroups.Count];
		}
	}

	internal int ImageAdUnitIndexClamped
	{
		get
		{
			if (AdmobImageAdUnitIds.Count == 0)
			{
				return -1;
			}
			return _imageAdUnitIdIndex % AdmobImageAdUnitIds.Count;
		}
	}

	internal int VideoAdUnitIndexClamped
	{
		get
		{
			if (AdmobVideoAdUnitIds.Count == 0)
			{
				return -1;
			}
			return _videoAdUnitIdIndex % AdmobVideoAdUnitIds.Count;
		}
	}

	private MobileAdManager()
	{
		ImageAdFailedToLoadMessage = string.Empty;
		VideoAdFailedToLoadMessage = string.Empty;
	}

	public InterstitialAd LoadImageInterstitial()
	{
		Debug.Log("Trying to load AdMob interstitial: " + RemovePrefix(ImageInterstitialUnitId));
		if (_imageInterstitialAd != null)
		{
			Debug.Log("Destroying previous interstitial...");
			DestroyImageInterstitialCore();
		}
		_imageInterstitialAd = new InterstitialAd(ImageInterstitialUnitId);
		AdRequest request = new AdRequest.Builder().Build();
		_imageInterstitialAd.AdFailedToLoad += HandleImageAdFailedToLoad;
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("AdMob - Image", "Request");
		Dictionary<string, string> parameters = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
		_imageInterstitialAd.LoadAd(request);
		return _imageInterstitialAd;
	}

	public InterstitialAd LoadVideoInterstitial()
	{
		Debug.Log("Trying to load AdMob interstitial: " + RemovePrefix(VideoInterstitialUnitId));
		if (_videoInterstitialAd != null)
		{
			Debug.Log("Destroying previous interstitial...");
			DestroyVideoInterstitialCore();
		}
		_videoInterstitialAd = new InterstitialAd(VideoInterstitialUnitId);
		AdRequest request = new AdRequest.Builder().Build();
		_videoInterstitialAd.AdFailedToLoad += HandleVideoAdFailedToLoad;
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("AdMob - Video", "Request");
		Dictionary<string, string> parameters = dictionary;
		FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
		_videoInterstitialAd.LoadAd(request);
		return _videoInterstitialAd;
	}

	public void ShowImageInterstitial(string context)
	{
		if (ImageInterstitialState != State.Loaded)
		{
			Debug.LogWarning("Cannot show interstitial in state " + ImageInterstitialState);
			return;
		}
		Debug.Log("Showing interstitial: " + ImageInterstitialState);
		if (BuildSettings.BuildTarget != BuildTarget.iPhone)
		{
			SuppressShowOnReturnFromPause = true;
		}
		EventHandler<EventArgs> openHandler = null;
		openHandler = delegate
		{
			if (_imageInterstitialAd != null)
			{
				_imageInterstitialAd.AdOpened -= openHandler;
			}
			Dictionary<string, string> parameters = new Dictionary<string, string> { { "AdMob - Image", "Impression" } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
		};
		_imageInterstitialAd.AdOpened += openHandler;
		_imageInterstitialAd.Show();
		PlayerPrefs.SetString(Defs.LastTimeShowBanerKey, DateTime.UtcNow.ToString("s"));
		LogToFlurry("Admob ADV Banner", context);
	}

	public void ShowVideoInterstitial(string context, Action completeHandler)
	{
		if (VideoInterstitialState != State.Loaded)
		{
			Debug.LogWarning("Cannot show interstitial in state " + VideoInterstitialState);
			return;
		}
		Debug.Log("Showing interstitial: " + VideoInterstitialState);
		if (BuildSettings.BuildTarget != BuildTarget.iPhone)
		{
			SuppressShowOnReturnFromPause = true;
		}
		EventHandler<EventArgs> completeHandlerWrapper = null;
		completeHandlerWrapper = delegate
		{
			_videoInterstitialAd.AdClosed -= completeHandlerWrapper;
			if (completeHandler != null)
			{
				completeHandler();
			}
		};
		_videoInterstitialAd.AdClosed += completeHandlerWrapper;
		EventHandler<EventArgs> openHandler = null;
		openHandler = delegate
		{
			_videoInterstitialAd.AdOpened -= openHandler;
			Dictionary<string, string> parameters = new Dictionary<string, string> { { "AdMob - Video", "Impression" } };
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Ads Show Stats - Total", parameters);
		};
		_videoInterstitialAd.AdOpened += openHandler;
		_videoInterstitialAd.Show();
		LogToFlurry("Admob ADV Video", context);
	}

	public void ShowVideoInterstitial(string context)
	{
		ShowVideoInterstitial(context, delegate
		{
		});
	}

	public void DestroyImageInterstitial()
	{
		if (_imageInterstitialAd != null)
		{
			Debug.Log("Destroying interstitial: " + ImageInterstitialState);
			DestroyImageInterstitialCore();
			_imageInterstitialAd = null;
		}
		else
		{
			Debug.LogWarning("Interstitial is already null: " + ImageInterstitialState);
		}
	}

	public void DestroyVideoInterstitial()
	{
		if (_videoInterstitialAd != null)
		{
			Debug.Log("Destroying interstitial: " + VideoInterstitialState);
			DestroyVideoInterstitialCore();
			_videoInterstitialAd = null;
		}
		else
		{
			Debug.LogWarning("Interstitial is already null: " + VideoInterstitialState);
		}
	}

	private void DestroyImageInterstitialCore()
	{
		ImageAdFailedToLoadMessage = string.Empty;
		_imageInterstitialAd.AdFailedToLoad -= HandleImageAdFailedToLoad;
		_imageInterstitialAd.Destroy();
	}

	private void DestroyVideoInterstitialCore()
	{
		VideoAdFailedToLoadMessage = string.Empty;
		_videoInterstitialAd.AdFailedToLoad -= HandleVideoAdFailedToLoad;
		_videoInterstitialAd.Destroy();
	}

	internal static bool AdIsApplicable(Type adType)
	{
		return AdIsApplicable(adType, false);
	}

	internal static bool AdIsApplicable(Type adType, bool verbose)
	{
		if (PromoActionsManager.MobileAdvert == null)
		{
			if (verbose)
			{
				Debug.LogWarning(string.Format("AdIsApplicable ({0}): false, because PromoActionsManager.MobileAdvert == null", adType));
			}
			return false;
		}
		return UserPredicate(adType, verbose);
	}

	public static bool UserPredicate(Type adType, bool verbose, bool showToPaying = false, bool showToNew = false)
	{
		bool flag = IsNewUser();
		bool flag2 = IsPayingUser();
		bool flag8;
		if (adType == Type.Video)
		{
			bool flag3 = PromoActionsManager.MobileAdvert != null && PromoActionsManager.MobileAdvert.VideoEnabled;
			bool flag4 = PromoActionsManager.MobileAdvert != null && PromoActionsManager.MobileAdvert.VideoShowPaying;
			bool flag5 = PromoActionsManager.MobileAdvert != null && PromoActionsManager.MobileAdvert.VideoShowNonpaying;
			bool flag6 = (flag2 && flag4) || (!flag2 && flag5);
			bool flag7 = PlayerPrefs.GetInt("CountRunMenu", 0) >= 3 || PlayerPrefs.GetInt(Defs.IsOldUserOldMetodKey, 0) == 1;
			flag8 = flag3 && flag7 && flag6;
			if (verbose)
			{
				Debug.Log(string.Format("AdIsApplicable ({0}): {1}    Paying: {2},  Need to show: {3},  Session count satisfied: {4}", adType, flag8, flag2, (!flag2) ? flag5 : flag4, flag7));
			}
		}
		else
		{
			bool flag9 = IsLongTimeShowBaner();
			flag8 = PromoActionsManager.MobileAdvert != null && PromoActionsManager.MobileAdvert.ImageEnabled && (!flag || showToNew) && (!flag2 || showToPaying) && flag9;
			if (verbose)
			{
				Dictionary<string, bool> dictionary = new Dictionary<string, bool>(6);
				dictionary.Add("ImageEnabled", PromoActionsManager.MobileAdvert != null && PromoActionsManager.MobileAdvert.ImageEnabled);
				dictionary.Add("isNewUser", flag);
				dictionary.Add("showToNew", showToNew);
				dictionary.Add("isPayingUser", flag2);
				dictionary.Add("showToPaying", showToPaying);
				dictionary.Add("longTimeShowBanner", flag9);
				Dictionary<string, bool> obj = dictionary;
				Debug.Log(string.Format("AdIsApplicable ({0}): {1}    Details: {2}", adType, flag8, Json.Serialize(obj)));
			}
		}
		return flag8;
	}

	internal static void RefreshBytes()
	{
		PlayerPrefs.SetString("Guid", new Guid(_guid).ToString("D"));
		PlayerPrefs.Save();
	}

	internal static SampleGroup GetSempleGroup()
	{
		byte b = GuidBytes[0];
		return ((int)b % 2 != 0) ? SampleGroup.Video : SampleGroup.Image;
	}

	private void HandleImageAdFailedToLoad(object sender, AdFailedToLoadEventArgs e)
	{
		ImageAdFailedToLoadMessage = e.Message;
		string message = string.Format("    # Image ad failed to load:    \"{0}\"", e.Message);
		Debug.LogWarning(message);
	}

	private void HandleVideoAdFailedToLoad(object sender, AdFailedToLoadEventArgs e)
	{
		VideoAdFailedToLoadMessage = e.Message;
		string message = string.Format("    # Video ad failed to load:    \"{0}\"", e.Message);
		Debug.LogWarning(message);
	}

	private void LogToFlurry(string eventName, string context)
	{
		Dictionary<string, string> dictionary = new Dictionary<string, string>();
		dictionary.Add("Menu", context);
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

	public static bool IsNewUserOldMetod()
	{
		string @string = PlayerPrefs.GetString("First Launch (Advertisement)", string.Empty);
		DateTimeOffset result;
		if (!string.IsNullOrEmpty(@string) && DateTimeOffset.TryParse(@string, out result))
		{
			return (DateTimeOffset.Now - result).TotalDays < 7.0;
		}
		return true;
	}

	private static bool IsLongTimeShowBaner()
	{
		string @string = PlayerPrefs.GetString(Defs.LastTimeShowBanerKey, string.Empty);
		DateTime utcNow = DateTime.UtcNow;
		DateTime result;
		if (string.IsNullOrEmpty(@string) || (DateTime.TryParse(@string, out result) && (utcNow - result).TotalSeconds > (double)PromoActionsManager.MobileAdvert.TimeoutBetweenShowInterstitial))
		{
			return true;
		}
		return false;
	}

	private static bool IsNewUser()
	{
		int @int = PlayerPrefs.GetInt(Defs.SessionDayNumberKey, 1);
		bool flag = PlayerPrefs.GetInt(Defs.IsOldUserOldMetodKey, 0) == 0;
		if (@int > PromoActionsManager.MobileAdvert.CountSessionNewPlayer || !flag)
		{
			return false;
		}
		return true;
	}

	public static bool IsPayingUser()
	{
		//Discarded unreachable code: IL_0074, IL_009e
		try
		{
			string @string = PlayerPrefs.GetString("Last Payment Time (Advertisement)", string.Empty);
			DateTime result;
			if (!string.IsNullOrEmpty(@string) && DateTime.TryParse(@string, out result))
			{
				double num = ((PromoActionsManager.MobileAdvert == null) ? double.MaxValue : PromoActionsManager.MobileAdvert.DaysOfBeingPayingUser);
				return (DateTime.UtcNow - result).TotalDays < num;
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

	private static State GetInterstitialState(InterstitialAd interstitialView)
	{
		if (interstitialView == null)
		{
			return State.None;
		}
		if (interstitialView.IsLoaded())
		{
			return State.Loaded;
		}
		return State.Idle;
	}

	internal bool SwitchImageAdUnitId()
	{
		int imageAdUnitIdIndex = _imageAdUnitIdIndex;
		string imageInterstitialUnitId = ImageInterstitialUnitId;
		_imageAdUnitIdIndex++;
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Switching image ad unit id from {0} ({1}) to {2} ({3})", imageAdUnitIdIndex, RemovePrefix(imageInterstitialUnitId), _imageAdUnitIdIndex, RemovePrefix(ImageInterstitialUnitId));
			Debug.Log(message);
		}
		return PromoActionsManager.MobileAdvert.AdmobImageAdUnitIds.Count == 0 || _imageAdUnitIdIndex % PromoActionsManager.MobileAdvert.AdmobImageAdUnitIds.Count == 0;
	}

	internal bool SwitchVideoAdUnitId()
	{
		int videoAdUnitIdIndex = _videoAdUnitIdIndex;
		string videoInterstitialUnitId = VideoInterstitialUnitId;
		_videoAdUnitIdIndex++;
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Switching video ad unit id from {0} ({1}) to {2} ({3}); group index {4}", videoAdUnitIdIndex, RemovePrefix(videoInterstitialUnitId), _videoAdUnitIdIndex, RemovePrefix(VideoInterstitialUnitId), _videoIdGroupIndex);
			Debug.Log(message);
		}
		return AdmobVideoAdUnitIds.Count == 0 || _videoAdUnitIdIndex % AdmobVideoAdUnitIds.Count == 0;
	}

	internal bool SwitchImageIdGroup()
	{
		int imageIdGroupIndex = _imageIdGroupIndex;
		List<string> obj = AdmobImageAdUnitIds.Select(RemovePrefix).ToList();
		string text = Json.Serialize(obj);
		_imageIdGroupIndex++;
		_imageAdUnitIdIndex = 0;
		List<string> obj2 = AdmobImageAdUnitIds.Select(RemovePrefix).ToList();
		string text2 = Json.Serialize(obj2);
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Switching image id group from {0} ({1}) to {2} ({3})", imageIdGroupIndex, text, _imageIdGroupIndex, text2);
			Debug.Log(message);
		}
		return PromoActionsManager.MobileAdvert.AdmobImageIdGroups.Count == 0 || _imageIdGroupIndex % PromoActionsManager.MobileAdvert.AdmobImageIdGroups.Count == 0;
	}

	internal bool SwitchVideoIdGroup()
	{
		int videoIdGroupIndex = _videoIdGroupIndex;
		List<string> obj = AdmobVideoAdUnitIds.Select(RemovePrefix).ToList();
		string text = Json.Serialize(obj);
		_videoIdGroupIndex++;
		_videoAdUnitIdIndex = 0;
		List<string> obj2 = AdmobVideoAdUnitIds.Select(RemovePrefix).ToList();
		string text2 = Json.Serialize(obj2);
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Switching video id group from {0} ({1}) to {2} ({3})", videoIdGroupIndex, text, _videoIdGroupIndex, text2);
			Debug.Log(message);
		}
		return PromoActionsManager.MobileAdvert.AdmobVideoIdGroups.Count == 0 || _videoIdGroupIndex % PromoActionsManager.MobileAdvert.AdmobVideoIdGroups.Count == 0;
	}

	internal static string RemovePrefix(string s)
	{
		if (string.IsNullOrEmpty(s))
		{
			return string.Empty;
		}
		int num = s.IndexOf('/');
		return (num <= 0) ? s : s.Remove(0, num);
	}

	internal bool ResetVideoAdUnitId()
	{
		int videoAdUnitIdIndex = _videoAdUnitIdIndex;
		string videoInterstitialUnitId = VideoInterstitialUnitId;
		int videoIdGroupIndex = _videoIdGroupIndex;
		_videoAdUnitIdIndex = 0;
		_videoIdGroupIndex = 0;
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Resetting video group from {0} to {1}", videoIdGroupIndex, _videoIdGroupIndex);
			Debug.Log(message);
		}
		return true;
	}

	internal bool ResetImageAdUnitId()
	{
		int imageAdUnitIdIndex = _imageAdUnitIdIndex;
		string imageInterstitialUnitId = ImageInterstitialUnitId;
		int imageIdGroupIndex = _imageIdGroupIndex;
		_imageAdUnitIdIndex = 0;
		_imageIdGroupIndex = 0;
		if (Defs.IsDeveloperBuild)
		{
			string message = string.Format("Resetting image ad unit id from {0} to {1}; group index from {2} to 0", imageAdUnitIdIndex, _imageAdUnitIdIndex, imageIdGroupIndex);
			Debug.Log(message);
		}
		return true;
	}
}
*/