using System;
using System.Collections;
using UnityEngine;

public class ReplaceAdmobPerelivController : MonoBehaviour
{
	public static ReplaceAdmobPerelivController sharedController;

	private Texture2D _image;

	private string _adUrl;

	private static int _timesWantToShow = -1;

	private static int _timesShown;

	private long _timeSuspended;

	public static bool ShouldShowAtThisTime
	{
		get
		{
			return PromoActionsManager.ReplaceAdmobPereliv != null && _timesWantToShow % ((PromoActionsManager.ReplaceAdmobPereliv.ShowEveryTimes == 0) ? 1 : PromoActionsManager.ReplaceAdmobPereliv.ShowEveryTimes) == 0;
		}
	}

	public Texture2D Image
	{
		get
		{
			return _image;
		}
	}

	public string AdUrl
	{
		get
		{
			return _adUrl;
		}
	}

	public bool DataLoaded
	{
		get
		{
			return _image != null && _adUrl != null;
		}
	}

	public bool DataLoading { get; private set; }

	public bool ShouldShowInLobby { get; set; }

	private static bool LimitReached
	{
		get
		{
			if (PromoActionsManager.ReplaceAdmobPereliv != null)
			{
				if (PromoActionsManager.ReplaceAdmobPereliv.ShowTimesTotal == 0)
				{
					return false;
				}
				return _timesShown >= PromoActionsManager.ReplaceAdmobPereliv.ShowTimesTotal;
			}
			return true;
		}
	}

	public static void IncreaseTimesCounter()
	{
		_timesWantToShow++;
	}

	public static void TryShowPereliv(string context)
	{
		if (sharedController != null && sharedController.Image != null && sharedController.AdUrl != null)
		{
			AdmobPerelivWindow.admobTexture = sharedController.Image;
			AdmobPerelivWindow.admobUrl = sharedController.AdUrl;
			AdmobPerelivWindow.Context = context;
			PlayerPrefs.SetString(Defs.LastTimeShowBanerKey, DateTime.UtcNow.ToString("s"));
			FlurryPluginWrapper.LogEventAndDublicateToConsole("Replace Admob With Pereliv Show", FlurryPluginWrapper.LevelAndTierParameters);
			_timesShown++;
		}
	}

	public void DestroyImage()
	{
		if (Image != null)
		{
			_image = null;
		}
	}

	public static bool ReplaceAdmobWithPerelivApplicable()
	{
		bool showToPaying = PromoActionsManager.ReplaceAdmobPereliv != null && PromoActionsManager.ReplaceAdmobPereliv.ShowToPaying;
		bool showToNew = PromoActionsManager.ReplaceAdmobPereliv != null && PromoActionsManager.ReplaceAdmobPereliv.ShowToNew;
		return false;
	}

	public void LoadPerelivData()
	{
		if (DataLoading)
		{
			Debug.LogWarning("ReplaceAdmobPerelivController: data is already loading. returning...");
			return;
		}
		if (_image != null)
		{
			UnityEngine.Object.Destroy(_image);
		}
		_image = null;
		_adUrl = null;
		int num = 0;
		if (PromoActionsManager.ReplaceAdmobPereliv.imageUrls.Count > 0)
		{
			num = UnityEngine.Random.Range(0, PromoActionsManager.ReplaceAdmobPereliv.imageUrls.Count);
			StartCoroutine(LoadDataCoroutine(num));
		}
		else
		{
			Debug.LogWarning("ReplaceAdmobPerelivController:PromoActionsManager.ReplaceAdmobPereliv.imageUrls.Count = 0. returning...");
		}
	}

	private string GetImageURLForOurQuality(string urlString)
	{
		string value = string.Empty;
		if (Screen.height >= 500)
		{
			value = "-Medium";
		}
		if (Screen.height >= 900)
		{
			value = "-Hi";
		}
		urlString = urlString.Insert(urlString.LastIndexOf("."), value);
		return urlString;
	}

	private IEnumerator LoadDataCoroutine(int index)
	{
		DataLoading = true;
		WWW imageRequest = new WWW(GetImageURLForOurQuality(PromoActionsManager.ReplaceAdmobPereliv.imageUrls[index]));
		yield return imageRequest;
		if (!string.IsNullOrEmpty(imageRequest.error))
		{
			DataLoading = false;
			Debug.LogWarning("ReplaceAdmobPerelivController: error loading image. returning...");
		}
		else if (!imageRequest.texture)
		{
			DataLoading = false;
			Debug.LogWarning("ReplaceAdmobPerelivController: imageRequest.texture = null. returning...");
		}
		else if (imageRequest.texture.width < 20)
		{
			DataLoading = false;
			Debug.LogWarning("ReplaceAdmobPerelivController: imageRequest.texture is dummy. returning...");
		}
		else
		{
			_image = imageRequest.texture;
			_adUrl = PromoActionsManager.ReplaceAdmobPereliv.adUrls[index];
			DataLoading = false;
		}
	}

	private void Awake()
	{
		sharedController = this;
		UnityEngine.Object.DontDestroyOnLoad(base.gameObject);
	}

	private void OnApplicationPause(bool pausing)
	{
		if (!pausing)
		{
			if (PromoActionsManager.CurrentUnixTime - _timeSuspended > 3600)
			{
				_timesShown = 0;
			}
		}
		else
		{
			_timeSuspended = PromoActionsManager.CurrentUnixTime;
		}
	}
}
