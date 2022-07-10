using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading;
using Rilisoft;
using UnityEngine;
using UnityEngine.SocialPlatforms.GameCenter;
using UnityEngine.UI;

internal sealed class Launcher : MonoBehaviour
{
	private struct Bounds
	{
		private readonly float _lower;

		private readonly float _upper;

		public float Lower
		{
			get
			{
				return _lower;
			}
		}

		public float Upper
		{
			get
			{
				return _upper;
			}
		}

		public Bounds(float lower, float upper)
		{
			_lower = Mathf.Min(lower, upper);
			_upper = Mathf.Max(lower, upper);
		}

		private float Clamp(float value)
		{
			return Mathf.Clamp(value, _lower, _upper);
		}

		public float Lerp(float value, float t)
		{
			return Mathf.Lerp(Clamp(value), _upper, t);
		}

		public float Lerp(float t)
		{
			return Lerp(_lower, t);
		}
	}

	[CompilerGenerated]
	private sealed class _003CAppsMenuStartCoroutine_003Ec__IteratorC9 : IEnumerable<float>, IEnumerator<float>, IEnumerator, IDisposable, IEnumerable
	{
		internal LicenseVerificationController.PackageInfo _003CactualPackageInfo_003E__0;

		internal Exception _003Cex_003E__1;

		internal string _003CactualPackageName_003E__2;

		internal string _003CactualSignatureHash_003E__3;

		internal string _003CexpPath_003E__4;

		internal string _003CmainPath_003E__5;

		internal UnityEngine.Object _003CactivityIndicatorPrefab_003E__6;

		internal int _0024PC;

		internal float _0024current;

		internal Launcher _003C_003Ef__this;

		float IEnumerator<float>.Current
		{
			[DebuggerHidden]
			get
			{
				return _0024current;
			}
		}

		object IEnumerator.Current
		{
			[DebuggerHidden]
			get
			{
				return _0024current;
			}
		}

		[DebuggerHidden]
		IEnumerator IEnumerable.GetEnumerator()
		{
			//return System_002ECollections_002EGeneric_002EIEnumerable_003Cfloat_003E_002EGetEnumerator();
			return null;
		}

		[DebuggerHidden]
		IEnumerator<float> IEnumerable<float>.GetEnumerator()
		{
			if (Interlocked.CompareExchange(ref _0024PC, 0, -2) == -2)
			{
				return this;
			}
			return new _003CAppsMenuStartCoroutine_003Ec__IteratorC9
			{
				_003C_003Ef__this = _003C_003Ef__this
			};
		}

		public bool MoveNext()
		{
			//Discarded unreachable code: IL_039c
			uint num = (uint)_0024PC;
			_0024PC = -1;
			switch (num)
			{
			case 0u:
				if (Application.platform != RuntimePlatform.Android || (Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GoogleLite && Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GooglePro))
				{
					goto case 1u;
				}
				_003CactualPackageInfo_003E__0 = default(LicenseVerificationController.PackageInfo);
				try
				{
					_003CactualPackageInfo_003E__0 = LicenseVerificationController.GetPackageInfo();
					PackageInfo = _003CactualPackageInfo_003E__0;
				}
				catch (Exception ex)
				{
					Exception ex2 = (_003Cex_003E__1 = ex);
					UnityEngine.Debug.Log("LicenseVerificationController.GetPackageInfo() failed:    " + _003Cex_003E__1);
					Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
				}
				finally
				{
					_003C_003E__Finally0();
				}
				_003CactualPackageName_003E__2 = _003CactualPackageInfo_003E__0.PackageName;
				if (string.Compare(_003CactualPackageName_003E__2, Defs.GetIntendedAndroidPackageName(), StringComparison.Ordinal) != 0)
				{
					UnityEngine.Debug.LogWarning("Verification FakeBundleDetected:    " + _003CactualPackageName_003E__2);
					FlurryPluginWrapper.LogEventWithParameterAndValue("Verification FakeBundleDetected", "Actual Package Name", _003CactualPackageName_003E__2);
					Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
				}
				else
				{
					UnityEngine.Debug.Log("Package check passed.");
				}
				if (string.IsNullOrEmpty(_003C_003Ef__this.intendedSignatureHash))
				{
					UnityEngine.Debug.LogWarning("String.IsNullOrEmpty(intendedSignatureHash)");
					Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
				}
				_003CactualSignatureHash_003E__3 = _003CactualPackageInfo_003E__0.SignatureHash;
				if (string.Compare(_003CactualSignatureHash_003E__3, _003C_003Ef__this.intendedSignatureHash, StringComparison.Ordinal) != 0)
				{
					UnityEngine.Debug.LogWarning("Verification FakeSignatureDetected:    " + _003CactualSignatureHash_003E__3);
					FlurryPluginWrapper.LogEventWithParameterAndValue("Verification FakeSignatureDetected", "Actual Signature Hash", _003CactualSignatureHash_003E__3);
					Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
				}
				else
				{
					UnityEngine.Debug.Log("Signature check passed.");
				}
				_0024current = 0.2f;
				_0024PC = 1;
				break;
			case 1u:
				if (Application.platform == RuntimePlatform.Android)
				{
					if (AppsMenu.ApplicationBinarySplitted && !Application.isEditor)
					{
						_003CexpPath_003E__4 = GooglePlayDownloader.GetExpansionFilePath();
						if (string.IsNullOrEmpty(_003CexpPath_003E__4))
						{
							UnityEngine.Debug.LogError(string.Format("ExpPath: “{0}”", _003CexpPath_003E__4));
						}
						else if (Defs.IsDeveloperBuild)
						{
							UnityEngine.Debug.Log(string.Format("ExpPath: “{0}”", _003CexpPath_003E__4));
						}
						_003CmainPath_003E__5 = GooglePlayDownloader.GetMainOBBPath(_003CexpPath_003E__4);
						if (_003CmainPath_003E__5 == null)
						{
							UnityEngine.Debug.Log("Trying to fetch OBB...");
							GooglePlayDownloader.FetchOBB();
						}
						_003CmainPath_003E__5 = GooglePlayDownloader.GetMainOBBPath(_003CexpPath_003E__4);
						if (_003CmainPath_003E__5 == null)
						{
							UnityEngine.Debug.Log("Waiting OBB fetch...");
						}
						goto IL_02ec;
					}
					goto IL_02f7;
				}
				goto case 3u;
			case 2u:
				if (Time.frameCount % 120 == 0)
				{
					_003CmainPath_003E__5 = GooglePlayDownloader.GetMainOBBPath(_003CexpPath_003E__4);
				}
				goto IL_02ec;
			case 3u:
				_003CactivityIndicatorPrefab_003E__6 = Resources.Load("ActivityIndicator");
				UnityEngine.Object.DontDestroyOnLoad(_003CactivityIndicatorPrefab_003E__6);
				if (_003CactivityIndicatorPrefab_003E__6 == null)
				{
					UnityEngine.Debug.LogWarning("activityIndicatorPrefab == null");
				}
				else
				{
					StoreKitEventListener.purchaseActivityInd = UnityEngine.Object.Instantiate(_003CactivityIndicatorPrefab_003E__6) as GameObject;
				}
				_0024current = 0.8f;
				_0024PC = 4;
				break;
			case 4u:
				AppsMenu.SetCurrentLanguage();
				_0024current = 1f;
				_0024PC = 5;
				break;
			case 5u:
				_0024PC = -1;
				goto default;
			default:
				{
					return false;
				}
				IL_02f7:
				_0024current = 0.6f;
				_0024PC = 3;
				break;
				IL_02ec:
				if (_003CmainPath_003E__5 == null)
				{
					_0024current = 0.6f;
					_0024PC = 2;
					break;
				}
				goto IL_02f7;
			}
			return true;
		}

		[DebuggerHidden]
		public void Dispose()
		{
			_0024PC = -1;
		}

		[DebuggerHidden]
		public void Reset()
		{
			throw new NotSupportedException();
		}

		private void _003C_003E__Finally0()
		{
			if (_003CactualPackageInfo_003E__0.SignatureHash == null)
			{
				UnityEngine.Debug.Log("actualPackageInfo.SignatureHash == null");
				Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
			}
		}
	}

	public string intendedSignatureHash;

	public GameObject inAppGameObjectPrefab;

	public Canvas Canvas;

	public Slider ProgressSlider;

	public Text ProgressLabel;

	public RawImage SplashScreen;

	public GameObject amazonIapManagerPrefab;

	private GameObject amazonGameCircleManager;

	private static float? _progress;

	private bool _amazonGamecircleManagerInitialized;

	private bool _amazonIapManagerInitialized;

	private bool _crossfadeFinished;

	private static bool? _usingNewLauncher;

	private string _leaderboardId = string.Empty;

	private int _targetFramerate = 30;

	internal static LicenseVerificationController.PackageInfo? PackageInfo { get; set; }

	internal static bool UsingNewLauncher
	{
		get
		{
			return _usingNewLauncher.HasValue && _usingNewLauncher.Value;
		}
	}

	private void Awake()
	{
		if (Application.platform == RuntimePlatform.Android || Application.platform == RuntimePlatform.WP8Player)
		{
			Application.targetFrameRate = 30;
		}
		_targetFramerate = ((Application.targetFrameRate != -1) ? Mathf.Clamp(Application.targetFrameRate, 30, 60) : 300);
		if (!_usingNewLauncher.HasValue)
		{
			_usingNewLauncher = Application.loadedLevelName.Equals("Launcher");
		}
		if (ProgressLabel != null)
		{
			ProgressLabel.text = 0f.ToString("P0");
		}
	}

	private IEnumerable<float> SplashScreenFadeOut()
	{
		if (SplashScreen != null)
		{
			int splashScreenFadeOutFrameCount = 1 * _targetFramerate;
			SplashScreen.gameObject.SetActive(true);
			for (int i = 0; i != splashScreenFadeOutFrameCount; i++)
			{
				Color newColor = Color.Lerp(Color.white, Color.black, (float)i / (float)splashScreenFadeOutFrameCount);
				SplashScreen.color = newColor;
				yield return 0f;
			}
			SplashScreen.color = Color.black;
			yield return 1f;
		}
	}

	private IEnumerable<float> LoadingProgressFadeIn()
	{
		if (SplashScreen != null)
		{
			int loadingFadeInFrameCount = 1 * _targetFramerate;
			Color transparentColor = new Color(0f, 0f, 0f, 0f);
			for (int i = 0; i != loadingFadeInFrameCount; i++)
			{
				Color newColor = Color.Lerp(t: Mathf.Pow((float)i / (float)loadingFadeInFrameCount, 2.2f), a: Color.black, b: transparentColor);
				SplashScreen.color = newColor;
				yield return 0.5f;
			}
			UnityEngine.Object.Destroy(SplashScreen.gameObject);
			yield return 1f;
		}
		_crossfadeFinished = true;
	}

	private IEnumerator LoadingProgressFadeInCoroutine()
	{
		foreach (float item in LoadingProgressFadeIn())
		{
			float step = item;
			yield return null;
		}
	}

	private IEnumerator Start()
	{
		if (!_progress.HasValue)
		{
			foreach (float item in SplashScreenFadeOut())
			{
				float step3 = item;
				yield return null;
			}
			foreach (float item2 in LoadingProgressFadeIn())
			{
				float step2 = item2;
				yield return null;
			}
			_progress = 0f;
			FrameStopwatchScript stopwatch = GetComponent<FrameStopwatchScript>();
			if (stopwatch == null)
			{
				stopwatch = base.gameObject.AddComponent<FrameStopwatchScript>();
			}
			foreach (float item3 in InitRootCoroutine())
			{
				float step = item3;
				if (step >= 0f)
				{
					_progress = step;
				}
				if (stopwatch != null)
				{
					float elapsedSeconds = stopwatch.GetSecondsSinceFrameStarted();
					if (step >= 0f && elapsedSeconds < 1.618f / (float)_targetFramerate)
					{
						continue;
					}
				}
				if (ProgressSlider != null)
				{
					ProgressSlider.value = _progress.Value;
				}
				if (ProgressLabel != null)
				{
					ProgressLabel.text = _progress.Value.ToString("P0");
				}
				if (ActivityIndicator.sharedActivityIndicator != null && !ActivityIndicator.sharedActivityIndicator.activeInHierarchy)
				{
					ActivityIndicator.sharedActivityIndicator.SetActive(_crossfadeFinished);
				}
				yield return null;
			}
			if (Canvas != null)
			{
				UnityEngine.Object.Destroy(Canvas.gameObject);
			}
			UnityEngine.Object.Destroy(base.gameObject);
			yield break;
		}
		while (true)
		{
			float? progress = _progress;
			if (progress.HasValue && progress.Value < 1f)
			{
				yield return null;
				continue;
			}
			break;
		}
	}

	private static void LogMessageWithBounds(string prefix, Bounds bounds)
	{
		string message = string.Format("{0}: [{1:P0}, {2:P0}]\t\t{3}", prefix, bounds.Lower, bounds.Upper, Time.frameCount);
		UnityEngine.Debug.Log(message);
	}

	private IEnumerable<float> InitRootCoroutine()
	{
		Bounds bounds2 = new Bounds(0f, 0.04f);
		LogMessageWithBounds("AppsMenuAwakeCoroutine()", bounds2);
		foreach (float item in AppsMenu.AppsMenuAwakeCoroutine())
		{
			float step5 = item;
			yield return bounds2.Lerp(step5);
		}
		Bounds bounds7 = new Bounds(0.05f, 0.09f);
		LogMessageWithBounds("AppsMenuStartCoroutine()", bounds7);
		foreach (float item2 in AppsMenuStartCoroutine())
		{
			float step4 = item2;
			yield return bounds7.Lerp(step4);
		}
		Bounds bounds6 = new Bounds(0.1f, 0.19f);
		LogMessageWithBounds("InAppInstancerStartCoroutine()", bounds6);
		foreach (float item3 in InAppInstancerStartCoroutine())
		{
			float step3 = item3;
			yield return bounds6.Lerp(step3);
		}
		Bounds bounds5 = new Bounds(0.2f, 0.24f);
		LogMessageWithBounds("Application.LoadLevelAdditiveAsync(\"AppCenter\")", bounds5);
		AsyncOperation loadingCoroutine2 = Application.LoadLevelAdditiveAsync("AppCenter");
		while (!loadingCoroutine2.isDone)
		{
			yield return bounds5.Lerp(loadingCoroutine2.progress);
		}
		yield return -1f;
		Bounds bounds4 = new Bounds(0.25f, 0.29f);
		LogMessageWithBounds("Application.LoadLevelAdditiveAsync(\"Loading\")", bounds4);
		AsyncOperation loadingCoroutine = Application.LoadLevelAdditiveAsync("Loading");
		while (!loadingCoroutine.isDone)
		{
			yield return bounds4.Lerp(loadingCoroutine.progress);
		}
		yield return -1f;
		Switcher switcher = UnityEngine.Object.FindObjectOfType<Switcher>();
		if (switcher != null)
		{
			Bounds bounds3 = new Bounds(0.3f, 0.89f);
			LogMessageWithBounds("Switcher.InitializeSwitcher()", bounds3);
			foreach (float item4 in switcher.InitializeSwitcher())
			{
				float step2 = item4;
				yield return (!(step2 < 0f)) ? bounds3.Lerp(step2) : step2;
			}
		}
		Bounds bounds = new Bounds(0.9f, 0.99f);
		LogMessageWithBounds("Switcher.LoadMainMenu()", bounds);
		foreach (float item5 in Switcher.LoadMainMenu())
		{
			float step = item5;
			yield return bounds.Lerp(step);
		}
		yield return 1f;
	}

	private static string GetTerminalSceneName_3afcc97c(uint gamma)
	{
		return "ClosingScene";
	}

	private IEnumerable<float> AppsMenuStartCoroutine()
	{
		if (Application.platform == RuntimePlatform.Android && (Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GoogleLite || Defs.AndroidEdition == Defs.RuntimeAndroidEdition.GooglePro))
		{
			LicenseVerificationController.PackageInfo actualPackageInfo = default(LicenseVerificationController.PackageInfo);
			try
			{
				actualPackageInfo = LicenseVerificationController.GetPackageInfo();
				PackageInfo = actualPackageInfo;
			}
			catch (Exception ex2)
			{
				Exception ex = ex2;
				UnityEngine.Debug.Log("LicenseVerificationController.GetPackageInfo() failed:    " + ex);
				Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
			}
			finally
			{
				//((_003CAppsMenuStartCoroutine_003Ec__IteratorC9)(object)this)._003C_003E__Finally0();
			}
			string actualPackageName = actualPackageInfo.PackageName;
			if (string.Compare(actualPackageName, Defs.GetIntendedAndroidPackageName(), StringComparison.Ordinal) != 0)
			{
				UnityEngine.Debug.LogWarning("Verification FakeBundleDetected:    " + actualPackageName);
				FlurryPluginWrapper.LogEventWithParameterAndValue("Verification FakeBundleDetected", "Actual Package Name", actualPackageName);
				Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
			}
			else
			{
				UnityEngine.Debug.Log("Package check passed.");
			}
			if (string.IsNullOrEmpty(intendedSignatureHash))
			{
				UnityEngine.Debug.LogWarning("String.IsNullOrEmpty(intendedSignatureHash)");
				Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
			}
			string actualSignatureHash = actualPackageInfo.SignatureHash;
			if (string.Compare(actualSignatureHash, intendedSignatureHash, StringComparison.Ordinal) != 0)
			{
				UnityEngine.Debug.LogWarning("Verification FakeSignatureDetected:    " + actualSignatureHash);
				FlurryPluginWrapper.LogEventWithParameterAndValue("Verification FakeSignatureDetected", "Actual Signature Hash", actualSignatureHash);
				Application.LoadLevel(GetTerminalSceneName_3afcc97c(989645180u));
			}
			else
			{
				UnityEngine.Debug.Log("Signature check passed.");
			}
			yield return 0.2f;
		}
		if (Application.platform == RuntimePlatform.Android)
		{
			if (AppsMenu.ApplicationBinarySplitted && !Application.isEditor)
			{
				string expPath = GooglePlayDownloader.GetExpansionFilePath();
				if (string.IsNullOrEmpty(expPath))
				{
					UnityEngine.Debug.LogError(string.Format("ExpPath: “{0}”", expPath));
				}
				else if (Defs.IsDeveloperBuild)
				{
					UnityEngine.Debug.Log(string.Format("ExpPath: “{0}”", expPath));
				}
				string mainPath2 = GooglePlayDownloader.GetMainOBBPath(expPath);
				if (mainPath2 == null)
				{
					UnityEngine.Debug.Log("Trying to fetch OBB...");
					GooglePlayDownloader.FetchOBB();
				}
				mainPath2 = GooglePlayDownloader.GetMainOBBPath(expPath);
				if (mainPath2 == null)
				{
					UnityEngine.Debug.Log("Waiting OBB fetch...");
				}
				while (mainPath2 == null)
				{
					yield return 0.6f;
					if (Time.frameCount % 120 == 0)
					{
						mainPath2 = GooglePlayDownloader.GetMainOBBPath(expPath);
					}
				}
			}
			yield return 0.6f;
		}
		UnityEngine.Object activityIndicatorPrefab = Resources.Load("ActivityIndicator");
		UnityEngine.Object.DontDestroyOnLoad(activityIndicatorPrefab);
		if (activityIndicatorPrefab == null)
		{
			UnityEngine.Debug.LogWarning("activityIndicatorPrefab == null");
		}
		else
		{
			StoreKitEventListener.purchaseActivityInd = UnityEngine.Object.Instantiate(activityIndicatorPrefab) as GameObject;
		}
		yield return 0.8f;
		AppsMenu.SetCurrentLanguage();
		yield return 1f;
	}

	private IEnumerable<float> InAppInstancerStartCoroutine()
	{
		if (!GameObject.FindGameObjectWithTag("InAppGameObject"))
		{
			UnityEngine.Object.Instantiate(inAppGameObjectPrefab, Vector3.zero, Quaternion.identity);
			yield return 0.1f;
		}
		if (amazonIapManagerPrefab == null)
		{
			UnityEngine.Debug.LogWarning("amazonIapManager == null");
		}
		else if (!_amazonIapManagerInitialized)
		{
			UnityEngine.Object.Instantiate(amazonIapManagerPrefab, Vector3.zero, Quaternion.identity);
			_amazonIapManagerInitialized = true;
			yield return 0.2f;
		}
		if (Application.platform == RuntimePlatform.Android && Defs.AndroidEdition == Defs.RuntimeAndroidEdition.Amazon)
		{
			if (amazonGameCircleManager == null)
			{
				UnityEngine.Debug.LogWarning("amazonGamecircleManager == null");
			}
			else if (!_amazonGamecircleManagerInitialized)
			{
				UnityEngine.Object.DontDestroyOnLoad(amazonGameCircleManager);
				_leaderboardId = ((Defs.AndroidEdition != Defs.RuntimeAndroidEdition.GoogleLite) ? "best_survival_scores" : "CgkIr8rGkPIJEAIQCg");
				if (!AGSClient.IsServiceReady())
				{
					UnityEngine.Debug.Log("Trying to initialize Amazon GameCircle service...");
					AGSClient.ServiceReadyEvent += HandleAmazonGamecircleServiceReady;
					AGSClient.ServiceNotReadyEvent += HandleAmazonGamecircleServiceNotReady;
					AGSClient.Init(true, true, true);
					AGSWhispersyncClient.OnNewCloudDataEvent += HandleAmazonPotentialProgressConflicts;
					AGSWhispersyncClient.OnDataUploadedToCloudEvent += HandleAmazonPotentialProgressConflicts;
					AGSWhispersyncClient.OnSyncFailedEvent += HandleAmazonSyncFailed;
					AGSWhispersyncClient.OnThrottledEvent += HandleAmazonThrottled;
				}
				else
				{
					UnityEngine.Debug.Log("Amazon GameCircle was already initialized.");
					AGSLeaderboardsClient.SubmitScoreSucceededEvent += HandleAmazonSubmitScoreSucceeded;
					AGSLeaderboardsClient.SubmitScoreFailedEvent += HandleAmazonSubmitScoreFailed;
					AGSLeaderboardsClient.SubmitScore(_leaderboardId, PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0));
				}
				_amazonGamecircleManagerInitialized = true;
			}
		}
		else if (BuildSettings.BuildTarget == BuildTarget.iPhone)
		{
			GameCenterPlatform.ShowDefaultAchievementCompletionBanner(true);
		}
		yield return 1f;
	}

	private static void HandleNotification(string message, Dictionary<string, object> additionalData, bool isActive)
	{
		UnityEngine.Debug.Log(string.Format("GameThrive HandleNotification(“{0}”, ..., {1})", message, isActive));
	}

	private void HandleAmazonGamecircleServiceReady()
	{
		AGSClient.ServiceReadyEvent -= HandleAmazonGamecircleServiceReady;
		AGSClient.ServiceNotReadyEvent -= HandleAmazonGamecircleServiceNotReady;
		UnityEngine.Debug.Log("Amazon GameCircle service is initialized.");
		AGSAchievementsClient.UpdateAchievementCompleted += HandleUpdateAchievementCompleted;
		AGSLeaderboardsClient.SubmitScoreSucceededEvent += HandleAmazonSubmitScoreSucceeded;
		AGSLeaderboardsClient.SubmitScoreFailedEvent += HandleAmazonSubmitScoreFailed;
		AGSLeaderboardsClient.SubmitScore(_leaderboardId, PlayerPrefs.GetInt(Defs.SurvivalScoreSett, 0));
	}

	private void HandleAmazonPotentialProgressConflicts()
	{
		UnityEngine.Debug.Log("HandleAmazonPotentialProgressConflicts()");
	}

	private void HandleAmazonSyncFailed()
	{
		UnityEngine.Debug.LogWarning("HandleAmazonSyncFailed(): " + AGSWhispersyncClient.failReason);
	}

	private void HandleAmazonThrottled()
	{
		UnityEngine.Debug.LogWarning("HandleAmazonThrottled().");
	}

	private void HandleAmazonGamecircleServiceNotReady(string message)
	{
		UnityEngine.Debug.LogError("Amazon GameCircle service is not ready:\n" + message);
	}

	private void HandleUpdateAchievementCompleted(AGSUpdateAchievementResponse response)
	{
		string message = ((!string.IsNullOrEmpty(response.error)) ? string.Format("Achievement {0} failed. {1}", response.achievementId, response.error) : string.Format("Achievement {0} succeeded.", response.achievementId));
		UnityEngine.Debug.Log(message);
	}

	private void HandleAmazonSubmitScoreSucceeded(string leaderbordId)
	{
		AGSLeaderboardsClient.SubmitScoreSucceededEvent -= HandleAmazonSubmitScoreSucceeded;
		AGSLeaderboardsClient.SubmitScoreFailedEvent -= HandleAmazonSubmitScoreFailed;
		if (UnityEngine.Debug.isDebugBuild)
		{
			UnityEngine.Debug.Log("Submit score succeeded for leaderboard " + leaderbordId);
		}
	}

	private void HandleAmazonSubmitScoreFailed(string leaderbordId, string error)
	{
		AGSLeaderboardsClient.SubmitScoreSucceededEvent -= HandleAmazonSubmitScoreSucceeded;
		AGSLeaderboardsClient.SubmitScoreFailedEvent -= HandleAmazonSubmitScoreFailed;
		string message = string.Format("Submit score failed for leaderboard {0}:\n{1}", leaderbordId, error);
		UnityEngine.Debug.LogError(message);
	}
}
